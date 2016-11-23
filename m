From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/4] serial: core: Add LED trigger support
Date: Wed, 23 Nov 2016 11:01:03 +0100
Message-ID: <20161123100106.15969-2-s.hauer@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123100106.15969-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

With this patch the serial core provides LED triggers for RX and TX.

As the serial core layer does not know when the hardware actually sends
or receives characters, this needs help from the UART drivers. The
LED triggers are registered in uart_add_led_triggers() called from
the UART drivers which want to support LED triggers. All the driver
has to do then is to call uart_led_trigger_[tx|rx] to indicate
activity.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/serial_core.c | 73 ++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h      | 10 ++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f2303f3..3e8afb7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,6 +34,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/leds.h>
 
 #include <asm/irq.h>
 #include <asm/uaccess.h>
@@ -2703,6 +2704,77 @@ static const struct attribute_group tty_dev_attr_group = {
 	.attrs = tty_dev_attrs,
 	};
 
+void uart_led_trigger_tx(struct uart_port *uport)
+{
+	unsigned long delay = 50;
+
+	led_trigger_blink_oneshot(uport->led_trigger_tx, &delay, &delay, 0);
+}
+
+void uart_led_trigger_rx(struct uart_port *uport)
+{
+	unsigned long delay = 50;
+
+	led_trigger_blink_oneshot(uport->led_trigger_rx, &delay, &delay, 0);
+}
+
+/**
+ *	uart_add_led_triggers - register LED triggers for a UART
+ *	@drv: pointer to the uart low level driver structure for this port
+ *	@uport: uart port structure to use for this port.
+ *
+ *	Called by the driver to register LED triggers for a UART. It's the
+ *	drivers responsibility to call uart_led_trigger_rx/tx on received
+ *	and transmitted chars then.
+ */
+int uart_add_led_triggers(struct uart_driver *drv, struct uart_port *uport)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_LEDS_TRIGGERS))
+		return 0;
+
+	uport->led_trigger_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
+					       drv->dev_name, uport->line);
+	uport->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
+					       drv->dev_name, uport->line);
+	if (!uport->led_trigger_tx_name || !uport->led_trigger_rx_name) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	led_trigger_register_simple(uport->led_trigger_tx_name,
+				    &uport->led_trigger_tx);
+	led_trigger_register_simple(uport->led_trigger_rx_name,
+				    &uport->led_trigger_rx);
+
+	return 0;
+
+err_alloc:
+	kfree(uport->led_trigger_tx_name);
+	kfree(uport->led_trigger_rx_name);
+
+	return ret;
+}
+
+/**
+ *	uart_remove_led_triggers - remove LED triggers
+ *	@drv: pointer to the uart low level driver structure for this port
+ *	@uport: uart port structure to use for this port.
+ *
+ *	Remove LED triggers previously registered with uart_add_led_triggers
+ */
+void uart_remove_led_triggers(struct uart_port *uport)
+{
+	if (uport->led_trigger_rx)
+		led_trigger_unregister_simple(uport->led_trigger_rx);
+	kfree(uport->led_trigger_rx_name);
+
+	if (uport->led_trigger_tx)
+		led_trigger_unregister_simple(uport->led_trigger_tx);
+	kfree(uport->led_trigger_tx_name);
+}
+
 /**
  *	uart_add_one_port - attach a driver-defined port structure
  *	@drv: pointer to the uart low level driver structure for this port
@@ -2872,6 +2944,7 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
 	state->uart_port = NULL;
+
 	mutex_unlock(&port->mutex);
 out:
 	mutex_unlock(&port_mutex);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3442014..1b0a169 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/mutex.h>
 #include <linux/sysrq.h>
+#include <linux/leds.h>
 #include <uapi/linux/serial_core.h>
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
@@ -249,6 +250,10 @@ struct uart_port {
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	void			*private_data;		/* generic platform data pointer */
+	struct led_trigger	*led_trigger_rx;
+	char			*led_trigger_rx_name;
+	struct led_trigger	*led_trigger_tx;
+	char			*led_trigger_tx_name;
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
@@ -392,6 +397,11 @@ void uart_console_write(struct uart_port *port, const char *s,
 			unsigned int count,
 			void (*putchar)(struct uart_port *, int));
 
+int uart_add_led_triggers(struct uart_driver *drv, struct uart_port *uport);
+void uart_remove_led_triggers(struct uart_port *uport);
+void uart_led_trigger_tx(struct uart_port *port);
+void uart_led_trigger_rx(struct uart_port *port);
+
 /*
  * Port/driver registration/removal
  */
-- 
2.10.2
