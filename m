From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] tty: serial: lpc32xx_hs: fix missing console boot messages
Date: Tue, 15 Jan 2019 18:18:14 +0100
Message-ID: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>, Roland Stigge <stigge@antcom.de>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-serial@vger.kernel.org

When probing the HSUART, it is put in loopback mode in order to prevent a
potential issue that may happen on RX (Errata HSUART.1).

serial_lpc32xx_startup() moves it out of loopback mode but this is too late
to get the kernel boot messages before userspace opens the device.

Also get out of loopback mode in lpc32xx_hsuart_console_setup().

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/tty/serial/lpc32xx_hs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index d1d73261575b..f4e27d0ad947 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -151,6 +151,8 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
+static void lpc32xx_loopback_set(resource_size_t mapbase, int state);
+
 static int __init lpc32xx_hsuart_console_setup(struct console *co,
 					       char *options)
 {
@@ -170,6 +172,8 @@ static int __init lpc32xx_hsuart_console_setup(struct console *co,
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	lpc32xx_loopback_set(port->mapbase, 0); /* get out of loopback mode */
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-- 
2.20.1
