#include <asm/io.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/delay.h>
#include <linux/pid.h>
#include <linux/kernel.h>
#include <linux/kthread.h>
#include <linux/types.h>
#include <linux/slab.h>
#include <linux/atomic.h>
#include <linux/spinlock.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

#define EDU_DEV_MAJOR 200 
#define EDU_DEV_NAME "edu"

struct edu_dev_info {
    resource_size_t io;
    long range, flags;
    void __iomem *ioaddr;
    int irq;
};

struct user_data {
    int id;
    atomic64_t data;
};

struct thread_data {
    struct user_data *user_data_ptr;
    int input_data;
};

static int edu_driver_probe(struct pci_dev *dev, const struct pci_device_id *id);
static void edu_driver_remove(struct pci_dev *dev);

static struct pci_device_id id_table[] = {
    { PCI_DEVICE(0x1234, 0x11e8) },
    { 0 } 
};

static struct pci_driver pci_driver = {
    .name = "edu_driver",
    .id_table = id_table,
    .probe = edu_driver_probe,
    .remove = edu_driver_remove,
};

static struct edu_dev_info *edu_info;
static spinlock_t lock;
static int current_id = 0;

static int edu_driver_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
    int ret = 0;
    printk("executing edu driver probe function!\n");

    ret = pci_enable_device(dev);
    if (ret) {
        printk(KERN_ERR "Failed to enable PCI device.\n");
        return -EIO;
    }

    edu_info = kmalloc(sizeof(struct edu_dev_info), GFP_KERNEL);
    if (!edu_info) {
        printk(KERN_ERR "Memory allocation for edu_dev_info failed.\n");
        return -ENOMEM;
    }

    ret = pci_request_regions(dev, "edu_driver");
    if (ret) {
        printk("PCI request regions failed.\n");
        goto free_edu_info;
    }

    edu_info->ioaddr = pci_ioremap_bar(dev, 0);
    if (!edu_info->ioaddr) {
        printk(KERN_ERR "Failed to map BAR to virtual memory.\n");
        goto release_regions;
    }

    pci_set_drvdata(dev, edu_info);

    printk("Probe succeeds. PCIE ioport addr starts at %llX, edu_info->ioaddr is 0x%p.\n", edu_info->io, edu_info->ioaddr);
    return 0;

release_regions:
    pci_release_regions(dev);
free_edu_info:
    kfree(edu_info);
    return ret;
}

static void edu_driver_remove(struct pci_dev *dev)
{
    struct edu_dev_info *info = pci_get_drvdata(dev);

    if (info) {
        iounmap(info->ioaddr);
        pci_release_regions(dev);
        kfree(info);
    }
    pci_disable_device(dev);
    printk("Device removed successfully.\n");
}

int kthread_handler(void *data)
{
    struct thread_data *thread_data_ptr = (struct thread_data *)data;
    uint64_t result = 1;
    int i;

    for (i = 1; i <= thread_data_ptr->input_data; i++) {
        result *= i;
    }

    spin_lock(&lock);
    atomic64_set(&thread_data_ptr->user_data_ptr->data, result);
    spin_unlock(&lock);

    printk("Factorial computed: %llu\n", result);
    kfree(thread_data_ptr);
    return 0;
}

static int edu_dev_open(struct inode *inode, struct file *filp)
{
    struct user_data *user_data_ptr = kmalloc(sizeof(struct user_data), GFP_KERNEL);
    if (!user_data_ptr) {
        return -ENOMEM;
    }

    user_data_ptr->id = current_id++;
    atomic64_set(&user_data_ptr->data, 0);
    filp->private_data = user_data_ptr;
    return 0;
}

static int edu_dev_release(struct inode *inode, struct file *filp)
{
    struct user_data *user_data_ptr = filp->private_data;
    kfree(user_data_ptr); 
    return 0;
}

long edu_dev_unlocked_ioctl(struct file *pfilp_t, unsigned int cmd, unsigned long arg)
{
    struct user_data *user_data_ptr = pfilp_t->private_data;
    if (cmd == 0) {
        struct thread_data *data = kmalloc(sizeof(struct thread_data), GFP_KERNEL);
        if (!data) {
            printk(KERN_ERR "Memory allocation for thread_data failed.\n");
            return -ENOMEM;
        }
        data->user_data_ptr = user_data_ptr;
        data->input_data = arg;

        printk("IOCTL Write: arg = %lu\n", arg);

        struct task_struct *task = kthread_create(kthread_handler, data, "factorial_thread");
        if (IS_ERR(task)) {
            kfree(data);
            return PTR_ERR(task);
        }
        wake_up_process(task);

        return 0;
    } else if (cmd == 1) {
        int result = atomic64_read(&user_data_ptr->data);

        printk("IOCTL Read: result = %d\n", result);

        return result;
    }

    return -EINVAL;
}


static struct file_operations edu_dev_fops = {
    .open = edu_dev_open,
    .release = edu_dev_release,
    .unlocked_ioctl = edu_dev_unlocked_ioctl,
};

static int __init edu_driver_init(void)
{
    int ret = register_chrdev(EDU_DEV_MAJOR, EDU_DEV_NAME, &edu_dev_fops);
    if (ret < 0) {
        printk("Failed to register char device\n");
        return ret;
    }

    ret = pci_register_driver(&pci_driver);
    if (ret) {
        unregister_chrdev(EDU_DEV_MAJOR, EDU_DEV_NAME);
        return ret;
    }

    spin_lock_init(&lock);
    printk("HELLO PCI\n");
    return 0;
}

static void __exit edu_driver_exit(void)
{
    unregister_chrdev(EDU_DEV_MAJOR, EDU_DEV_NAME);
    pci_unregister_driver(&pci_driver);
    printk("GOODBYE PCI\n");
}

MODULE_LICENSE("GPL");
module_init(edu_driver_init);
module_exit(edu_driver_exit);
