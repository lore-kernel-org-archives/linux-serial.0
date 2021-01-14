Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74485C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 15:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499E023AAC
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 15:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbhANPR3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbhANPR2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jan 2021 10:17:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81DEC0613D6
        for <linux-serial@vger.kernel.org>; Thu, 14 Jan 2021 07:16:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l04MT-00022k-Lx; Thu, 14 Jan 2021 16:16:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l04MT-000133-B6; Thu, 14 Jan 2021 16:16:33 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org
Subject: [PATCH v1 6/7] tty: Drop unused efm32 serial driver
Date:   Thu, 14 Jan 2021 16:16:29 +0100
Message-Id: <20210114151630.128830-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114151630.128830-1-u.kleine-koenig@pengutronix.de>
References: <20210114151630.128830-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Support for this machine was just removed, so drop the now unused UART
driver, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/Kconfig       | 13 -------------
 drivers/tty/serial/Makefile      |  1 -
 include/uapi/linux/serial_core.h |  3 ---
 3 files changed, 17 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 34a2899e69c0..83f6ca4bf210 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1295,14 +1295,6 @@ config SERIAL_AR933X_NR_UARTS
 	  Set this to the number of serial ports you want the driver
 	  to support.
 
-config SERIAL_EFM32_UART
-	tristate "EFM32 UART/USART port"
-	depends on ARM && (ARCH_EFM32 || COMPILE_TEST)
-	select SERIAL_CORE
-	help
-	  This driver support the USART and UART ports on
-	  Energy Micro's efm32 SoCs.
-
 config SERIAL_MPS2_UART_CONSOLE
 	bool "MPS2 UART console support"
 	depends on SERIAL_MPS2_UART
@@ -1316,11 +1308,6 @@ config SERIAL_MPS2_UART
 	help
 	  This driver support the UART ports on ARM MPS2.
 
-config SERIAL_EFM32_UART_CONSOLE
-	bool "EFM32 UART/USART console support"
-	depends on SERIAL_EFM32_UART=y
-	select SERIAL_CORE_CONSOLE
-
 config SERIAL_ARC
 	tristate "ARC UART driver support"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index b85d53f9e9ff..ec2b74091f0c 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_SERIAL_SIRFSOC) += sirfsoc_uart.o
 obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
 obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
 obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
-obj-$(CONFIG_SERIAL_EFM32_UART) += efm32-uart.o
 obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
 obj-$(CONFIG_SERIAL_RP2)	+= rp2.o
 obj-$(CONFIG_SERIAL_FSL_LPUART)	+= fsl_lpuart.o
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 62c22045fe65..c4042dcfdc0c 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -208,9 +208,6 @@
 /* Atheros AR933X SoC */
 #define PORT_AR933X	99
 
-/* Energy Micro efm32 SoC */
-#define PORT_EFMUART   100
-
 /* ARC (Synopsys) on-chip UART */
 #define PORT_ARC       101
 
-- 
2.29.2

