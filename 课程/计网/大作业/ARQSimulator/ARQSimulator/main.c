#define _CRT_SECURE_NO_WARNINGS
#include "raylib.h"
#include <stdio.h>
#include <string.h>

// 帧结构体
typedef struct {
    Rectangle rect;
    char text[20];
    Color color;
    bool active;
    bool isAck;
    int seq;
    bool lost;
} Frame;

// 状态枚举
typedef enum {
    SEND_FRAME0,
    WAIT_ACK0,
    SEND_FRAME1,
    WAIT_ACK1
} State;

int main(void) {
    const int screenWidth = 1000;
    const int screenHeight = 600;
    InitWindow(screenWidth, screenHeight, "Stop-and-Wait ARQ Simulation");

    // 初始化发送方和接收方区域
    Rectangle senderArea = { 50, 200, 200, 200 };
    Rectangle receiverArea = { 750, 200, 200, 200 };

    // 初始化帧
    Frame dataFrame = { 0 };
    Frame ackFrame = { 0 };

    // 状态变量
    State currentState = SEND_FRAME0;
    float timer = 0.0f;
    bool lostMode = false;
    bool frameLost = false;
    bool ackLost = false;
    bool showWarning = false;

    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        // 处理输入
        if (IsKeyPressed(KEY_F)) {
            lostMode = !lostMode;
        }

        // 检测帧点击（丢帧模式）
        if (lostMode && IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {
            Vector2 mousePos = GetMousePosition();

            if (CheckCollisionPointRec(mousePos, dataFrame.rect)) {
                dataFrame.lost = true;
                frameLost = true;
            }

            if (CheckCollisionPointRec(mousePos, ackFrame.rect)) {
                ackFrame.lost = true;
                ackLost = true;
            }
        }

        // 状态机更新
        switch (currentState) {
        case SEND_FRAME0:
            // 初始化帧0
            dataFrame = (Frame){
                .rect = {senderArea.x + 50, senderArea.y + 80, 100, 50},
                .color = BLUE,
                .active = true,
                .isAck = false,
                .seq = 0,
                .lost = false
            };
            strcpy(dataFrame.text, "Frame0");
            timer = 0.0f;
            currentState = WAIT_ACK0;
            break;

        case WAIT_ACK0:
            // 帧0移动
            if (dataFrame.active && !dataFrame.lost) {
                dataFrame.rect.x += 3;

                // 到达接收方
                if (dataFrame.rect.x > receiverArea.x - 50) {
                    dataFrame.active = false;

                    // 发送ACK0
                    ackFrame = (Frame){
                        .rect = {receiverArea.x, receiverArea.y + 80, 100, 50},
                        .color = GREEN,
                        .active = true,
                        .isAck = true,
                        .seq = 0,
                        .lost = false
                    };
                    strcpy(ackFrame.text, "ACK0");
                }
            }

            // ACK0移动
            if (ackFrame.active && !ackFrame.lost) {
                ackFrame.rect.x -= 3;

                // 到达发送方
                if (ackFrame.rect.x < senderArea.x + 100) {
                    ackFrame.active = false;
                    currentState = SEND_FRAME1;
                }
            }

            // 超时处理
            timer += GetFrameTime();
            if (timer > 3.0f) {
                if (frameLost || ackLost) {
                    // 重传帧0
                    dataFrame = (Frame){
                        .rect = {senderArea.x + 50, senderArea.y + 80, 100, 50},
                        .color = BLUE,
                        .active = true,
                        .isAck = false,
                        .seq = 0,
                        .lost = false
                    };
                    strcpy(dataFrame.text, "Frame0");
                    timer = 0.0f;
                    frameLost = false;
                    ackLost = false;
                }
            }
            break;

        case SEND_FRAME1:
            // 初始化帧1
            dataFrame = (Frame){
                .rect = {senderArea.x + 50, senderArea.y + 80, 100, 50},
                .color = BLUE,
                .active = true,
                .isAck = false,
                .seq = 1,
                .lost = false
            };
            strcpy(dataFrame.text, "Frame1");
            timer = 0.0f;
            currentState = WAIT_ACK1;
            break;

        case WAIT_ACK1:
            // 帧1移动
            if (dataFrame.active && !dataFrame.lost) {
                dataFrame.rect.x += 3;

                // 到达接收方
                if (dataFrame.rect.x > receiverArea.x - 50) {
                    dataFrame.active = false;

                    // 发送ACK1
                    ackFrame = (Frame){
                        .rect = {receiverArea.x, receiverArea.y + 80, 100, 50},
                        .color = GREEN,
                        .active = true,
                        .isAck = true,
                        .seq = 1,
                        .lost = false
                    };
                    strcpy(ackFrame.text, "ACK1");
                }
            }

            // ACK1移动
            if (ackFrame.active && !ackFrame.lost) {
                ackFrame.rect.x -= 3;

                // 到达发送方
                if (ackFrame.rect.x < senderArea.x + 100) {
                    ackFrame.active = false;
                    currentState = SEND_FRAME0; // 回到帧0状态
                }
            }

            // 超时处理
            timer += GetFrameTime();
            if (timer > 3.0f) {
                if (frameLost || ackLost) {
                    // 重传帧1
                    dataFrame = (Frame){
                        .rect = {senderArea.x + 50, senderArea.y + 80, 100, 50},
                        .color = BLUE,
                        .active = true,
                        .isAck = false,
                        .seq = 1,
                        .lost = false
                    };
                    strcpy(dataFrame.text, "Frame1");
                    timer = 0.0f;
                    frameLost = false;
                    ackLost = false;
                }
            }
            break;
        }

        // 绘制
        BeginDrawing();
        ClearBackground(RAYWHITE);

        // 绘制发送方和接收方
        DrawRectangleRec(senderArea, LIGHTGRAY);
        DrawRectangleRec(receiverArea, LIGHTGRAY);
        DrawText("Sender", senderArea.x + 70, senderArea.y + 20, 20, DARKGRAY);
        DrawText("Receiver", receiverArea.x + 60, receiverArea.y + 20, 20, DARKGRAY);

        // 绘制帧
        if (dataFrame.active && !dataFrame.lost) {
            DrawRectangleRounded(dataFrame.rect, 0.3, 0, dataFrame.color);
            DrawText(dataFrame.text,
                dataFrame.rect.x + 20,
                dataFrame.rect.y + 15,
                20, WHITE);
        }

        if (ackFrame.active && !ackFrame.lost) {
            DrawRectangleRounded(ackFrame.rect, 0.3, 0, ackFrame.color);
            DrawText(ackFrame.text,
                ackFrame.rect.x + 30,
                ackFrame.rect.y + 15,
                20, WHITE);
        }

        // 绘制状态信息
        DrawText(TextFormat("Current State: %d", currentState), 20, 20, 20, DARKGRAY);
        DrawText(TextFormat("Timer: %.1f", timer), 20, 50, 20, DARKGRAY);

        // 绘制丢帧模式状态
        if (lostMode) {
            DrawText("LOST MODE: ON (Press F to toggle)", 20, 80, 20, RED);
            DrawText("Click frames to lose them", 20, 110, 20, RED);
        }
        else {
            DrawText("LOST MODE: OFF (Press F to toggle)", 20, 80, 20, DARKGRAY);
        }

        // 绘制丢失的帧标记
        if (dataFrame.lost) {
            DrawText("FRAME LOST!", dataFrame.rect.x, dataFrame.rect.y - 30, 20, RED);
        }

        if (ackFrame.lost) {
            DrawText("ACK LOST!", ackFrame.rect.x, ackFrame.rect.y - 30, 20, RED);
        }

        EndDrawing();
    }

    CloseWindow();
    return 0;
}