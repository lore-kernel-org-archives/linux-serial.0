From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 3/3] tty/serial: at91: fix hardware handshake when DMA is not used
Date: Wed,  7 Sep 2016 18:13:24 +0200
Message-ID: <20160907161324.27774-3-richard.genoud@gmail.com>
References: <20160907161324.27774-1-richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160907161324.27774-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled") broke the hardware handshake when
DMA is not used.

So, here's a summary:
If DMA is NOT USED the mode should be ATMEL_US_USMODE_NORMAL because the
controller can't drive the RTS pin (there's no way for it to know when
we can't receive data anymore).

If DMA is USED along with FIFOs, the mode should be ATMEL_US_USMODE_HWHS
because when there's a FIFO, it can know when it's full and then drive
the RTS pin accordingly.
NB: I didn't test this mode since my board (at91sam9g35-cm) has not the
FIFO mechanism.

If DMA is USED WITHOUT FIFOs, then this is the bad case: the controller
can't control the RTS pin, and we can't control it either by hand. So,
the hardware handshake is disabled. (that's what commit 5be605ac9af9
("tty/serial: atmel: fix hardware handshake selection") did).

There's still something obscure to me:
In the SAM9G35 datasheet, it's said that
"Setting the USART to operate with hardware handshaking is performed by
writing the USART_MODE field in US_MR to the value 0x2.
[..] Using this mode requires using the DMA channel for reception."

So, according to this, it *should* be possible to use automatic hardware
handshake with the DMA and without FIFO (sam9x5 have no FIFOs like
samad controllers)

NB: -stable is not Cced because it doesn't cleanly apply on 4.1+

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when hardware handshake is enabled")
---
 drivers/tty/serial/atmel_serial.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e9b4fbf88c2d..503fbc623227 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2130,14 +2130,26 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	} else if ((termios->c_cflag & CRTSCTS) &&
 		   !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
 		/*
-		 * RS232 with hardware handshake (RTS/CTS)
-		 * handled by the controller.
+		 * Automatic hardware handshake (RTS/CTS) only work with
+		 * DMA enabled and FIFOs.
+		 * TODO: sam9x5 controllers don't have FIFOs like samad
+		 * controllers, and yet, the datasheet says that the
+		 * ATMEL_US_USMODE_HWHS can be used with (and only with) a DMA
+		 * channel for reception.
 		 */
-		if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
-			dev_info(port->dev, "not enabling hardware flow control because DMA is used");
-			termios->c_cflag &= ~CRTSCTS;
+		if (atmel_use_dma_rx(port)) {
+			if (atmel_use_fifo(port)) {
+				mode |= ATMEL_US_USMODE_HWHS;
+			} else {
+				dev_info(port->dev, "not enabling hardware flow control because DMA is used without fifo");
+				termios->c_cflag &= ~CRTSCTS;
+			}
 		} else {
-			mode |= ATMEL_US_USMODE_HWHS;
+			/*
+			 * if DMA is not used, tell the controller that it
+			 * should not handle the RTS pin automatically
+			 */
+			mode |= ATMEL_US_USMODE_NORMAL;
 		}
 	} else {
 		/* RS232 without hadware handshake or controlled by GPIOs */
