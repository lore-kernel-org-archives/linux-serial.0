From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: 8250_pxa: hide early console setup when disabled
Date: Wed,  9 Nov 2016 14:27:00 +0100
Message-ID: <20161109132725.2072258-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The newly added pxa glue driver for 8250 supports console output, but
fails to build if the 8250 console is disabled:

drivers/tty/serial/8250/8250_pxa.o: In function `early_serial_pxa_setup':
8250_pxa.c:(.init.text+0x50): undefined reference to `early_serial8250_setup'

This adds an #ifdef like the other glue drivers have it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 31f27d95d8b4..4d68731af534 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -170,6 +170,7 @@ static struct platform_driver serial_pxa_driver = {
 
 module_platform_driver(serial_pxa_driver);
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init early_serial_pxa_setup(struct earlycon_device *device,
 				  const char *options)
 {
@@ -182,6 +183,7 @@ static int __init early_serial_pxa_setup(struct earlycon_device *device,
 	return early_serial8250_setup(device, NULL);
 }
 OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
+#endif
 
 MODULE_AUTHOR("Sergei Ianovich");
 MODULE_LICENSE("GPL");
-- 
2.9.0
