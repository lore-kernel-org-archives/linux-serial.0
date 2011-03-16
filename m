From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 24/76] serial: ifx6x60: probe routine needs to call spi_setup
Date: Wed, 16 Mar 2011 14:11:54 -0700
Message-ID: <1300309966-5745-24-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33107 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab1CPVNn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:43 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

The probe routine should call spi_setup() to configure
the SPI bus so it can properly communicate with the device.
E.g. the device operates in SPI mode 1.

Called spi_setup to configure SPI mode, max_speed_hz, and bpw

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 766f0c3..59e9cb8 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -67,6 +67,7 @@
 #define IFX_SPI_MORE_MASK		0x10
 #define IFX_SPI_MORE_BIT		12	/* bit position in u16 */
 #define IFX_SPI_CTS_BIT			13	/* bit position in u16 */
+#define IFX_SPI_MODE			SPI_MODE_1
 #define IFX_SPI_TTY_ID			0
 #define IFX_SPI_TIMEOUT_SEC		2
 #define IFX_SPI_HEADER_0		(-1)
@@ -992,7 +993,15 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	ifx_dev->modem = pl_data->modem_type;
 	ifx_dev->use_dma = pl_data->use_dma;
 	ifx_dev->max_hz = pl_data->max_hz;
+	/* initialize spi mode, etc */
 	spi->max_speed_hz = ifx_dev->max_hz;
+	spi->mode = IFX_SPI_MODE | (SPI_LOOP & spi->mode);
+	spi->bits_per_word = spi_bpw;
+	ret = spi_setup(spi);
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup wasn't successful %d", ret);
+		return -ENODEV;
+	}
 
 	/* ensure SPI protocol flags are initialized to enable transfer */
 	ifx_dev->spi_more = 0;
-- 
1.7.4.1

