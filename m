From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/8] serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
Date: Tue, 24 Jan 2017 13:43:06 +0000
Message-ID: <20170124134310.27512-5-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124134310.27512-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

When hardware flow-control is disabled, manual toggling of the UART's
reset line (RTS) using userland applications (e.g. stty) is not
possible, since the ASC IP does not provide this functionality in the
same was as some other IPs do.  Thus, we have to do this manually.

This patch ensures that when HW flow-control is disabled the RTS/CTS
lines are free to be registered via the GPIO API.  It also ensures
any registered GPIO lines are unregistered when HW flow-control is
requested, allowing the IP to control them automatically.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 03801ed..2c4b5f5 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -512,6 +512,8 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct asc_port *ascport = to_asc_port(port);
+	struct device_node *np = port->dev->of_node;
+	struct gpio_desc *gpiod;
 	unsigned int baud;
 	u32 ctrl_val;
 	tcflag_t cflag;
@@ -555,9 +557,32 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
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
+		if (!ascport->rts && ascport->states[MANUAL_RTS]) {
+			pinctrl_select_state(ascport->pinctrl,
+					     ascport->states[MANUAL_RTS]);
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
2.10.2
