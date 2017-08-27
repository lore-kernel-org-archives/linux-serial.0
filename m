From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] tty: serial: 8250_mtk: Use PTR_ERR_OR_ZERO
Date: Sun, 27 Aug 2017 12:01:41 +0530
Message-ID: <1503815501-9205-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, matthias.bgg@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: linux-serial@vger.kernel.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index ce0cc47..fb45770 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -171,10 +171,7 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	}
 
 	data->bus_clk = devm_clk_get(&pdev->dev, "bus");
-	if (IS_ERR(data->bus_clk))
-		return PTR_ERR(data->bus_clk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(data->bus_clk);
 }
 
 static int mtk8250_probe(struct platform_device *pdev)
-- 
2.7.4
