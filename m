From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v3 06/10] serial: stm32: add support for no_console_suspend
Date: Thu, 13 Jun 2019 15:49:56 +0200
Message-ID: <1560433800-12255-7-git-send-email-erwan.leray@st.com>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, linux-serial@vger.kernel.org, Bich Hemon <bich.hemon@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

In order to display console messages in low power mode, console pins
must be kept active after suspend call.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

Conflicts:
	drivers/tty/serial/stm32-usart.c

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index b0fb420..00e4d7a 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
@@ -847,6 +848,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 {
 	struct uart_port *port = &stm32port->port;
 	struct resource *res;
+	struct pinctrl *uart_pinctrl;
 	int ret;
 
 	port->iotype	= UPIO_MEM;
@@ -880,6 +882,24 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
+	uart_pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(uart_pinctrl)) {
+		ret = PTR_ERR(uart_pinctrl);
+		if (ret != -ENODEV) {
+			dev_err(&pdev->dev, "Can't get pinctrl, error %d\n",
+				ret);
+			return ret;
+		}
+		stm32port->console_pins = ERR_PTR(-ENODEV);
+	} else {
+		stm32port->console_pins = pinctrl_lookup_state
+			(uart_pinctrl, "no_console_suspend");
+	}
+
+	if (IS_ERR(stm32port->console_pins) && PTR_ERR(stm32port->console_pins)
+	    != -ENODEV)
+		return PTR_ERR(stm32port->console_pins);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(port->membase))
@@ -1304,6 +1324,7 @@ static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
 static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct stm32_port *stm32_port = to_stm32_port(port);
 
 	uart_suspend_port(&stm32_usart_driver, port);
 
@@ -1312,7 +1333,19 @@ static int __maybe_unused stm32_serial_suspend(struct device *dev)
 	else
 		stm32_serial_enable_wakeup(port, false);
 
-	pinctrl_pm_select_sleep_state(dev);
+	if (uart_console(port) && !console_suspend_enabled) {
+		if (IS_ERR(stm32_port->console_pins)) {
+			dev_err(dev, "no_console_suspend pinctrl not found\n");
+			return PTR_ERR(stm32_port->console_pins);
+		}
+
+		pinctrl_select_state(dev->pins->p, stm32_port->console_pins);
+	} else {
+		if (device_may_wakeup(dev))
+			pinctrl_pm_select_idle_state(dev);
+		else
+			pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 30d2433..050fe04 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -255,6 +255,7 @@ struct stm32_port {
 	bool fifoen;
 	int wakeirq;
 	int rdr_mask;		/* receive data register mask */
+	struct pinctrl_state *console_pins;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1
