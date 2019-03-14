From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH v2 45/45] drivers: tty: serial: mux: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:15 +0100
Message-ID: <1552602855-26086-46-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, andriy.shevchenko@linux.intel.com, vz@mleia.com, matthias.bgg@gmail.com, yamada.masahiro@socionext.com, tklauser@distanz.ch, richard.genoud@gmail.com, macro@linux-mips.org, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, slemieux.tyco@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/mux.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e..cd08f0f 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -456,8 +456,9 @@ static int __init mux_probe(struct parisc_device *dev)
 	printk(KERN_INFO "Serial mux driver (%d ports) Revision: 0.6\n", port_count);
 
 	dev_set_drvdata(&dev->dev, (void *)(long)port_count);
-	request_mem_region(dev->hpa.start + MUX_OFFSET,
-                           port_count * MUX_LINE_OFFSET, "Mux");
+	devm_request_mem_region(&dev->dev,
+				dev->hpa.start + MUX_OFFSET,
+				port_count * MUX_LINE_OFFSET, "Mux");
 
 	if(!port_cnt) {
 		mux_driver.cons = MUX_CONSOLE;
@@ -474,7 +475,9 @@ static int __init mux_probe(struct parisc_device *dev)
 		port->iobase	= 0;
 		port->mapbase	= dev->hpa.start + MUX_OFFSET +
 						(i * MUX_LINE_OFFSET);
-		port->membase	= ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
+		port->membase	= devm_ioremap_nocache(port->dev,
+						       port->mapbase,
+						       MUX_LINE_OFFSET);
 		port->iotype	= UPIO_MEM;
 		port->type	= PORT_MUX;
 		port->irq	= 0;
@@ -517,10 +520,12 @@ static int __exit mux_remove(struct parisc_device *dev)
 
 		uart_remove_one_port(&mux_driver, port);
 		if(port->membase)
-			iounmap(port->membase);
+			devm_iounmap(port->dev, port->membase);
 	}
 
-	release_mem_region(dev->hpa.start + MUX_OFFSET, port_count * MUX_LINE_OFFSET);
+	devm_release_mem_region(&dev->dev,
+				dev->hpa.start + MUX_OFFSET,
+				port_count * MUX_LINE_OFFSET);
 	return 0;
 }
 
-- 
1.9.1
