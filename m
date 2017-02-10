From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] atmel_serial: Use the fractional divider when possible
Date: Fri, 10 Feb 2017 16:24:46 +0100
Message-ID: <20170210152446.12674-1-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Genoud <richard.genoud@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

The fractional baud rate generator is available when using the
asynchronous mode of Atmel USART controllers. It makes it possible to
use higher baudrates, in exchange for a less precise clock with a
variable duty cycle.

The existing code restricts its use to the normal mode of the USART
controller, following the recommendation from the datasheet for the
first chip embedding this type of controller. This recommendation has
been removed from the documentation for the newer chips. After
verification, all revisions of this controller should be able to use the
fractional baud rate generator with the different asynchronous modes.

Removing the condition on ATMEL_US_USMODE makes it possible to get
correct baudrates at high speed in more cases.

This was tested with a board using an Atmel SAMA5D2 chip and a TI
WL1831 WiFi/Bluetooth combo chip at 3 Mbauds, with hardware flow control
enabled.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index fabbe76203bb..6684456dca9e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1758,7 +1758,9 @@ static void atmel_get_ip_name(struct uart_port *port)
 
 	/*
 	 * Only USART devices from at91sam9260 SOC implement fractional
-	 * baudrate.
+	 * baudrate. It is available for all asynchronous modes, with the
+	 * following restriction: the sampling clock's duty cycle is not
+	 * constant.
 	 */
 	atmel_port->has_frac_baudrate = false;
 	atmel_port->has_hw_timer = false;
@@ -2202,8 +2204,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * then
 	 * 8 CD + FP = selected clock / (2 * baudrate)
 	 */
-	if (atmel_port->has_frac_baudrate &&
-	    (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
+	if (atmel_port->has_frac_baudrate) {
 		div = DIV_ROUND_CLOSEST(port->uartclk, baud * 2);
 		cd = div >> 3;
 		fp = div & ATMEL_US_FP_MASK;
-- 
2.9.3
