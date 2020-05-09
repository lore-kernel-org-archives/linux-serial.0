Return-Path: <SRS0=wdWf=6X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AC5C28CBC
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 06:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F7F24953
	for <linux-serial@archiver.kernel.org>; Sat,  9 May 2020 06:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgEIGlT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 9 May 2020 02:41:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:2357 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgEIGlT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 9 May 2020 02:41:19 -0400
IronPort-SDR: drC1Oz23I3VZH7ne6h0fhKttGaZR8VhWCuVXCZsfjo2uCvUXFKAr3RP6TI/X1Jvt0+RFObMzFY
 8sXaLp445Q7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 23:41:19 -0700
IronPort-SDR: v55QBOIkmvL1Db2Nho/wV13nBwQanrTrSTJ/OK3yJLMtkTmZdoPZVCFIi94RzuVPVjIGtWKBWC
 rKYwZjCSEEUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; 
   d="scan'208";a="370722447"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2020 23:41:17 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/2] serial: lantiq: Make UART's use as console selectable
Date:   Sat,  9 May 2020 14:41:14 +0800
Message-Id: <35f2d002ba1cb26192fe4d9b8cdab275300705bc.1589006353.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Lantiq UART driver can be used for system console. Add changes to
make this driver's use as console selectable/configurable.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/Kconfig  |  9 ++++++++-
 drivers/tty/serial/lantiq.c | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4b0a7b98f8c7..bb4009a1135f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1037,10 +1037,17 @@ config SERIAL_LANTIQ
 	bool "Lantiq serial driver"
 	depends on (LANTIQ || X86) || COMPILE_TEST
 	select SERIAL_CORE
+	help
+	  Support for UART on Lantiq and Intel SoCs.
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
index c5e46ff972e4..d3b62a1be6ad 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -597,6 +597,7 @@ static const struct uart_ops lqasc_pops = {
 	.verify_port =	lqasc_verify_port,
 };
 
+#ifdef CONFIG_SERIAL_LANTIQ_CONSOLE
 static void
 lqasc_console_putchar(struct uart_port *port, int ch)
 {
@@ -705,6 +706,14 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
 OF_EARLYCON_DECLARE(lantiq, "intel,lgm-asc", lqasc_serial_early_console_setup);
 
+#define LANTIQ_SERIAL_CONSOLE	(&lqasc_console)
+
+#else
+
+#define LANTIQ_SERIAL_CONSOLE	NULL
+
+#endif /* CONFIG_SERIAL_LANTIQ_CONSOLE */
+
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
 	.driver_name =	DRVNAME,
@@ -712,7 +721,7 @@ static struct uart_driver lqasc_reg = {
 	.major =	0,
 	.minor =	0,
 	.nr =		MAXPORTS,
-	.cons =		&lqasc_console,
+	.cons =		LANTIQ_SERIAL_CONSOLE,
 };
 
 static int fetch_irq_lantiq(struct device *dev, struct ltq_uart_port *ltq_port)
-- 
2.11.0

