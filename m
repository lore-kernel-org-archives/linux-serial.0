From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH] serial: samsung: enable clock before clearing pending interrupts during init
Date: Tue, 28 May 2013 18:32:07 +0530
Message-ID: <1369746127-13129-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-serial@vger.kernel.org

Ensure that the uart controller clock is enabled prior to writing to the
interrupt mask and pending registers in the s3c24xx_serial_init_port
function.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 drivers/tty/serial/samsung.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 2c873c4..d1972b9 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1166,6 +1166,18 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret;
 
 	ourport->clk	= clk_get(&platdev->dev, "uart");
+	if (IS_ERR(ourport->clk)) {
+		pr_err("%s: Controller clock not found\n",
+				dev_name(&platdev->dev));
+		return PTR_ERR(ourport->clk);
+	}
+
+	ret = clk_prepare_enable(ourport->clk);
+	if (ret) {
+		pr_err("uart: clock failed to prepare+enable: %d\n", ret);
+		clk_put(ourport->clk);
+		return ret;
+	}
 
 	/* Keep all interrupts masked and cleared */
 	if (s3c24xx_serial_has_interrupt_mask(port)) {
@@ -1180,6 +1192,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	/* reset the fifos (and setup the uart) */
 	s3c24xx_serial_resetport(port, cfg);
+	clk_disable_unprepare(ourport->clk);
 	return 0;
 }
 
-- 
1.7.9.5
