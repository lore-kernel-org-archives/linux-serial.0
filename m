From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 3/5] serial: core: Support common rs485 binding for RTS
 polarity
Date: Wed, 8 Nov 2017 11:32:34 +0100
Message-ID: <e85e3d02a45e79e410b6606d8fdec347f03053f4.1510134353.git.lukas@wunner.de>
References: <cover.1510134353.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510134353.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

When a driver invokes the uart_get_rs485_mode() helper, set the RTS
polarity to active high by default unless the newly introduced
"rs485-rts-active-low" property was specified.

omap-serial historically defaults to active low and supports an
"rs485-rts-active-high" property to inverse the polarity.  Retain that
behavior for compatibility.

Cc: Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Cc: Michał Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
 drivers/tty/serial/omap-serial.c | 7 +++++--
 drivers/tty/serial/serial_core.c | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index e6aadb6d02e5..7ef36c0af825 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1617,10 +1617,13 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 
 	uart_get_rs485_mode(up->dev, rs485conf);
 
-	if (of_property_read_bool(np, "rs485-rts-active-high"))
+	if (of_property_read_bool(np, "rs485-rts-active-high")) {
 		rs485conf->flags |= SER_RS485_RTS_ON_SEND;
-	else
+		rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+	} else {
+		rs485conf->flags &= ~SER_RS485_RTS_ON_SEND;
 		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+	}
 
 	/* check for tx enable gpio */
 	up->rts_gpio = of_get_named_gpio_flags(np, "rts-gpio", 0, &flags);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 548bb80223c1..64e15507a9bd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3048,6 +3048,14 @@ void uart_get_rs485_mode(struct device *dev, struct serial_rs485 *rs485conf)
 		rs485conf->delay_rts_after_send = 0;
 	}
 
+	if (device_property_read_bool(dev, "rs485-rts-active-low")) {
+		rs485conf->flags &= ~SER_RS485_RTS_ON_SEND;
+		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+	} else {
+		rs485conf->flags |= SER_RS485_RTS_ON_SEND;
+		rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
+
 	/*
 	 * clear full-duplex and enabled flags to get to a defined state with
 	 * the two following properties.
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
