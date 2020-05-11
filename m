Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110B7C54E4A
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 05:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3FA520820
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 05:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEKF5g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 01:57:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:54277 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgEKF5f (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 01:57:35 -0400
IronPort-SDR: TYhSSYlRCWzHBxB23gZoxAMCsT81ICu1hd1IYQjcPIB9GcoOpHiwzBdtdNShIG/WI8kxyq9Fpt
 Vaa5vHVATZyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 22:57:35 -0700
IronPort-SDR: vjEWTfL3FYUjWJlIrYuX7W/KkBwmcWqKOnkV58x+Mujzk6KO/ipTLRIAFD2kjBdrqaejJrlnqk
 0sFAHEPlzpDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; 
   d="scan'208";a="279680285"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2020 22:57:33 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/2] serial: lantiq: Make UART's use as console selectable
Date:   Mon, 11 May 2020 13:57:26 +0800
Message-Id: <35f2d002ba1cb26192fe4d9b8cdab275300705bc.1589176044.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1589176044.git.rahul.tanwar@linux.intel.com>
References: <cover.1589176044.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1589176044.git.rahul.tanwar@linux.intel.com>
References: <cover.1589176044.git.rahul.tanwar@linux.intel.com>
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

