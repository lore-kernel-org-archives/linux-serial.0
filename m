From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/79] tty: Add support serial for EXYNOS4212 SoC
Date: Wed, 26 Oct 2011 14:12:31 +0200
Message-ID: <1319631204-23262-26-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60977 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932857Ab1JZMNj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:39 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kukjin Kim <kgene.kim@samsung.com>

According to add support EXYNOS4212 SoC, we need to enable
SERIAL_S5PV210 on EXYNOS4212.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a9b307f..10babe2 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -522,8 +522,8 @@ config SERIAL_S3C6400
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210)
-	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210)
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210 || SOC_EXYNOS4212)
+	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210 || SOC_EXYNOS4212)
 	default y
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
-- 
1.7.7

