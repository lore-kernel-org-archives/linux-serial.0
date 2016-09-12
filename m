From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv2 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Mon, 12 Sep 2016 11:47:32 +0200
Message-ID: <20160912094733.21501-3-richard.genoud@gmail.com>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160912094733.21501-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled") broke the hardware handshake when GPIOs
where used.

Hardware handshake with GPIOs used to work before this commit because
the CRTSCTS flag (termios->c_cflag) was set, but not the
ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
enabled, but not handled by the controller.

This commit restores this behaviour.

NB: -stable is not Cced because it doesn't cleanly apply on 4.1+
and it will also need previous commit:
"serial: mctrl_gpio: implement mctrl_gpio_use_rtscts"

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when hardware handshake is enabled")
---
 drivers/tty/serial/atmel_serial.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2eaa18ddef61..e9b4fbf88c2d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2025,6 +2025,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
 {
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
 	unsigned int old_mode, mode, imr, quot, baud;
 
@@ -2126,8 +2127,12 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		atmel_uart_writel(port, ATMEL_US_TTGR,
 				  port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
-	} else if (termios->c_cflag & CRTSCTS) {
-		/* RS232 with hardware handshake (RTS/CTS) */
+	} else if ((termios->c_cflag & CRTSCTS) &&
+		   !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
+		/*
+		 * RS232 with hardware handshake (RTS/CTS)
+		 * handled by the controller.
+		 */
 		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
 			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
 			termios->c_cflag &= ~CRTSCTS;
@@ -2135,7 +2140,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 			mode |= ATMEL_US_USMODE_HWHS;
 		}
 	} else {
-		/* RS232 without hadware handshake */
+		/* RS232 without hadware handshake or controlled by GPIOs */
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
