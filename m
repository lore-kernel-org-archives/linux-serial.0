From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 7/7] serial: stm32: fix the get_irq error case
Date: Tue, 21 May 2019 17:45:47 +0200
Message-ID: <1558453547-22866-8-git-send-email-erwan.leray@st.com>
References: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Fabien Dessenne <fabien.dessenne@st.com>
List-Id: linux-serial@vger.kernel.org

Checks the returned values of platform_get_irq() for both required
"event" and optional "wakeup" IRQs during probe. This allows the driver
probe to be deferred if needed.
Removes redundant checks for 'cfg.has_wakeup'.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 1334e42..9c2b04e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -852,12 +852,31 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
-	port->irq	= platform_get_irq(pdev, 0);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't get event IRQ: %d\n", ret);
+		return ret ? ret : -ENODEV;
+	}
+	port->irq = ret;
+
 	port->rs485_config = stm32_config_rs485;
 
 	stm32_init_rs485(port, pdev);
 
-	stm32port->wakeirq = platform_get_irq(pdev, 1);
+	if (stm32port->info->cfg.has_wakeup) {
+		stm32port->wakeirq = platform_get_irq(pdev, 1);
+		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO) {
+			if (stm32port->wakeirq != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"Can't get event wake IRQ: %d\n",
+					stm32port->wakeirq);
+			return stm32port->wakeirq ? stm32port->wakeirq :
+				-ENODEV;
+		}
+	}
+
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1064,7 +1083,7 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0) {
+	if (stm32port->wakeirq > 0) {
 		ret = device_init_wakeup(&pdev->dev, true);
 		if (ret)
 			goto err_uninit;
@@ -1094,11 +1113,11 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	return 0;
 
 err_wirq:
-	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+	if (stm32port->wakeirq > 0)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
 err_nowup:
-	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+	if (stm32port->wakeirq > 0)
 		device_init_wakeup(&pdev->dev, false);
 
 err_uninit:
@@ -1112,7 +1131,6 @@ static int stm32_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 
 	stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAR);
 
@@ -1134,7 +1152,7 @@ static int stm32_serial_remove(struct platform_device *pdev)
 				  TX_BUF_L, stm32_port->tx_buf,
 				  stm32_port->tx_dma_buf);
 
-	if (cfg->has_wakeup && stm32_port->wakeirq >= 0) {
+	if (stm32_port->wakeirq > 0) {
 		dev_pm_clear_wake_irq(&pdev->dev);
 		device_init_wakeup(&pdev->dev, false);
 	}
@@ -1252,7 +1270,7 @@ static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 val;
 
-	if (!cfg->has_wakeup || stm32_port->wakeirq < 0)
+	if (stm32_port->wakeirq <= 0)
 		return;
 
 	if (enable) {
-- 
1.9.1
