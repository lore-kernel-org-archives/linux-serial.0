From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] x86/mrst: Add platform data for Max3110 devices
Date: Fri, 26 Aug 2011 11:25:14 +0100
Message-ID: <20110826102501.17010.91892.stgit@localhost.localdomain>
References: <20110826102414.17010.71484.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HZLU7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 07:20:59 -0400
In-Reply-To: <20110826102414.17010.71484.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

Those info will be used when spi controller driver setup
max3110 as a slave device

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
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

