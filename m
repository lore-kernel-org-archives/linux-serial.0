Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F042D838E;
	Tue, 29 Sep 2026 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663716; cv=none; b=bEu6omYrdI7G5GyZZ4lETGg5mkl7HKoP/V/vaPcGxEOfK/lSjkVXs1LpjAeXH3C3hOP/pbBiyHQdUel9kt+XHdxMbYG62mfaSeibuwIrXk3GZnX5wndNIvZT3TtH0rvYVFYySNhGcRATlLJcLD25gg1oX/fG79zzwJtif93Qytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663716; c=relaxed/simple;
	bh=qEUL9g8TDlbnQvwQeKu6IuwrsoDmWVLIm5J+y4Sv8rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln5gFIZWl9UgcH+a5AdLCAi67d0OwLVlHM4R7g7Dwf7ysJhJSz29DlgUQ4sLLBBo0W6/QOWRmetqU3hGTLNWb+JfgMn2ne/zVO5wosfijCT643VGqGHcE3lrmy/t+UuyMqyLxpu/IPjeMmhrZ0tymzcCAkVsrqT7a/TqC3yG6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwbwDI9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwbwDI9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE051F00899;
	Tue, 29 Sep 2026 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663715;
	bh=vXCQwL0+uS3vheWYh5aAD8zm3f8FsSyTHPKC+Fp+a+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JwbwDI9V6kXjo43+rCGRE4SBLNDEwrPEShYIr87zkOUrmZvOMFIPl88/VMQmmXMFQ
	 3f2bVLwupdAmA18UjdXbxBbAPpVuN8hPmXp4vDJAW0P1JMdM2Ed2h1DWjPkq0WF7ys
	 ORsYUxvQ9rmaj0GvjagTspqaqIGxkFf6erFYPVKAblnpEN8ymgoby2d7LODO0gvFZ7
	 6fWtrRVhmXYgkrw8ArWgXiLsf3LRO+z/L5o3AxlCKnGDg+Oe4ppiMnFBVijIvpGpRC
	 uEdy7SFATpPcGWDK2wgJhJ+Huldmd4+8DiwTw5NbpKYLDMt2J69jHkjBcF8cUXxGWo
	 7OgNAJwu5vB0g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/20] reset: add Synaptics SL261x reset support
Date: Tue, 29 Sep 2026 14:14:06 +0800
Message-ID: <20260929061417.20733-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reset controller in Synaptics SL261X SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/reset/Kconfig        |   6 +
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-sl261x.c | 224 +++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/reset/reset-sl261x.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3168ab1eea88..0e8424ede7fa 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -348,6 +348,12 @@ config RESET_SUNXI
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
+config RESET_SL261X
+	tristate "Synaptics SL261X Reset Driver"
+	depends on ARCH_BERLIN || COMPILE_TEST
+	help
+	  This enables the reset controller driver for Synaptics SL261X SoCs.
+
 config RESET_TENSTORRENT_ATLANTIS
 	tristate "Tenstorrent atlantis reset driver"
 	depends on ARCH_TENSTORRENT || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 45ad17062462..f3a46f2176db 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_RESET_SKY1_AUDSS) += reset-sky1-audss.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_RESET_SL261X) += reset-sl261x.o
 obj-$(CONFIG_RESET_TENSTORRENT_ATLANTIS) += reset-tenstorrent-atlantis.o
 obj-$(CONFIG_RESET_TH1520) += reset-th1520.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/reset-sl261x.c b/drivers/reset/reset-sl261x.c
new file mode 100644
index 000000000000..aed22f7d56db
--- /dev/null
+++ b/drivers/reset/reset-sl261x.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * Synaptics SL261X reset driver
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <dt-bindings/reset/syna,sl261x-reset.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/* SL261X ACPU subsystem */
+#define SL261X_GBL_PERIFRESET			0x350
+#define SL261X_GBL_PERIFSTICKYRESET		0x360
+#define SL261X_GBL_APBPERIFRESET		0x370
+#define SL261X_GBL_TOPSTICKYRESET		0x378
+#define SL261X_GBL_AVIOSTICKYRESET		0x37c
+
+/* SL261X system subsystem */
+#define SL261X_SMGBL_STICKYRST0			0x400
+
+#define to_sl261x_reset_priv(p)	container_of((p), struct sl261x_reset_priv, rcdev)
+
+#define SL261X_RESET(id, reg, bit, sticky)[id] = { reg, BIT(bit), sticky }
+
+struct sl261x_reset_cfg {
+	u32 reg;
+	u32 bit;
+	bool sticky;
+};
+
+struct sl261x_reset_data {
+	const struct sl261x_reset_cfg *cfgs;
+	size_t num;
+};
+
+struct sl261x_reset_priv {
+	struct regmap *regmap;
+	const struct sl261x_reset_cfg *cfgs;
+	struct reset_controller_dev rcdev;
+};
+
+static const struct sl261x_reset_cfg sl261x_reset_cfgs[] = {
+	SL261X_RESET(RST_SOC_SDIO0, SL261X_GBL_PERIFRESET, 2, false),
+	SL261X_RESET(RST_SOC_USB0, SL261X_GBL_PERIFRESET, 4, false),
+	SL261X_RESET(RST_SOC_EMMC, SL261X_GBL_PERIFRESET, 5, false),
+	SL261X_RESET(RST_SOC_GETH0, SL261X_GBL_PERIFRESET, 6, false),
+	SL261X_RESET(RST_SOC_SDIO1, SL261X_GBL_PERIFRESET, 7, false),
+	SL261X_RESET(RST_SOC_USB1, SL261X_GBL_PERIFRESET, 8, false),
+	SL261X_RESET(RST_SOC_GETH1, SL261X_GBL_PERIFRESET, 9, false),
+	SL261X_RESET(RST_SOC_USB0PHY, SL261X_GBL_PERIFSTICKYRESET, 0, true),
+	SL261X_RESET(RST_SOC_USB0CORE, SL261X_GBL_PERIFSTICKYRESET, 1, true),
+	SL261X_RESET(RST_SOC_USB0MAHB, SL261X_GBL_PERIFSTICKYRESET, 2, true),
+	SL261X_RESET(RST_SOC_USB1PHY, SL261X_GBL_PERIFSTICKYRESET, 3, true),
+	SL261X_RESET(RST_SOC_USB1CORE, SL261X_GBL_PERIFSTICKYRESET, 4, true),
+	SL261X_RESET(RST_SOC_USB1MAHB, SL261X_GBL_PERIFSTICKYRESET, 5, true),
+	SL261X_RESET(RST_SOC_UART0, SL261X_GBL_APBPERIFRESET, 0, false),
+	SL261X_RESET(RST_SOC_UART1, SL261X_GBL_APBPERIFRESET, 1, false),
+	SL261X_RESET(RST_SOC_UART2, SL261X_GBL_APBPERIFRESET, 2, false),
+	SL261X_RESET(RST_SOC_UART3, SL261X_GBL_APBPERIFRESET, 3, false),
+	SL261X_RESET(RST_SOC_I2C0, SL261X_GBL_APBPERIFRESET, 4, false),
+	SL261X_RESET(RST_SOC_I2C1, SL261X_GBL_APBPERIFRESET, 5, false),
+	SL261X_RESET(RST_SOC_SPI0, SL261X_GBL_APBPERIFRESET, 6, false),
+	SL261X_RESET(RST_SOC_SPI1, SL261X_GBL_APBPERIFRESET, 7, false),
+	SL261X_RESET(RST_SOC_SPI2, SL261X_GBL_APBPERIFRESET, 8, false),
+	SL261X_RESET(RST_SOC_SPI3, SL261X_GBL_APBPERIFRESET, 9, false),
+	SL261X_RESET(RST_SOC_APBTIMERS, SL261X_GBL_APBPERIFRESET, 10, false),
+	SL261X_RESET(RST_SOC_APBSYSCNT, SL261X_GBL_APBPERIFRESET, 11, false),
+	SL261X_RESET(RST_SOC_APBWDT, SL261X_GBL_APBPERIFRESET, 12, false),
+	SL261X_RESET(RST_SOC_APBGPIO, SL261X_GBL_APBPERIFRESET, 13, false),
+	SL261X_RESET(RST_SOC_APBDMA, SL261X_GBL_APBPERIFRESET, 14, false),
+	SL261X_RESET(RST_SOC_GPUCORE, SL261X_GBL_TOPSTICKYRESET, 0, true),
+	SL261X_RESET(RST_SOC_NPUCORE, SL261X_GBL_TOPSTICKYRESET, 1, true),
+	SL261X_RESET(RST_SOC_AVIOAIOG, SL261X_GBL_AVIOSTICKYRESET, 0, true),
+	SL261X_RESET(RST_SOC_AVIOVPPG, SL261X_GBL_AVIOSTICKYRESET, 1, true),
+	SL261X_RESET(RST_SOC_AVIOVIPG, SL261X_GBL_AVIOSTICKYRESET, 2, true),
+};
+
+static const struct sl261x_reset_cfg sl261x_system_reset_cfgs[] = {
+	SL261X_RESET(RST_SM_ADCCORE, SL261X_SMGBL_STICKYRST0, 0, true),
+	SL261X_RESET(RST_SM_ADCPRST, SL261X_SMGBL_STICKYRST0, 1, true),
+	SL261X_RESET(RST_SM_CAN0PRST, SL261X_SMGBL_STICKYRST0, 2, true),
+	SL261X_RESET(RST_SM_CAN0SRST, SL261X_SMGBL_STICKYRST0, 3, true),
+	SL261X_RESET(RST_SM_CAN1PRST, SL261X_SMGBL_STICKYRST0, 4, true),
+	SL261X_RESET(RST_SM_CAN1SRST, SL261X_SMGBL_STICKYRST0, 5, true),
+	SL261X_RESET(RST_SM_GPIOPRST, SL261X_SMGBL_STICKYRST0, 6, true),
+	SL261X_RESET(RST_SM_GPIOSRST, SL261X_SMGBL_STICKYRST0, 7, true),
+	SL261X_RESET(RST_SM_I2CM0PRST, SL261X_SMGBL_STICKYRST0, 8, true),
+	SL261X_RESET(RST_SM_I2CM0SRST, SL261X_SMGBL_STICKYRST0, 9, true),
+	SL261X_RESET(RST_SM_I2CM1PRST, SL261X_SMGBL_STICKYRST0, 10, true),
+	SL261X_RESET(RST_SM_I2CM1SRST, SL261X_SMGBL_STICKYRST0, 11, true),
+	SL261X_RESET(RST_SM_I3CPRST, SL261X_SMGBL_STICKYRST0, 12, true),
+	SL261X_RESET(RST_SM_I3CSRST, SL261X_SMGBL_STICKYRST0, 13, true),
+	SL261X_RESET(RST_SM_PDMPRST, SL261X_SMGBL_STICKYRST0, 14, true),
+	SL261X_RESET(RST_SM_PDMSRST, SL261X_SMGBL_STICKYRST0, 15, true),
+	SL261X_RESET(RST_SM_PVTHSRST, SL261X_SMGBL_STICKYRST0, 16, true),
+	SL261X_RESET(RST_SM_PVTPRST, SL261X_SMGBL_STICKYRST0, 17, true),
+	SL261X_RESET(RST_SM_PWMPERIRST, SL261X_SMGBL_STICKYRST0, 18, true),
+	SL261X_RESET(RST_SM_PWMPRST, SL261X_SMGBL_STICKYRST0, 19, true),
+	SL261X_RESET(RST_SM_SPIMPRST, SL261X_SMGBL_STICKYRST0, 20, true),
+	SL261X_RESET(RST_SM_SPIMSRST, SL261X_SMGBL_STICKYRST0, 21, true),
+	SL261X_RESET(RST_SM_SPISPRST, SL261X_SMGBL_STICKYRST0, 22, true),
+	SL261X_RESET(RST_SM_SPISSRST, SL261X_SMGBL_STICKYRST0, 23, true),
+	SL261X_RESET(RST_SM_UART0PRST, SL261X_SMGBL_STICKYRST0, 24, true),
+	SL261X_RESET(RST_SM_UART0SRST, SL261X_SMGBL_STICKYRST0, 25, true),
+	SL261X_RESET(RST_SM_UART1PRST, SL261X_SMGBL_STICKYRST0, 26, true),
+	SL261X_RESET(RST_SM_UART1SRST, SL261X_SMGBL_STICKYRST0, 27, true),
+	SL261X_RESET(RST_SM_UART2PRST, SL261X_SMGBL_STICKYRST0, 28, true),
+	SL261X_RESET(RST_SM_UART2SRST, SL261X_SMGBL_STICKYRST0, 29, true),
+	SL261X_RESET(RST_SM_UART3PRST, SL261X_SMGBL_STICKYRST0, 30, true),
+	SL261X_RESET(RST_SM_UART3SRST, SL261X_SMGBL_STICKYRST0, 31, true),
+};
+
+static const struct sl261x_reset_data sl261x_reset_data = {
+	.cfgs = sl261x_reset_cfgs,
+	.num = ARRAY_SIZE(sl261x_reset_cfgs),
+};
+
+static const struct sl261x_reset_data sl261x_system_reset_data = {
+	.cfgs = sl261x_system_reset_cfgs,
+	.num = ARRAY_SIZE(sl261x_system_reset_cfgs),
+};
+
+static int sl261x_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct sl261x_reset_priv *priv = to_sl261x_reset_priv(rcdev);
+	const struct sl261x_reset_cfg *cfg = &priv->cfgs[id];
+
+	if (!cfg->sticky)
+		return -EINVAL;
+
+	return regmap_clear_bits(priv->regmap, cfg->reg, cfg->bit);
+}
+
+static int sl261x_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct sl261x_reset_priv *priv = to_sl261x_reset_priv(rcdev);
+	const struct sl261x_reset_cfg *cfg = &priv->cfgs[id];
+
+	if (!cfg->sticky)
+		return -EINVAL;
+
+	return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);
+}
+
+static int sl261x_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct sl261x_reset_priv *priv = to_sl261x_reset_priv(rcdev);
+	const struct sl261x_reset_cfg *cfg = &priv->cfgs[id];
+
+	if (cfg->sticky) {
+		regmap_clear_bits(priv->regmap, cfg->reg, cfg->bit);
+		usleep_range(10, 15);
+		return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);
+	}
+
+	return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);
+}
+
+static const struct reset_control_ops sl261x_reset_ops = {
+	.reset	= sl261x_reset_reset,
+	.assert = sl261x_reset_assert,
+	.deassert = sl261x_reset_deassert,
+};
+
+static int sl261x2_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *parent_np;
+	struct sl261x_reset_priv *priv;
+	const struct sl261x_reset_data *data = device_get_match_data(&pdev->dev);
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	parent_np = of_get_parent(pdev->dev.of_node);
+	priv->regmap = syscon_node_to_regmap(parent_np);
+	of_node_put(parent_np);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.ops = &sl261x_reset_ops;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.nr_resets = data->num;
+	priv->cfgs = data->cfgs;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
+static const struct of_device_id sl261x_reset_dt_match[] = {
+	{ .compatible = "syna,sl261x-reset", .data = &sl261x_reset_data },
+	{ .compatible = "syna,sl261x-system-reset", .data = &sl261x_system_reset_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sl261x_reset_dt_match);
+
+static struct platform_driver sl261x_reset_driver = {
+	.probe	= sl261x2_reset_probe,
+	.driver	= {
+		.name = "sl261x2-reset",
+		.of_match_table = sl261x_reset_dt_match,
+	},
+};
+module_platform_driver(sl261x_reset_driver);
+
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("Synaptics SL261X reset controller");
+MODULE_LICENSE("GPL");
-- 
2.53.0

