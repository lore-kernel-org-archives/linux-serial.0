From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 41/48] tty: Remove to support serial for S5P6442
Date: Mon, 23 May 2011 12:10:47 -0700
Message-ID: <1306177854-18172-41-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42128 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294Ab1EWTMK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:12:10 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kukjin Kim <kgene.kim@samsung.com>

According to removing ARCH_S5P6442, we don't need to support
serial for S5P6442.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2f96ce9..c01af80 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -537,7 +537,7 @@ config SERIAL_S3C6400
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442 || CPU_EXYNOS4210)
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210)
 	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210)
 	default y
 	help
-- 
1.7.4.2

