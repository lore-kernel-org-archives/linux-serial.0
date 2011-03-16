From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 45/76] serial: mfd: add a module parameter for setting each port's working mode
Date: Wed, 16 Mar 2011 14:12:15 -0700
Message-ID: <1300309966-5745-45-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32981 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab1CPVO1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:27 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Feng Tang <feng.tang@intel.com>

The three identical uart ports can work either in DMA or PIO mode. Adding such
a module parameter "hsu_dma_enable" will enable user to chose working modes for
each port. If the mfd driver is built in kernel, adding a "mfd.hsu_dma_enable=x"
in kernel command line has the same effect.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.4.1

