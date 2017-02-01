From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 04/10] serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
Date: Wed,  1 Feb 2017 14:31:39 +0000
Message-ID: <20170201143145.31962-5-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170201143145.31962-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

When hardware flow-control is disabled, manual toggling of the UART's
reset line (RTS) using userland applications (e.g. stty) is not
possible, since the ASC IP does not provide this functionality in the
same was as some other IPs do.  Thus, we have to do this manually.

This patch ensures that when HW flow-control is disabled the RTS/CTS
lines are free to be registered via the GPIO API.  It also ensures
any registered GPIO lines are unregistered when HW flow-control is
requested, allowing the IP to control them automatically.

Acked-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/st-asc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 1058020..e521078 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -513,6 +513,8 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct asc_port *ascport = to_asc_port(port);
+	struct device_node *np = port->dev->of_node;
+	struct gpio_desc *gpiod;
 	unsigned int baud;
 	u32 ctrl_val;
 	tcflag_t cflag;
@@ -556,9 +558,32 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 		ctrl_val |= ASC_CTL_PARITYODD;
 
 	/* hardware flow control */
-	if ((cflag & CRTSCTS))
+	if ((cflag & CRTSCTS)) {
 		ctrl_val |= ASC_CTL_CTSENABLE;
 
+		/* If flow-control selected, stop handling RTS manually */
+		if (ascport->rts) {
+			devm_gpiod_put(port->dev, ascport->rts);
+			ascport->rts = NULL;
+
+			pinctrl_select_state(ascport->pinctrl,
+					     ascport->states[DEFAULT]);
+		}
+	} else {
+		/* If flow-control disabled, it's safe to handle RTS manually */
+		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL]) {
+			pinctrl_select_state(ascport->pinctrl,
+					     ascport->states[NO_HW_FLOWCTRL]);
+
+			gpiod =	devm_get_gpiod_from_child(port->dev, "rts",
+							  &np->fwnode);
+			if (!IS_ERR(gpiod)) {
+				gpiod_direction_output(gpiod, 0);
+				ascport->rts = gpiod;
+			}
+		}
+	}
+
 	if ((baud < 19200) && !ascport->force_m1) {
 		asc_out(port, ASC_BAUDRATE, (port->uartclk / (16 * baud)));
 	} else {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
