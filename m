Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9E46A60A
	for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932443; cv=none; b=ZFzGbO6raWzc9uI40fFJw470p3jvrDogRodWCwlwU66erMryQ6+N6WVRC4X0Vgjb4dVE6ecr9Zjdx0zS1gEvL9D+bLRP/aVmT5uSAvhJveChrMlQF71OXdNOZa+gR7wF/HWcn7bRYBivXgEWg/rqYT3TrRK/rJnR76WUvWqnooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932443; c=relaxed/simple;
	bh=aPgnUiNxZPPEKmHzG+C3UsNCrunOGDP5W9EHW14UGng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpoI8fmt8nUUm6VuL4mL0KPb93VdsewrNuVhWfj7bRwXk8NOiUho03bAWaqkNSOd1aNikL7aS0yKQqZqwVjLo41pLyJ7gyP5DWufLqhOA6aM73pzLQlZDKSGHrOxwaOmjiLZC2dOPTbk/3rmadiK66+X2aNzTRxbqcosXk6wExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=TqkAEPTp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="TqkAEPTp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso4884005e9.3
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932439; x=1786537239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiYoCygDlxrRrot+eB6RDJlTFwCO5JkkHaoDbWt1nfs=;
        b=TqkAEPTpIQEFdlb7kcke7bH3bAms4gtFHEOEj6SiBoDvLWeNN+00pbwOggTkloaA4d
         IloaHkihORTuuU82J2NpkZVrBBlmBSNLSHtiKUfivNTA8H1GgBtFlM3hXaQmiynpJbIo
         8a6J0sNS17tIPVsItUYIqm1a1Ne45uAv6ddqzGA6SIeF7+6ts0Y4wm7SdlW3mIhWLJE8
         z3aYN2m6/A+w3+sdLA7csFfzDmLjjqgdYcC0MAZbdu0JOZBne78JjgW5XKsH/06Mh6pc
         bcKnr/x+jU5eGbcNErb+aCH9jiJBYOaVdtKtxorTX0t6aUV1v7NbLGlR/H2mPpv5DIEy
         UjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932439; x=1786537239;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiYoCygDlxrRrot+eB6RDJlTFwCO5JkkHaoDbWt1nfs=;
        b=DhGC83vTXQFq4ktonG5NotyZl7ohgNm03hVQIG9YgJURlz7yVZ0wsnb60B33PpRevT
         0yjbQUNgMF/twA0hK+Jyvp7HYBNYIBzAcW0d/mUwsySZLoCipx839fnCfsVOIsTvS4k5
         pX/eY0KJkRRD/iqMHhLSftmr9ff+155X4pXhG2WxMn2oZ49W6GGoOFB5hAoKHUgSNmC4
         5sUB4karegDHELGeCCM5r/MpSt0DamCRR8Dm4TTpJtPpp2F3k0uK8cinfrXDJBGzFql0
         pnitQ0JbvaCxrdGnCH+raCm1oDhiNVo03N8F0FJB/3zy2TO/R61RHztS8S7Cs1f7cv7S
         Q30A==
X-Forwarded-Encrypted: i=1; AHgh+RpSSGFbuxRzMK15oH6WaGN+sJ77e20vOWpt5OeofWtdkqzLA5iH3DlDd0xFcLWN9CUYqtBc4GtZIWH1IhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyC2QB1ltS78I/qtRrPe5qeWTfRjPs1/5wOwp1Y++K1aL5xEu
	OWqBYHWYED+/4moJBehiid+v+23TI3jzNsmRUnAPpynAImZ6YvKZOjCCfrnl/h+uWGk=
X-Gm-Gg: AR+sD13bYP2dfXQ0IgDWNx+M7vr4D2HXDvp4dEXw2vgNK3TYwB1xcweqnSgcHWApU3e
	FpMtdhp9v3ORiLR1CimntBIk6CszY1vaIW0i2yEtlp3xcdhgy3fTTm/Lda8u0mk502E2cTshMlS
	um1TjWCj0lFC/4o1ZH9tYoRHObL5arC5+3OLlQpqQ8+9ZMt3fJxNoP9EFl1afMQLNbZ2Y62p5CO
	SsU/KcLmpySnuT1WA4R72Mqe5nFDd0lC4dnVb815GXdC+R773HmSrBGwY/pGPIO7BTYjttnSP00
	Ci6xg+5SAI0E+y27dEkRmE7IvQnOqONQTkTwBIi7x2lS0FghCo3ky+MpOeExgnqW9IsSv5p14aM
	Fz0ez/J1C2d5mrkBtkAGlJQLEDB5Bi8XhVk0ygcaGcVlScPDKExpnqIhx97sH5UaBlwXfkt0+RX
	QV0826cMR3Xps9u/jR66dCKgaLeXbQJZQr0JB1eOjCoA8TBWGCsfjwxlW3htQKzgGtcCQosr/D6
	cF9HiqQ/FCs+/WvFlmCaeNMMeoHa1wb9HE8b6Nswlg9TvOx5/oakZY7VtalLS2ISk9yXiyz4rnT
X-Received: by 2002:a05:600c:3b9b:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4994e7ba85fmr75294935e9.9.1785932438769;
        Wed, 05 Aug 2026 05:20:38 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:38 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 3/6] serial: 8250_aspeed_vuart: add VUART over PCI
Date: Wed,  5 Aug 2026 14:19:50 +0200
Message-ID: <84efc6b23b79e901245e9ed7f58546bef6089530.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
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

The AST2600 has 2 VUART that are usable over PCI. These are already
defined as the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.

Sets the BMC PCI device enable bits, sets the PCI class code to
unassgined/device specific, and configures MSI interrupts.

There is no disable function. Removing this driver should not disable
the BMC PCI device, as other drivers could use it.
However, if all the drivers using it are removed, the
BMC PCI device will still be activated, which is not ideal. But in reality,
this is not a use case for a BMC, the drivers will never be removed.

This is useful on PCIe BMC expansion cards that use the AST2600,
such as the ASUS Kommando IPMI Expansion Card.

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
Change from v4 to v5:
- Change bit 14 to RESERVED macro
- Changed ordering of macros
- use FIELD_PREP macro
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 91 +++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6afa2f4057e1..2360d37139bf 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -32,6 +32,28 @@
 #define ASPEED_VUART_DEFAULT_SIRQ	4
 #define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
 
+#define ASPEED_SCU_SILICON_REVISION_ID			0x04
+#define AST2600A3_REVISION_ID				0x05030303
+
+#define ASPEED_SCU_PCIE_CONF_CTRL 0xC20
+#define  SCU_PCIE_CONF_BMC_DEV_EN					BIT(8)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MMIO				BIT(9)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MSI				BIT(11)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_IRQ				BIT(13)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER	BIT(14)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_E2L				BIT(15)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE		BIT(21)
+
+#define ASPEED_SCUC24 0xC24
+#define  ASPEED_SCUC24_MSI_ROUTING_MASK				GENMASK(11, 10)
+#define  ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1 \
+		FIELD_PREP(ASPEED_SCUC24_MSI_ROUTING_MASK, 2)
+#define  ASPEED_SCUC24_RESERVED_14					BIT(14)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN	BIT(17)
+#define  ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN	BIT(18)
+
+#define ASPEED_SCU_BMC_DEV_CLASS	0xC68
+
 struct aspeed_vuart {
 	struct device		*dev;
 	int			line;
@@ -412,6 +434,66 @@ static int aspeed_vuart_map_irq_polarity(u32 dt)
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
+	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "aspeed,scu-syscon");
+	if (IS_ERR(scu)) {
+		dev_err(dev, "failed to find SCU regmap\n");
+		return PTR_ERR(scu);
+	}
+
+	/* update class code to be an Unassigned/device specific class device */
+	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
+		dev_err(dev, "could not set PCIe class code\n");
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
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN |
+					ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN |
+					ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
+	else
+		rc = regmap_update_bits(scu, ASPEED_SCUC24,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN |
+					ASPEED_SCUC24_RESERVED_14 |
+					ASPEED_SCUC24_MSI_ROUTING_MASK,
+					ASPEED_SCUC24_PCIDEV1_INTX_MSI_SCU560_EN |
+					ASPEED_SCUC24_RESERVED_14 |
+					ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
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
@@ -540,6 +622,15 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
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

