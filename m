From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH 10/14] serial: lantiq: Reorder the head files
Date: Mon, 24 Sep 2018 18:27:59 +0800
Message-ID: <20180924102803.30263-11-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, hauke.mehrtens@intel.com
Cc: Songjun Wu <songjun.wu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Reorder the head files according to the coding style.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 88210de00f35..c983694ba24d 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -8,22 +8,22 @@
  * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
  */
 
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/sysrq.h>
 #include <linux/device.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-#include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/of_platform.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #include <lantiq_soc.h>
 
-- 
2.11.0
