From: channing <chao.bi@intel.com>
Subject: [PATCH] serial:ifx6x60:Keep word size accordance with SPI
 controller
Date: Wed, 16 Jan 2013 13:14:20 +0800
Message-ID: <1358313260.3729.5.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9500 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758392Ab3APE5H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jan 2013 23:57:07 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: greg@kroah.com, richardx.r.gorby@intel.com, jun.d.chen@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org


As protocol driver, IFX SPI driver initiate to setup SPI master with default
SPI word size as 16 bit/word, however, SPI master may not adopt this default
value due to SPI controller's capability, it might choose an available value by
itself and set it to spi_device.bits_per_word. In order to keep align with
Controller, IFX driver should make use of this value during SPI transfer,
but the default one.

Signed-off-by: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 675d94a..3e337b8 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -810,7 +810,8 @@ static void ifx_spi_io(unsigned long data)
 		ifx_dev->spi_xfer.cs_change = 0;
 		ifx_dev->spi_xfer.speed_hz = ifx_dev->spi_dev->max_speed_hz;
 		/* ifx_dev->spi_xfer.speed_hz = 390625; */
-		ifx_dev->spi_xfer.bits_per_word = spi_bpw;
+		ifx_dev->spi_xfer.bits_per_word =
+			ifx_dev->spi_dev->bits_per_word;
 
 		ifx_dev->spi_xfer.tx_buf = ifx_dev->tx_buffer;
 		ifx_dev->spi_xfer.rx_buf = ifx_dev->rx_buffer;
-- 
1.7.1



