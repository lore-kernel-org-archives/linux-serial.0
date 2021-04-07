Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C78C433ED
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504306139C
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhDGKOE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:14:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:19565 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235231AbhDGKOE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 06:14:04 -0400
IronPort-SDR: AIoLtVxKvf1FuyzENS7hQ1wTLT/xWAL+Sa9yet+++OEfrpCI0hlXKSVVdKhPRfy2eRhrxiGxMZ
 p0U2mk+S5O1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="190072126"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="190072126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 03:13:54 -0700
IronPort-SDR: qleZDu8eJuLlaSWIaIU2R/RRiC1vGuzKR38sJRfwTstGF8B7y/O9hYQLgv6jK/LT1gQtyupuaz
 wm1Bu6AyahAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="415203417"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Apr 2021 03:13:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2AE3D197; Wed,  7 Apr 2021 13:14:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/1] defconfig: enable SERIAL_SH_SCI
Date:   Wed,  7 Apr 2021 13:14:06 +0300
Message-Id: <20210407101406.8562-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed one typo
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 drivers/tty/serial/Kconfig        | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 396b5d4781ed..d696336674b0 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -347,6 +347,7 @@ CONFIG_SERIAL_8250_DMA=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_PCH_UART=y
 CONFIG_SERIAL_PCH_UART_CONSOLE=y
+CONFIG_SERIAL_SH_SCI=m
 CONFIG_MMC=m
 CONFIG_MMC_SDHCI=m
 CONFIG_MMC_SDHCI_PCI=m
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 49bd168a1f6a..20a955acf775 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -343,6 +343,7 @@ CONFIG_SERIAL_8250_DMA=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_PCH_UART=y
 CONFIG_SERIAL_PCH_UART_CONSOLE=y
+CONFIG_SERIAL_SH_SCI=m
 CONFIG_MMC=m
 CONFIG_MMC_SDHCI=m
 CONFIG_MMC_SDHCI_PCI=m
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e6f55c28cc2e..584e0d166e31 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -651,7 +651,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_RENESAS || H8300 || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || H8300 || COMPILE_TEST || X86
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 
-- 
2.30.2

