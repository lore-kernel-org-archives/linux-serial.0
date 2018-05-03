From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] tty: implement led triggers
Date: Thu,  3 May 2018 22:19:52 +0200
Message-ID: <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org

The rx trigger fires when data is pushed to the ldisc. This is a bit later
than the actual receiving of data but has the nice benefit that it
doesn't need adaption for each driver and isn't in the hot path.

Similarily the tx trigger fires when data taken from the ldisc.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since v1, sent with Message-Id: 
20180503100448.1350-1-u.kleine-koenig@pengutronix.de:

 - implement tx trigger;
 - introduce Kconfig symbol for conditional compilation;
 - set trigger to NULL if allocating the name failed to not free random
   pointers in case the port struct wasn't zeroed;
 - use if/else instead of goto

 drivers/tty/Kconfig      |  7 +++++++
 drivers/tty/tty_buffer.c |  4 ++++
 drivers/tty/tty_io.c     |  6 ++++++
 drivers/tty/tty_port.c   | 32 ++++++++++++++++++++++++++++++++
 include/linux/tty.h      |  7 +++++++
 5 files changed, 56 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 0840d27381ea..07a2fb05439f 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -41,6 +41,13 @@ config VT
 	  If unsure, say Y, or else you won't be able to do much with your new
 	  shiny Linux system :-)
 
+config TTY_LEDS_TRIGGER
+	bool "Enable support for TTY actions making LEDs blink"
+	depends on LEDS_TRIGGERS
+	---help---
+	  This enable support for tty triggers. It provides two LED triggers
+	  (rx and tx) for each TTY.
+
 config CONSOLE_TRANSLATIONS
 	depends on VT
 	default y
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..4d364b77b1a7 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ratelimit.h>
+#include <linux/leds.h>
 
 
 #define MIN_TTYB_SIZE	256
@@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
 		struct tty_buffer *head = buf->head;
 		struct tty_buffer *next;
 		int count;
+		unsigned long delay = 50 /* ms */;
 
 		/* Ldisc or user is trying to gain exclusive access */
 		if (atomic_read(&buf->priority))
@@ -521,6 +523,8 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}
 
+		led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
+
 		count = receive_buf(port, head, count);
 		if (!count)
 			break;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7c838b90a31d..2c840f1e1e82 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -83,6 +83,7 @@
 #include <linux/timer.h>
 #include <linux/ctype.h>
 #include <linux/kd.h>
+#include <linux/leds.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/slab.h>
@@ -950,11 +951,16 @@ static inline ssize_t do_tty_write(
 	/* Do the write .. */
 	for (;;) {
 		size_t size = count;
+		unsigned long delay = 50 /* ms */;
+
 		if (size > chunk)
 			size = chunk;
 		ret = -EFAULT;
 		if (copy_from_user(tty->write_buf, buf, size))
 			break;
+
+		led_trigger_blink_oneshot(tty->port->led_trigger_tx, &delay, &delay, 0);
+
 		ret = write(tty, file, tty->write_buf, size);
 		if (ret <= 0)
 			break;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..f042879a597c 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/serdev.h>
 
@@ -157,6 +158,30 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 
 	tty_port_link_device(port, driver, index);
 
+#ifdef CONFIG_TTY_LEDS_TRIGGER
+	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
+					      driver->name, index);
+	if (port->led_trigger_rx_name) {
+		led_trigger_register_simple(port->led_trigger_rx_name,
+					    &port->led_trigger_rx);
+	} else {
+		port->led_trigger_rx = NULL;
+		pr_err("Failed to allocate trigger name for %s%d\n",
+		       driver->name, index);
+	}
+
+	port->led_trigger_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
+					      driver->name, index);
+	if (port->led_trigger_tx_name) {
+		led_trigger_register_simple(port->led_trigger_tx_name,
+					    &port->led_trigger_tx);
+	} else {
+		port->led_trigger_tx = NULL;
+		pr_err("Failed to allocate trigger name for %s%d\n",
+		       driver->name, index);
+	}
+#endif
+
 	dev = serdev_tty_port_register(port, device, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
 		/* Skip creating cdev if we registered a serdev device */
@@ -206,6 +231,13 @@ void tty_port_unregister_device(struct tty_port *port,
 	if (ret == 0)
 		return;
 
+#ifdef CONFIG_TTY_LEDS_TRIGGER
+	led_trigger_unregister_simple(port->led_trigger_rx);
+	kfree(port->led_trigger_rx_name);
+	led_trigger_unregister_simple(port->led_trigger_tx);
+	kfree(port->led_trigger_tx_name);
+#endif
+
 	tty_unregister_device(driver, index);
 }
 EXPORT_SYMBOL_GPL(tty_port_unregister_device);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1dd587ba6d88..b7dc957365b6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -249,6 +249,13 @@ struct tty_port {
 						   set to size of fifo */
 	struct kref		kref;		/* Ref counter */
 	void 			*client_data;
+
+#ifdef CONFIG_TTY_LEDS_TRIGGER
+	struct led_trigger	*led_trigger_rx;
+	char			*led_trigger_rx_name;
+	struct led_trigger	*led_trigger_tx;
+	char			*led_trigger_tx_name;
+#endif
 };
 
 /* tty_port::iflags bits -- use atomic bit ops */
-- 
2.17.0
