Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EDC4363D
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFBF208E4
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 22:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgJFWYt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:24:49 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:62596 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgJFWYt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 18:24:49 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 7ff68936-0820-11eb-ba23-005056bd6ce9;
        Wed, 07 Oct 2020 01:08:44 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/2] serial: max310x: Make use of device properties
Date:   Wed,  7 Oct 2020 01:08:42 +0300
Message-Id: <20201006220843.582459-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/max310x.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 21130af106bb..f25b9516109c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -15,8 +15,8 @@
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
@@ -267,7 +267,7 @@ struct max310x_one {
 	container_of(_port, struct max310x_one, port)
 
 struct max310x_port {
-	struct max310x_devtype	*devtype;
+	const struct max310x_devtype *devtype;
 	struct regmap		*regmap;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
@@ -1269,7 +1269,7 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 }
 #endif
 
-static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
+static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
 	int i, ret, fmin, fmax, freq, uartclk;
@@ -1478,7 +1478,7 @@ static struct regmap_config regcfg = {
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_probe(struct spi_device *spi)
 {
-	struct max310x_devtype *devtype;
+	const struct max310x_devtype *devtype;
 	struct regmap *regmap;
 	int ret;
 
@@ -1490,18 +1490,9 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (spi->dev.of_node) {
-		const struct of_device_id *of_id =
-			of_match_device(max310x_dt_ids, &spi->dev);
-		if (!of_id)
-			return -ENODEV;
-
-		devtype = (struct max310x_devtype *)of_id->data;
-	} else {
-		const struct spi_device_id *id_entry = spi_get_device_id(spi);
-
-		devtype = (struct max310x_devtype *)id_entry->driver_data;
-	}
+	devtype = device_get_match_data(&spi->dev);
+	if (!devtype)
+		devtype = (struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
 
 	regcfg.max_register = devtype->nr * 0x20 - 1;
 	regmap = devm_regmap_init_spi(spi, &regcfg);
@@ -1526,7 +1517,7 @@ MODULE_DEVICE_TABLE(spi, max310x_id_table);
 static struct spi_driver max310x_spi_driver = {
 	.driver = {
 		.name		= MAX310X_NAME,
-		.of_match_table	= of_match_ptr(max310x_dt_ids),
+		.of_match_table	= max310x_dt_ids,
 		.pm		= &max310x_pm_ops,
 	},
 	.probe		= max310x_spi_probe,
-- 
2.28.0

