From: Charanya Venkatraman <charanya@codeaurora.org>
Subject: [PATCH v2] tty:serial:msm:Do not restore Rx interrupts in DMA
Date: Fri,  3 Jun 2016 16:40:32 +0530
Message-ID: <1464952232-5778-1-git-send-email-charanya@codeaurora.org>
References: <1462896580-11554-1>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462896580-11554-1>
Sender: linux-kernel-owner@vger.kernel.org
To: agross@codeaurora.org, david.brown@linaro.org, andy.gross@linaro.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, absahu@codeaurora.org, njaigane@codeaurora.org, Charanya <charanya@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

From: Charanya <charanya@codeaurora.org>

Avoid data corruption issues that result in
CRC erros during file transfers over serial ports
at higher baud rates.

The current msm_serial driver masks the FIFO Rx
interrupts in msm_start_rx_dma() since Rx FIFO
interrupts are not required in DMA mode. However,
msm_complete_rx_dma() renables the Rx FIFO interrupt
which could cause RXSTALE event to be processed
when a TXLEV interrupt occurs.

The following is the sequence of events that
could occur resulting in data corruption

msm_start_rx_dma -> msm_complete_rx_dma -->
spin_unlock_irqrestore(&port->lock) -->  msm_uart_irq()
(For TXLEV interrupt) -->  msm_handle_rx_dm() (Read
from FIFO resulting in data corruption)

The patch fixes the issue by not restoring the RXLEV
and RXSTALE interrupts in msm_complete_rx_dma(). These
interrupts are required only in FIFO mode.

Signed-off-by: Charanya Venkatraman <charanya@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b7d80bd..646aa3f 100644
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
