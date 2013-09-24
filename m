From: takasi-y@ops.dti.ne.jp
Subject: [PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
Date: Tue, 24 Sep 2013 13:10:39 +0900
Message-ID: <20130924131039.3c871cad7acb2a068a988d0f@ops.dti.ne.jp>
References: <52410F86.4040301@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52410F86.4040301@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: SH-Linux <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
migrate to the common clock framework.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
[takashi.yoshii.ze@renesas.com: edited for conflicts]
Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
---
 drivers/tty/serial/8250/8250_em.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 5f3bba1..d1a9078 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -122,7 +122,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	up.port.dev = &pdev->dev;
 	up.port.private_data = priv;
 
-	clk_enable(priv->sclk);
+	clk_prepare_enable(priv->sclk);
 	up.port.uartclk = clk_get_rate(priv->sclk);
 
 	up.port.iotype = UPIO_MEM32;
@@ -134,7 +134,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
-		clk_disable(priv->sclk);
+		clk_disable_unprepare(priv->sclk);
 		return ret;
 	}
 
@@ -148,7 +148,7 @@ static int serial8250_em_remove(struct platform_device *pdev)
 	struct serial8250_em_priv *priv = platform_get_drvdata(pdev);
 
 	serial8250_unregister_port(priv->line);
-	clk_disable(priv->sclk);
+	clk_disable_unprepare(priv->sclk);
 	return 0;
 }
 
-- 
1.8.1.5
