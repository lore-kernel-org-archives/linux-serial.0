From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH RFC v2 3/3] misc: Add w2g0004 gps receiver driver
Date: Sun, 28 Jun 2015 21:46:26 +0200
Message-ID: <1435520786-31867-4-git-send-email-marek@goldelico.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435520786-31867-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jslaby@suse.cz, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: peter@hurleysoftware.com, mark.rutland@arm.com, gnomes@lxorguk.ukuu.org.uk, sre@kernel.org, neil@brown.name, grant.likely@linaro.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Add driver for Wi2Wi w2g004 GPS module connected through  uart. Use uart
slave + notification hooks to glue with tty.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
 drivers/misc/Kconfig                               |  18 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/w2sg0004.c                            | 436 +++++++++++++++++++++
 include/linux/w2sg0004.h                           |  28 ++
 5 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
 create mode 100644 drivers/misc/w2sg0004.c
 create mode 100644 include/linux/w2sg0004.h

diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
new file mode 100644
index 0000000..ef0d6d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
@@ -0,0 +1,18 @@
+Wi2Wi GPS module connected through UART
+
+Required properties:
+- compatible: wi2wi,w2sg0004 or wi2wi,w2sg0084
+- on-off-gpio: the GPIO that controls the module's on-off toggle input
+- uart: the uart we are connected to (provides DTR for power control)
+
+Optional properties:
+- lna-suppy: an (optional) LNA regulator that is enabled together with the GPS receiver
+
+example:
+
+        gps_receiver: w2sg0004 {
+                compatible = "wi2wi,w2sg0004";
+                lna-supply = <&vsim>;	/* LNA regulator */
+                on-off-gpio = <&gpio5 17 0>;	/* GPIO_145: trigger for turning on/off w2sg0004 */
+                uart = <&uart1>;	/* we are a slave of uart1 */
+        }
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42c3852..952add4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -527,4 +527,22 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+
+menu "GTA04 misc hardware support"
+
+config W2SG0004
+	tristate "W2SG0004 on/off control"
+	depends on GPIOLIB
+	help
+	  Enable on/off control of W2SG0004 GPS using a tty slave to
+	  to allow powering up if the /dev/tty$n is opened.
+	  It also provides a rfkill gps node to control the LNA power.
+
+config W2SG0004_DEBUG
+	bool "W2SG0004 on/off debugging"
+	depends on W2SG0004
+	help
+	  Enable driver debugging mode of W2SG0004 GPS.
+
+endmenu
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d056fb7..3bc67c7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -53,5 +53,6 @@ obj-$(CONFIG_SRAM)		+= sram.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
+obj-$(CONFIG_W2SG0004)		+= w2sg0004.o
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
new file mode 100644
index 0000000..c5f0f7b
--- /dev/null
+++ b/drivers/misc/w2sg0004.c
@@ -0,0 +1,436 @@
+/*
+ * w2sg0004.c
+ * Driver for power controlling the w2sg0004/w2sg0084 GPS receiver.
+ *
+ * This receiver has an ON/OFF pin which must be toggled to
+ * turn the device 'on' of 'off'.  A high->low->high toggle
+ * will switch the device on if it is off, and off if it is on.
+ *
+ * To enable receiving on/off requests we register with the
+ * UART power management notifications.
+ *
+ * It is not possible to directly detect the state of the device.
+ * However when it is on it will send characters on a UART line
+ * regularly.
+ *
+ * To detect that the power state is out of sync (e.g. if GPS
+ * was enabled before a reboot), we register for UART data received
+ * notifications.
+ *
+ * In addition we register as a rfkill client so that we can
+ * control the LNA power.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/w2sg0004.h>
+#include <linux/workqueue.h>
+#include <linux/rfkill.h>
+#include <linux/serial_core.h>
+
+#ifdef CONFIG_W2SG0004_DEBUG
+#undef pr_debug
+#define pr_debug printk
+#endif
+
+/*
+ * There seems to be restrictions on how quickly we can toggle the
+ * on/off line.  data sheets says "two rtc ticks", whatever that means.
+ * If we do it too soon it doesn't work.
+ * So we have a state machine which uses the common work queue to ensure
+ * clean transitions.
+ * When a change is requested we record that request and only act on it
+ * once the previous change has completed.
+ * A change involves a 10ms low pulse, and a 990ms raised level, so only
+ * one change per second.
+ */
+
+enum w2sg_state {
+	W2SG_IDLE,	/* is not changing state */
+	W2SG_PULSE,	/* activate on/off impulse */
+	W2SG_NOPULSE	/* deactivate on/off impulse */
+};
+
+struct w2sg_data {
+	struct		rfkill *rf_kill;
+	struct		regulator *lna_regulator;
+	int		lna_blocked;	/* rfkill block gps active */
+	int		lna_is_off;	/* LNA is currently off */
+	int		is_on;		/* current state (0/1) */
+	unsigned long	last_toggle;
+	unsigned long	backoff;	/* time to wait since last_toggle */
+	int		on_off_gpio;	/* the on-off gpio number */
+	struct uart_port	*uart;		/* the drvdata of the uart or tty */
+	enum w2sg_state	state;
+	int		requested;	/* requested state (0/1) */
+	int		suspended;
+	spinlock_t	lock;
+	struct delayed_work work;
+};
+
+static int w2sg_data_set_lna_power(struct w2sg_data *data)
+{
+	int ret = 0;
+	int off = data->suspended || !data->requested || data->lna_blocked;
+
+	pr_debug("%s: %s\n", __func__, off ? "off" : "on");
+
+	if (off != data->lna_is_off) {
+		data->lna_is_off = off;
+		if (!IS_ERR_OR_NULL(data->lna_regulator)) {
+			if (off)
+				regulator_disable(data->lna_regulator);
+			else
+				ret = regulator_enable(data->lna_regulator);
+		}
+	}
+
+	return ret;
+}
+
+static void w2sg_data_set_power(void *pdata, int val)
+{
+	struct w2sg_data *data = (struct w2sg_data *) pdata;
+	unsigned long flags;
+
+	pr_debug("%s to %d (%d)\n", __func__, val, data->requested);
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	if (val && !data->requested) {
+		data->requested = true;
+	} else if (!val && data->requested) {
+		data->backoff = HZ;
+		data->requested = false;
+	} else
+		goto unlock;
+
+	pr_debug("w2sg scheduled for %d\n", data->requested);
+
+	if (!data->suspended)
+		schedule_delayed_work(&data->work, 0);
+unlock:
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+/* called each time data is received by the host (i.e. sent by the w2sg0004) */
+
+static int rx_notification(void *pdata, unsigned int *c)
+{
+	struct w2sg_data *data = (struct w2sg_data *) pdata;
+	unsigned long flags;
+
+	if (!data->requested && !data->is_on) {
+		pr_debug("%02x!", *c); /* we have received a RX signal while GPS should be off */
+		if ((data->state == W2SG_IDLE) &&
+		    time_after(jiffies,
+		    data->last_toggle + data->backoff)) {
+			/* Should be off by now, time to toggle again */
+			pr_debug("w2sg has sent data although it should be off!\n");
+			data->is_on = true;
+			data->backoff *= 2;
+			spin_lock_irqsave(&data->lock, flags);
+			if (!data->suspended)
+				schedule_delayed_work(&data->work, 0);
+			spin_unlock_irqrestore(&data->lock, flags);
+		}
+	}
+	return 0;	/* forward to tty */
+}
+
+/* called by uart modem control line changes (DTR) */
+
+static int w2sg_mctrl(void *pdata, int val)
+{
+	pr_debug("%s(...,%x)\n", __func__, val);
+	val = (val & TIOCM_DTR) != 0;	/* DTR controls power on/off */
+	w2sg_data_set_power((struct w2sg_data *) pdata, val);
+	return 0;
+}
+
+/* try to toggle the power state by sending a pulse to the on-off GPIO */
+
+static void toggle_work(struct work_struct *work)
+{
+	struct w2sg_data *data = container_of(work, struct w2sg_data, work.work);
+
+	switch (data->state) {
+	case W2SG_IDLE:
+		spin_lock_irq(&data->lock);
+		if (data->requested == data->is_on) {
+			spin_unlock_irq(&data->lock);
+			return;
+		}
+		spin_unlock_irq(&data->lock);
+		w2sg_data_set_lna_power(data);	/* update LNA power state */
+		gpio_set_value_cansleep(data->on_off_gpio, 0);
+		data->state = W2SG_PULSE;
+
+		pr_debug("w2sg: power gpio ON\n");
+
+		schedule_delayed_work(&data->work,
+				      msecs_to_jiffies(10));
+		break;
+
+	case W2SG_PULSE:
+		gpio_set_value_cansleep(data->on_off_gpio, 1);
+		data->last_toggle = jiffies;
+		data->state = W2SG_NOPULSE;
+		data->is_on = !data->is_on;
+
+		pr_debug("w2sg: power gpio OFF\n");
+
+		schedule_delayed_work(&data->work,
+				      msecs_to_jiffies(10));
+		break;
+
+	case W2SG_NOPULSE:
+		data->state = W2SG_IDLE;
+		pr_debug("w2sg: idle\n");
+
+		break;
+
+	}
+}
+
+static int w2sg_data_rfkill_set_block(void *pdata, bool blocked)
+{
+	struct w2sg_data *data = pdata;
+
+	pr_debug("%s: blocked: %d\n", __func__, blocked);
+
+	data->lna_blocked = blocked;
+
+	return w2sg_data_set_lna_power(data);
+}
+
+static struct rfkill_ops w2sg_data0004_rfkill_ops = {
+	.set_block = w2sg_data_rfkill_set_block,
+};
+
+static int w2sg_data_probe(struct platform_device *pdev)
+{
+	struct w2sg_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct w2sg_data *data;
+	struct rfkill *rf_kill;
+	int err;
+
+	pr_debug("%s()\n", __func__);
+
+	if (pdev->dev.of_node) {
+		struct device *dev = &pdev->dev;
+		enum of_gpio_flags flags;
+
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		pdata->on_off_gpio = of_get_named_gpio_flags(dev->of_node, "on-off-gpio", 0, &flags);
+
+		if (pdata->on_off_gpio == -EPROBE_DEFER)
+			return -EPROBE_DEFER;	/* defer until we have all gpios */
+
+		pdata->lna_regulator = devm_regulator_get_optional(dev, "lna");
+
+		pr_debug("%x() lna_regulator = %p\n", __func__, pdata->lna_regulator);
+
+		pdev->dev.platform_data = pdata;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data->lna_regulator = pdata->lna_regulator;
+	data->lna_blocked = true;
+	data->lna_is_off = true;
+
+	data->on_off_gpio = pdata->on_off_gpio;
+
+	data->is_on = false;
+	data->requested = false;
+	data->state = W2SG_IDLE;
+	data->last_toggle = jiffies;
+	data->backoff = HZ;
+
+#ifdef CONFIG_OF
+	data->uart = devm_serial_get_uart_by_phandle(&pdev->dev, "uart", 0);
+	if (IS_ERR(data->uart)) {
+		if (PTR_ERR(data->uart) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;	/* we can't probe yet */
+		else
+			data->uart = NULL;	/* no UART */
+		}
+#endif
+
+	INIT_DELAYED_WORK(&data->work, toggle_work);
+	spin_lock_init(&data->lock);
+
+	err = devm_gpio_request(&pdev->dev, data->on_off_gpio, "w2sg0004-on-off");
+	if (err < 0)
+		goto out;
+
+	gpio_direction_output(data->on_off_gpio, false);
+
+	if (data->uart) {
+		struct ktermios termios = {
+			.c_iflag = IGNBRK,
+			.c_oflag = 0,
+			.c_cflag = B9600 | CS8,
+			.c_lflag = 0,
+			.c_line = 0,
+			.c_ispeed = 9600,
+			.c_ospeed = 9600
+		};
+		uart_register_slave(data->uart, data);
+		uart_register_mctrl_notification(data->uart, w2sg_mctrl);
+		uart_register_rx_notification(data->uart, rx_notification, &termios);
+	}
+
+	rf_kill = rfkill_alloc("GPS", &pdev->dev, RFKILL_TYPE_GPS,
+				&w2sg_data0004_rfkill_ops, data);
+	if (rf_kill == NULL) {
+		err = -ENOMEM;
+		goto err_rfkill;
+	}
+
+	err = rfkill_register(rf_kill);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot register rfkill device\n");
+		goto err_rfkill;
+	}
+
+	data->rf_kill = rf_kill;
+
+	platform_set_drvdata(pdev, data);
+
+	pr_debug("w2sg0004 probed\n");
+
+#ifdef CONFIG_W2SG0004_DEBUG
+	/* turn on for debugging rx notifications */
+	pr_debug("w2sg power gpio ON\n");
+	gpio_set_value_cansleep(data->on_off_gpio, 1);
+	mdelay(100);
+	pr_debug("w2sg power gpio OFF\n");
+	gpio_set_value_cansleep(data->on_off_gpio, 0);
+	mdelay(300);
+#endif
+
+	/* if we won't receive mctrl notifications, turn on.
+	 * otherwise keep off until DTR is asserted through mctrl.
+	 */
+
+	w2sg_data_set_power(data, !data->uart);
+
+	return 0;
+
+err_rfkill:
+	rfkill_destroy(rf_kill);
+out:
+	return err;
+}
+
+static int w2sg_data_remove(struct platform_device *pdev)
+{
+	struct w2sg_data *data = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&data->work);
+
+	if (data->uart) {
+		uart_register_rx_notification(data->uart, NULL, NULL);
+		uart_register_slave(data->uart, NULL);
+	}
+	return 0;
+}
+
+static int w2sg_data_suspend(struct device *dev)
+{
+	struct w2sg_data *data = dev_get_drvdata(dev);
+
+	spin_lock_irq(&data->lock);
+	data->suspended = true;
+	spin_unlock_irq(&data->lock);
+
+	cancel_delayed_work_sync(&data->work);
+
+	w2sg_data_set_lna_power(data);	/* shuts down if needed */
+
+	if (data->state == W2SG_PULSE) {
+		msleep(10);
+		gpio_set_value_cansleep(data->on_off_gpio, 1);
+		data->last_toggle = jiffies;
+		data->is_on = !data->is_on;
+		data->state = W2SG_NOPULSE;
+	}
+
+	if (data->state == W2SG_NOPULSE) {
+		msleep(10);
+		data->state = W2SG_IDLE;
+	}
+
+	if (data->is_on) {
+		pr_info("GPS off for suspend %d %d %d\n", data->requested, data->is_on, data->lna_is_off);
+
+		gpio_set_value_cansleep(data->on_off_gpio, 0);
+		msleep(10);
+		gpio_set_value_cansleep(data->on_off_gpio, 1);
+		data->is_on = 0;
+	}
+
+	return 0;
+}
+
+static int w2sg_data_resume(struct device *dev)
+{
+	struct w2sg_data *data = dev_get_drvdata(dev);
+
+	spin_lock_irq(&data->lock);
+	data->suspended = false;
+	spin_unlock_irq(&data->lock);
+
+	pr_info("GPS resuming %d %d %d\n", data->requested, data->is_on, data->lna_is_off);
+
+	schedule_delayed_work(&data->work, 0);	/* enables LNA if needed */
+
+	return 0;
+}
+
+#if defined(CONFIG_OF)
+static const struct of_device_id w2sg0004_of_match[] = {
+	{ .compatible = "wi2wi,w2sg0004" },
+	{ .compatible = "wi2wi,w2sg0084" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, w2sg0004_of_match);
+#endif
+
+SIMPLE_DEV_PM_OPS(w2sg_pm_ops, w2sg_data_suspend, w2sg_data_resume);
+
+static struct platform_driver w2sg_data_driver = {
+	.probe		= w2sg_data_probe,
+	.remove		= w2sg_data_remove,
+	.driver = {
+		.name	= "w2sg0004",
+		.owner	= THIS_MODULE,
+		.pm	= &w2sg_pm_ops,
+		.of_match_table = of_match_ptr(w2sg0004_of_match)
+	},
+};
+
+module_platform_driver(w2sg_data_driver);
+
+MODULE_ALIAS("w2sg0004");
+
+MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
+MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/w2sg0004.h b/include/linux/w2sg0004.h
new file mode 100644
index 0000000..7aee709
--- /dev/null
+++ b/include/linux/w2sg0004.h
@@ -0,0 +1,28 @@
+/*
+ * UART slave to allow ON/OFF control of w2sg0004 GPS receiver.
+ *
+ * Copyright (C) 2011 Neil Brown <neil@brown.name>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+
+
+#ifndef __LINUX_W2SG0004_H
+#define __LINUX_W2SG0004_H
+
+#include <linux/regulator/consumer.h>
+
+struct w2sg_pdata {
+	struct regulator *lna_regulator;	/* enable LNA power */
+	int	on_off_gpio;	/* connected to the on-off input of the GPS module */
+};
+#endif /* __LINUX_W2SG0004_H */
-- 
1.9.1
