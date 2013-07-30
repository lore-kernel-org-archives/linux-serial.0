From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 14/35] serial: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:06:57 +0900
Message-ID: <003f01ce8cfb$c334cb20$499e6160$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45220 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab3G3IHA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jul 2013 04:07:00 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ00J7NP7M5CQ0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 30 Jul 2013 17:06:58 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/8250/8250_core.c  |    2 +-
 drivers/tty/serial/altera_jtaguart.c |    3 ++-
 drivers/tty/serial/altera_uart.c     |    2 +-
 drivers/tty/serial/amba-pl010.c      |    2 +-
 drivers/tty/serial/amba-pl011.c      |   14 +++++++-------
 drivers/tty/serial/ar933x_uart.c     |    2 +-
 drivers/tty/serial/arc_uart.c        |    2 +-
 drivers/tty/serial/atmel_serial.c    |   10 +++++-----
 drivers/tty/serial/bfin_sport_uart.c |    7 ++++---
 drivers/tty/serial/bfin_uart.c       |   11 ++++++-----
 drivers/tty/serial/ifx6x60.c         |    2 +-
 drivers/tty/serial/imx.c             |   10 +++++-----
 drivers/tty/serial/max3100.c         |    2 +-
 drivers/tty/serial/mcf.c             |    3 ++-
 drivers/tty/serial/mpsc.c            |    4 ++--
 drivers/tty/serial/msm_serial_hs.c   |    2 +-
 drivers/tty/serial/omap-serial.c     |    6 +++---
 drivers/tty/serial/samsung.c         |    4 ++--
 drivers/tty/serial/sc26xx.c          |    2 +-
 drivers/tty/serial/serial_txx9.c     |    2 +-
 drivers/tty/serial/sh-sci.c          |    4 ++--
 drivers/tty/serial/vr41xx_siu.c      |    2 +-
 22 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 86c00b1..570df9d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3062,7 +3062,7 @@ void serial8250_resume_port(int line)
  */
 static int serial8250_probe(struct platform_device *dev)
 {
-	struct plat_serial8250_port *p = dev->dev.platform_data;
+	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
 	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
 
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c6bdb94..2299a34 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -408,7 +408,8 @@ static struct uart_driver altera_jtaguart_driver = {
 
 static int altera_jtaguart_probe(struct platform_device *pdev)
 {
-	struct altera_jtaguart_platform_uart *platp = pdev->dev.platform_data;
+	struct altera_jtaguart_platform_uart *platp =
+			dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
 	struct resource *res_irq, *res_mem;
 	int i = pdev->id;
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 1d46966..fa638db 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -534,7 +534,7 @@ static int altera_uart_get_of_uartclk(struct platform_device *pdev,
 
 static int altera_uart_probe(struct platform_device *pdev)
 {
-	struct altera_uart_platform_uart *platp = pdev->dev.platform_data;
+	struct altera_uart_platform_uart *platp = dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
 	struct resource *res_mem;
 	struct resource *res_irq;
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index c368405..8b90f0b 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -721,7 +721,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
 	uap->dev = dev;
-	uap->data = dev->dev.platform_data;
+	uap->data = dev_get_platdata(&dev->dev);
 
 	amba_ports[i] = uap;
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 28b35ad..eb38fb8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -265,7 +265,7 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
 {
 	/* DMA is the sole user of the platform data right now */
-	struct amba_pl011_data *plat = uap->port.dev->platform_data;
+	struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
 	struct dma_slave_config tx_conf = {
 		.dst_addr = uap->port.mapbase + UART01x_DR,
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
@@ -1497,10 +1497,10 @@ static int pl011_hwinit(struct uart_port *port)
 	uap->im = readw(uap->port.membase + UART011_IMSC);
 	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
 
-	if (uap->port.dev->platform_data) {
+	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
-		plat = uap->port.dev->platform_data;
+		plat = dev_get_platdata(uap->port.dev);
 		if (plat->init)
 			plat->init();
 	}
@@ -1645,10 +1645,10 @@ static void pl011_shutdown(struct uart_port *port)
 	/* Optionally let pins go into sleep states */
 	pinctrl_pm_select_sleep_state(port->dev);
 
-	if (uap->port.dev->platform_data) {
+	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
-		plat = uap->port.dev->platform_data;
+		plat = dev_get_platdata(uap->port.dev);
 		if (plat->exit)
 			plat->exit();
 	}
@@ -2002,10 +2002,10 @@ static int __init pl011_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
-	if (uap->port.dev->platform_data) {
+	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
-		plat = uap->port.dev->platform_data;
+		plat = dev_get_platdata(uap->port.dev);
 		if (plat->init)
 			plat->init();
 	}
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 9824dfb..7aa9062 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -629,7 +629,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	int id;
 	int ret;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata)
 		return -EINVAL;
 
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 22f280a..cd91781 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -528,7 +528,7 @@ arc_uart_init_one(struct platform_device *pdev, int dev_id)
 	unsigned long *plat_data;
 	struct arc_uart_port *uart = &arc_uart_ports[dev_id];
 
-	plat_data = ((unsigned long *)(pdev->dev.platform_data));
+	plat_data = (unsigned long *)dev_get_platdata(&pdev->dev);
 	if (!plat_data)
 		return -ENODEV;
 
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 7e2cb31..d067285 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1393,7 +1393,7 @@ static int atmel_init_property(struct atmel_uart_port *atmel_port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_uart_data *pdata = pdev->dev.platform_data;
+	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (np) {
 		/* DMA/PDC usage specification */
@@ -1437,7 +1437,7 @@ static void atmel_init_rs485(struct atmel_uart_port *atmel_port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_uart_data *pdata = pdev->dev.platform_data;
+	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (np) {
 		u32 rs485_delay[2];
@@ -2028,7 +2028,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 {
 	int ret;
 	struct uart_port *port = &atmel_port->uart;
-	struct atmel_uart_data *pdata = pdev->dev.platform_data;
+	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (!atmel_init_property(atmel_port, pdev))
 		atmel_set_ops(port);
@@ -2226,7 +2226,7 @@ static int __init atmel_console_init(void)
 	int ret;
 	if (atmel_default_console_device) {
 		struct atmel_uart_data *pdata =
-			atmel_default_console_device->dev.platform_data;
+			dev_get_platdata(&atmel_default_console_device->dev);
 		int id = pdata->num;
 		struct atmel_uart_port *port = &atmel_ports[id];
 
@@ -2334,7 +2334,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_uart_data *pdata = pdev->dev.platform_data;
+	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 	void *data;
 	int ret = -ENODEV;
 
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 487c173..424ed36 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -766,7 +766,8 @@ static int sport_uart_probe(struct platform_device *pdev)
 		}
 
 		ret = peripheral_request_list(
-			(unsigned short *)pdev->dev.platform_data, DRV_NAME);
+			(unsigned short *)dev_get_platdata(&pdev->dev),
+			DRV_NAME);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"Fail to request SPORT peripherals\n");
@@ -843,7 +844,7 @@ out_error_unmap:
 		iounmap(sport->port.membase);
 out_error_free_peripherals:
 		peripheral_free_list(
-			(unsigned short *)pdev->dev.platform_data);
+			(unsigned short *)dev_get_platdata(&pdev->dev));
 out_error_free_mem:
 		kfree(sport);
 		bfin_sport_uart_ports[pdev->id] = NULL;
@@ -863,7 +864,7 @@ static int sport_uart_remove(struct platform_device *pdev)
 		uart_remove_one_port(&sport_uart_reg, &sport->port);
 		iounmap(sport->port.membase);
 		peripheral_free_list(
-			(unsigned short *)pdev->dev.platform_data);
+			(unsigned short *)dev_get_platdata(&pdev->dev));
 		kfree(sport);
 		bfin_sport_uart_ports[pdev->id] = NULL;
 	}
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 72031d7..378f3c3 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -1240,7 +1240,8 @@ static int bfin_serial_probe(struct platform_device *pdev)
 			 */
 #endif
 		ret = peripheral_request_list(
-			(unsigned short *)pdev->dev.platform_data, DRIVER_NAME);
+			(unsigned short *)dev_get_platdata(&pdev->dev),
+			DRIVER_NAME);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"fail to request bfin serial peripherals\n");
@@ -1358,7 +1359,7 @@ out_error_unmap:
 		iounmap(uart->port.membase);
 out_error_free_peripherals:
 		peripheral_free_list(
-			(unsigned short *)pdev->dev.platform_data);
+			(unsigned short *)dev_get_platdata(&pdev->dev));
 out_error_free_mem:
 		kfree(uart);
 		bfin_serial_ports[pdev->id] = NULL;
@@ -1377,7 +1378,7 @@ static int bfin_serial_remove(struct platform_device *pdev)
 		uart_remove_one_port(&bfin_serial_reg, &uart->port);
 		iounmap(uart->port.membase);
 		peripheral_free_list(
-			(unsigned short *)pdev->dev.platform_data);
+			(unsigned short *)dev_get_platdata(&pdev->dev));
 		kfree(uart);
 		bfin_serial_ports[pdev->id] = NULL;
 	}
@@ -1432,7 +1433,7 @@ static int bfin_earlyprintk_probe(struct platform_device *pdev)
 	}
 
 	ret = peripheral_request_list(
-		(unsigned short *)pdev->dev.platform_data, DRIVER_NAME);
+		(unsigned short *)dev_get_platdata(&pdev->dev), DRIVER_NAME);
 	if (ret) {
 		dev_err(&pdev->dev,
 				"fail to request bfin serial peripherals\n");
@@ -1463,7 +1464,7 @@ static int bfin_earlyprintk_probe(struct platform_device *pdev)
 
 out_error_free_peripherals:
 	peripheral_free_list(
-		(unsigned short *)pdev->dev.platform_data);
+		(unsigned short *)dev_get_platdata(&pdev->dev));
 
 	return ret;
 }
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 8b1534c..af286e6 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1008,7 +1008,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	pl_data = (struct ifx_modem_platform_data *)spi->dev.platform_data;
+	pl_data = (struct ifx_modem_platform_data *)dev_get_platdata(&spi->dev);
 	if (!pl_data) {
 		dev_err(&spi->dev, "missing platform data!");
 		return -ENODEV;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90655b8..a5f32c7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1222,7 +1222,7 @@ static int imx_startup(struct uart_port *port)
 
 	if (USE_IRDA(sport)) {
 		struct imxuart_platform_data *pdata;
-		pdata = sport->port.dev->platform_data;
+		pdata = dev_get_platdata(sport->port.dev);
 		sport->irda_inv_rx = pdata->irda_inv_rx;
 		sport->irda_inv_tx = pdata->irda_inv_tx;
 		sport->trcv_delay = pdata->transceiver_delay;
@@ -1265,7 +1265,7 @@ static void imx_shutdown(struct uart_port *port)
 
 	if (USE_IRDA(sport)) {
 		struct imxuart_platform_data *pdata;
-		pdata = sport->port.dev->platform_data;
+		pdata = dev_get_platdata(sport->port.dev);
 		if (pdata->irda_enable)
 			pdata->irda_enable(0);
 	}
@@ -1925,7 +1925,7 @@ static inline int serial_imx_probe_dt(struct imx_port *sport,
 static void serial_imx_probe_pdata(struct imx_port *sport,
 		struct platform_device *pdev)
 {
-	struct imxuart_platform_data *pdata = pdev->dev.platform_data;
+	struct imxuart_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	sport->port.line = pdev->id;
 	sport->devdata = (struct imx_uart_data	*) pdev->id_entry->driver_data;
@@ -2000,7 +2000,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	imx_ports[sport->port.line] = sport;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata && pdata->init) {
 		ret = pdata->init(pdev);
 		if (ret)
@@ -2024,7 +2024,7 @@ static int serial_imx_remove(struct platform_device *pdev)
 	struct imxuart_platform_data *pdata;
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 
 	uart_remove_one_port(&imx_reg, &sport->port);
 
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 35866d5..79f9a9e 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -779,7 +779,7 @@ static int max3100_probe(struct spi_device *spi)
 	max3100s[i]->irq = spi->irq;
 	spin_lock_init(&max3100s[i]->conf_lock);
 	spi_set_drvdata(spi, max3100s[i]);
-	pdata = spi->dev.platform_data;
+	pdata = dev_get_platdata(&spi->dev);
 	max3100s[i]->crystal = pdata->crystal;
 	max3100s[i]->loopback = pdata->loopback;
 	max3100s[i]->poll_time = pdata->poll_time * HZ / 1000;
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 65be0c0..a2e97c9 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -24,6 +24,7 @@
 #include <linux/serial_core.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/platform_device.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
 #include <asm/mcfuart.h>
@@ -644,7 +645,7 @@ static struct uart_driver mcf_driver = {
 
 static int mcf_probe(struct platform_device *pdev)
 {
-	struct mcf_platform_uart *platp = pdev->dev.platform_data;
+	struct mcf_platform_uart *platp = dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
 	int i;
 
diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index bc24f49..fba5257 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -1884,7 +1884,7 @@ static int mpsc_shared_drv_probe(struct platform_device *dev)
 	if (dev->id == 0) {
 		if (!(rc = mpsc_shared_map_regs(dev))) {
 			pdata = (struct mpsc_shared_pdata *)
-				dev->dev.platform_data;
+				dev_get_platdata(&dev->dev);
 
 			mpsc_shared_regs.MPSC_MRR_m = pdata->mrr_val;
 			mpsc_shared_regs.MPSC_RCRR_m= pdata->rcrr_val;
@@ -2025,7 +2025,7 @@ static void mpsc_drv_get_platform_data(struct mpsc_port_info *pi,
 {
 	struct mpsc_pdata	*pdata;
 
-	pdata = (struct mpsc_pdata *)pd->dev.platform_data;
+	pdata = (struct mpsc_pdata *)dev_get_platdata(&pd->dev);
 
 	pi->port.uartclk = pdata->brg_clk_freq;
 	pi->port.iotype = UPIO_MEM;
diff --git a/drivers/tty/serial/msm_serial_hs.c b/drivers/tty/serial/msm_serial_hs.c
index 4ca2f64..48e9496 100644
--- a/drivers/tty/serial/msm_serial_hs.c
+++ b/drivers/tty/serial/msm_serial_hs.c
@@ -1618,7 +1618,7 @@ static int msm_hs_probe(struct platform_device *pdev)
 	struct msm_hs_port *msm_uport;
 	struct resource *resource;
 	const struct msm_serial_hs_platform_data *pdata =
-						pdev->dev.platform_data;
+						dev_get_platdata(&pdev->dev);
 
 	if (pdev->id < 0 || pdev->id >= UARTDM_NR) {
 		printk(KERN_ERR "Invalid plaform device ID = %d\n", pdev->id);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c77bf0c..c751706 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -200,7 +200,7 @@ static inline void serial_omap_clear_fifos(struct uart_omap_port *up)
 
 static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 {
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
+	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
 
 	if (!pdata || !pdata->get_context_loss_count)
 		return -EINVAL;
@@ -210,7 +210,7 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 
 static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
 {
-	struct omap_uart_port_info *pdata = up->dev->platform_data;
+	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
 
 	if (!pdata || !pdata->enable_wakeup)
 		return;
@@ -1409,7 +1409,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct uart_omap_port	*up;
 	struct resource		*mem, *irq;
-	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
+	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	if (pdev->dev.of_node) {
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 376079b..019b915 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1250,8 +1250,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	ourport->baudclk = ERR_PTR(-EINVAL);
 	ourport->info = ourport->drv_data->info;
-	ourport->cfg = (pdev->dev.platform_data) ?
-			(struct s3c2410_uartcfg *)pdev->dev.platform_data :
+	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
+			(struct s3c2410_uartcfg *)dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
 
 	ourport->port.fifosize = (ourport->info->fifosize) ?
diff --git a/drivers/tty/serial/sc26xx.c b/drivers/tty/serial/sc26xx.c
index 4b1434d..887b4f7 100644
--- a/drivers/tty/serial/sc26xx.c
+++ b/drivers/tty/serial/sc26xx.c
@@ -637,7 +637,7 @@ static int sc26xx_probe(struct platform_device *dev)
 {
 	struct resource *res;
 	struct uart_sc26xx_port *up;
-	unsigned int *sc26xx_data = dev->dev.platform_data;
+	unsigned int *sc26xx_data = dev_get_platdata(&dev->dev);
 	int err;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index fe48a0c..440a962 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1097,7 +1097,7 @@ static void serial_txx9_unregister_port(int line)
  */
 static int serial_txx9_probe(struct platform_device *dev)
 {
-	struct uart_port *p = dev->dev.platform_data;
+	struct uart_port *p = dev_get_platdata(&dev->dev);
 	struct uart_port port;
 	int ret, i;
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5ef9300..d262c1f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2381,7 +2381,7 @@ static char early_serial_buf[32];
 
 static int sci_probe_earlyprintk(struct platform_device *pdev)
 {
-	struct plat_sci_port *cfg = pdev->dev.platform_data;
+	struct plat_sci_port *cfg = dev_get_platdata(&pdev->dev);
 
 	if (early_serial_console.data)
 		return -EEXIST;
@@ -2591,7 +2591,7 @@ static int sci_probe(struct platform_device *dev)
 	if (dev->dev.of_node)
 		p = sci_parse_dt(dev, &dev_id);
 	else
-		p = dev->dev.platform_data;
+		p = dev_get_platdata(&dev->dev);
 
 	if (!p) {
 		dev_err(&dev->dev, "no setup data supplied\n");
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index f655997..a63c14b 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -705,7 +705,7 @@ static int siu_init_ports(struct platform_device *pdev)
 {
 	struct uart_port *port;
 	struct resource *res;
-	int *type = pdev->dev.platform_data;
+	int *type = dev_get_platdata(&pdev->dev);
 	int i;
 
 	if (!type)
-- 
1.7.10.4


