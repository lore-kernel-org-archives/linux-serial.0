From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 03/10] serial: st-asc: Read in all Pinctrl states
Date: Fri, 27 Jan 2017 17:27:57 +0000
Message-ID: <20170127172804.23881-4-lee.jones@linaro.org>
References: <20170127172804.23881-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170127172804.23881-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

There are now 2 possible separate/different Pinctrl states which can
be provided from platform data.  One which encompasses the lines
required for HW flow-control (CTS/RTS) and another which does not
specify these lines, such that they can be used via GPIO mechanisms
for manually toggling (i.e. from a request by `stty`).

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/st-asc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 397df50..82f5714 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -18,6 +18,7 @@
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -37,10 +38,16 @@
 #define ASC_FIFO_SIZE 16
 #define ASC_MAX_PORTS 8
 
+/* Pinctrl states */
+#define DEFAULT		0
+#define MANUAL_RTS	1
+
 struct asc_port {
 	struct uart_port port;
 	struct gpio_desc *rts;
 	struct clk *clk;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *states[2];
 	unsigned int hw_flow_control:1;
 	unsigned int force_m1:1;
 };
@@ -694,6 +701,7 @@ static int asc_init_port(struct asc_port *ascport,
 {
 	struct uart_port *port = &ascport->port;
 	struct resource *res;
+	int ret;
 
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF;
@@ -720,6 +728,27 @@ static int asc_init_port(struct asc_port *ascport,
 	WARN_ON(ascport->port.uartclk == 0);
 	clk_disable_unprepare(ascport->clk);
 
+	ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(ascport->pinctrl)) {
+		ret = PTR_ERR(ascport->pinctrl);
+		dev_err(&pdev->dev, "Failed to get Pinctrl: %d\n", ret);
+	}
+
+	ascport->states[DEFAULT] =
+		pinctrl_lookup_state(ascport->pinctrl, "default");
+	if (IS_ERR(ascport->states[DEFAULT])) {
+		ret = PTR_ERR(ascport->states[DEFAULT]);
+		dev_err(&pdev->dev,
+			"Failed to look up Pinctrl state 'default': %d\n", ret);
+		return ret;
+	}
+
+	/* "manual-rts" state is optional */
+	ascport->states[MANUAL_RTS] =
+		pinctrl_lookup_state(ascport->pinctrl, "manual-rts");
+	if (IS_ERR(ascport->states[MANUAL_RTS]))
+		ascport->states[MANUAL_RTS] = NULL;
+
 	return 0;
 }
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
