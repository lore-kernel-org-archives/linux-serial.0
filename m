From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/3] serial: st-asc: Provide RTS functionality
Date: Fri,  2 Dec 2016 14:11:45 +0000
Message-ID: <20161202141146.31281-2-lee.jones@linaro.org>
References: <20161202141146.31281-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161202141146.31281-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, patrice.chotard@st.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

Until this point, it has not been possible for serial applications
to toggle the UART RTS line.  This can be useful with certain
configurations. For example, when using a Mezzanine on a Linaro
96board, RTS line is used to take the the on-board microcontroller
in and out of reset.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 379e5bd..ce46898 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -38,6 +39,7 @@
 
 struct asc_port {
 	struct uart_port port;
+	struct gpio_desc *rts;
 	struct clk *clk;
 	unsigned int hw_flow_control:1;
 	unsigned int force_m1:1;
@@ -381,12 +383,16 @@ static unsigned int asc_tx_empty(struct uart_port *port)
 
 static void asc_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct asc_port *ascport = to_asc_port(port);
+
 	/*
 	 * This routine is used for seting signals of: DTR, DCD, CTS/RTS
 	 * We use ASC's hardware for CTS/RTS, so don't need any for that.
 	 * Some boards have DTR and DCD implemented using PIO pins,
 	 * code to do this should be hooked in here.
 	 */
+
+	gpiod_set_value(ascport->rts, mctrl & TIOCM_RTS);
 }
 
 static unsigned int asc_get_mctrl(struct uart_port *port)
@@ -731,12 +737,20 @@ MODULE_DEVICE_TABLE(of, asc_match);
 static int asc_serial_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct device_node *np = pdev->dev.of_node;
 	struct asc_port *ascport;
+	struct gpio_desc *gpiod;
 
 	ascport = asc_of_get_asc_port(pdev);
 	if (!ascport)
 		return -ENODEV;
 
+	gpiod = devm_get_gpiod_from_child(&pdev->dev, "rts", &np->fwnode);
+	if (!IS_ERR(gpiod)) {
+		gpiod_direction_output(gpiod, 0);
+		ascport->rts = gpiod;
+	}
+
 	ret = asc_init_port(ascport, pdev);
 	if (ret)
 		return ret;
-- 
2.10.2
