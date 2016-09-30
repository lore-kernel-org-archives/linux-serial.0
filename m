From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv4 3/3] tty/serial: at91: fix hardware handshake on SAM9x5 (without GPIOs)
Date: Fri, 30 Sep 2016 10:58:01 +0200
Message-ID: <20160930085801.21497-4-richard.genoud@gmail.com>
References: <20160930085801.21497-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160930085801.21497-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled") broke the hardware handshake on SAM9x5
platforms.

On Atmel platforms, the USART can only handle the handware handshake
(ATMEL_US_USMODE_HWHS) if FIFOs or PDC are used.

Thus, ATMEL_US_USMODE_HWHS mode should only be used in this case.

For SAM9x5, there's no FIFOs nor PDC for the USART, so the mode should
be ATMEL_US_USMODE_NORMAL and the RTS pin should be controlled by the
driver.

NB: -stable is not Cced because it doesn't cleanly apply on 4.1+

Tested on SAM9G35-CM with and without DMA

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when hardware handshake is enabled")
---
 drivers/tty/serial/atmel_serial.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index b01b68ece35c..4d033e6af44a 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2131,19 +2131,23 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 				  port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else if ((termios->c_cflag & CRTSCTS) &&
-		   !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
+		   !mctrl_gpio_use_rtscts(atmel_port->gpios) &&
+		   (atmel_use_pdc_rx(port) || atmel_use_fifo(port))) {
 		/*
-		 * RS232 with hardware handshake (RTS/CTS)
-		 * handled by the controller.
+		 * Automatic hardware handshake (RTS/CTS) only work with
+		 * FIFOs or PDC.
+		 * Meaning that on SAM9x5 the controller can't handle
+		 * the hardware handshake (no FIFOs nor PDC on these platforms).
 		 */
-		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
-			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
-			termios->c_cflag &= ~CRTSCTS;
-		} else {
-			mode |= ATMEL_US_USMODE_HWHS;
-		}
+		mode |= ATMEL_US_USMODE_HWHS;
 	} else {
-		/* RS232 without hardware handshake or controlled by GPIOs */
+		/*
+		 * Other cases are:
+		 * - RS232 without hardware handshake
+		 * - RS232 with hardware handshake and:
+		 *   - controller unable to handle CTS/RTS by itself
+		 *   - or CTS/RTS handled by GPIOs
+		 */
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
