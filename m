From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v2 05/10] serial: stm32: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date: Tue, 11 Jun 2019 14:25:25 +0200
Message-ID: <1560255930-22554-6-git-send-email-erwan.leray@st.com>
References: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

Use __maybe_unused for power management related functionsinstead of

fixes: 270e5a74fe4c ("serial: stm32: add wakeup mechanism")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 60f3faf..0d43711 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1275,8 +1275,8 @@ static int stm32_console_setup(struct console *co, char *options)
 	.cons		= STM32_SERIAL_CONSOLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
-static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
+static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
+						      bool enable)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -1300,7 +1300,7 @@ static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
 	}
 }
 
-static int stm32_serial_suspend(struct device *dev)
+static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
@@ -1316,7 +1316,7 @@ static int stm32_serial_suspend(struct device *dev)
 	return 0;
 }
 
-static int stm32_serial_resume(struct device *dev)
+static int __maybe_unused stm32_serial_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
@@ -1327,7 +1327,6 @@ static int stm32_serial_resume(struct device *dev)
 
 	return uart_resume_port(&stm32_usart_driver, port);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int __maybe_unused stm32_serial_runtime_suspend(struct device *dev)
 {
-- 
1.9.1
