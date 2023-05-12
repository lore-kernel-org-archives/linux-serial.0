Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC1C77B75
	for <linux-serial@archiver.kernel.org>; Fri, 12 May 2023 17:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjELRiz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 May 2023 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjELRiy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 May 2023 13:38:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC161718
        for <linux-serial@vger.kernel.org>; Fri, 12 May 2023 10:38:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWil-0004k0-3E; Fri, 12 May 2023 19:38:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWig-0031HN-UI; Fri, 12 May 2023 19:38:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWig-003ns0-8o; Fri, 12 May 2023 19:38:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        "moderated list:ARM/Microchip" <linux-arm-kernel@lists.infradead.org>,
        kernel@pengutronix.de
Subject: [PATCH 2/2] serial: Make uart_remove_one_port() return void
Date:   Fri, 12 May 2023 19:38:10 +0200
Message-Id: <20230512173810.131447-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
References: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9090; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5Puc2QTtWZXExc99bvBiOOISWBz32tevF3baPk/jSIc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXnl9IqWsM0ex3oTZcPddAGl6ZNIKVeedASEHl AxWE7pnYx2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF55fQAKCRCPgPtYfRL+ TmV3CACS1JWHTfoiJlh+r3W0DYrElFTckwqRIEH3yWkslMx6DTSO7ZQqKbyt7SzicFEw/C+xUIs au1SND9MKLxmZiq9WeZhDBVonMO69pQPEPOP39mCtUgepDIA3BktWna1dm7emQx6Ca4/ZrWp9/d 5QZRYruLLBgse0ghv1AA2Cs5mIB4hw7IaQZ2Ti9CyLMgz64On5U4p0VxkxSKeKjf/WbBAv/0X3w SLZh+ZALumCsKSCOtf4hoBJrB4bHkPABbjhraUdN8yIjdZy2HBXFEme6hp14pHlvZnVs5ekFeVq EsBfWNQueuvZOnhhTNOmpYpCH2+GsQIZJ4HGlDLXGd0n7VPU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The return value is only ever used as a return value for remove callbacks
of platform drivers. This return value is ignored by the driver core.
(The only effect is an error message, but uart_remove_one_port() already
emitted one in this case.)

So the return value isn't used at all and uart_remove_one_port() can be
changed to return void without any loss. Also this better matches the
Linux device model as remove functions are not supposed to fail.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/atmel_serial.c           |  5 ++---
 drivers/tty/serial/clps711x.c               |  4 +++-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  5 ++++-
 drivers/tty/serial/imx.c                    |  4 +++-
 drivers/tty/serial/lantiq.c                 |  4 +++-
 drivers/tty/serial/serial_core.c            |  6 +-----
 drivers/tty/serial/st-asc.c                 |  4 +++-
 drivers/tty/serial/uartlite.c               | 12 ++++--------
 drivers/tty/serial/xilinx_uartps.c          |  5 ++---
 include/linux/serial_core.h                 |  2 +-
 10 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 9cd7479b03c0..6e9192f122aa 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -3006,14 +3006,13 @@ static int atmel_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	int ret = 0;
 
 	tasklet_kill(&atmel_port->tasklet_rx);
 	tasklet_kill(&atmel_port->tasklet_tx);
 
 	device_init_wakeup(&pdev->dev, 0);
 
-	ret = uart_remove_one_port(&atmel_uart, port);
+	uart_remove_one_port(&atmel_uart, port);
 
 	kfree(atmel_port->rx_ring.buf);
 
@@ -3023,7 +3022,7 @@ static int atmel_serial_remove(struct platform_device *pdev)
 
 	pdev->dev.of_node = NULL;
 
-	return ret;
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index e190dce58f46..e49bc4019b50 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -514,7 +514,9 @@ static int uart_clps711x_remove(struct platform_device *pdev)
 {
 	struct clps711x_port *s = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&clps711x_uart, &s->port);
+	uart_remove_one_port(&clps711x_uart, &s->port);
+
+	return 0;
 }
 
 static const struct of_device_id __maybe_unused clps711x_uart_dt_ids[] = {
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 349e7da643f0..66afa9bea6bf 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1431,7 +1431,10 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 static int cpm_uart_remove(struct platform_device *ofdev)
 {
 	struct uart_cpm_port *pinfo = platform_get_drvdata(ofdev);
-	return uart_remove_one_port(&cpm_reg, &pinfo->port);
+
+	uart_remove_one_port(&cpm_reg, &pinfo->port);
+
+	return 0;
 }
 
 static const struct of_device_id cpm_uart_match[] = {
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c5e17569c3ad..b2bf3cb449f4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2467,7 +2467,9 @@ static int imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+
+	return 0;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index a58e9277dfad..d413f97f7190 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -889,7 +889,9 @@ static int lqasc_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&lqasc_reg, port);
+	uart_remove_one_port(&lqasc_reg, port);
+
+	return 0;
 }
 
 static const struct ltq_soc_data soc_data_lantiq = {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 54e82f476a2c..4b98d13555c0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3154,13 +3154,12 @@ EXPORT_SYMBOL(uart_add_one_port);
  * This unhooks (and hangs up) the specified port structure from the core
  * driver. No further calls will be made to the low-level code for this port.
  */
-int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
+void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 {
 	struct uart_state *state = drv->state + uport->line;
 	struct tty_port *port = &state->port;
 	struct uart_port *uart_port;
 	struct tty_struct *tty;
-	int ret = 0;
 
 	mutex_lock(&port_mutex);
 
@@ -3176,7 +3175,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	if (!uart_port) {
 		mutex_unlock(&port->mutex);
-		ret = -EINVAL;
 		goto out;
 	}
 	uport->flags |= UPF_DEAD;
@@ -3219,8 +3217,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	mutex_unlock(&port->mutex);
 out:
 	mutex_unlock(&port_mutex);
-
-	return ret;
 }
 EXPORT_SYMBOL(uart_remove_one_port);
 
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 5215e6910f68..dc2f2051435c 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -796,7 +796,9 @@ static int asc_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&asc_uart_driver, port);
+	uart_remove_one_port(&asc_uart_driver, port);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 94584e54ebbe..679574893ebe 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -685,18 +685,15 @@ static int ulite_assign(struct device *dev, int id, phys_addr_t base, int irq,
  *
  * @dev: pointer to device structure
  */
-static int ulite_release(struct device *dev)
+static void ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
-	int rc = 0;
 
 	if (port) {
-		rc = uart_remove_one_port(&ulite_uart_driver, port);
+		uart_remove_one_port(&ulite_uart_driver, port);
 		dev_set_drvdata(dev, NULL);
 		port->mapbase = 0;
 	}
-
-	return rc;
 }
 
 /**
@@ -900,14 +897,13 @@ static int ulite_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	struct uartlite_data *pdata = port->private_data;
-	int rc;
 
 	clk_disable_unprepare(pdata->clk);
-	rc = ulite_release(&pdev->dev);
+	ulite_release(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	return rc;
+	return 0;
 }
 
 /* work with hotplug and coldplug */
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8e521c69a959..20a751663ef9 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1670,14 +1670,13 @@ static int cdns_uart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct cdns_uart *cdns_uart_data = port->private_data;
-	int rc;
 
 	/* Remove the cdns_uart port from the serial core */
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
-	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
+	uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
@@ -1693,7 +1692,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-	return rc;
+	return 0;
 }
 
 static struct platform_driver cdns_uart_platform_driver = {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 66ecec15a1bf..ddcdb5b8523e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -853,7 +853,7 @@ void uart_console_write(struct uart_port *port, const char *s,
 int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
-int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
+void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 bool uart_match_port(const struct uart_port *port1,
 		const struct uart_port *port2);
 
-- 
2.39.2

