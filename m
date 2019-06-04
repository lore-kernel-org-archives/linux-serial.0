From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 06/10] serial: stm32: add support for no_console_suspend
Date: Tue, 4 Jun 2019 10:55:15 +0200
Message-ID: <1559638519-6128-7-git-send-email-erwan.leray@st.com>
References: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Bich Hemon <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

In order to display console messages in low power mode, console pins
must be kept active after suspend call.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index aa3da1c..573eae1 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -24,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
@@ -802,6 +804,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 {
 	struct uart_port *port = &stm32port->port;
 	struct resource *res;
+	struct pinctrl *uart_pinctrl;
 	int ret;
 
 	port->iotype	= UPIO_MEM;
@@ -816,6 +819,24 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	stm32port->wakeirq = platform_get_irq(pdev, 1);
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
@@ -1228,6 +1249,7 @@ static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
 static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct stm32_port *stm32_port = to_stm32_port(port);
 
 	uart_suspend_port(&stm32_usart_driver, port);
 
@@ -1236,7 +1258,19 @@ static int __maybe_unused stm32_serial_suspend(struct device *dev)
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
index 6f294e2..6957d50 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -261,6 +261,7 @@ struct stm32_port {
 	bool hw_flow_control;
 	bool fifoen;
 	int wakeirq;
+	struct pinctrl_state *console_pins;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1
