From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/76] serial: ifx6x60: dma_alloc_coherent must use parent dev
Date: Wed, 16 Mar 2011 14:11:51 -0700
Message-ID: <1300309966-5745-21-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32781 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab1CPVNd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:33 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

This driver is a SPI protocol driver and has no DMA ops
associated with the device so the call will fail. Furthermore,
the DMA allocation made here will be used by the SPI
controller driver (parent dev) so it makes sense to
pass that device instead.

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 972c04d..bb2ff20 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -998,7 +998,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ifx_dev->spi_slave_cts = 0;
 
 	/*initialize transfer and dma buffers */
-	ifx_dev->tx_buffer = dma_alloc_coherent(&ifx_dev->spi_dev->dev,
+	ifx_dev->tx_buffer = dma_alloc_coherent(ifx_dev->spi_dev->dev.parent,
 				IFX_SPI_TRANSFER_SIZE,
 				&ifx_dev->tx_bus,
 				GFP_KERNEL);
@@ -1007,7 +1007,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ifx_dev->rx_buffer = dma_alloc_coherent(&ifx_dev->spi_dev->dev,
+	ifx_dev->rx_buffer = dma_alloc_coherent(ifx_dev->spi_dev->dev.parent,
 				IFX_SPI_TRANSFER_SIZE,
 				&ifx_dev->rx_bus,
 				GFP_KERNEL);
-- 
1.7.4.1

