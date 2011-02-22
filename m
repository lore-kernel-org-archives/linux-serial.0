From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/2] serial: mfd: add a module parameter for setting each port's working mode
Date: Tue, 22 Feb 2011 15:28:12 +0800
Message-ID: <1298359692-9182-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20292 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab1BVH1m (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Feb 2011 02:27:42 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com, alan@linux.intel.com
Cc: chiau.ee.chew@intel.com, Feng Tang <feng.tang@intel.com>

The three identical uart ports can work either in DMA or PIO mode. Adding such
a module parameter "hsu_dma_enable" will enable user to chose working modes for
each port. If the mfd driver is built in kernel, adding a "mfd.hsu_dma_enable=x"
in kernel command line has the same effect.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/mfd.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 53ff6af..c111f36 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -47,6 +47,11 @@
 #define mfd_readl(obj, offset)		readl(obj->reg + offset)
 #define mfd_writel(obj, offset, val)	writel(val, obj->reg + offset)
 
+static int hsu_dma_enable;
+module_param(hsu_dma_enable, int, 0);
+MODULE_PARM_DESC(hsu_dma_enable, "It is a bitmap to set working mode, if \
+bit[x] is 1, then port[x] will work in DMA mode, otherwise in PIO mode.");
+
 struct hsu_dma_buffer {
 	u8		*buf;
 	dma_addr_t	dma_addr;
@@ -1367,6 +1372,12 @@ static void hsu_global_init(void)
 
 		serial_hsu_ports[i] = uport;
 		uport->index = i;
+
+		if (hsu_dma_enable & (1<<i))
+			uport->use_dma = 1;
+		else
+			uport->use_dma = 0;
+
 		uport++;
 	}
 
-- 
1.7.0.4

