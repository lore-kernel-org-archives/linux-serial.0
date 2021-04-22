Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF59C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 08:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C07C61426
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 08:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhDVIDG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 04:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234773AbhDVIDF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 04:03:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD21761426;
        Thu, 22 Apr 2021 08:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619078550;
        bh=LnsQ6yRq+lw6CBNsLAkU4/gVJtCf7+j3nrKvFbpk5QY=;
        h=From:To:Cc:Subject:Date:From;
        b=X6uzzyxvYjoNdca/5meIjtrfNPni6wA0sik0855R5vFec8gDxNajfvW/4eZYGyaWp
         LopT19a9nlY9UCyWPEP/QlRtpp0QKsF+98vPuaQTcYzRy2Zg0LsDyGabk2D5eIP+gH
         6ls1yNUYPxcKgEg0iQ6PP0fxy0Y2jxqzs1ya/RtuOCEGlcJUsuVpbNS2MAXNB1oyiJ
         rKPpNHQkfsJgJp/bvbAUW357e2A2g3ixMDGbkjnl5UVCwZOJLV/XuwNi3MtM1QA0N6
         xwtOcFpWEKmTrbscRok68f+djspNdlpqssjWcoqWrAQVoQfLOpnxNN0C0eEqKEi+vR
         UsrnM9mu4yMdQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZUIE-0007dl-6z; Thu, 22 Apr 2021 10:02:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] serial: extend compile-test coverage
Date:   Thu, 22 Apr 2021 10:02:11 +0200
Message-Id: <20210422080211.29326-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Allow more drivers to be compile tested more easily, for example, when
doing subsystem-wide changes.

Verified on X86_64 as well as arm, powerpc and m68k with minimal configs
in order to catch missing implicit build dependencies (e.g. MAILBOX for
SERIAL_TEGRA_TCU).

Signed-off-by: Johan Hovold <johan@kernel.org>
---

v2
 - amend commit message
 - drop the txx9 driver which has a build-dependency of sort and
   triggers a W=1 warning as reported by the kernel test robot 


 drivers/tty/serial/8250/Kconfig |  6 ++++--
 drivers/tty/serial/Kconfig      | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

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
index e6f55c28cc2e..682f9171c82c 100644
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

