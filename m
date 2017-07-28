From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] drivers/serial: Do not leave sysfs group in case of error in aspeed_vuart_probe()
Date: Fri, 28 Jul 2017 21:54:03 +0300
Message-ID: <1501268043-20687-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Rob Herring <robh@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

There are several error handling paths in aspeed_vuart_probe(),
where sysfs group is left unremoved. The patch fixes them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 822be4906763..33a801353114 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -223,12 +223,13 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		if (IS_ERR(vuart->clk)) {
 			dev_warn(&pdev->dev,
 				"clk or clock-frequency not defined\n");
-			return PTR_ERR(vuart->clk);
+			rc = PTR_ERR(vuart->clk);
+			goto err_sysfs_remove;
 		}
 
 		rc = clk_prepare_enable(vuart->clk);
 		if (rc < 0)
-			return rc;
+			goto err_sysfs_remove;
 
 		clk = clk_get_rate(vuart->clk);
 	}
@@ -286,6 +287,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 err_clk_disable:
 	clk_disable_unprepare(vuart->clk);
 	irq_dispose_mapping(port.port.irq);
+err_sysfs_remove:
+	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	return rc;
 }
 
-- 
2.7.4
