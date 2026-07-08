Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B8409265
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525121; cv=none; b=WaDvV5tbpmkbN2yOISJVh39KbmgYDfzO7h6WvjWJopmDkNEnJ8He+iKCUe+m0k7L5hK+sKW7LFHQ9EpM1WXHfQ0UTgqYNEkVnCF0ueKR25ITSngezxn1EsIgTwbeNhe7bfIX8Z681TCJb9MKsXunOyQpuh9QcZq79G/hBDPaRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525121; c=relaxed/simple;
	bh=emLy3nV6PTOWJ5S8ZLEZtJdphacSFAURIEjAbHUF4OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ8EphgxMRG5KXfBGXRIenNBr9AXHveIKFCZSBBHPX1M9ADIBPhNOdNQlBAEyXm4UPZpko5M00R4QXOQl3iFEDjBIcmxm53Y31K/ooAIoX+7aFLVFGbyaRvTJB23EaM7lMTekVENYJOnOWAFvSwcT06dnLOU5N3A6F34Lwvwq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=CSIx4Rev; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="CSIx4Rev"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso791897f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525118; x=1784129918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uZx0CqGWbyzDUzo0/NyEFqDoVb8LDJ7NHysAd8cbbL8=;
        b=CSIx4Rev4a+a+2Q0Q5c4FsqT05z/aesIljlgXbIazd4L7VT6u62Fzp88V3uilbsVrn
         ceDu5ZReFxBhy7Dl8ia6eQqbDIETAJxX6/JDqICFkEVAWTWOY5X5NM2DykpoqjwxRii0
         tdtKVDK6AJrxuLRGPB1n/XAgkzaGl5OQi87a4krs7tbcWOQoWDAPMAkZhd7X/qdTijZi
         K1x3ww0mahqlikO2CHDwZXQU9sr/vb1cb0It1wxl+hl9ToQXIsWj4rC7YrojjHzW3QNQ
         6ZZ+Lw42f9W4qVsN9/4VTkzSIBh9ofZApP57uEVuuZCWfTAyK0petT49dpd95hh2XE8V
         xFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525118; x=1784129918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZx0CqGWbyzDUzo0/NyEFqDoVb8LDJ7NHysAd8cbbL8=;
        b=YLW1DRyq/QqoXQ06TQbqpxqihcKT92JHPcr5H9qrKQXz0Elqa/1mxBxlBtpBtZeFOp
         kiVRmd2eNCDDxug/gH/+ELB4QoGJgbQQgmg+AmnM9wMUgWDjsDxjMfUoQTFcMqQHmZlE
         yyByTfttQ9npSeAcAfC6gTCdoPlCFe+X6Do9+JXPI+EpVWZLbBh/XJbnU9x20Ji9F1dU
         PecU5fuJhsDsyagdruJ8kXHuKhzcvR6MQnLGn+3Pi+FQa4LMB7KCHqM2C9ew2k1el753
         stvpVE5dQ2B1u8eMVU4BFOgjhaMESGXmCutgIfdJ1xSB/dZ61+F5ta9kUCt8dXLmCOfu
         I17Q==
X-Forwarded-Encrypted: i=1; AHgh+RrATMYmu9f41lyXBWWCecLgqM0riRO4Mj58CNjjtUTOBVd5nIbjX+CMtYKqHjkkWWakilMzNe5VvFa0FQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76ImVZbeZOGBTZYCTNonCLMqVUJKA/Acg0cv7ovQgoZ7sSnH1
	9Y6ThghAdDLGRPZerBGWyTj9sOinhlymsCweJaAFX7ss98v3hSf2a6Z2kH1/Bfgvs8o3tpE3qVM
	6+UzLnj0=
X-Gm-Gg: AfdE7cmdyVLW1HzJ125Db593Hb4XWp4n5DFFOMXk9pF44MN5k99yeZ43LmqMIRAE77r
	PRw6GCmDXhP536ir/0txhn478eoBgJ46UP9vnahakWM0kIAE9VKudUyg1Sh8TYNcx9PnyJgmgpy
	J9rLOdad9ZwuJLXJVstcoqUy2tdiTk+SGjs2+ZCyOWBAjjPhRXV8ZMf0nvmyPcehNgLJ8wdBaaP
	viQd61rJx0ZRxdN3Nwduzti//OaXm7Ld6fA7kebK+fsRX0ZqBVqS97dfrQEJHpJigABAFd7IhCW
	Xhci1cB4sAYOnhfkFgWGynpdikeGkiQzYP0/YiKR0wqMGNpazJNXzG7xYSDPJc6UTms17c5//c+
	QRTplvsjB8Zyy6SySGaJ4G2Q5f96fcpesmNrXTroFMiSifSzy/XcRWvmA5Zn9ggKUThOiChf/vu
	2xPda9Tb68k3RgEgoN+Js4N+gbMQw6NduASHU7M4aX/gSnWX+sl6W9ZQUa6eRsSqvJzNScRknj9
	ErWmDiMA56SjTgYerrkdP+UGzSwCodKrzFcOKM=
X-Received: by 2002:a5d:5846:0:b0:472:edc7:b4c9 with SMTP id ffacd0b85a97d-47df07896demr3174799f8f.38.1783525118187;
        Wed, 08 Jul 2026 08:38:38 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:37 -0700 (PDT)
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
Subject: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
Date: Wed,  8 Jul 2026 15:35:56 +0000
Message-ID: <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the VUART over PCI for the AST2600. Activate it only if the
'aspeed,vuart-over-pci' property flag is set on an
'ast2600-vuart' compatible node.

The AST2600 has 2 VUART that are usable over PCI. These are already defined as
the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.

Sets the BMC PCI device enable bits, sets the PCI class code to
unassgined/device specific, and configures MSI interrupts.

There is no disable function. Removing this driver should not disable
the BMC PCI device, as other drivers could use it.
However, if all the drivers using it are removed, the
BMC PCI device will still be activated, which is not ideal. But in reality,
this is not a use case for a BMC, the drivers will never be removed.

This is useful on PCIe BMC expansion cards that use the AST2600, such as the
ASUS Kommando IPMI Expansion Card.

Register initialisation taken from ASPEED 6.18 Kernel SDK.
Add return code checks to each register write.
Simplify the code and add macros.

The ASPEED_SCUC24 regmap update is missing a macro for 'BIT(14)'. I was
unable to determine the purpose of this bit. In the AST2600 A3
datasheet it is marked as 'reserved'. It is only used on the other
revision. As I only have the AST2600A3, I was unable to try this code
path. This BIT14 was set in the ASPEED SDK so I kept it.
I can remove it and the untested path if necessary.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 86 +++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6afa2f4057e1..4d09c04cb972 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -32,6 +32,26 @@
 #define ASPEED_VUART_DEFAULT_SIRQ	4
 #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
 
+#define ASPEED_SCU_SILICON_REVISION_ID			0x04
+#define AST2600A3_REVISION_ID				0x05030303
+
+#define ASPEED_SCUC24			0xC24
+#define  ASPEED_SCUC24_MSI_ROUTING_MASK			GENMASK(11, 10)
+#define  ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1		(0x2 << 10)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN		BIT(18)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN			BIT(17)
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
@@ -412,6 +432,63 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
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
+				SCU_PCIE_CONF_BMC_DEV_EN_MMIO |
+				SCU_PCIE_CONF_BMC_DEV_EN_MSI |
+				SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER |
+				SCU_PCIE_CONF_BMC_DEV_EN_E2L |
+				SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE |
+				SCU_PCIE_CONF_BMC_DEV_EN;
+
+	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
+	if (IS_ERR(scu)) {
+		dev_err(&pdev->dev, "failed to find SCU regmap\n");
+		return PTR_ERR(scu);
+	}
+
+	/* update class code to be an Unassigned/device specific class device */
+	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
+		dev_err(dev, "could not set PCI class code\n");
+		return -EIO;
+	}
+
+	if (regmap_update_bits(scu, ASPEED_SCU_PCIE_CONF_CTRL,
+			       pcie_config_ctl, pcie_config_ctl)) {
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
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
+	else
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					/**
+					 * The bit 14 is reserved in the Datasheet.
+					 */
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
+	if (rc) {
+		dev_err(dev, "could not set PCI device 1 MSI interrupt routing\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
 	struct of_phandle_args sirq_polarity_sense_args;
@@ -540,6 +617,15 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	aspeed_vuart_set_host_tx_discard(vuart, true);
 	platform_set_drvdata(pdev, vuart);
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-vuart") &&
+	    of_property_read_bool(dev->of_node, "aspeed,vuart-over-pci")) {
+		rc = aspeed_ast2600_vuart_over_pci_set_enabled(pdev);
+		if (rc < 0) {
+			dev_err_probe(dev, rc, "could not enable VUART over PCI\n");
+			goto err_sysfs_remove;
+		}
+	}
+
 	return 0;
 
 err_sysfs_remove:
-- 
2.54.0

