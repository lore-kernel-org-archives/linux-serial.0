From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: [PATCH] OMAP/serial: Support 1Mbaud and similar baudrates that
 require Mode16 instead of Mode13
Date: Wed, 16 Jan 2013 05:08:06 -0500
Message-ID: <20130116100806.GA57684@inertiallabs-linux64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:57760 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534Ab3APKI0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 05:08:26 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so426642eaa.36
        for <linux-serial@vger.kernel.org>; Wed, 16 Jan 2013 02:08:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

From: Alexey Pelykh <alexey.pelykh@gmail.com>

Original table in OMAP TRM named "UART Mode Baud Rates, Divisor
Values, and Error Rates" determines modes not for all common baud
rates. E.g. for 1000000 baud rate mode should be 16x, but according to
that table it's determined as 13x. According to current implementation
of mode divisor selection, after requesting 1000000 baudrate from
driver, later one will configure chip to use MODE13 divisor. Assuming
48Mhz as common UART clock speed, MODE13 divisor will effectively give
1230769 baudrate, what is quite far from desired 1000000 baudrate.
While with MODE16 divisor, chip will produce exact 1000000 baudrate.
In old driver that served UART devices (8250.c and serial_core.c) this
divisor could have been configured by user-space program, but in
omap_serial.c driver implementation this ability was not implemented
(afaik, by design) thus disallowing proper usage of MODE16-compatible
baudrates.

Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6d3d26a..6d567dd 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -182,24 +182,42 @@ static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 }
 
 /*
+ * serial_omap_baud_is_mode16 - check if baud rate is MODE16X
+ * @port: uart port info
+ * @baud: baudrate for which mode needs to be determined
+ *
+ * Returns true if baud rate is MODE16X and false if MODE13X
+ * Original table in OMAP TRM named "UART Mode Baud Rates, Divisor Values,
+ * and Error Rates" determines modes not for all common baud rates.
+ * E.g. for 1000000 baud rate mode must be 16x, but according to that
+ * table it's determined as 13x.
+ */
+static bool
+serial_omap_baud_is_mode16(struct uart_port *port, unsigned int baud)
+{
+	unsigned int n13 = port->uartclk / (13 * baud);
+	unsigned int n16 = port->uartclk / (16 * baud);
+	int baudAbsDiff13 = baud - (port->uartclk / (13 * n13));
+	int baudAbsDiff16 = baud - (port->uartclk / (16 * n16));
+	if(baudAbsDiff13 < 0)
+		baudAbsDiff13 = -baudAbsDiff13;
+	if(baudAbsDiff16 < 0)
+		baudAbsDiff16 = -baudAbsDiff16;
+
+	return (baudAbsDiff13 > baudAbsDiff16);
+}
+
+/*
  * serial_omap_get_divisor - calculate divisor value
  * @port: uart port info
  * @baud: baudrate for which divisor needs to be calculated.
- *
- * We have written our own function to get the divisor so as to support
- * 13x mode. 3Mbps Baudrate as an different divisor.
- * Reference OMAP TRM Chapter 17:
- * Table 17-1. UART Mode Baud Rates, Divisor Values, and Error Rates
- * referring to oversampling - divisor value
- * baudrate 460,800 to 3,686,400 all have divisor 13
- * except 3,000,000 which has divisor value 16
  */
 static unsigned int
 serial_omap_get_divisor(struct uart_port *port, unsigned int baud)
 {
 	unsigned int divisor;
 
-	if (baud > OMAP_MODE13X_SPEED && baud != 3000000)
+	if (!serial_omap_baud_is_mode16(port, baud))
 		divisor = 13;
 	else
 		divisor = 16;
@@ -893,7 +911,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, cval);
 
-	if (baud > 230400 && baud != 3000000)
+	if (!serial_omap_baud_is_mode16(port, baud))
 		up->mdr1 = UART_OMAP_MDR1_13X_MODE;
 	else
 		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
