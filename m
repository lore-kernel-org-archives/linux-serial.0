From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 4/8] drivers: tty: serial: use devm_ioremap_resource()
Date: Tue, 12 Mar 2019 15:57:36 +0100
Message-ID: <1552402660-31730-5-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

instead of fetching out start and len from a struct resource for
passing it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_lpc18xx.c  | 3 +--
 drivers/tty/serial/8250/8250_mtk.c      | 3 +--
 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 drivers/tty/serial/amba-pl010.c         | 3 +--
 drivers/tty/serial/samsung.c            | 2 +-
 drivers/tty/serial/sirfsoc_uart.c       | 3 +--
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index eddf119..f36902b 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -119,8 +119,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	memset(&uart, 0, sizeof(uart));
 
-	uart.port.membase = devm_ioremap(&pdev->dev, res->start,
-					 resource_size(res));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c1fdbc0..bf6eb8d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -383,8 +383,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 164ba13..9c1244e 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -171,7 +171,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	membase = devm_ioremap(dev, regs->start, resource_size(regs));
+	membase = devm_ioremap_resource(dev, regs);
 	if (!membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11..109b8df 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -713,8 +713,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!uap)
 		return -ENOMEM;
 
-	base = devm_ioremap(&dev->dev, dev->res.start,
-			    resource_size(&dev->res));
+	base = devm_ioremap_resource(&dev->dev, &dev->res);
 	if (!base)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 83fd516..a49cf15 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1775,7 +1775,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dbg("resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(port->dev, res);
 	if (!port->membase) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 38622f2..db2e08d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1359,8 +1359,7 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		goto err;
 	}
 	port->mapbase = res->start;
-	port->membase = devm_ioremap(&pdev->dev,
-			res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (!port->membase) {
 		dev_err(&pdev->dev, "Cannot remap resource.\n");
 		ret = -ENOMEM;
-- 
1.9.1
