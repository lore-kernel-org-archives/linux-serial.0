From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: atmel: fix hardware handshake selection
Date: Tue, 12 Apr 2016 14:51:40 +0200
Message-ID: <1460465500-25396-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled") actually allowed to enable hardware
handshaking.
Before, the CRTSCTS flags was silently ignored.

As the DMA controller can't drive RTS (as explain in the commit message).
Ensure that hardware flow control stays disabled when DMA is used and FIFOs
are not available.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d9439e6ab719..954941dd8124 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -274,6 +274,13 @@ static bool atmel_use_dma_rx(struct uart_port *port)
 	return atmel_port->use_dma_rx;
 }
 
+static bool atmel_use_fifo(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	return atmel_port->fifo_size;
+}
+
 static unsigned int atmel_get_lines_status(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -2090,7 +2097,12 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		mode |= ATMEL_US_USMODE_RS485;
 	} else if (termios->c_cflag & CRTSCTS) {
 		/* RS232 with hardware handshake (RTS/CTS) */
-		mode |= ATMEL_US_USMODE_HWHS;
+		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
+			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
+			termios->c_cflag &= ~CRTSCTS;
+		} else {
+			mode |= ATMEL_US_USMODE_HWHS;
+		}
 	} else {
 		/* RS232 without hadware handshake */
 		mode |= ATMEL_US_USMODE_NORMAL;
-- 
2.8.0.rc3
