From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 03/10] serial: st-asc: Read in all Pinctrl states
Date: Wed,  1 Feb 2017 14:31:38 +0000
Message-ID: <20170201143145.31962-4-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201143145.31962-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

There are now 2 possible separate/different Pinctrl states which can
be provided from platform data.  One which encompasses the lines
required for HW flow-control (CTS/RTS) and another which does not
specify these lines, such that they can be used via GPIO mechanisms
for manually toggling (i.e. from a request by `stty`).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 397df50..1058020 100644
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
+#define NO_HW_FLOWCTRL	1
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
+	/* "no-hw-flowctrl" state is optional */
+	ascport->states[NO_HW_FLOWCTRL] =
+		pinctrl_lookup_state(ascport->pinctrl, "no-hw-flowctrl");
+	if (IS_ERR(ascport->states[NO_HW_FLOWCTRL]))
+		ascport->states[NO_HW_FLOWCTRL] = NULL;
+
 	return 0;
 }
 
-- 
2.9.3
