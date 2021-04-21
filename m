Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0BC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 14:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A46261404
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhDUOcI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235533AbhDUOcH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 10:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C8F6144B;
        Wed, 21 Apr 2021 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619015494;
        bh=NXj63/8U2SE0hHqDcZlq9DdOPJh2tCg3DLXxfIZkThA=;
        h=From:To:Cc:Subject:Date:From;
        b=smu/8ofwCfPaP1PTlXU6degzVMot9pjGDTQGS0fXSiDTr1+Anc0MTZzbp1PWMwwsd
         W4cdvpcDF3LTQRM0+mQXzu6fUi9HkbD1YeZIazNAQ/K9uRYNpNBF9ZCujpA915wR57
         uBSayuncwOciTOBwvRBgdXmpGkUumQrcV0PYg6YGSRBocWImPbDaoYFuIzS8LcV5tp
         pkaLJnhbPOWzRBqn7/83Ew89aAaFl3ZIH64ePp467DaCxJvAD3hyoxe3Ee6L1fgQ+D
         44U5rDBJT4P7CdwZWoZn4CzhR1eqsOGF7B2pGn92xg0cTd+iiU2/rWuv6Y46Chq8yG
         bsM5t+cKhHVkg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZDtB-0005wc-6Y; Wed, 21 Apr 2021 16:31:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: extend compile-test coverage
Date:   Wed, 21 Apr 2021 16:31:15 +0200
Message-Id: <20210421143115.22797-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Allow more drivers to be compile tested, for example, when doing
subsystem-wide changes.

Verified on X86_64 as well as arm, powerpc and m68k with minimal configs
in order to catch missing implicit build dependencies (e.g. MAILBOX for
SERIAL_TEGRA_TCU).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/Kconfig |  6 ++++--
 drivers/tty/serial/Kconfig      | 20 +++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 4b9d7d1951f8..d1b3c2373fa4 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -403,7 +403,8 @@ config SERIAL_8250_RT288X
 
 config SERIAL_8250_OMAP
 	tristate "Support for OMAP internal UART (8250 based driver)"
-	depends on SERIAL_8250 && (ARCH_OMAP2PLUS || ARCH_K3)
+	depends on SERIAL_8250
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
 	  can enable its onboard serial ports by enabling this option.
@@ -439,7 +440,8 @@ config SERIAL_8250_LPC18XX
 
 config SERIAL_8250_MT6577
 	tristate "Mediatek serial port support"
-	depends on SERIAL_8250 && ARCH_MEDIATEK
+	depends on SERIAL_8250
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	help
 	  If you have a Mediatek based board and want to use the
 	  serial port, say Y to this option. If unsure, say N.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e6f55c28cc2e..35fd148fd2b2 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -20,7 +20,7 @@ comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
-	depends on ARM_AMBA
+	depends on ARM_AMBA || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This selects the ARM(R) AMBA(R) PrimeCell PL010 UART.  If you have
@@ -198,7 +198,7 @@ config SERIAL_KGDB_NMI
 
 config SERIAL_MESON
 	tristate "Meson serial port support"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Amlogic
@@ -278,7 +278,7 @@ config SERIAL_SAMSUNG_CONSOLE
 
 config SERIAL_TEGRA
 	tristate "NVIDIA Tegra20/30 SoC serial controller"
-	depends on ARCH_TEGRA && TEGRA20_APB_DMA
+	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the NVIDIA Tegra series SOCs
@@ -289,7 +289,8 @@ config SERIAL_TEGRA
 
 config SERIAL_TEGRA_TCU
 	tristate "NVIDIA Tegra Combined UART"
-	depends on ARCH_TEGRA && TEGRA_HSP_MBOX
+	depends on MAILBOX
+	depends on (ARCH_TEGRA && TEGRA_HSP_MBOX) || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the mailbox-based TCU (Tegra Combined UART) serial port.
@@ -852,7 +853,8 @@ config SERIAL_MPC52xx_CONSOLE_BAUD
 
 config SERIAL_ICOM
 	tristate "IBM Multiport Serial Adapter"
-	depends on PCI && PPC_PSERIES
+	depends on PCI
+	depends on PPC_PSERIES || COMPILE_TEST
 	select SERIAL_CORE
 	select FW_LOADER
 	help
@@ -865,7 +867,7 @@ config SERIAL_ICOM
 
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends on HAS_TXX9_SERIAL
+	depends on HAS_TXX9_SERIAL || COMPILE_TEST
 	select SERIAL_CORE
 	default y
 
@@ -921,7 +923,7 @@ config SERIAL_JSM
 
 config SERIAL_MSM
 	tristate "MSM on-chip serial port support"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_MSM_CONSOLE
@@ -947,7 +949,7 @@ config SERIAL_QCOM_GENI_CONSOLE
 
 config SERIAL_VT8500
 	bool "VIA VT8500 on-chip serial port support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_VT8500_CONSOLE
@@ -957,7 +959,7 @@ config SERIAL_VT8500_CONSOLE
 
 config SERIAL_OMAP
 	tristate "OMAP serial port support"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
-- 
2.26.3

