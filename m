Return-Path: <SRS0=Pw1G=6W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0219BC47254
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E072F20661
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 11:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHLUz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 May 2020 07:20:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:58519 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHLUy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 07:20:54 -0400
IronPort-SDR: b73UGGSDcvgsjMD7FPZE7nxcwvpYjFDSqp/OA8iIiVJETZJ1n+a3d33ySm+GJjZqA6BtOGsxTx
 ewQ04HaJpDww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:20:54 -0700
IronPort-SDR: L3ZS7pIBLFx1WplCTOxs1Usmy4xWOZgzH/gYmTuqoCsyWtA/xFY2jYQ59pIeoK7WZSkIgZouhB
 F9F0e8zfQzLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="370429123"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2020 04:20:52 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH] serial: lantiq: Make driver modular and console configurable
Date:   Fri,  8 May 2020 19:20:49 +0800
Message-Id: <42292519ba78f086eb19d058dec6411f5f29da51.1588936756.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add changes so Lantiq serial driver can be compiled as a module.
Also, make this driver's use as console selectable/configurable.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/Kconfig  | 13 +++++++++++--
 drivers/tty/serial/lantiq.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4b0a7b98f8c7..996782247174 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1034,13 +1034,22 @@ config SERIAL_SIFIVE_CONSOLE
 	  boot time.)
 
 config SERIAL_LANTIQ
-	bool "Lantiq serial driver"
+	tristate "Lantiq serial driver"
 	depends on (LANTIQ || X86) || COMPILE_TEST
 	select SERIAL_CORE
+	help
+	  Support for UART on Lantiq and Intel SoCs.
+	  To compile this driver as a module, choose M here, the
+	  module will be called lantiq.
+
+config SERIAL_LANTIQ_CONSOLE
+	bool "Console on Lantiq UART"
+	depends on SERIAL_LANTIQ=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-	  Support for console and UART on Lantiq SoCs.
+	  Select this option if you would like to use a Lantiq UART as the
+	  system console.
 
 config SERIAL_QE
 	tristate "Freescale QUICC Engine serial port support"
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index c5e46ff972e4..93ed59bccd11 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/lantiq.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -597,6 +598,13 @@ static const struct uart_ops lqasc_pops = {
 	.verify_port =	lqasc_verify_port,
 };
 
+
+/*
+ * Linux console interface
+ */
+
+#ifdef CONFIG_SERIAL_LANTIQ_CONSOLE
+
 static void
 lqasc_console_putchar(struct uart_port *port, int ch)
 {
@@ -705,6 +713,14 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
 OF_EARLYCON_DECLARE(lantiq, "intel,lgm-asc", lqasc_serial_early_console_setup);
 
+#define LANTIQ_SERIAL_CONSOLE	(&lqasc_console)
+
+#else
+
+#define LANTIQ_SERIAL_CONSOLE	NULL
+
+#endif
+
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
 	.driver_name =	DRVNAME,
@@ -712,7 +728,7 @@ static struct uart_driver lqasc_reg = {
 	.major =	0,
 	.minor =	0,
 	.nr =		MAXPORTS,
-	.cons =		&lqasc_console,
+	.cons =		LANTIQ_SERIAL_CONSOLE,
 };
 
 static int fetch_irq_lantiq(struct device *dev, struct ltq_uart_port *ltq_port)
@@ -899,6 +915,13 @@ lqasc_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int lqasc_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+
+	return uart_remove_one_port(&lqasc_reg, port);
+}
+
 static const struct ltq_soc_data soc_data_lantiq = {
 	.fetch_irq = fetch_irq_lantiq,
 	.request_irq = request_irq_lantiq,
@@ -916,8 +939,11 @@ static const struct of_device_id ltq_asc_match[] = {
 	{ .compatible = "intel,lgm-asc", .data = &soc_data_intel },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ltq_asc_match);
 
 static struct platform_driver lqasc_driver = {
+	.probe		= lqasc_probe,
+	.remove		= lqasc_remove,
 	.driver		= {
 		.name	= DRVNAME,
 		.of_match_table = ltq_asc_match,
@@ -933,10 +959,21 @@ init_lqasc(void)
 	if (ret != 0)
 		return ret;
 
-	ret = platform_driver_probe(&lqasc_driver, lqasc_probe);
+	ret = platform_driver_register(&lqasc_driver);
 	if (ret != 0)
 		uart_unregister_driver(&lqasc_reg);
 
 	return ret;
 }
-device_initcall(init_lqasc);
+
+static void __exit exit_lqasc(void)
+{
+	platform_driver_unregister(&lqasc_driver);
+	uart_unregister_driver(&lqasc_reg);
+}
+
+module_init(init_lqasc);
+module_exit(exit_lqasc);
+
+MODULE_DESCRIPTION("Serial driver for Lantiq & Intel gateway SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

