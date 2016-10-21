From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] serial: 8250: pxa: add devicetree earlyconsole
Date: Sat, 22 Oct 2016 00:06:21 +0200
Message-ID: <1477087581-1836-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-serial@vger.kernel.org

Transfer the device-tree pxa uart handling from 8250_of to the new
8250_pxa.  As a corollary, add the early console definition into
8250_pxa.

This enables to have the same uart node for the early console and the
normal uart.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/tty/serial/8250/8250_of.c  |  2 --
 drivers/tty/serial/8250/8250_pxa.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 7a8b5fc81a19..d25ab1cd4295 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -332,8 +332,6 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F128, },
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
-	{ .compatible = "mrvl,pxa-uart",
-		.data = (void *)PORT_XSCALE, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 6a14df013754..3b08f342851a 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -172,6 +172,19 @@ static struct platform_driver serial_pxa_driver = {
 
 module_platform_driver(serial_pxa_driver);
 
+static int __init early_serial_pxa_setup(struct earlycon_device *device,
+				  const char *options)
+{
+	struct uart_port *port = &device->port;
+
+	if (!(device->port.membase || device->port.iobase))
+		return -ENODEV;
+
+	port->regshift = 2;
+	return early_serial8250_setup(device, NULL);
+}
+OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
+
 MODULE_AUTHOR("Sergei Ianovich");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pxa2xx-uart");
-- 
2.1.4
