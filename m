From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: specify transmit FIFO size
Date: Fri, 13 Mar 2015 14:51:50 +0100
Message-ID: <1426254711-618-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

Specify transmit FIFO size which might be different depending on
LPUART instance. This makes sure uart_wait_until_sent in serial
core getting called, which in turn waits and checks if the FIFO
is really empty on shutdown by using the tx_empty callback.
Without the call of this callback, the last several characters
might not yet be transmitted when closing the serial port. This
can be reproduced by simply using echo and redirect the output to
a ttyLP device.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Greg,

Another two fixes for this driver. I think they both are worthwhile
fixes to be part of stable kernels too...

--
Stefan

 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b1893f3..7ec9110 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1076,6 +1076,8 @@ static int lpuart_startup(struct uart_port *port)
 	sport->txfifo_size = 0x1 << (((temp >> UARTPFIFO_TXSIZE_OFF) &
 		UARTPFIFO_FIFOSIZE_MASK) + 1);
 
+	sport->port.fifosize = sport->txfifo_size;
+
 	sport->rxfifo_size = 0x1 << (((temp >> UARTPFIFO_RXSIZE_OFF) &
 		UARTPFIFO_FIFOSIZE_MASK) + 1);
 
-- 
2.3.1
