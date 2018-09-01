From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH] spi: at91-usart: at91_usart_spi_transfer_one() can be
 static
Date: Sun, 2 Sep 2018 05:23:50 +0800
Message-ID: <20180901212350.GA89606@lkp-ib04>
References: <20180831134141.9335-6-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831134141.9335-6-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, richard.genoud@gmail.com, pirea.radu@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, jslaby@suse.com, broonie@kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org


Fixes: 5890bab41187 ("spi: at91-usart: add driver for at91-usart as spi")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 spi-at91-usart.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 4712bd4..a924657 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -215,9 +215,9 @@ static int at91_usart_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
-				struct spi_device *spi,
-				struct spi_transfer *xfer)
+static int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
+				       struct spi_device *spi,
+				       struct spi_transfer *xfer)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 
@@ -242,8 +242,8 @@ int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
 	return 0;
 }
 
-int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
-				   struct spi_message *message)
+static int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
+					  struct spi_message *message)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
@@ -256,8 +256,8 @@ int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
 	return 0;
 }
 
-int at91_usart_spi_unprepare_message(struct spi_controller *ctlr,
-				     struct spi_message *message)
+static int at91_usart_spi_unprepare_message(struct spi_controller *ctlr,
+					    struct spi_message *message)
 {
 	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
 
