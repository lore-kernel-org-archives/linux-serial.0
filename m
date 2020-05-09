Return-Path: <SRS0=wdWf=6X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5929C28CBC
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 06:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6992184D
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 06:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgEIGl0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 9 May 2020 02:41:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:51306 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgEIGlZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 9 May 2020 02:41:25 -0400
IronPort-SDR: piFth/WoSK8/glW9ye7CfYYXBgno5EGltp69YJ86mhVZlClXrZQZzvgUujUcUv3q6mo039fcdQ
 NtwzvtJXfajg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 23:41:23 -0700
IronPort-SDR: YJehiYscluXueXQs/gNYZzNglJ2ZUgA7gfrzwKaAzb40JSnRpXyf2kufy/NfCn/LYI0D/N4OCp
 cP1FPhhbWhjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; 
   d="scan'208";a="279251600"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2020 23:41:21 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 2/2] serial: lantiq: Make driver modular
Date:   Sat,  9 May 2020 14:41:15 +0800
Message-Id: <7ca89173492b17207da6c85dbec0abed6d4708c7.1589006353.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <35f2d002ba1cb26192fe4d9b8cdab275300705bc.1589006353.git.rahul.tanwar@linux.intel.com>
References: <35f2d002ba1cb26192fe4d9b8cdab275300705bc.1589006353.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <35f2d002ba1cb26192fe4d9b8cdab275300705bc.1589006353.git.rahul.tanwar@linux.intel.com>
References: <35f2d002ba1cb26192fe4d9b8cdab275300705bc.1589006353.git.rahul.tanwar@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add changes so Lantiq serial driver can be compiled as a module.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/Kconfig  |  4 +++-
 drivers/tty/serial/lantiq.c | 26 ++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index bb4009a1135f..c0681da66653 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1034,11 +1034,13 @@ config SERIAL_SIFIVE_CONSOLE
 	  boot time.)
 
 config SERIAL_LANTIQ
-	bool "Lantiq serial driver"
+	tristate "Lantiq serial driver"
 	depends on (LANTIQ || X86) || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for UART on Lantiq and Intel SoCs.
+	  To compile this driver as a module, select M here. The
+	  module will be called lantiq.
 
 config SERIAL_LANTIQ_CONSOLE
 	bool "Console on Lantiq UART"
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index d3b62a1be6ad..42fa52a224f7 100644
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
@@ -908,6 +909,13 @@ lqasc_probe(struct platform_device *pdev)
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
@@ -925,8 +933,11 @@ static const struct of_device_id ltq_asc_match[] = {
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
@@ -942,10 +953,21 @@ init_lqasc(void)
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

