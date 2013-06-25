From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V2] serial: remove unnecessary platform_set_drvdata()
Date: Tue, 25 Jun 2013 10:08:49 +0900
Message-ID: <000301ce7140$8d14f690$a73ee3b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40776 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab3FYBIv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Jun 2013 21:08:51 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOX00011CIQGJ60@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 25 Jun 2013 10:08:50 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, Barry Song <baohua.song@csr.com>, Tony Prisk <linux@prisktech.co.nz>, Shawn Guo <shawn.guo@linaro.org>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Barry Song <baohua.song@csr.com>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/ar933x_uart.c   |    1 -
 drivers/tty/serial/atmel_serial.c  |    1 -
 drivers/tty/serial/bcm63xx_uart.c  |    1 -
 drivers/tty/serial/clps711x.c      |   11 ++---------
 drivers/tty/serial/efm32-uart.c    |    2 --
 drivers/tty/serial/imx.c           |    2 --
 drivers/tty/serial/netx-serial.c   |    2 --
 drivers/tty/serial/pmac_zilog.c    |    1 -
 drivers/tty/serial/pnx8xxx_uart.c  |    2 --
 drivers/tty/serial/pxa.c           |    2 --
 drivers/tty/serial/sa1100.c        |    2 --
 drivers/tty/serial/sccnxp.c        |    3 ---
 drivers/tty/serial/sirfsoc_uart.c  |    3 +--
 drivers/tty/serial/vt8500_serial.c |    1 -
 14 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 27f20c5..9824dfb 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -703,7 +703,6 @@ static int ar933x_uart_remove(struct platform_device *pdev)
 	struct ar933x_uart_port *up;
 
 	up = platform_get_drvdata(pdev);
-	platform_set_drvdata(pdev, NULL);
 
 	if (up) {
 		uart_remove_one_port(&ar933x_uart_driver, &up->port);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3467462..a7ca0e7 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1847,7 +1847,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
 	int ret = 0;
 
 	device_init_wakeup(&pdev->dev, 0);
-	platform_set_drvdata(pdev, NULL);
 
 	ret = uart_remove_one_port(&atmel_uart, port);
 
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 6fa2ae7..d14ba5a 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -852,7 +852,6 @@ static int bcm_uart_remove(struct platform_device *pdev)
 
 	port = platform_get_drvdata(pdev);
 	uart_remove_one_port(&bcm_uart_driver, port);
-	platform_set_drvdata(pdev, NULL);
 	/* mark port as free */
 	ports[pdev->id].membase = 0;
 	return 0;
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index bfb1796..7e4e408 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -438,8 +438,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	s->uart_clk = devm_clk_get(&pdev->dev, "uart");
 	if (IS_ERR(s->uart_clk)) {
 		dev_err(&pdev->dev, "Can't get UART clocks\n");
-		ret = PTR_ERR(s->uart_clk);
-		goto err_out;
+		return PTR_ERR(s->uart_clk);
 	}
 
 	s->uart.owner		= THIS_MODULE;
@@ -461,7 +460,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Registering UART driver failed\n");
 		devm_clk_put(&pdev->dev, s->uart_clk);
-		goto err_out;
+		return ret;
 	}
 
 	for (i = 0; i < UART_CLPS711X_NR; i++) {
@@ -478,11 +477,6 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_out:
-	platform_set_drvdata(pdev, NULL);
-
-	return ret;
 }
 
 static int uart_clps711x_remove(struct platform_device *pdev)
@@ -495,7 +489,6 @@ static int uart_clps711x_remove(struct platform_device *pdev)
 
 	devm_clk_put(&pdev->dev, s->uart_clk);
 	uart_unregister_driver(&s->uart);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 7d199c8..e029907 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -778,8 +778,6 @@ static int efm32_uart_remove(struct platform_device *pdev)
 {
 	struct efm32_uart_port *efm_port = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	uart_remove_one_port(&efm32_uart_reg, &efm_port->port);
 
 	if (pdev->id >= 0 && pdev->id < ARRAY_SIZE(efm32_uart_ports))
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 415cec6..7b0f956 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1605,8 +1605,6 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 
-	platform_set_drvdata(pdev, NULL);
-
 	uart_remove_one_port(&imx_reg, &sport->port);
 
 	if (pdata && pdata->exit)
diff --git a/drivers/tty/serial/netx-serial.c b/drivers/tty/serial/netx-serial.c
index b9a40ed..ce04f3f 100644
--- a/drivers/tty/serial/netx-serial.c
+++ b/drivers/tty/serial/netx-serial.c
@@ -693,8 +693,6 @@ static int serial_netx_remove(struct platform_device *pdev)
 {
 	struct netx_port *sport = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (sport)
 		uart_remove_one_port(&netx_reg, &sport->port);
 
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index b1785f5..f87f1a0 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1798,7 +1798,6 @@ static int __exit pmz_detach(struct platform_device *pdev)
 
 	uart_remove_one_port(&pmz_uart_reg, &uap->port);
 
-	platform_set_drvdata(pdev, NULL);
 	uap->port.dev = NULL;
 
 	return 0;
diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 7e277a5..b6b7aca 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -801,8 +801,6 @@ static int pnx8xxx_serial_remove(struct platform_device *pdev)
 {
 	struct pnx8xxx_port *sport = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (sport)
 		uart_remove_one_port(&pnx8xxx_reg, &sport->port);
 
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 05f504e..ac8b2f5 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -945,8 +945,6 @@ static int serial_pxa_remove(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport = platform_get_drvdata(dev);
 
-	platform_set_drvdata(dev, NULL);
-
 	uart_remove_one_port(&serial_pxa_reg, &sport->port);
 
 	clk_unprepare(sport->clk);
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index af6b3e3..fc23ea19 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -864,8 +864,6 @@ static int sa1100_serial_remove(struct platform_device *pdev)
 {
 	struct sa1100_port *sport = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (sport)
 		uart_remove_one_port(&sa1100_reg, &sport->port);
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index c773041..9855517 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -997,8 +997,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 	}
 
 err_out:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
@@ -1016,7 +1014,6 @@ static int sccnxp_remove(struct platform_device *pdev)
 		uart_remove_one_port(&s->uart, &s->port[i]);
 
 	uart_unregister_driver(&s->uart);
-	platform_set_drvdata(pdev, NULL);
 
 	if (!IS_ERR(s->regulator))
 		return regulator_disable(s->regulator);
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 1fd564b..67a0d1b 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -717,7 +717,6 @@ port_err:
 	clk_disable_unprepare(sirfport->clk);
 	clk_put(sirfport->clk);
 clk_err:
-	platform_set_drvdata(pdev, NULL);
 	if (sirfport->hw_flow_ctrl)
 		pinctrl_put(sirfport->p);
 err:
@@ -728,7 +727,7 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 {
 	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
-	platform_set_drvdata(pdev, NULL);
+
 	if (sirfport->hw_flow_ctrl)
 		pinctrl_put(sirfport->p);
 	clk_disable_unprepare(sirfport->clk);
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 48af43d..a90bf04 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -630,7 +630,6 @@ static int vt8500_serial_remove(struct platform_device *pdev)
 {
 	struct vt8500_port *vt8500_port = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	clk_disable_unprepare(vt8500_port->clk);
 	uart_remove_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 
-- 
1.7.10.4


