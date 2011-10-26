From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 39/79] x86/mrst: Add platform data for Max3110 devices
Date: Wed, 26 Oct 2011 14:12:44 +0200
Message-ID: <1319631204-23262-39-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32775 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901Ab1JZMNq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:46 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Alan Cox <alan@linux.intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Feng Tang <feng.tang@intel.com>

Those info will be used when spi controller driver setup
max3110 as a slave device

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/x86/platform/mrst/mrst.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index 7000e74..b8da1b9 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -14,6 +14,8 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/scatterlist.h>
 #include <linux/sfi.h>
 #include <linux/intel_pmic_gpio.h>
 #include <linux/spi/spi.h>
@@ -392,6 +394,7 @@ static void __init *max3111_platform_data(void *info)
 	struct spi_board_info *spi_info = info;
 	int intr = get_gpio_by_name("max3111_int");
 
+	spi_info->mode = SPI_MODE_0;
 	if (intr == -1)
 		return NULL;
 	spi_info->irq = intr + MRST_IRQ_OFFSET;
-- 
1.7.7

