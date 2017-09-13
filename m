From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v5 1/7] serial: Add common rs485 device tree parsing function
Date: Wed, 13 Sep 2017 10:18:27 +0200
Message-ID: <20170913081833.2740-2-u.kleine-koenig@pengutronix.de>
References: <20170913081833.2740-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170913081833.2740-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Several drivers have the same device tree parsing code. Create
a common helper function for it.

This patch bases on work done by Sascha Hauer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/tty/serial/serial_core.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h      |  5 +++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3a14cccbd7ff..f4e6c8662987 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3026,5 +3026,41 @@ EXPORT_SYMBOL(uart_resume_port);
 EXPORT_SYMBOL(uart_add_one_port);
 EXPORT_SYMBOL(uart_remove_one_port);
 
+/**
+ * of_get_rs485_mode() - Implement parsing rs485 properties
+ * @np: uart node
+ * @rs485conf: output parameter
+ *
+ * This function implements the device tree binding described in
+ * Documentation/devicetree/bindings/serial/rs485.txt.
+ */
+void of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf)
+{
+	u32 rs485_delay[2];
+	int ret;
+
+	ret = of_property_read_u32_array(np, "rs485-rts-delay", rs485_delay, 2);
+	if (!ret) {
+		rs485conf->delay_rts_before_send = rs485_delay[0];
+		rs485conf->delay_rts_after_send = rs485_delay[1];
+	} else {
+		rs485conf->delay_rts_before_send = 0;
+		rs485conf->delay_rts_after_send = 0;
+	}
+
+	/*
+	 * clear full-duplex and enabled flags to get to a defined state with
+	 * the two following properties.
+	 */
+	rs485conf->flags &= ~(SER_RS485_RX_DURING_TX | SER_RS485_ENABLED);
+
+	if (of_property_read_bool(np, "rs485-rx-during-tx"))
+		rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
+	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
+		rs485conf->flags |= SER_RS485_ENABLED;
+}
+EXPORT_SYMBOL_GPL(of_get_rs485_mode);
+
 MODULE_DESCRIPTION("Serial driver core");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5553e04e59c9..37b044e78333 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -501,4 +501,9 @@ static inline int uart_handle_break(struct uart_port *port)
 					 (cflag) & CRTSCTS || \
 					 !((cflag) & CLOCAL))
 
+/*
+ * Common device tree parsing helpers
+ */
+void of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf);
+
 #endif /* LINUX_SERIAL_CORE_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
