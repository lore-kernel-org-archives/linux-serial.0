From: Jun Chen <jun.d.chen@intel.com>
Subject: [PATCH] serial: ifx6x60: Add modem power off function in the
 platform reboot process
Date: Thu, 22 Nov 2012 06:19:23 -0500
Message-ID: <1353583163.23300.7.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Bi Chao <chao.bi@intel.com>, Jun Chen <jun.d.chen@intel.com>, serial <linux-serial@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>
List-Id: linux-serial@vger.kernel.org


This patch add modem power off function in the reboot process according registering
reboot callback to the reboot_notifier_list. Also realizing the spi shutdown function.

Signed-off-by: Bi Chao <chao.bi@intel.com>
Signed-off-by: Chen Jun <jun.d.chen@intel.com>
---
 drivers/tty/serial/ifx6x60.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..a91f4cb 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -60,6 +60,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/spi/ifx_modem.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
 
 #include "ifx6x60.h"
 
@@ -72,8 +73,14 @@
 #define IFX_SPI_HEADER_0		(-1)
 #define IFX_SPI_HEADER_F		(-2)
 
+#define PO_POST_DELAY		200
+#define IFX_MDM_RST_PMU	4
+
 /* forward reference */
 static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev);
+static int ifx_modem_reboot_callback(struct notifier_block *nfb,
+				unsigned long event, void *data);
+static int ifx_modem_power_off(struct ifx_spi_device *ifx_dev);
 
 /* local variables */
 static int spi_bpw = 16;		/* 8, 16 or 32 bit word length */
@@ -81,6 +88,29 @@ static struct tty_driver *tty_drv;
 static struct ifx_spi_device *saved_ifx_dev;
 static struct lock_class_key ifx_spi_key;
 
+static struct notifier_block ifx_modem_reboot_notifier_block = {
+	.notifier_call = ifx_modem_reboot_callback,
+};
+
+static int ifx_modem_power_off(struct ifx_spi_device *ifx_dev)
+{
+	gpio_set_value(IFX_MDM_RST_PMU, 1);
+	msleep(PO_POST_DELAY);
+
+	return 0;
+}
+
+static int ifx_modem_reboot_callback(struct notifier_block *nfb,
+				 unsigned long event, void *data)
+{
+	if (saved_ifx_dev)
+		ifx_modem_power_off(saved_ifx_dev);
+	else
+		pr_warn("no ifx modem active \n");
+
+	return NOTIFY_OK;
+}
+
 /* GPIO/GPE settings */
 
 /**
@@ -1219,6 +1249,9 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
 
 static void ifx_spi_spi_shutdown(struct spi_device *spi)
 {
+	struct ifx_spi_device *ifx_dev = spi_get_drvdata(spi);
+
+	ifx_modem_power_off(ifx_dev);
 }
 
 /*
@@ -1368,6 +1401,7 @@ static void __exit ifx_spi_exit(void)
 static int __init ifx_spi_init(void)
 {
 	int result;
+	int ret;
 
 	tty_drv = alloc_tty_driver(1);
 	if (!tty_drv) {
@@ -1399,6 +1433,11 @@ static int __init ifx_spi_init(void)
 			DRVNAME, result);
 		tty_unregister_driver(tty_drv);
 	}
+
+	ret = register_reboot_notifier(&ifx_modem_reboot_notifier_block);
+	if (ret)
+		pr_err("cannot register reboot notifier (err=%d)\n", ret);
+
 	return result;
 }
 
-- 
1.7.4.1
