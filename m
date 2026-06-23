Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB4384CCB
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224993; cv=none; b=ebuT0W9gh1YKFu7Fhgop9RgoFMjNhkLEk8k/1R+fPS4qMm6DJ0UZFaamJznqYoqC1Mu7ZA5Rkqww2UdjN+gOAk7Si6YgGSGIqPsrjOozKMxh3wDZpQaop0ms8CNaeJQy3AicaovSJTRSvk6ZQDbqGo/22JJDOXwnNrnYhPatA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224993; c=relaxed/simple;
	bh=aqakucGcdLKlbf+n2yhLxqvUx93HQncF2RBNntGZKfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTeXOZqejlCWBHa8KC71m9PxKXKWk/Fe/UK41f3aov6pGJ08f2DZPBR0uGZ6ysi7WmJ1Q7lHR7hDk6Tw1svEvig+pYbDcL66m/+fCor+HV5RGpdQIpShTJuY7CNir7le7OPFpnysoQbQPjxAzuv7C/mii9npmeuGM2YJyMZBcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=D0UjNvGN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="D0UjNvGN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso35462095e9.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224990; x=1782829790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ys1+I3mTN4tFLUeTqimgmOWnqyRP0wdFQKXJW//HVk=;
        b=D0UjNvGN8JBk5k2FxQWo7CuynsPJ8xLSPZtqZKVM4GR6wlcJ3UX+tbF0m3CbpKJr++
         yRPGxNglZRJfEwciVNSrKdlnT2NnZOGwlagtzuNVZ0g7s9+w3wzH/Frg+BPnQ9j+R0Jm
         CBow6CylTZN6NHSL3G75WJ9tjTx9z7rvYBqMZjhu8Yb0JOWgvVnl4sMMaq7xuEF/z15G
         At3Agz/JIUz7/ctDHbe8S8G+geyOlN46nmpd9tnIFy32NOdn+W9ber96yRwzRXDg4xMM
         7W/gTd3l9Dm4skUlBkjRhrjc7BXtee3iP1/JUJNg/L5QxIQ8b/tagkcm30yHi6LpxNCg
         bGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224990; x=1782829790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Ys1+I3mTN4tFLUeTqimgmOWnqyRP0wdFQKXJW//HVk=;
        b=UG1uN/CKecmif/T5BxfjvtDWXeFQ1IDkr//cMvg/MMAus5b33U+F0ML515TuLYHNEe
         fCgrJuKlIHgI9my96WgJji2f7zR0rzEON1MNDCRJI2WxLvt8WWX2NZgwNXp2UojijzPC
         BBOCQ7bNyYty9BPRtJr3faNoOS/+LCdFmjFT/NhXu3FAlVcZe/EnnVEtnGcu/4qZCo8H
         WZlqMidcQrMM9o5nwhZXfOFvHRvUjA4VECI+H2Z356VsnqY3ZCYnhCAsPftldF+UwKay
         VCbU0DdxSlUwr9JugptDSjfcvwVtUGdCLbfdUnEiHNOKdA9PkDDsgclY0iqIBw3OUfoS
         cTGg==
X-Forwarded-Encrypted: i=1; AFNElJ/E7ttGaUJugv5C4lik3HxhJZSOuJhDBNGQ2SlFkUQcEoVX7H0cqu9jBUTE+JX0dsf1RR2QRTJJeMdsft8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ29b8VJM7wrKKMP0Zf9GjiOIYZCl3iNDdNERU9gVrdDJqa99x
	2CVRA+fNfisWT+YviIiZ4ltDNpvZ6ifReYWEbHNj+S7OlCrw+c6pvh/9V2sF0phS3Cw=
X-Gm-Gg: AfdE7cmSnUZQK/G5WUqnaq2KW56+chEJUbkCLwrZxvV2VJ/AQl/2u1GzMNgUdJSEynW
	Jz3zA5RJ3+MQqaOr5rh3IdjWhOkyNdHEDzc50qgXcTi84EqE8kWugIk3YKUWauyi5H6aDWcoiNn
	dA9Zv9Hbeevz08N9oNgoqxXf4aAQndm5FUugfMHf9NxE+N7h7f/VCVrumz+NtgxICWEJ3jBAXQP
	I2YdDBfXqpqFxdFqRz2Tq7WfVgDyvNUPelEyst7JOuJzSWBwyRTWD8sDH1WFPdZMLP6fHaj3X3w
	bgYYvm4tgeK085GfdIl2xbEJmjNsQyrNrUboHW6M5kyQ58uToOSJbVAxcS5tqaMNsNSow3pg6nN
	hDEX+MrNd8dpJcMSrJFg0o2vw4YDneUY3Jfi2a7UdcmWGpVIgFNsKBVFBYLTqA6AE6ngeXsBGKv
	p1fQ2r63NTbNJkiKHM+LBNicQ+2gRTnp1azA3PzQC30GBtT1jIp7bI765Pi1ZT6JtRV89y8GKm0
	bqQ++myk1QygB+wJ5Us2UXz/ayd
X-Received: by 2002:a05:600c:1d1e:b0:492:4ca9:a46d with SMTP id 5b1f17b1804b1-4924ca9a4e8mr215051385e9.5.1782224990389;
        Tue, 23 Jun 2026 07:29:50 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:49 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
Date: Tue, 23 Jun 2026 14:25:42 +0000
Message-ID: <c3e1136d3565216c254db138e29299c2a3c6499f.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch enables the VUART over PCI possible for the AST2600. This is
only activated if the 'aspeed,vuart-over-pci' property flag is set on an
'ast2600-vuart' compatible node.

The AST2600 has 2 VUART that are usable over PCI. These are the VUART3
and VUART4 in the 'apseed-g6.dtsi'.

This code sets the BMC PCI device enables
bits, sets the PCI class code to MFD device and configures MSI interrupts.

There is no disable function. Removing this driver should not disable
the BMC PCI device, as other drivers could use it.
However, if all the drivers using it are removed, the
BMC PCI device will still be activated, which is not ideal. Realistically though, this is not a
use case for a BMC, the drivers will never be removed.

This is useful on PCIe BMC expansion cards that use the AST2600, such as the
ASUS Kommando IPMI Expansion Card.

Registers initialisation taken from ASPEED 6.18 Kernel SDK.
Return code checks were added to each register write.
The code has been simplified and macros have been added.

The ASPEED_SCUC24 regmap update is missing a macro for 'BIT(14)'. I was
unable to  determine the purpose of this bit. In the AST2600 A3
datasheet it is marked as 'reserved'. It is only used on the other
revision. As I only have the AST2600A3, I was unable to try this code
path.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
Tested-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 86 +++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6afa2f4057e1..e204e26fa173 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -32,6 +32,27 @@
 #define ASPEED_VUART_DEFAULT_SIRQ	4
 #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
 
+#define ASPEED_SCU_SILICON_REVISION_ID			0x04
+#define AST2600A3_REVISION_ID				0x05030303
+
+#define ASPEED_SCUC24			0xC24
+#define  ASPEED_SCUC24_MSI_ROUTING_MASK			GENMASK(11, 10)
+#define  ASPEED_SCUC24_MSI_ROUTING_PCIe2LPC_PCIDEV1		(0x2 << 10)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN		BIT(18)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN			BIT(17)
+
+
+#define ASPEED_SCU_PCIE_CONF_CTRL	0xC20
+#define  SCU_PCIE_CONF_BMC_DEV_EN					BIT(8)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MMIO				BIT(9)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MSI				BIT(11)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_IRQ				BIT(13)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER	BIT(14)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_E2L				BIT(15)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE		BIT(21)
+
+#define ASPEED_SCU_BMC_DEV_CLASS	0xC68
+
 struct aspeed_vuart {
 	struct device		*dev;
 	int			line;
@@ -412,6 +433,62 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
 	}
 }
 
+static int aspeed_ast2600_vuart_over_pci_set_enabled(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	u32 silicon_revision_id;
+	struct regmap *scu;
+	int rc;
+
+	u32 pcie_config_ctl = SCU_PCIE_CONF_BMC_DEV_EN_IRQ |
+						SCU_PCIE_CONF_BMC_DEV_EN_MMIO |
+						SCU_PCIE_CONF_BMC_DEV_EN_MSI |
+						SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER |
+						SCU_PCIE_CONF_BMC_DEV_EN_E2L |
+						SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE |
+						SCU_PCIE_CONF_BMC_DEV_EN;
+
+	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "clocks");
+	if (IS_ERR(scu)) {
+		dev_err(&pdev->dev, "failed to find SCU regmap\n");
+		return PTR_ERR(scu);
+	}
+
+	/* update class code to be an MFD device */
+	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
+		dev_err(dev, "could not set PCI class code\n");
+		return -EIO;
+	}
+
+	if (regmap_update_bits(scu, ASPEED_SCU_PCIE_CONF_CTRL,
+			   pcie_config_ctl, pcie_config_ctl)) {
+		dev_err(dev, "could not set PCIe configuration\n");
+		return -EIO;
+	}
+
+	if (regmap_read(scu, ASPEED_SCU_SILICON_REVISION_ID, &silicon_revision_id)) {
+		dev_err(dev, "could not read silicon revision\n");
+		return -EIO;
+	}
+
+	if (silicon_revision_id == AST2600A3_REVISION_ID)
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIe2LPC_PCIDEV1);
+	else
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					/* The bit 14 is reserved in the Datasheet, so we can't say what it does. This revision has not been tested */
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
+				   ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIe2LPC_PCIDEV1);
+	if (rc) {
+		dev_err(dev, "could not set PCI device 1 MSI interrupt routing\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
 	struct of_phandle_args sirq_polarity_sense_args;
@@ -540,6 +617,15 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-vuart") &&
+		of_property_read_bool(dev->of_node, "aspeed,vuart-over-pci")) {
+		rc = aspeed_ast2600_vuart_over_pci_set_enabled(pdev);
+		if (rc) {
+			dev_err(dev, "could not enable VUART over PCI\n");
+			return rc;
+		}
+	}
+
 	return 0;
 
 err_sysfs_remove:
-- 
2.54.0

