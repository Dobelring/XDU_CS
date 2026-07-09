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
    bool delivered;
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
    const int screenHeight = 650;
    InitWindow(screenWidth, screenHeight, "Selective Repeat ARQ Simulation");

    // 初始化发送方和接收方区域
    Rectangle senderArea = { 50, 250, 200, 200 };
    Rectangle receiverArea = { 750, 250, 200, 200 };
    Rectangle channelArea = { 250, 280, 500, 140 };
    Rectangle infoPanel = { 50, 480, 900, 150 };

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
    int resendList[MAX_FRAMES] = { 0 };
    int resendCount = 0;
    char receivedInfo[256] = { 0 };
    char ackInfo[256] = { 0 };
    char resendInfo[256] = { 0 };

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
                    resendCount = 0;
                    strcpy(receivedInfo, "");
                    strcpy(ackInfo, "");
                    strcpy(resendInfo, "");
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
                        strcpy(resendInfo, TextFormat("Frame %d manually lost!", i));
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
                    .delivered = false,
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
            if (resendCount > 0 && (GetTime() - lastSendTime) > 0.8f) {
                int seq = resendList[resendCount - 1];
                frames[seq] = (Frame){
                    .rect = { senderArea.x + 50, senderArea.y + 50 + seq * 30, 100, 25 },
                    .color = SKYBLUE, // 重传帧使用不同颜色
                    .active = true,
                    .isAck = false,
                    .seq = seq,
                    .lost = false,
                    .acknowledged = false,
                    .delivered = false,
                    .startTime = GetTime()
                };
                snprintf(frames[seq].text, sizeof(frames[seq].text), "Frame%d", seq);

                framesInTransit++;
                framesRetransmitted++;
                resendCount--;
                lastSendTime = GetTime();
                strcpy(resendInfo, TextFormat("Resending frame %d...", seq));

                if (resendCount == 0) {
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
                        if (!frames[i].delivered) {
                            // 更新接收信息
                            if (strlen(receivedInfo)) {
                                strcat(receivedInfo, ", ");
                            }
                            strcat(receivedInfo, TextFormat("%d", i));

                                // 标记帧为已交付
                                frames[i].delivered = true;
                                framesDelivered++;
                        }
                    }
                }
            }

            // 发送ACK（当所有帧都交付后按序发送）
            if (framesDelivered == MAX_FRAMES && acksInTransit == 0) {
                // 按顺序发送所有ACK
                for (int i = 0; i < MAX_FRAMES; i++) {
                    acks[i] = (Frame){
                        .rect = { receiverArea.x, receiverArea.y + 80 + i * 30, 80, 25 },
                        .color = GREEN,
                        .active = true,
                        .isAck = true,
                        .seq = i,
                        .lost = false,
                        .acknowledged = false,
                        .startTime = GetTime()
                    };
                    snprintf(acks[i].text, sizeof(acks[i].text), "ACK%d", i);
                    acksInTransit++;

                    // 更新ACK信息
                    if (strlen(ackInfo)) {
                        strcat(ackInfo, ", ");
                    }
                    strcat(ackInfo, TextFormat("%d", i));
                }
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
                        // 标记对应帧为已确认
                        for (int j = 0; j < MAX_FRAMES; j++) {
                            if (frames[j].active && frames[j].seq == acks[i].seq && !frames[j].acknowledged) {
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
                    }
                }
            }

            // 超时处理
            if (framesInTransit > 0 && !timeout && simState == WAITING) {
                timer += GetFrameTime();
                if (timer > TIMEOUT_DURATION) {
                    timeout = true;

                    // 找出所有未交付的帧
                    resendCount = 0;
                    for (int i = 0; i < MAX_FRAMES; i++) {
                        if (frames[i].active && !frames[i].delivered) {
                            resendList[resendCount++] = i;
                        }
                    }

                    // 设置重传状态
                    if (resendCount > 0) {
                        simState = RESENDING;
                        lastSendTime = 0.0f;
                        timer = 0.0f;
                        strcpy(resendInfo, TextFormat("Timeout! Resending frames: %d", resendList[0]));
                        for (int i = 1; i < resendCount; i++) {
                            strcat(resendInfo, TextFormat(", %d", resendList[i]));
                        }
                    }
                }
            }

            // 检查是否完成
            bool allFramesAcked = true;
            for (int i = 0; i < MAX_FRAMES; i++) {
                if (frames[i].active && !frames[i].acknowledged) {
                    allFramesAcked = false;
                    break;
                }
            }

            if (allFramesAcked) {
                simState = COMPLETE;
            }
        }

        // 绘制
        BeginDrawing();
        ClearBackground(RAYWHITE);

        // 绘制标题
        DrawText("SELECTIVE REPEAT ARQ PROTOCOL SIMULATION",
            screenWidth / 2 - MeasureText("SELECTIVE REPEAT ARQ PROTOCOL SIMULATION", 32) / 2,
            10, 32, BLUE);

        // 绘制通道
        DrawRectangleRec(channelArea, (Color) { 200, 230, 255, 255 });
        DrawRectangleLinesEx(channelArea, 2, BLUE);
        DrawText("TRANSMISSION CHANNEL",
            channelArea.x + channelArea.width / 2 - MeasureText("TRANSMISSION CHANNEL", 20) / 2,
            channelArea.y - 25, 20, DARKBLUE);

        // 绘制发送方和接收方
        DrawRectangleRec(senderArea, (Color) { 240, 240, 240, 255 });
        DrawRectangleLinesEx(senderArea, 2, DARKGRAY);
        DrawText("SENDER",
            senderArea.x + senderArea.width / 2 - MeasureText("SENDER", 20) / 2,
            senderArea.y + 20, 20, DARKGRAY);

        DrawRectangleRec(receiverArea, (Color) { 240, 240, 240, 255 });
        DrawRectangleLinesEx(receiverArea, 2, DARKGRAY);
        DrawText("RECEIVER",
            receiverArea.x + receiverArea.width / 2 - MeasureText("RECEIVER", 20) / 2,
            receiverArea.y + 20, 20, DARKGRAY);

        // 绘制帧
        for (int i = 0; i < MAX_FRAMES; i++) {
            if (frames[i].active && !frames[i].lost) {
                DrawRectangleRec(frames[i].rect, frames[i].color);
                DrawRectangleLinesEx(frames[i].rect, 2, DARKBLUE);
                DrawText(frames[i].text,
                    frames[i].rect.x + 10,
                    frames[i].rect.y + 5,
                    18, WHITE);

                // 标记已确认的帧
                if (frames[i].acknowledged) {
                    DrawText("ACK",
                        frames[i].rect.x + frames[i].rect.width - 40,
                        frames[i].rect.y + 5,
                        15, GREEN);
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
                DrawRectangleRec(acks[i].rect, acks[i].color);
                DrawRectangleLinesEx(acks[i].rect, 2, DARKGREEN);
                DrawText(acks[i].text,
                    acks[i].rect.x + 10,
                    acks[i].rect.y + 5,
                    18, WHITE);
            }
        }

        // 绘制按钮
        if (startButton.active) {
            DrawRectangleRec(startButton.rect, BLUE);
            DrawRectangleLinesEx(startButton.rect, 2, DARKBLUE);
            DrawText(startButton.text,
                startButton.rect.x + startButton.rect.width / 2 - MeasureText(startButton.text, 20) / 2,
                startButton.rect.y + 15,
                20, WHITE);
        }

        DrawRectangleRec(lossModeButton.rect, lossModeButton.toggled ? RED : LIGHTGRAY);
        DrawRectangleLinesEx(lossModeButton.rect, 2, DARKGRAY);
        DrawText(lossModeButton.text,
            lossModeButton.rect.x + lossModeButton.rect.width / 2 - MeasureText(lossModeButton.text, 20) / 2,
            lossModeButton.rect.y + 8,
            20, DARKGRAY);

        // 绘制信息面板
        DrawRectangleRec(infoPanel, (Color) { 230, 240, 255, 255 });
        DrawRectangleLinesEx(infoPanel, 2, BLUE);

        DrawText("RECEIVER INFO PANEL",
            infoPanel.x + infoPanel.width / 2 - MeasureText("RECEIVER INFO PANEL", 22) / 2,
            infoPanel.y + 10, 22, DARKBLUE);

        // 绘制接收信息
        DrawText(TextFormat("Received Frames: %s", receivedInfo),
            infoPanel.x + 20, infoPanel.y + 40, 20, DARKGREEN);

        // 绘制ACK信息
        DrawText(TextFormat("Sent ACKs: %s", ackInfo),
            infoPanel.x + 20, infoPanel.y + 70, 20, DARKGREEN);

        // 绘制重传信息
        DrawText(TextFormat("Resend Info: %s", resendInfo),
            infoPanel.x + 20, infoPanel.y + 100, 20, MAROON);

        // 绘制状态信息
        DrawRectangle(20, 180, 960, 50, (Color) { 230, 230, 250, 255 });
        DrawLine(20, 180, 980, 180, DARKGRAY);
        DrawLine(20, 230, 980, 230, DARKGRAY);

        DrawText(TextFormat("Current State: %s",
            simState == IDLE ? "IDLE" :
            simState == SENDING ? "SENDING FRAMES" :
            simState == WAITING ? "WAITING" :
            simState == RESENDING ? "RESENDING" :
            "COMPLETE"), 30, 190, 20, DARKBLUE);

        DrawText(TextFormat("Next Sequence: %d", nextSeqToSend), 300, 190, 20, DARKBLUE);
        DrawText(TextFormat("Expected Sequence: %d", expectedSeq), 500, 190, 20, DARKBLUE);
        DrawText(TextFormat("Timer: %.1f/%.1f", timer, TIMEOUT_DURATION), 750, 190, 20, DARKBLUE);

        // 绘制统计数据
        DrawText(TextFormat("Frames Sent: %d", framesSent), 30, 450, 20, DARKGREEN);
        DrawText(TextFormat("Frames Delivered: %d", framesDelivered), 30, 475, 20, DARKGREEN);
        DrawText(TextFormat("Frames Retransmitted: %d", framesRetransmitted), 30, 500, 20, DARKGREEN);
        DrawText(TextFormat("Frames in Transit: %d", framesInTransit), 30, 525, 20, DARKGREEN);
        DrawText(TextFormat("ACKs in Transit: %d", acksInTransit), 30, 550, 20, DARKGREEN);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}