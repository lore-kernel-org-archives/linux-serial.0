From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH 12/14] serial: lantiq: Replace lantiq_soc.h with lantiq.h
Date: Mon, 24 Sep 2018 18:28:01 +0800
Message-ID: <20180924102803.30263-13-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, hauke.mehrtens@intel.com
Cc: Songjun Wu <songjun.wu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

In this existing lantiq serial driver,
lantiq_soc.h is defined in the arch directory,

./arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
./arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

This driver need to be extended to support more platform,
lantiq.h is added in include/linux/ to make it
globally available and provide some wrapper code.
Use lantiq.h to make the driver can find the correct
header file.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index c983694ba24d..ba0c70b16bda 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/lantiq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -25,8 +26,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#include <lantiq_soc.h>
-
 #define PORT_LTQ_ASC		111
 #define MAXPORTS		2
 #define UART_DUMMY_UER_RX	1
-- 
2.11.0
