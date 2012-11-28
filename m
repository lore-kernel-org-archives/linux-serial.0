From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Fwd: [PULL REQUEST] Tweak to support 1Mbaud and similar baudrates
 that require Mode16 instead of Mode13
Date: Wed, 28 Nov 2012 11:05:08 +0200
Message-ID: <CAOmKuSr+PYcs37DdiOj+h8wq0hjrdtHN4pCUvj-y97fr6-0DCA@mail.gmail.com>
References: <CAOmKuSpRJhBibSDxTFCH157-XokhaFhvQ-gYxKZe+PfzokaBoA@mail.gmail.com>
	<CAOmKuSpjitfTeeXz6VKQbhe+iUFb8wYy4n3tAzbjr9g_GOAn4g@mail.gmail.com>
	<CAOmKuSrQW1j_tmQNbXMO-GUH7zrUR0WR3K4rJNok=2LZmRKVYg@mail.gmail.com>
	<20121128004204.GB3857@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50907 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab2K1JFJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 04:05:09 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so9915886vcm.19
        for <linux-serial@vger.kernel.org>; Wed, 28 Nov 2012 01:05:09 -0800 (PST)
In-Reply-To: <20121128004204.GB3857@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Original table in OMAP TRM named "UART Mode Baud Rates, Divisor
Values, and Error Rates" determines modes not for all common baud
rates. E.g. for 1000000 baud rate mode should be 16x, but according to
that table it's determined as 13x. According to current implementation
of mode
divisor selection, after requesting 1000000 baudrate from driver,
later one will configure chip to use MODE13 divisor. Assuming 48Mhz as
common UART clock speed, MODE13 divisor will effectively give 1230769
baudrate, what is quite far from desired 1000000 baudrate. While with
MODE16 divisor, chip will produce exact 1000000 baudrate.

In old driver that served UART devices (8250.c and serial_core.c) this
divisor could have been configured by user-space program, but in
omap_serial.c driver implementation this ability was not implemented
(afaik, by design) thus disallowing proper usage of MODE16-compatible
baudrates.

Changes: I've fixed styling errors using ./scripts/checkpatch.pl

Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://github.com/alexey-pelykh/linux.git omap_serial_mode_fix

for you to fetch changes up to cf827bb4057fdcdaeac20b95b01c29c068109185:

  Tweak to support 1Mbaud and similar baudrates that require Mode16
instead of Mode13 (2012-11-12 19:29:27 +0200)

----------------------------------------------------------------
Alexey Pelykh (1):
      Tweak to support 1Mbaud and similar baudrates that require
Mode16 instead of Mode13

 drivers/tty/serial/omap-serial.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6d3d26a..6d567dd 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -182,24 +182,42 @@ static void serial_omap_enable_wakeup(struct
uart_omap_port *up, bool enable)
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
+       unsigned int n13 = port->uartclk / (13 * baud);
+       unsigned int n16 = port->uartclk / (16 * baud);
+       int baudAbsDiff13 = baud - (port->uartclk / (13 * n13));
+       int baudAbsDiff16 = baud - (port->uartclk / (16 * n16));
+       if (baudAbsDiff13 < 0)
+               baudAbsDiff13 = -baudAbsDiff13;
+       if (baudAbsDiff16 < 0)
+               baudAbsDiff16 = -baudAbsDiff16;
+
+       return (baudAbsDiff13 > baudAbsDiff16);
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

-       if (baud > OMAP_MODE13X_SPEED && baud != 3000000)
+       if (!serial_omap_baud_is_mode16(port, baud))
                divisor = 13;
        else
                divisor = 16;
@@ -893,7 +911,7 @@ serial_omap_set_termios(struct uart_port *port,
struct ktermios *termios,
        serial_out(up, UART_EFR, up->efr);
        serial_out(up, UART_LCR, cval);

-       if (baud > 230400 && baud != 3000000)
+       if (!serial_omap_baud_is_mode16(port, baud))
                up->mdr1 = UART_OMAP_MDR1_13X_MODE;
        else
                up->mdr1 = UART_OMAP_MDR1_16X_MODE;
