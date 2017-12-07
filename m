From: Branislav Radocaj <branislav@radocaj.org>
Subject: [PATCH] tty: serial: mxs-auart: fix error handling in mxs_auart_probe
Date: Thu,  7 Dec 2017 14:11:47 +0100
Message-ID: <20171207131147.14258-1-branislav@radocaj.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Branislav Radocaj <branislav@radocaj.org>
List-Id: linux-serial@vger.kernel.org

If uart_add_one_port() fails in mxs_auart_probe, the clks has
to be disabled.Two clks are previously enabled in mxs_get_clks().
Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Branislav Radocaj <branislav@radocaj.org>
---
 drivers/tty/serial/mxs-auart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index efb4fd3784ed..5b470406bf9d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1721,7 +1721,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
 	if (ret)
-		goto out_free_gpio_irq;
+		goto out_disable_clks_free_qpio_irq;
 
 	/* ASM9260 don't have version reg */
 	if (is_asm9260_auart(s)) {
@@ -1735,7 +1735,11 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_free_gpio_irq:
+out_disable_clks_free_qpio_irq:
+	if (s->clk)
+		clk_disable_unprepare(s->clk_ahb);
+	if (s->clk_ahb)
+		clk_disable_unprepare(s->clk_ahb);
 	mxs_auart_free_gpio_irq(s);
 	auart_port[pdev->id] = NULL;
 	return ret;
-- 
2.11.0
