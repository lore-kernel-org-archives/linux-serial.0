From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] serial/bcm63xx_uart: use correct alias naming
Date: Wed,  8 Jun 2016 12:08:43 +0200
Message-ID: <1465380523-7385-1-git-send-email-jogo@openwrt.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Simon Arlott <simon-A6De1vDTPLDsq35pWSNszA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The bcm63xx_uart driver uses the of alias for determing its id. Recent
changes in dts files changed the expected 'uartX' to the recommended
'serialX', breaking serial output. Fix this by checking for a 'serialX'
alias as well.

Fixes: e3b992d028f8 ("MIPS: BMIPS: Improve BCM6328 device tree")
Fixes: 2d52ee82b475 ("MIPS: BMIPS: Improve BCM6368 device tree")
Fixes: 7537d273e2f3 ("MIPS: BMIPS: Add device tree example for BCM6358")
Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---

Based on 4.7-rc2, which is the current head of tty-next.

 drivers/tty/serial/bcm63xx_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index c28e5c24..5108fab 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -813,8 +813,12 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	if (pdev->dev.of_node)
-		pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+	if (pdev->dev.of_node) {
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+		if (pdev->id < 0)
+			pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+	}
 
 	if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
 		return -EINVAL;
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
