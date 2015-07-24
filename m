From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250_uniphier: call clk_disable_unprepare() on failure path
Date: Fri, 24 Jul 2015 15:58:28 +0900
Message-ID: <1437721108-19037-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

If serial8250_register_8250_port() fails, disable and unprepare the
clock before exiting.

Fixes: 1a8d2903cb6a ("serial: 8250_uniphier: add UniPhier serial driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 7d79425..d11621e 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -218,6 +218,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(dev, "failed to register 8250 port\n");
+		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 
-- 
1.9.1
