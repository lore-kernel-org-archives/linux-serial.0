From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 23/76] serial: ifx6x60: set SPI max_speed_hz based on platform type
Date: Wed, 16 Mar 2011 14:11:53 -0700
Message-ID: <1300309966-5745-23-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33074 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab1CPVNh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:37 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

Platforms containing the 6260 can run up to 25Mhz.

For these platforms set max_speed_hz to 25Mhz.

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 9161cab..766f0c3 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -722,7 +722,7 @@ static void ifx_spi_io(unsigned long data)
 		/* note len is BYTES, not transfers */
 		ifx_dev->spi_xfer.len = IFX_SPI_TRANSFER_SIZE;
 		ifx_dev->spi_xfer.cs_change = 0;
-		ifx_dev->spi_xfer.speed_hz = 12500000;
+		ifx_dev->spi_xfer.speed_hz = ifx_dev->spi_dev->max_speed_hz;
 		/* ifx_dev->spi_xfer.speed_hz = 390625; */
 		ifx_dev->spi_xfer.bits_per_word = spi_bpw;
 
@@ -992,6 +992,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ifx_dev->modem = pl_data->modem_type;
 	ifx_dev->use_dma = pl_data->use_dma;
 	ifx_dev->max_hz = pl_data->max_hz;
+	spi->max_speed_hz = ifx_dev->max_hz;
 
 	/* ensure SPI protocol flags are initialized to enable transfer */
 	ifx_dev->spi_more = 0;
-- 
1.7.4.1

