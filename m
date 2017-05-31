From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Fix serial console on SNI RM400 machines
Date: Wed, 31 May 2017 22:21:03 +0200
Message-ID: <20170531203518.76311508766@solo.franken.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk
List-Id: linux-serial@vger.kernel.org

sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
is disabled. Correct usage of clk API to make it work with/without it.

Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)

Suggested-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/tty/serial/sccnxp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index fcf803f..cdd2f94 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -884,14 +884,19 @@ static int sccnxp_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		ret = PTR_ERR(clk);
+		if (ret == -EPROBE_DEFER)
 			goto err_out;
-		}
+		uartclk = 0;
+	} else {
+		clk_prepare_enable(clk);
+		uartclk = clk_get_rate(clk);
+	}
+
+	if (!uartclk) {
 		dev_notice(&pdev->dev, "Using default clock frequency\n");
 		uartclk = s->chip->freq_std;
-	} else
-		uartclk = clk_get_rate(clk);
+	}
 
 	/* Check input frequency */
 	if ((uartclk < s->chip->freq_min) || (uartclk > s->chip->freq_max)) {
-- 
2.1.4
