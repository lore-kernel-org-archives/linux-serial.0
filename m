From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 2/6] mfd: at91-usart: added mfd driver for usart
Date: Fri, 4 May 2018 18:47:10 +0300
Message-ID: <20180504154714.5109-3-radu.pirea@microchip.com>
References: <20180504154714.5109-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504154714.5109-1-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: lee.jones@linaro.org, broonie@kernel.org, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, jslaby@suse.com, gregkh@linuxfoundation.org, richard.genoud@gmail.com, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

This mfd driver is just a wrapper over atmel_serial driver and
spi-at91-usart driver. Selection of one of the drivers is based on a
property from device tree. If the property is not specified, the default
driver is atmel_serial.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 drivers/mfd/Kconfig                  | 10 ++++
 drivers/mfd/Makefile                 |  1 +
 drivers/mfd/at91-usart.c             | 81 ++++++++++++++++++++++++++++
 include/dt-bindings/mfd/at91-usart.h | 17 ++++++
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..de99b79061b7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -99,6 +99,16 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_AT91_USART
+	tristate "AT91 USART Driver"
+	select MFD_CORE
+	depends on OF
+	help
+	  Select this to get support for AT91 USART IP. This is a wrapper
+	  over at91-usart-serial driver and usart-spi-driver. Only one function
+	  can be used at a time. The choice is done at boot time by the probe
+	  function of this MFD driver according to a device tree property.
+
 config MFD_ATMEL_FLEXCOM
 	tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9d2cf0d32ef..db1332aa96db 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
+obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
new file mode 100644
index 000000000000..cd8f020ca7c0
--- /dev/null
+++ b/drivers/mfd/at91-usart.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for AT91 USART
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#include <dt-bindings/mfd/at91-usart.h>
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+static struct mfd_cell at91_usart_spi_subdev = {
+		.name = "at91_usart_spi",
+		.of_compatible = "microchip,at91sam9g45-usart-spi",
+	};
+
+static struct mfd_cell at91_usart_serial_subdev = {
+		.name = "atmel_usart_serial",
+		.of_compatible = "atmel,at91rm9200-usart-serial",
+	};
+
+static int at91_usart_mode_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct mfd_cell cell;
+	u32 opmode;
+	int err;
+
+	err = of_property_read_u32(np, "at91,usart-mode", &opmode);
+
+	switch (opmode) {
+	case AT91_USART_MODE_SPI:
+		cell = at91_usart_spi_subdev;
+		break;
+	case AT91_USART_MODE_SERIAL:
+	default:
+		cell = at91_usart_serial_subdev;
+	}
+
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
+			      NULL, 0, NULL);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add subdevices\n");
+		return err;
+	}
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id at91_usart_mode_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-usart" },
+	{ .compatible = "atmel,at91sam9260-usart" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, at91_flexcom_of_match);
+
+static struct platform_driver at91_usart_mfd = {
+	.probe	= at91_usart_mode_probe,
+	.driver	= {
+		.name		= "at91_usart_mode",
+		.of_match_table	= at91_usart_mode_of_match,
+	},
+};
+
+module_platform_driver(at91_usart_mfd);
+
+MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
+MODULE_DESCRIPTION("AT91 USART MFD driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
new file mode 100644
index 000000000000..ac811628a42d
--- /dev/null
+++ b/include/dt-bindings/mfd/at91-usart.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for AT91 USART DT bindings.
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_AT91_USART_H__
+#define __DT_BINDINGS_AT91_USART_H__
+
+#define AT91_USART_MODE_SERIAL	1
+#define AT91_USART_MODE_SPI	2
+
+#endif /* __DT_BINDINGS_AT91_USART_H__ */
-- 
2.17.0
