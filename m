From: Jun Chen <jun.d.chen@intel.com>
Subject: [PATCH] serial: ifx6x60: Add module parameters to manage the modem
 status through sysfs.
Date: Fri, 02 Nov 2012 12:15:43 -0400
Message-ID: <1351872943.4332.37.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51289 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab2KBINP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Nov 2012 04:13:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, russ.gorby@intel.com, chuansheng.liu@intel.com, chao.bi@intel.com, jun.d.chen@intel.com


The Medfield Platform implements a recovery procedure consisting in an escalation
from simple and light recovery procedures to stronger ones with increased visibility
and impact to end-user.After platform find some problem from Modem,such as no response,
platform will try do modem warm reset.If several tries failed, platform will try to
do modem cold boot procedure.For Modem Cold Boot, AP is responsible to generate
blob (binary object containing PIN code and other necessary information).
Blob is stored in AP volatile memory. AP decides to read PIN code from cache instead of
prompting end-user, and sends it to modem as if end-user had entered it.

This patch add module parameters to manage the modem status through sysfs.
These function are:reset_modem,reset_ongoing,hangup_reasons,

Cc: Bi Chao <chao.bi@intel.com>
Cc: Liu chuansheng <chuansheng.liu@intel.com>
Signed-off-by: Chen Jun <jun.d.chen@intel.com>
---
 drivers/tty/serial/ifx6x60.c |  108 ++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/ifx6x60.h |    7 +++
 2 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index e56ed33..50de856 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -72,6 +72,19 @@
 #define IFX_SPI_HEADER_0		(-1)
 #define IFX_SPI_HEADER_F		(-2)
 
+
+/* Delays for powering up/resetting the modem, ms */
+#define PO_INTERLINE_DELAY	1
+#define PO_POST_DELAY		200
+
+#define IFX_COLD_RESET_REQ	1
+
+#define IFX_MDM_PWR_ON	3
+#define IFX_MDM_RST_PMU	4
+
+static unsigned long  reset_ongoing;
+static unsigned long hangup_reasons;
+
 /* forward reference */
 static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev);
 
@@ -81,6 +94,42 @@ static struct tty_driver *tty_drv;
 static struct ifx_spi_device *saved_ifx_dev;
 static struct lock_class_key ifx_spi_key;
 
+
+/**
+ * do_modem_power - activity required to bring up modem
+ *
+ * Toggle gpios required to bring up modem power and start modem.
+ */
+static void do_modem_power(void)
+{
+
+	reset_ongoing = 1;
+
+
+	gpio_set_value(IFX_MDM_PWR_ON, 1);
+	mdelay(PO_INTERLINE_DELAY);
+	gpio_set_value(IFX_MDM_PWR_ON, 0);
+	msleep(PO_POST_DELAY);
+}
+
+/**
+ * do_modem_reset - activity required to reset modem
+ *
+ * Toggle gpios required to reset modem.
+ */
+static void do_modem_reset(void)
+{
+
+	reset_ongoing = 1;
+
+	gpio_set_value(IFX_MDM_RST_PMU, 0);
+	mdelay(PO_INTERLINE_DELAY);
+	gpio_set_value(IFX_MDM_RST_PMU, 1);
+	msleep(PO_POST_DELAY);
+}
+
+
+
 /* GPIO/GPE settings */
 
 /**
@@ -227,6 +276,7 @@ static void ifx_spi_timeout(unsigned long arg)
 	struct ifx_spi_device *ifx_dev = (struct ifx_spi_device *)arg;
 
 	dev_warn(&ifx_dev->spi_dev->dev, "*** SPI Timeout ***");
+	hangup_reasons |= HU_TIMEOUT;
 	ifx_spi_ttyhangup(ifx_dev);
 	mrdy_set_low(ifx_dev);
 	clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
@@ -877,6 +927,7 @@ static irqreturn_t ifx_spi_reset_interrupt(int irq, void *dev)
 		}
 	} else {
 		/* exited reset */
+		reset_ongoing = 0 ;
 		clear_bit(MR_INPROGRESS, &ifx_dev->mdm_reset_state);
 		if (solreset) {
 			set_bit(MR_COMPLETE, &ifx_dev->mdm_reset_state);
@@ -1403,6 +1454,63 @@ static int __init ifx_spi_init(void)
 module_init(ifx_spi_init);
 module_exit(ifx_spi_exit);
 
+/*
+ * Module parameters to manage the modem status through sysfs
+ */
+
+/**
+ * reset_modem - modem reset command function
+ * @val: a reference to the string where the modem reset query is given
+ * @kp: an unused reference to the kernel parameter
+ */
+
+static int reset_modem(const char *val, const struct kernel_param *kp)
+{
+	unsigned long reset_request;
+
+	if (kstrtoul(val, 10, &reset_request) < 0)
+		return -EINVAL;
+
+	if (!saved_ifx_dev) {
+		dev_dbg(&saved_ifx_dev->spi_dev->dev,
+				"%s is called before probe\n", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&saved_ifx_dev->spi_dev->dev,
+					"%s requested !\n", __func__);
+
+	reset_ongoing = 1;
+
+	if (reset_request == IFX_COLD_RESET_REQ) {
+		/*  Need to add these action for modem cold reset:
+		* - Set the RESET_BB_N to low (better SIM protection)
+		* - Set the EXT1P35VREN field to low  during 20ms (V1P35CNT_W  register)
+		* - set the EXT1P35VREN field to high during 10ms (V1P35CNT_W  register)
+		*/
+	}
+
+	/* Perform a complete modem reset */
+	do_modem_reset();
+	do_modem_power();
+
+	return 0;
+}
+
+static struct kernel_param_ops reset_modem_ops = {
+	.set = reset_modem,
+};
+module_param_cb(reset_modem, &reset_modem_ops, NULL, 0644);
+
+
+module_param(reset_ongoing, ulong, S_IRUGO);
+MODULE_PARM_DESC(reset_ongoing,  "modem reset status module parameter");
+
+module_param(hangup_reasons, ulong, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(hangup_reasons, "modem hangup reasons module parameter ");
+
+
+
 MODULE_AUTHOR("Intel");
 MODULE_DESCRIPTION("IFX6x60 spi driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index e8464ba..1ac36c4 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -66,6 +66,13 @@
 #define IFX_SPI_POWER_DATA_PENDING	1
 #define IFX_SPI_POWER_SRDY		2
 
+
+/* reasons for hanging up */
+#define	HU_TIMEOUT		1	/* spi timer out */
+#define	HU_RESET			2	/* modem initiative reset */
+#define	HU_COREDUMP		4	/* modem crash coredump */
+#define	HU_RORTUR			8	/* spi transfer error:ROR or TUR */
+
 struct ifx_spi_device {
 	/* Our SPI device */
 	struct spi_device *spi_dev;
-- 
1.7.4.1



