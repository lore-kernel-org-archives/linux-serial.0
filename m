From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/76] serial: ifx6x60: expanded info available from platform data
Date: Wed, 16 Mar 2011 14:11:33 -0700
Message-ID: <1300309966-5745-3-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32804 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1CPVMv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:12:51 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

Some platform attributes (e.g. max_hz, use_dma) were being intuited
from the modem type. These things should be specified by the platform
data.

Added max_hz, use_dma to ifx_modem_platform_data definition,
replaced is_6160 w/ modem_type, and changed clients accordingly

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c  |   33 +++++++++++++++++----------------
 drivers/tty/serial/ifx6x60.h  |    4 +++-
 include/linux/spi/ifx_modem.h |   19 ++++++++++++-------
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index ab93763..c42de71 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -8,7 +8,7 @@
  *		      Jan Dumon <j.dumon@option.com>
  *
  * Copyright (C) 2009, 2010 Intel Corp
- * Russ Gorby <richardx.r.gorby@intel.com>
+ * Russ Gorby <russ.gorby@intel.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -732,7 +732,7 @@ static void ifx_spi_io(unsigned long data)
 		/*
 		 * setup dma pointers
 		 */
-		if (ifx_dev->is_6160) {
+		if (ifx_dev->use_dma) {
 			ifx_dev->spi_msg.is_dma_mapped = 1;
 			ifx_dev->tx_dma = ifx_dev->tx_bus;
 			ifx_dev->rx_dma = ifx_dev->rx_bus;
@@ -960,7 +960,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 {
 	int ret;
 	int srdy;
-	struct ifx_modem_platform_data *pl_data = NULL;
+	struct ifx_modem_platform_data *pl_data;
 	struct ifx_spi_device *ifx_dev;
 
 	if (saved_ifx_dev) {
@@ -968,6 +968,12 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	pl_data = (struct ifx_modem_platform_data *)spi->dev.platform_data;
+	if (!pl_data) {
+		dev_err(&spi->dev, "missing platform data!");
+		return -ENODEV;
+	}
+
 	/* initialize structure to hold our device variables */
 	ifx_dev = kzalloc(sizeof(struct ifx_spi_device), GFP_KERNEL);
 	if (!ifx_dev) {
@@ -983,7 +989,9 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	init_timer(&ifx_dev->spi_timer);
 	ifx_dev->spi_timer.function = ifx_spi_timeout;
 	ifx_dev->spi_timer.data = (unsigned long)ifx_dev;
-	ifx_dev->is_6160 = pl_data->is_6160;
+	ifx_dev->modem = pl_data->modem_type;
+	ifx_dev->use_dma = pl_data->use_dma;
+	ifx_dev->max_hz = pl_data->max_hz;
 
 	/* ensure SPI protocol flags are initialized to enable transfer */
 	ifx_dev->spi_more = 0;
@@ -1025,18 +1033,11 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		goto error_ret;
 	}
 
-	pl_data = (struct ifx_modem_platform_data *)spi->dev.platform_data;
-	if (pl_data) {
-		ifx_dev->gpio.reset = pl_data->rst_pmu;
-		ifx_dev->gpio.po = pl_data->pwr_on;
-		ifx_dev->gpio.mrdy = pl_data->mrdy;
-		ifx_dev->gpio.srdy = pl_data->srdy;
-		ifx_dev->gpio.reset_out = pl_data->rst_out;
-	} else {
-		dev_err(&spi->dev, "missing platform data!");
-		ret = -ENODEV;
-		goto error_ret;
-	}
+	ifx_dev->gpio.reset = pl_data->rst_pmu;
+	ifx_dev->gpio.po = pl_data->pwr_on;
+	ifx_dev->gpio.mrdy = pl_data->mrdy;
+	ifx_dev->gpio.srdy = pl_data->srdy;
+	ifx_dev->gpio.reset_out = pl_data->rst_out;
 
 	dev_info(&spi->dev, "gpios %d, %d, %d, %d, %d",
 		 ifx_dev->gpio.reset, ifx_dev->gpio.po, ifx_dev->gpio.mrdy,
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index deb7b8d..0ec39b5 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -88,7 +88,9 @@ struct ifx_spi_device {
 	dma_addr_t rx_dma;
 	dma_addr_t tx_dma;
 
-	int is_6160;				/* Modem type */
+	int modem;		/* Modem type */
+	int use_dma;		/* provide dma-able addrs in SPI msg */
+	long max_hz;		/* max SPI frequency */
 
 	spinlock_t write_lock;
 	int write_pending;
diff --git a/include/linux/spi/ifx_modem.h b/include/linux/spi/ifx_modem.h
index a68f3b1..394fec9 100644
--- a/include/linux/spi/ifx_modem.h
+++ b/include/linux/spi/ifx_modem.h
@@ -2,13 +2,18 @@
 #define LINUX_IFX_MODEM_H
 
 struct ifx_modem_platform_data {
-	unsigned short rst_out; /* modem reset out */
-	unsigned short pwr_on;  /* power on */
-	unsigned short rst_pmu; /* reset modem */
-	unsigned short tx_pwr;  /* modem power threshold */
-	unsigned short srdy;    /* SRDY */
-	unsigned short mrdy;    /* MRDY */
-	unsigned short is_6160;	/* Modem type */
+	unsigned short rst_out;		/* modem reset out */
+	unsigned short pwr_on;		/* power on */
+	unsigned short rst_pmu;		/* reset modem */
+	unsigned short tx_pwr;		/* modem power threshold */
+	unsigned short srdy;		/* SRDY */
+	unsigned short mrdy;		/* MRDY */
+	unsigned char modem_type;	/* Modem type */
+	unsigned long max_hz;		/* max SPI frequency */
+	unsigned short use_dma:1;	/* spi protocol driver supplies
+					   dma-able addrs */
 };
+#define IFX_MODEM_6160	1
+#define IFX_MODEM_6260	2
 
 #endif
-- 
1.7.4.1

