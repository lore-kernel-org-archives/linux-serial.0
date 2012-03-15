From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] spi/pxa: add clk_prepare/clk_unprepare calls to spi-pxa2xx
Date: Thu, 15 Mar 2012 19:21:46 +0100
Message-ID: <1331835706.14662.13.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54813 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760303Ab2COSVu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Mar 2012 14:21:50 -0400
Received: by eekc41 with SMTP id c41so1829287eek.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Mar 2012 11:21:48 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@marvell.com>, GrantLikely <grant.likely@secretlab.ca>

This patch adds clk_prepare/clk_unprepare calls to the spi-pxa2xx
driver by using the helper functions clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi-pxa2xx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc25bee..ff0e168 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1625,7 +1625,7 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Enable SOC clock */
-	clk_enable(ssp->clk);
+	clk_prepare_enable(ssp->clk);
 
 	/* Load default SSP configuration */
 	write_SSCR0(0, drv_data->ioaddr);
@@ -1666,7 +1666,7 @@ out_error_queue_alloc:
 	destroy_queue(drv_data);
 
 out_error_clock_enabled:
-	clk_disable(ssp->clk);
+	clk_disable_unprepare(ssp->clk);
 
 out_error_dma_alloc:
 	if (drv_data->tx_channel != -1)
@@ -1709,7 +1709,7 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 
 	/* Disable the SSP at the peripheral and SOC level */
 	write_SSCR0(0, drv_data->ioaddr);
-	clk_disable(ssp->clk);
+	clk_disable_unprepare(ssp->clk);
 
 	/* Release DMA */
 	if (drv_data->master_info->enable_dma) {
@@ -1753,7 +1753,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	if (status != 0)
 		return status;
 	write_SSCR0(0, drv_data->ioaddr);
-	clk_disable(ssp->clk);
+	clk_disable_unprepare(ssp->clk);
 
 	return 0;
 }
@@ -1772,7 +1772,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 			DRCMR_MAPVLD | drv_data->tx_channel;
 
 	/* Enable the SSP clock */
-	clk_enable(ssp->clk);
+	clk_prepare_enable(ssp->clk);
 
 	/* Start the queue running */
 	status = start_queue(drv_data);
-- 
1.7.9.1


