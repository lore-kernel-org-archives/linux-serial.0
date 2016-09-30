From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv4 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Fri, 30 Sep 2016 10:58:00 +0200
Message-ID: <20160930085801.21497-3-richard.genoud@gmail.com>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930085801.21497-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled") broke the hardware handshake when GPIOs
were used.

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
 drivers/tty/serial/atmel_serial.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index fd8aa1f4ba78..b01b68ece35c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2130,8 +2130,12 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2139,7 +2143,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 			mode |= ATMEL_US_USMODE_HWHS;
 		}
 	} else {
-		/* RS232 without hadware handshake */
+		/* RS232 without hardware handshake or controlled by GPIOs */
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
