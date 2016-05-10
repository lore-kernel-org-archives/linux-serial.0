From: Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH] tty: serial: msm: Disable restoring Rx interrupts for DMA Mode
Date: Tue, 10 May 2016 21:39:40 +0530
Message-ID: <1462896580-11554-1-git-send-email-absahu@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: agross@codeaurora.org, david.brown@linaro.org, andy.gross@linaro.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charanya <charanya@codeaurora.org>, Abhishek Sahu <absahu@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

From: Charanya <charanya@codeaurora.org>

The Data loss was happening with current QCOM MSM serial driver during
large file transfer due to simultaneous enabling of both UART and
DMA interrupt. When UART operates in DMA mode, RXLEV (Rx FIFO over
watermark) or RXSTALE (stale interrupts) should not be enabled,
since these conditions will be handled by DMA controller itself.
If these interrupts are enabled then normal UART ISR will read some
bytes of data from Rx Buffer and DMA controller will not receive
these bytes of data, which will cause data loss.

Now this patch removed the code for enabling of RXLEV and RXSTALE
interrupt in DMA Rx completion routine.

Signed-off-by: Charanya <charanya@codeaurora.org>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 96d3ce8..6262b18 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -388,10 +388,6 @@ static void msm_complete_rx_dma(void *args)
 	val &= ~dma->enable_bit;
 	msm_write(port, val, UARTDM_DMEN);
 
-	/* Restore interrupts */
-	msm_port->imr |= UART_IMR_RXLEV | UART_IMR_RXSTALE;
-	msm_write(port, msm_port->imr, UART_IMR);
-
 	if (msm_read(port, UART_SR) & UART_SR_OVERRUN) {
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
