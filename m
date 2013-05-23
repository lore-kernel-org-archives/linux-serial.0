From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] serial: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:39:36 +0900
Message-ID: <002f01ce57a1$d2016120$76042360$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58277 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758065Ab3EWKji (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 May 2013 06:39:38 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MN800FP9YXAY2Z0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 23 May 2013 19:39:36 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, "'David S. Miller'" <davem@davemloft.net>, 'Timur Tabi' <timur@tabi.org>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Also, unnecessary dev_set_drvdata() is removed, because the driver core
clears the driver data to NULL after device_release or on probe failure.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    4 ++--
 drivers/tty/serial/mpc52xx_uart.c           |    9 ++++-----
 drivers/tty/serial/of_serial.c              |    4 ++--
 drivers/tty/serial/sc26xx.c                 |    5 ++---
 drivers/tty/serial/sunhv.c                  |    6 ++----
 drivers/tty/serial/sunsab.c                 |    6 ++----
 drivers/tty/serial/sunsu.c                  |    8 +++-----
 drivers/tty/serial/sunzilog.c               |    6 ++----
 drivers/tty/serial/ucc_uart.c               |    5 ++---
 drivers/tty/serial/xilinx_uartps.c          |    6 ++----
 10 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 97f4e18..f7672ca 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1384,7 +1384,7 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 	if (index >= UART_NR)
 		return -ENODEV;
 
-	dev_set_drvdata(&ofdev->dev, pinfo);
+	platform_set_drvdata(ofdev, pinfo);
 
 	/* initialize the device pointer for the port */
 	pinfo->port.dev = &ofdev->dev;
@@ -1398,7 +1398,7 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 
 static int cpm_uart_remove(struct platform_device *ofdev)
 {
-	struct uart_cpm_port *pinfo = dev_get_drvdata(&ofdev->dev);
+	struct uart_cpm_port *pinfo = platform_get_drvdata(ofdev);
 	return uart_remove_one_port(&cpm_reg, &pinfo->port);
 }
 
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 510fa98..2c03904 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1362,15 +1362,14 @@ static int mpc52xx_uart_of_probe(struct platform_device *op)
 	if (ret)
 		return ret;
 
-	dev_set_drvdata(&op->dev, (void *)port);
+	platform_set_drvdata(op, (void *)port);
 	return 0;
 }
 
 static int
 mpc52xx_uart_of_remove(struct platform_device *op)
 {
-	struct uart_port *port = dev_get_drvdata(&op->dev);
-	dev_set_drvdata(&op->dev, NULL);
+	struct uart_port *port = platform_get_drvdata(op);
 
 	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
@@ -1382,7 +1381,7 @@ mpc52xx_uart_of_remove(struct platform_device *op)
 static int
 mpc52xx_uart_of_suspend(struct platform_device *op, pm_message_t state)
 {
-	struct uart_port *port = (struct uart_port *) dev_get_drvdata(&op->dev);
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(op);
 
 	if (port)
 		uart_suspend_port(&mpc52xx_uart_driver, port);
@@ -1393,7 +1392,7 @@ mpc52xx_uart_of_suspend(struct platform_device *op, pm_message_t state)
 static int
 mpc52xx_uart_of_resume(struct platform_device *op)
 {
-	struct uart_port *port = (struct uart_port *) dev_get_drvdata(&op->dev);
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(op);
 
 	if (port)
 		uart_resume_port(&mpc52xx_uart_driver, port);
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 39c7ea4..2caf9c6 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -204,7 +204,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 
 	info->type = port_type;
 	info->line = ret;
-	dev_set_drvdata(&ofdev->dev, info);
+	platform_set_drvdata(ofdev, info);
 	return 0;
 out:
 	kfree(info);
@@ -217,7 +217,7 @@ out:
  */
 static int of_platform_serial_remove(struct platform_device *ofdev)
 {
-	struct of_serial_info *info = dev_get_drvdata(&ofdev->dev);
+	struct of_serial_info *info = platform_get_drvdata(ofdev);
 	switch (info->type) {
 #ifdef CONFIG_SERIAL_8250
 	case PORT_8250 ... PORT_MAX_8250:
diff --git a/drivers/tty/serial/sc26xx.c b/drivers/tty/serial/sc26xx.c
index c973568..4b1434d 100644
--- a/drivers/tty/serial/sc26xx.c
+++ b/drivers/tty/serial/sc26xx.c
@@ -696,7 +696,7 @@ static int sc26xx_probe(struct platform_device *dev)
 	if (err)
 		goto out_remove_ports;
 
-	dev_set_drvdata(&dev->dev, up);
+	platform_set_drvdata(dev, up);
 	return 0;
 
 out_remove_ports:
@@ -716,7 +716,7 @@ out_free_port:
 
 static int __exit sc26xx_driver_remove(struct platform_device *dev)
 {
-	struct uart_sc26xx_port *up = dev_get_drvdata(&dev->dev);
+	struct uart_sc26xx_port *up = platform_get_drvdata(dev);
 
 	free_irq(up->port[0].irq, up);
 
@@ -728,7 +728,6 @@ static int __exit sc26xx_driver_remove(struct platform_device *dev)
 	kfree(up);
 	sc26xx_port = NULL;
 
-	dev_set_drvdata(&dev->dev, NULL);
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index ba60708..cf86e72 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -577,7 +577,7 @@ static int hv_probe(struct platform_device *op)
 	if (err)
 		goto out_remove_port;
 
-	dev_set_drvdata(&op->dev, port);
+	platform_set_drvdata(op, port);
 
 	return 0;
 
@@ -601,7 +601,7 @@ out_free_port:
 
 static int hv_remove(struct platform_device *dev)
 {
-	struct uart_port *port = dev_get_drvdata(&dev->dev);
+	struct uart_port *port = platform_get_drvdata(dev);
 
 	free_irq(port->irq, port);
 
@@ -612,8 +612,6 @@ static int hv_remove(struct platform_device *dev)
 	kfree(port);
 	sunhv_port = NULL;
 
-	dev_set_drvdata(&dev->dev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index a422c8b..5d6136b 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -1037,7 +1037,7 @@ static int sab_probe(struct platform_device *op)
 	if (err)
 		goto out3;
 
-	dev_set_drvdata(&op->dev, &up[0]);
+	platform_set_drvdata(op, &up[0]);
 
 	inst++;
 
@@ -1059,7 +1059,7 @@ out:
 
 static int sab_remove(struct platform_device *op)
 {
-	struct uart_sunsab_port *up = dev_get_drvdata(&op->dev);
+	struct uart_sunsab_port *up = platform_get_drvdata(op);
 
 	uart_remove_one_port(&sunsab_reg, &up[1].port);
 	uart_remove_one_port(&sunsab_reg, &up[0].port);
@@ -1070,8 +1070,6 @@ static int sab_remove(struct platform_device *op)
 		   up[0].port.membase,
 		   sizeof(union sab82532_async_regs));
 
-	dev_set_drvdata(&op->dev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 0d84657..699cc1b 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1454,7 +1454,7 @@ static int su_probe(struct platform_device *op)
 			kfree(up);
 			return err;
 		}
-		dev_set_drvdata(&op->dev, up);
+		platform_set_drvdata(op, up);
 
 		nr_inst++;
 
@@ -1483,7 +1483,7 @@ static int su_probe(struct platform_device *op)
 	if (err)
 		goto out_unmap;
 
-	dev_set_drvdata(&op->dev, up);
+	platform_set_drvdata(op, up);
 
 	nr_inst++;
 
@@ -1496,7 +1496,7 @@ out_unmap:
 
 static int su_remove(struct platform_device *op)
 {
-	struct uart_sunsu_port *up = dev_get_drvdata(&op->dev);
+	struct uart_sunsu_port *up = platform_get_drvdata(op);
 	bool kbdms = false;
 
 	if (up->su_type == SU_PORT_MS ||
@@ -1516,8 +1516,6 @@ static int su_remove(struct platform_device *op)
 	if (kbdms)
 		kfree(up);
 
-	dev_set_drvdata(&op->dev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 813ef8e..135a152 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1495,7 +1495,7 @@ static int zs_probe(struct platform_device *op)
 		kbm_inst++;
 	}
 
-	dev_set_drvdata(&op->dev, &up[0]);
+	platform_set_drvdata(op, &up[0]);
 
 	return 0;
 }
@@ -1512,7 +1512,7 @@ static void zs_remove_one(struct uart_sunzilog_port *up)
 
 static int zs_remove(struct platform_device *op)
 {
-	struct uart_sunzilog_port *up = dev_get_drvdata(&op->dev);
+	struct uart_sunzilog_port *up = platform_get_drvdata(op);
 	struct zilog_layout __iomem *regs;
 
 	zs_remove_one(&up[0]);
@@ -1521,8 +1521,6 @@ static int zs_remove(struct platform_device *op)
 	regs = sunzilog_chip_regs[up[0].port.line / 2];
 	of_iounmap(&op->resource[0], regs, sizeof(struct zilog_layout));
 
-	dev_set_drvdata(&op->dev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 7355303..c8ab8e4 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1451,7 +1451,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		goto out_np;
 	}
 
-	dev_set_drvdata(&ofdev->dev, qe_port);
+	platform_set_drvdata(ofdev, qe_port);
 
 	dev_info(&ofdev->dev, "UCC%u assigned to /dev/ttyQE%u\n",
 		qe_port->ucc_num + 1, qe_port->port.line);
@@ -1471,13 +1471,12 @@ out_free:
 
 static int ucc_uart_remove(struct platform_device *ofdev)
 {
-	struct uart_qe_port *qe_port = dev_get_drvdata(&ofdev->dev);
+	struct uart_qe_port *qe_port = platform_get_drvdata(ofdev);
 
 	dev_info(&ofdev->dev, "removing /dev/ttyQE%u\n", qe_port->port.line);
 
 	uart_remove_one_port(&ucc_uart_driver, &qe_port->port);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
 	kfree(qe_port);
 
 	return 0;
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b5f655d..6c91745 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -974,12 +974,11 @@ static int xuartps_probe(struct platform_device *pdev)
 		port->dev = &pdev->dev;
 		port->uartclk = clk_get_rate(clk);
 		port->private_data = clk;
-		dev_set_drvdata(&pdev->dev, port);
+		platform_set_drvdata(pdev, port);
 		rc = uart_add_one_port(&xuartps_uart_driver, port);
 		if (rc) {
 			dev_err(&pdev->dev,
 				"uart_add_one_port() failed; err=%i\n", rc);
-			dev_set_drvdata(&pdev->dev, NULL);
 			return rc;
 		}
 		return 0;
@@ -994,13 +993,12 @@ static int xuartps_probe(struct platform_device *pdev)
  **/
 static int xuartps_remove(struct platform_device *pdev)
 {
-	struct uart_port *port = dev_get_drvdata(&pdev->dev);
+	struct uart_port *port = platform_get_drvdata(pdev);
 	struct clk *clk = port->private_data;
 	int rc;
 
 	/* Remove the xuartps port from the serial core */
 	rc = uart_remove_one_port(&xuartps_uart_driver, port);
-	dev_set_drvdata(&pdev->dev, NULL);
 	port->mapbase = 0;
 	clk_disable_unprepare(clk);
 	return rc;
-- 
1.7.10.4


