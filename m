Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5B45348D
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049111; cv=none; b=UpwQT08S6pjx5WFl16AiFgq6yu00GeJepmdmpk/gSrhmF18lDJclBPqfMW8r7ctlV/9zG10T/ADPYte6XK8WEA7qReI56nxCjtWHngAgDJ20iKTgc2678tEMzt4vOtvfm+lKThgOwspTmo6Ub8ioU0VpluOi6kEFVeLG8H5BUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049111; c=relaxed/simple;
	bh=/ZnDVyFXyOMlnp+4kOKxjkZE8/hrh/AgeryTNVSXcuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9pIaCi7qiE6Z8jtYKTPWdZfvhZYp9rSTJ8UwQtQYdN6uQ7/y31tIJVlvCNp0wndxo8eS+9RgAW8XfazNVxBO3JVrevTjPd4NO3Mf56mVP+/uIf8/+5BlnI5MsX6kKhPnjQz0pj6/V9koE9ZJg9cB30pJh3fPazNQ+N0i2Thl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=RvoR4Z9U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="RvoR4Z9U"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956869750eso29951415e9.2
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049107; x=1787653907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjRJ6CK8+10XxSw1IIq1k9Y5+IsaxjCnKt7BPw+fxxg=;
        b=RvoR4Z9UvM+sMGDd3enlJN2ZTXOo5Y9aGUHxPelaphJ8xyF54+XpWlyabPRfY4v+Ho
         7iuQgja95neLs55EzFdPOCWDEt+WZMc/MY8OklkbirzxMSL5ejmS2Bs8sC80O82hmh1s
         +2DOpNIYi6B/0mAOpPOMmjvNbxcRYHEV7rCuN6Jw+3VCmYndW1lbia8JZ3a1c3mUSbiL
         bTWuK0kM6xoxMH8Z3ecB7P3DzvoHCGgWdBGmgtuiuKvo3DUcTLqbouzBHULgfwxMY/Ep
         SzAcmgTbXj5OHAFwbYqkyecaUIVNiTLI9S6cizdUyxQIy9inKNiLSUc5x/SC9Tew/Fzu
         X2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049107; x=1787653907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjRJ6CK8+10XxSw1IIq1k9Y5+IsaxjCnKt7BPw+fxxg=;
        b=s2Cw1vyFfT9rJSx1Rbxg4LiTGqacw5iGz272O37+6lmwqlfYcj2/eGnDIvrwrhfK1v
         Vkem7r22ndDhMtSSS2s1sqQtZ7H5FRtoy3ngTMRa8fd8pCQKPqCJJ4bSibZOszrYIpyd
         nusXCdvtGofNQgk0v4H3d/QSKaMFGbZNc0GYPt+s+ZTcmcfxA/vZ0ulf941Co8E9+eCp
         QhpGDORW4zhNupmhvf3XhHR+s/tQT/b1jUnUz9+XvE00PvDtX3LUpOoehJlh6p4x7+ha
         MuFf8dtHL+ll8L3F26devFmd5Ez0rmm0i1qZNL1FKWniWac76dw5c7Xn2znxOUr3vDK8
         ARMg==
X-Forwarded-Encrypted: i=1; AHgh+RqBUMjJPPSVpLKaHPhEsXCdCu3kub4iUCu1E9kIeQbDDEBTbkqK7kdAkmA1niQKYSgUWNg0mE2L4rimTOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2R5CPSrGbgS6vK+aippPGXGsOvgKA9MD+kOCzJUA2vWbltP5
	eur3ed9WrCaecuh9EnMFDdVb7zu6tCemi/dBziwzEGUJfyti/gJbzxkiRc46whMzQHE=
X-Gm-Gg: AR+sD125jTyqAeoWyX3o8DviVFDfEs2G0rehACZc6KHSAV4bSPjIhLMau9zMPhcX4Rx
	U1/f2MjiEBZ2uU7y+I/CrMP73jGO9JhpPvJTOmajPX5yWTi6jt8oIdqlL18680VU9Dom/e8ZhB2
	tjlVS+p0wT16lAz1N73HpBl5clSRUOx+bWwZ7hUBhiWhZmNsjeFL6mTATkmhW1GrVKGx4t801gb
	iAZoMt5Dq4FAEcdEWv/99T8Oh+W9eaZX9xmh8wkCJb2J+Ot4BCna92Psri84y7G53sTJ7ApPL56
	xlHQ3A/jF7/OW2s54l2Cq7le34GmYPJxM3RIT2wpXrjbSSUDad2UkaL3RZoqhrACXrRJLn1ukgw
	lUzFies4nrdkq58O1GSQT24M+RiED6T+YAzZXMoEX0ZQk/Lz46mH3nRUJ4N+tRSNqPTGvYiH6hh
	9CHVxWz713RoyLeVYZos2ZbFUhEj9rPlaJ/Hw3LZNlqv/8GipS28WKf4zqJBhLdxdNXm9T4PcqK
	gWma9H2XFNt3syn1DuU87R7BX7MURFaPkuAZQ5xOsRgis45qFMarIXS58+h
X-Received: by 2002:a05:600c:3b1d:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-49988057986mr490766875e9.0.1787049107156;
        Tue, 18 Aug 2026 03:31:47 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:46 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:16 +0000
Subject: [PATCH v6 3/6] serial: 8250_aspeed_vuart: add VUART over PCI
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-3-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

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

The ASPEED_SCUC24 regmap update is use an undefined reserved register
ASPEED_SCUC24_RESERVED_14. I was unable to determine the purpose of this
bit. In the AST2600 A3 datasheet it is marked as 'reserved'. It is only
used on the other revision. As I only have the AST2600A3, I was unable
to try this code path. This BIT14 was set in the ASPEED SDK so I kept it.
I can remove it and the untested path if necessary.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 91 +++++++++++++++++++++++++++++
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

