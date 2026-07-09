#define _CRT_SECURE_NO_WARNINGS
#include "raylib.h"
#include <stdio.h>
#include <string.h>

#define MAX_FRAMES 4
#define WINDOW_SIZE 4
#define TIMEOUT_DURATION 3.0f

// 帧结构体
typedef struct {
    Rectangle rect;
    char text[20];
    Color color;
    bool active;
    bool isAck;
    int seq;
    bool lost;
    bool acknowledged;
    float startTime;
} Frame;

// 按钮结构体
typedef struct {
    Rectangle rect;
    char text[50];
    bool active;
    bool toggled;
} Button;

// 状态枚举
typedef enum {
    IDLE,
    SENDING,
    WAITING,
    RESENDING,
    COMPLETE
} SimState;

int main(void) {
    const int screenWidth = 1000;
    const int screenHeight = 600;
    InitWindow(screenWidth, screenHeight, "Go-Back-N ARQ Simulation");

    // 初始化发送方和接收方区域
    Rectangle senderArea = { 50, 250, 200, 200 };
    Rectangle receiverArea = { 750, 250, 200, 200 };
    Rectangle channelArea = { 250, 280, 500, 140 };

    // 初始化帧数组
    Frame frames[MAX_FRAMES] = { 0 };
    Frame acks[MAX_FRAMES] = { 0 };

    // 初始化按钮
    Button startButton = {
        .rect = { screenWidth / 2 - 100, 50, 200, 50 },
        .text = "START SIMULATION",
        .active = true,
        .toggled = false
    };

    Button lossModeButton = {
        .rect = { screenWidth / 2 - 100, 120, 200, 35 },
        .text = "LOSS MODE: OFF",
        .active = false,
        .toggled = false
    };

    // 状态变量
    SimState simState = IDLE;
    bool lostMode = false;
    int nextSeqToSend = 0;
    int expectedSeq = 0;
    float timer = 0.0f;
    bool timeout = false;
    int framesInTransit = 0;
    int acksInTransit = 0;
    int framesSent = 0;
    int framesDelivered = 0;
    int framesRetransmitted = 0;
    float lastSendTime = 0.0f;
    int resendStart = 0;
    int resendCount = 0;
    int lastInOrder = -1; // 记录最后一个按序接收的帧序号
    bool allFramesDelivered = false; // 新增：所有帧已交付标志

    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        // 处理按钮点击
        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {
            Vector2 mousePos = GetMousePosition();

            // 开始按钮
            if (CheckCollisionPointRec(mousePos, startButton.rect)) {
                if (simState == IDLE || simState == COMPLETE) {
                    simState = SENDING;
                    startButton.active = false;
                    lossModeButton.active = true;

                    // 重置所有状态
                    memset(frames, 0, sizeof(frames));
                    memset(acks, 0, sizeof(acks));
                    nextSeqToSend = 0;
                    expectedSeq = 0;
                    timer = 0.0f;
                    timeout = false;
                    framesInTransit = 0;
                    acksInTransit = 0;
                    framesSent = 0;
                    framesDelivered = 0;
                    framesRetransmitted = 0;
                    lastSendTime = 0.0f;
                    resendStart = 0;
                    resendCount = 0;
                    lastInOrder = -1;
                    allFramesDelivered = false; // 重置
                }
            }

            // 丢帧模式按钮
            if (lossModeButton.active && CheckCollisionPointRec(mousePos, lossModeButton.rect)) {
                lostMode = !lostMode;
                strcpy(lossModeButton.text, lostMode ? "LOSS MODE: ON" : "LOSS MODE: OFF");
                lossModeButton.toggled = lostMode;
            }

            // 帧点击（丢帧模式）
            if (simState != IDLE && simState != COMPLETE && lostMode) {
                for (int i = 0; i < MAX_FRAMES; i++) {
                    if (frames[i].active && !frames[i].lost &&
                        CheckCollisionPointRec(mousePos, frames[i].rect)) {
                        frames[i].lost = true;
                        break;
                    }
                }

                for (int i = 0; i < MAX_FRAMES; i++) {
                    if (acks[i].active && !acks[i].lost &&
                        CheckCollisionPointRec(mousePos, acks[i].rect)) {
                        acks[i].lost = true;
                        break;
                    }
                }
            }
        }

        // 模拟逻辑
        if (simState == SENDING) {
            // 发送帧（带延迟）
            if (framesSent < MAX_FRAMES && (GetTime() - lastSendTime) > 0.8f) {
                frames[nextSeqToSend] = (Frame){
                    .rect = { senderArea.x + 50, senderArea.y + 50 + nextSeqToSend * 30, 100, 25 },
                    .color = BLUE,
                    .active = true,
                    .isAck = false,
                    .seq = nextSeqToSend,
                    .lost = false,
                    .acknowledged = false,
                    .startTime = GetTime()
                };
                snprintf(frames[nextSeqToSend].text, sizeof(frames[nextSeqToSend].text), "Frame%d", nextSeqToSend);

                framesSent++;
                framesInTransit++;
                nextSeqToSend = (nextSeqToSend + 1) % MAX_FRAMES;
                lastSendTime = GetTime();

                if (framesSent == MAX_FRAMES) {
                    simState = WAITING;
                    timer = 0.0f;
                }
            }
        }
        else if (simState == RESENDING) {
            // 依次重传帧（带延迟）
            if (resendCount < MAX_FRAMES - resendStart && (GetTime() - lastSendTime) > 0.8f) {
                int seq = resendStart + resendCount;
                frames[seq] = (Frame){
                    .rect = { senderArea.x + 50, senderArea.y + 50 + seq * 30, 100, 25 },
                    .color = SKYBLUE, // 重传帧使用不同颜色
                    .active = true,
                    .isAck = false,
                    .seq = seq,
                    .lost = false,
                    .acknowledged = false,
                    .startTime = GetTime()
                };
                snprintf(frames[seq].text, sizeof(frames[seq].text), "Frame%d", seq);

                framesInTransit++;
                framesRetransmitted++;
                resendCount++;
                lastSendTime = GetTime();

                if (resendCount == MAX_FRAMES - resendStart) {
                    simState = WAITING;
                    timer = 0.0f;
                }
            }
        }

        // 帧传输逻辑
        if (simState != IDLE && simState != COMPLETE) {
            // 更新帧位置
            for (int i = 0; i < MAX_FRAMES; i++) {
                if (frames[i].active && !frames[i].lost && !frames[i].acknowledged) {
                    // 计算进度 (0.0-1.0)
                    float progress = (GetTime() - frames[i].startTime) / 2.0f;
                    if (progress > 1.0f) progress = 1.0f;

                    frames[i].rect.x = senderArea.x + 50 + (receiverArea.x - senderArea.x - 150) * progress;

                    // 帧到达接收方
                    if (progress >= 1.0f) {
                        // 如果是期望的序列号
                        if (frames[i].seq == expectedSeq) {
                            // 更新最后一个按序接收的帧序号
                            lastInOrder = frames[i].seq;
                            expectedSeq++;

                            // 标记帧为已确认
                            frames[i].acknowledged = true;
                            framesInTransit--;
                            framesDelivered++;

                            // 重置超时计时器
                            timer = 0.0f;
                            timeout = false;

                            // 检查是否所有帧都已交付
                            if (framesDelivered == MAX_FRAMES) {
                                allFramesDelivered = true;
                            }
                        }
                        // 如果帧不是期望的序列号（由于丢失的帧）
                        else {
                            frames[i].lost = true;
                            framesInTransit--;
                        }
                    }
                }
            }

            // 在帧传输完成后发送累积ACK
            if (lastInOrder != -1) {
                // 创建ACK帧（只发送最后一个按序帧的ACK）
                acks[lastInOrder] = (Frame){
                    .rect = { receiverArea.x, receiverArea.y + 80, 80, 25 },
                    .color = GREEN,
                    .active = true,
                    .isAck = true,
                    .seq = lastInOrder,
                    .lost = false,
                    .acknowledged = false,
                    .startTime = GetTime()
                };
                snprintf(acks[lastInOrder].text, sizeof(acks[lastInOrder].text), "ACK%d", lastInOrder);
                acksInTransit++;

                // 重置状态
                lastInOrder = -1;
            }

            // ACK移动
            for (int i = 0; i < MAX_FRAMES; i++) {
                if (acks[i].active && !acks[i].lost && !acks[i].acknowledged) {
                    // 计算进度 (0.0-1.0)
                    float progress = (GetTime() - acks[i].startTime) / 1.5f;
                    if (progress > 1.0f) progress = 1.0f;

                    acks[i].rect.x = receiverArea.x - (receiverArea.x - senderArea.x - 150) * progress;

                    // ACK到达发送方
                    if (progress >= 1.0f) {
                        // 标记所有小于等于ACK序号的帧为已确认
                        for (int j = 0; j < MAX_FRAMES; j++) {
                            if (frames[j].active && frames[j].seq <= acks[i].seq && !frames[j].acknowledged) {
                                frames[j].acknowledged = true;
                                framesInTransit--;
                            }
                        }

                        // 标记ACK为已确认
                        acks[i].acknowledged = true;
                        acksInTransit--;

                        // 重置超时计时器
                        timer = 0.0f;
                        timeout = false;

                        // 检查是否所有ACK都已到达
                        if (allFramesDelivered && acksInTransit == 0) {
                            simState = COMPLETE;
                        }
                    }
                }
            }

            // 超时处理
            if (framesInTransit > 0 && !timeout && simState == WAITING) {
                timer += GetFrameTime();
                if (timer > TIMEOUT_DURATION) {
                    timeout = true;

                    // 找到第一个未确认的帧
                    resendStart = MAX_FRAMES;
                    for (int i = 0; i < MAX_FRAMES; i++) {
                        if (frames[i].active && !frames[i].acknowledged) {
                            resendStart = i;
                            break;
                        }
                    }

                    // 设置重传状态
                    if (resendStart < MAX_FRAMES) {
                        simState = RESENDING;
                        resendCount = 0;
                        lastSendTime = 0.0f;
                        timer = 0.0f;
                    }
                }
            }
        }

        // 绘制
        BeginDrawing();
        ClearBackground(RAYWHITE);

        // 绘制标题
        DrawText("GO-BACK-N ARQ PROTOCOL SIMULATION", screenWidth / 2 - MeasureText("GO-BACK-N ARQ PROTOCOL SIMULATION", 32) / 2, 10, 32, BLUE);

        // 绘制通道
        DrawRectangleRec(channelArea, (Color) { 200, 230, 255, 255 });
        DrawRectangleLinesEx(channelArea, 2, BLUE);
        DrawText("TRANSMISSION CHANNEL", channelArea.x + channelArea.width / 2 - MeasureText("TRANSMISSION CHANNEL", 20) / 2,
            channelArea.y - 25, 20, DARKBLUE);

        // 绘制发送方和接收方
        DrawRectangleRounded(senderArea, 0.1, 10, (Color) { 240, 240, 240, 255 });
        DrawRectangleLinesEx(senderArea, 2, DARKGRAY);
        DrawText("SENDER", senderArea.x + senderArea.width / 2 - MeasureText("SENDER", 20) / 2, senderArea.y + 20, 20, DARKGRAY);

        DrawRectangleRounded(receiverArea, 0.1, 10, (Color) { 240, 240, 240, 255 });
        DrawRectangleLinesEx(receiverArea, 2, DARKGRAY);
        DrawText("RECEIVER", receiverArea.x + receiverArea.width / 2 - MeasureText("RECEIVER", 20) / 2, receiverArea.y + 20, 20, DARKGRAY);

        // 绘制帧
        for (int i = 0; i < MAX_FRAMES; i++) {
            if (frames[i].active && !frames[i].lost) {
                DrawRectangleRounded(frames[i].rect, 0.2, 10, frames[i].color);
                DrawRectangleLinesEx(frames[i].rect, 2, frames[i].color.r > 100 ? DARKBLUE : DARKBLUE);
                DrawText(frames[i].text,
                    frames[i].rect.x + 10,
                    frames[i].rect.y + 5,
                    18, WHITE);

                // 标记已确认的帧
                if (frames[i].acknowledged) {
                    DrawText("ACK", frames[i].rect.x + frames[i].rect.width - 40, frames[i].rect.y + 5, 15, GREEN);
                }
            }

            // 绘制丢失标记
            if (frames[i].lost) {
                DrawText(TextFormat("Frame %d LOST!", frames[i].seq),
                    frames[i].rect.x,
                    frames[i].rect.y - 20,
                    18, RED);
            }
        }

        // 绘制ACK
        for (int i = 0; i < MAX_FRAMES; i++) {
            if (acks[i].active && !acks[i].lost && !acks[i].acknowledged) {
                DrawRectangleRounded(acks[i].rect, 0.2, 10, acks[i].color);
                DrawRectangleLinesEx(acks[i].rect, 2, DARKGREEN);
                DrawText(acks[i].text, acks[i].rect.x + 10, acks[i].rect.y + 5, 18, WHITE);
            }

            // 绘制丢失的ACK标记
            if (acks[i].active && acks[i].lost) {
                DrawText(TextFormat("%s LOST!", acks[i].text),
                    acks[i].rect.x,
                    acks[i].rect.y - 20,
                    18, RED);
            }
        }

        // 绘制按钮
        if (startButton.active) {
            DrawRectangleRounded(startButton.rect, 0.3, 10, BLUE);
            DrawRectangleLinesEx(startButton.rect, 2, DARKBLUE);
            DrawText(startButton.text,
                startButton.rect.x + startButton.rect.width / 2 - MeasureText(startButton.text, 20) / 2,
                startButton.rect.y + 15,
                20, WHITE);
        }

        DrawRectangleRounded(lossModeButton.rect, 0.2, 10, lossModeButton.toggled ? RED : LIGHTGRAY);
        DrawRectangleLinesEx(lossModeButton.rect, 2, DARKGRAY);
        DrawText(lossModeButton.text,
            lossModeButton.rect.x + lossModeButton.rect.width / 2 - MeasureText(lossModeButton.text, 20) / 2,
            lossModeButton.rect.y + 8,
            20, DARKGRAY);

        // 绘制状态信息
        DrawRectangle(20, 180, 960, 50, (Color) { 230, 230, 250, 255 });
        DrawLine(20, 180, 980, 180, DARKGRAY);
        DrawLine(20, 230, 980, 230, DARKGRAY);

        DrawText(TextFormat("Current State: %s",
            simState == IDLE ? "IDLE" :
            simState == SENDING ? "SENDING FRAMES" :
            simState == WAITING ? "WAITING FOR ACK" :
            simState == RESENDING ? "RESENDING" :
            "COMPLETE"), 30, 190, 20, DARKBLUE);

        DrawText(TextFormat("Next Sequence: %d", nextSeqToSend), 300, 190, 20, DARKBLUE);
        DrawText(TextFormat("Expected Sequence: %d", expectedSeq), 500, 190, 20, DARKBLUE);
        DrawText(TextFormat("Timer: %.1f/%.1f", timer, TIMEOUT_DURATION), 750, 190, 20, DARKBLUE);

        // 绘制统计数据
        DrawText(TextFormat("Frames Sent: %d", framesSent), 30, 470, 20, DARKGREEN);
        DrawText(TextFormat("Frames Delivered: %d", framesDelivered), 30, 500, 20, DARKGREEN);
        DrawText(TextFormat("Frames Retransmitted: %d", framesRetransmitted), 30, 530, 20, DARKGREEN);
        DrawText(TextFormat("Frames in Transit: %d", framesInTransit), 30, 560, 20, DARKGREEN);
        DrawText(TextFormat("ACKs in Transit: %d", acksInTransit), 30, 590, 20, DARKGREEN);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}
