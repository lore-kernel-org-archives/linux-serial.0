From: Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 1/2] tty: serial: msm_serial regression fix data corruption
Date: Sat, 23 Apr 2016 10:14:32 -0700
Message-ID: <571BAD78.4020609@gmail.com>
References: <571BAC8B.80001@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <571BAC8B.80001@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

From: Frank Rowand <frank.rowand@am.sony.com>

Commit 3a878c430fd6 ("tty: serial: msm: Add TX DMA support") regression.
The calculation of tx_count was moved from the old msm_handle_tx(),
now renamed msm_handle_tx_pio(), to the new msm_handle_tx().  The
move left out one size test.

The regression seen on the qcom-apq8074-dragonboard is dropped
characters and corrupted characters (values greater than 0x7f)
when DMA is not enabled.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/msm_serial.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/tty/serial/msm_serial.c
===================================================================
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -727,6 +727,8 @@ static void msm_handle_tx(struct uart_po
 	}
 
 	pio_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
+	pio_count = min3(pio_count, (unsigned int)UART_XMIT_SIZE - xmit->tail,
+			port->fifosize);
 	dma_count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
 	dma_min = 1;	/* Always DMA */
@@ -738,9 +740,6 @@ static void msm_handle_tx(struct uart_po
 			dma_count = UARTDM_TX_MAX;
 	}
 
-	if (pio_count > port->fifosize)
-		pio_count = port->fifosize;
-
 	if (!dma->chan || dma_count < dma_min)
 		msm_handle_tx_pio(port, pio_count);
 	else
