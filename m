From: Wang Long <long.wanglong@huawei.com>
Subject: [PATCH v1] serial: 8250: remove the redundant include
Date: Mon, 9 Mar 2015 04:17:51 +0000
Message-ID: <1425874671-153401-1-git-send-email-long.wanglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: bigeasy@linutronix.de, peter@hurleysoftware.com, tony@atomide.com, alan@linux.intel.com, ricardo.ribalda@gmail.com, yoshihiro.yunomae.ez@hitachi.com, andriy.shevchenko@linux.intel.com, robh@kernel.org, long.wanglong@huawei.com, Vineet.Gupta1@synopsys.com, wsa@the-dreams.de, dforsi@gmail.com, rafael.j.wysocki@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peifeiyue@huawei.com
List-Id: linux-serial@vger.kernel.org

The serial_core.h file have been included in header file
serial_8250.h. so remove the "#include <serial_core.h>" in
some 8250 serial drivers, because they have included the header file
serial_8250.h.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 drivers/tty/serial/8250/8250_core.c  | 1 -
 drivers/tty/serial/8250/8250_dw.c    | 1 -
 drivers/tty/serial/8250/8250_early.c | 1 -
 drivers/tty/serial/8250/8250_em.c    | 1 -
 drivers/tty/serial/8250/8250_hp300.c | 1 -
 drivers/tty/serial/8250/8250_omap.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e3b9570a..7ddd668 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -31,7 +31,6 @@
 #include <linux/tty.h>
 #include <linux/ratelimit.h>
 #include <linux/tty_flip.h>
-#include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
 #include <linux/nmi.h>
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e601162..9c58ceb 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -17,7 +17,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/serial_8250.h>
-#include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c31a22b..c7ae647 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -29,7 +29,6 @@
 #include <linux/tty.h>
 #include <linux/init.h>
 #include <linux/console.h>
-#include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index ae5eaed..0b63812 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/serial_8250.h>
-#include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
index b488208..2891958 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -10,7 +10,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/serial.h>
-#include <linux/serial_core.h>
 #include <linux/serial_8250.h>
 #include <linux/delay.h>
 #include <linux/dio.h>
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index fe6d2e51..9289999 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/serial_8250.h>
-#include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/tty_flip.h>
 #include <linux/platform_device.h>
-- 
1.8.3.4
