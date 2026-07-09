#!/usr/bin/env node

import axios from 'axios';
import * as fs from 'fs';
import * as path from 'path';
import * as stream from 'stream';
import { promisify } from 'util';

const finished = promisify(stream.finished);

interface DownloadProgress {
  downloadedBytes: number;
  totalBytes: number;
  startTime: number;
}

class FileDownloader {
  private progress: DownloadProgress;
  private progressInterval?: NodeJS.Timeout;
  private lastPrintedTime: number = 0;

  constructor() {
    this.progress = {
      downloadedBytes: 0,
      totalBytes: 0,
      startTime: Date.now()
    };
  }

   // 格式化文件大小
  private formatFileSize(bytes: number): string {
    const kb = bytes / 1024;
    if (kb < 1024) {
      return `${kb.toFixed(2)} KB`;
    } else {
      const mb = kb / 1024;
      return `${mb.toFixed(2)} MB`;
    }
  }

   // 格式化时间
  private formatTime(ms: number): string {
    const minutes = Math.floor(ms / 60000);
    const seconds = Math.floor((ms % 60000) / 1000);
    return `${minutes}分${seconds}秒`;
  }

   //打印下载进度
  private printProgress(): void {
    const now = Date.now();
    // 控制打印频率，至少间隔200ms
    if (now - this.lastPrintedTime < 200) {
      return;
    }

    const elapsedTime = now - this.progress.startTime;
    const downloadedKB = this.progress.downloadedBytes / 1024;
    
    let progressText = `已下载：${downloadedKB.toFixed(2)} KB，已用时：${this.formatTime(elapsedTime)}`;
    
    if (this.progress.totalBytes > 0) {
      const progressPercent = (this.progress.downloadedBytes / this.progress.totalBytes * 100).toFixed(1);
      const totalKB = this.progress.totalBytes / 1024;
      progressText += `，进度：${progressPercent}% (${downloadedKB.toFixed(2)}/${totalKB.toFixed(2)} KB)`;
    }
    
    // 清除当前行并打印进度
    process.stdout.write('\r' + progressText);
    this.lastPrintedTime = now;
  }

   //验证命令行参数
  public validateArgs(args: string[]): { url: string; outputPath: string } {
    if (args.length < 4) {
      console.error('错误：缺少参数');
      console.error('用法：filedownloader <url> <outputfile>');
      console.error('示例：filedownloader https://example.com/sample.txt ./sample.txt');
      process.exit(1);
    }

    const url = args[2];
    const outputPath = args[3];

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      console.error('错误：URL必须以 http:// 或 https:// 开头');
      process.exit(1);
    }

    return { url, outputPath };
  }

   //确保输出目录存在
  private ensureDirectoryExists(filePath: string): void {
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
  }

   //下载文件
  public async downloadFile(url: string, outputPath: string): Promise<void> {
    console.log(`开始下载: ${url}`);
    console.log(`保存到: ${outputPath}`);

    try {
      // 确保输出目录存在
      this.ensureDirectoryExists(outputPath);

      // 发送HEAD请求获取文件信息
      const headResponse = await axios.head(url, {
        timeout: 10000,
        validateStatus: (status) => status < 400
      });

      this.progress.totalBytes = parseInt(headResponse.headers['content-length']) || 0;
      
      if (this.progress.totalBytes > 0) {
        console.log(`文件大小: ${this.formatFileSize(this.progress.totalBytes)}`);
      } else {
        console.log('文件大小: 未知');
      }

      // 开始进度显示
      this.startProgressTracking();

      // 下载文件
      const response = await axios({
        method: 'GET',
        url: url,
        responseType: 'stream',
        timeout: 30000
      });

      const writer = fs.createWriteStream(outputPath);

      response.data.on('data', (chunk: Buffer) => {
        this.progress.downloadedBytes += chunk.length;
      });

      response.data.pipe(writer);

      await finished(writer);
      
      // 停止进度显示
      this.stopProgressTracking();
      
      // 打印最终结果
      console.log('\n下载完成！文件已保存到', outputPath);
      
    } catch (error) {
      this.stopProgressTracking();
      console.error('\n下载失败:');
      
      if (axios.isAxiosError(error)) {
        if (error.code === 'ECONNABORTED') {
          console.error('连接超时');
        } else if (error.response) {
          console.error(`HTTP错误: ${error.response.status} - ${error.response.statusText}`);
        } else {
          console.error(`网络错误: ${error.message}`);
        }
      } else {
        console.error(error instanceof Error ? error.message : '未知错误');
      }
      process.exit(1);
    }
  }

   //开始进度跟踪
  private startProgressTracking(): void {
    this.progressInterval = setInterval(() => {
      this.printProgress();
    }, 200);
  }

   //停止进度跟踪
  private stopProgressTracking(): void {
    if (this.progressInterval) {
      clearInterval(this.progressInterval);
      this.progressInterval = undefined;
    }
  }
}

// 主函数
async function main(): Promise<void> {
  const downloader = new FileDownloader();
  const { url, outputPath } = downloader.validateArgs(process.argv);
  
  await downloader.downloadFile(url, outputPath);
}

// 运行程序
if (require.main === module) {
  main().catch((error) => {
    console.error('程序执行出错:', error);
    process.exit(1);
  });
}

export default FileDownloader;