From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] tty: serial: vt8500: fix annotations for probe/remove
Date: Sun, 11 Mar 2012 15:02:38 +0100
Message-ID: <1331474558-14281-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48049 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab2CKOCF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Mar 2012 10:02:05 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Charkov <alchark@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>

Fixes:

WARNING: drivers/tty/serial/built-in.o(.data+0x30): Section mismatch in reference from the variable vt8500_platform_driver to the function .init.text:vt8500_serial_probe()
The variable vt8500_platform_driver references
the function __init vt8500_serial_probe()

And mark the remove pointer while we are here.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/tty/serial/vt8500_serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 026cb9e..2be006f 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -544,7 +544,7 @@ static struct uart_driver vt8500_uart_driver = {
 	.cons		= VT8500_CONSOLE,
 };
 
-static int __init vt8500_serial_probe(struct platform_device *pdev)
+static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 {
 	struct vt8500_port *vt8500_port;
 	struct resource *mmres, *irqres;
@@ -605,7 +605,7 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
 
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
-	.remove = vt8500_serial_remove,
+	.remove = __devexit_p(vt8500_serial_remove),
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
-- 
1.7.2.5

