From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH 09/14] serial: lantiq: Add CCF support
Date: Mon, 24 Sep 2018 18:27:58 +0800
Message-ID: <20180924102803.30263-10-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, hauke.mehrtens@intel.com
Cc: Songjun Wu <songjun.wu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Previous implementation uses platform-dependent API to get the clock.
Those functions are not available for other SoC which uses the same IP.
The CCF (Common Clock Framework) have an abstraction based APIs for
clock. In future, the platform specific code will be removed when the
legacy soc use CCF as well.
Change to use CCF APIs to get clock and rate. So that different SoCs
can use the same driver.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 34b1ef3c12ce..88210de00f35 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -744,14 +744,22 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
-	ltq_port->freqclk = clk_get_fpi();
+	if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
+		ltq_port->freqclk = clk_get_fpi();
+	else
+		ltq_port->freqclk = devm_clk_get(&pdev->dev, "freq");
+
+
 	if (IS_ERR(ltq_port->freqclk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
 	}
 
 	/* not all asc ports have clock gates, lets ignore the return code */
-	ltq_port->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ENABLED(CONFIG_LANTIQ) && !IS_ENABLED(CONFIG_COMMON_CLK))
+		ltq_port->clk = clk_get(&pdev->dev, NULL);
+	else
+		ltq_port->clk = devm_clk_get(&pdev->dev, "asc");
 
 	ltq_port->tx_irq = irqres[0].start;
 	ltq_port->rx_irq = irqres[1].start;
-- 
2.11.0
