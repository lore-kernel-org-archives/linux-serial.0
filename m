From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v3 04/10] serial: stm32: add pm_runtime support
Date: Thu, 13 Jun 2019 15:49:54 +0200
Message-ID: <1560433800-12255-5-git-send-email-erwan.leray@st.com>
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

Use pm_runtime for clock management.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index a8f20ba..41898c4 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -810,13 +810,13 @@ static void stm32_pm(struct uart_port *port, unsigned int state,
 
 	switch (state) {
 	case UART_PM_STATE_ON:
-		clk_prepare_enable(stm32port->clk);
+		pm_runtime_get_sync(port->dev);
 		break;
 	case UART_PM_STATE_OFF:
 		spin_lock_irqsave(&port->lock, flags);
 		stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 		spin_unlock_irqrestore(&port->lock, flags);
-		clk_disable_unprepare(stm32port->clk);
+		pm_runtime_put_sync(port->dev);
 		break;
 	}
 }
@@ -1111,6 +1111,11 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &stm32port->port);
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+
 	return 0;
 
 err_wirq:
@@ -1132,6 +1137,9 @@ static int stm32_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
+	int err;
+
+	pm_runtime_get_sync(&pdev->dev);
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
@@ -1160,7 +1168,12 @@ static int stm32_serial_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(stm32_port->clk);
 
-	return uart_remove_one_port(&stm32_usart_driver, port);
+	err = uart_remove_one_port(&stm32_usart_driver, port);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return err;
 }
 
 
@@ -1317,7 +1330,29 @@ static int stm32_serial_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static int __maybe_unused stm32_serial_runtime_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct stm32_port *stm32port = container_of(port,
+			struct stm32_port, port);
+
+	clk_disable_unprepare(stm32port->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_serial_runtime_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct stm32_port *stm32port = container_of(port,
+			struct stm32_port, port);
+
+	return clk_prepare_enable(stm32port->clk);
+}
+
 static const struct dev_pm_ops stm32_serial_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_serial_runtime_suspend,
+			   stm32_serial_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_serial_suspend, stm32_serial_resume)
 };
 
-- 
1.9.1
