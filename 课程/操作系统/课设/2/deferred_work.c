#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/kthread.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/workqueue.h>
#include <linux/atomic.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("FuShengyuan");
MODULE_DESCRIPTION("deferred work");


struct work_ctx {
    struct work_struct work;
    int current_id;
};

struct delayed_work my_work;
struct work_ctx works[10];
struct task_struct *threads[10];

void work_queue_handler(struct work_struct *work) {
    struct work_ctx *ctx = container_of(work, struct work_ctx, work);
    printk("work queue : %d\n", ctx->current_id);
}

int kthread_handler(void *data) {
    struct work_ctx *ctx = (struct work_ctx *)data;
    printk("kthread : %d\n", ctx->current_id);
    return 0;
}

void delayed_work_handler(struct work_struct *work) {
    printk("delayed work!\n");
}

int deferred_work_init(void) {
    printk(KERN_INFO "deferred work module init\n");
    int i;

    for (i = 0; i < 10; i++) {
        works[i].current_id = 247 + i;
        INIT_WORK(&works[i].work, work_queue_handler);
        schedule_work(&works[i].work);
    }

    for (i = 0; i < 10; i++) {
        threads[i] = kthread_create(kthread_handler, &works[i], "kthread_%d", i);
        if (threads[i]) {
            wake_up_process(threads[i]);
        }
    }

    INIT_DELAYED_WORK(&my_work, delayed_work_handler);
    schedule_delayed_work(&my_work, 5 * HZ);

    return 0;
}

void deferred_work_exit(void) {
    int i;
    for (i = 0; i < 10; i++) {
        if (threads[i]) {
            kthread_stop(threads[i]);
        }
    }
    printk(KERN_INFO "deferred work module exit\n");
}

module_init(deferred_work_init);
module_exit(deferred_work_exit);