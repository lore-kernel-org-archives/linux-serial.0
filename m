From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tty: implement a rx led trigger
Date: Thu,  3 May 2018 12:04:48 +0200
Message-ID: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-serial@vger.kernel.org

The trigger fires when data is pushed to the ldisc. This is a bit later
than the actual receiving of data but has the nice benefit that it
doesn't need adaption for each driver and isn't in the hot path.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is actually v2 of the series "serial: Add LED trigger support" that
Sascha sent in November 2016.

For now this is only the RX part however that I'd like to use as a base
to get feedback. Once we got to an acceptable change the TX part should
be easy (once the right place to place the trigger is clear).

Other than that the trigger moved from a dedicated function in
serial_core that each driver is supposed to call on reception of data to
flush_to_ldisc().

Best regards
Uwe

 drivers/tty/tty_buffer.c |  4 ++++
 drivers/tty/tty_port.c   | 16 ++++++++++++++++
 include/linux/tty.h      |  3 +++
 3 files changed, 23 insertions(+)

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
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..51b78a585417 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/serdev.h>
 
@@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 
 	tty_port_link_device(port, driver, index);
 
+	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
+					      driver->name, index);
+	if (!port->led_trigger_rx_name) {
+		pr_err("Failed to allocate trigger name for %s%d\n",
+		       driver->name, index);
+		goto skip_trigger;
+	}
+
+	led_trigger_register_simple(port->led_trigger_rx_name,
+				    &port->led_trigger_rx);
+
+skip_trigger:
 	dev = serdev_tty_port_register(port, device, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
 		/* Skip creating cdev if we registered a serdev device */
@@ -206,6 +219,9 @@ void tty_port_unregister_device(struct tty_port *port,
 	if (ret == 0)
 		return;
 
+	led_trigger_unregister_simple(port->led_trigger_rx);
+	kfree(port->led_trigger_rx_name);
+
 	tty_unregister_device(driver, index);
 }
 EXPORT_SYMBOL_GPL(tty_port_unregister_device);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1dd587ba6d88..7e36ee1d2056 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -249,6 +249,9 @@ struct tty_port {
 						   set to size of fifo */
 	struct kref		kref;		/* Ref counter */
 	void 			*client_data;
+
+	struct led_trigger	*led_trigger_rx;
+	char			*led_trigger_rx_name;
 };
 
 /* tty_port::iflags bits -- use atomic bit ops */
-- 
2.17.0
