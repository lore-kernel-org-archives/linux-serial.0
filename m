From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCHv2 3/3] tty/serial: at91: fix hardware handshake on SAM9x5 (without GPIOs)
Date: Mon, 12 Sep 2016 11:47:33 +0200
Message-ID: <20160912094733.21501-4-richard.genoud@gmail.com>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160912094733.21501-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>
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
 drivers/tty/serial/atmel_serial.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e9b4fbf88c2d..32154e7231ce 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2130,15 +2130,19 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	} else if ((termios->c_cflag & CRTSCTS) &&
 		   !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
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
+		if (atmel_use_pdc_rx(port) || atmel_use_fifo(port))
 			mode |= ATMEL_US_USMODE_HWHS;
-		}
+		else
+			/*
+			 * The hardware handshake won't be handle by the
+			 * controller but by the driver.
+			 */
+			mode |= ATMEL_US_USMODE_NORMAL;
 	} else {
 		/* RS232 without hadware handshake or controlled by GPIOs */
 		mode |= ATMEL_US_USMODE_NORMAL;
