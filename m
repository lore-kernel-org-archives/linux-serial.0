Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA831F99B
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055206; cv=none; b=Idh+uxBX8z+3ATcL+iS4Czu3y9Ezd8MmorFxOx1hiUtxva4KjlzvxyS6UGJmWlupkOrUWLWSFN8fm/6LSQsOXGNJqCts1faj1ToxFbSk5VdztMh300BTXO7cr2BYfDylrpipCVfqGWeoXr1x95wz0OxqrAxZyDPRAhD7+xf2VLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055206; c=relaxed/simple;
	bh=ZdMjtjALJ9INUjixbUCM2kZrdun7GikDbIME1A+PLD4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Uz/0ebioMk5Xm8YeX2fEEKULDj1R+avg8rrw1bg+vrg6ne2UhSYV7iw9YRi8PrxsL6VkEZO85jW34uRmfF947bhASgv2d2skKEbdi6/9nikqSDDTzHGwGTZ2N36iWq/fkRWhUNJN6AwT8nvTF+uKz7dRHudA+s8m8if3HxAwc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=G5s5+9aT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="G5s5+9aT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so33624885e9.1
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784055187; x=1784659987; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v81RYgZzr05KCDxoR1cyj6HFcz85Vml1RF/7JkwpDYw=;
        b=G5s5+9aTIhYBACQSUFZ2HIJTVgnEpAiWFkp96yBvmlrBVcttfdbebm5xM9r8IgiVSG
         3Z82/2jAf+k8WEcHAZvV5q9bquk8WZGoH4p9p6R+fAYmNKWBSAkZxflvpuX9lvRKrOyI
         lnN+mJkDrPXJg6xvsT/SE/sbZpvt2zDJmMYJC98rtXtTqVIkMwW//Vv7ftxt/TepEunW
         Gx+aBZjHwGuV6EqnSMDYaa0o3f9M4w7h7y8dtp1g+UoRZhZm5NcDqow802zi1Y4H8gYb
         Abk3zvgbjfk2A7SBMj0420ZbIsGMG2Xcl+U1qzkhRjovZ0xoxyZQPDxLQjzWcpGKiwHQ
         fJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055187; x=1784659987;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v81RYgZzr05KCDxoR1cyj6HFcz85Vml1RF/7JkwpDYw=;
        b=PSfwhmET4x9cxqU29Yy5K85gKvQhPnVrWwynSBvA5Lyo/mk6r+T+BQU/4d1x+jiDcy
         TJQ6MubGVpAIpgCQrbzN2e9Yib75iJhgRVQndQbnQ51TI7TIFD36FUYg0ZZXpOPVHtQ2
         PaJJijESwRJW8EQ2dknAz8YbgwGaQwN0vYBbtc3uCDHnPE8v36eFmmyq8FvOzzvaOt1q
         Xag4VbtfzbYRWy1SiuWvkRzo7plL7gj3MjdEP9+O92w5IeMjNPFmBZ2IMm//P+wNySxR
         tdwU89ABa1zdC7zSo4DnMTGpEwIUPUR2MXKUioe1e0m1Q7GYzGFX+fPJZRoOr1Rux+1H
         HMeA==
X-Forwarded-Encrypted: i=1; AHgh+Roo1qU8A6QsdgLkrDweyjNAoe0OYdpGOrX6WAXPG05fAKNB5b9aVmp4HgcSE9T4H9ffiNv4UplvCetjmtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxks4CJiTCdRZVCYN0sBmrBs9BAsPt+ku9iJ29KyFOq0J6vJz
	U7dvf0QOXMD5fKIZQi6fzY7CO4KMm+qz8RrHoEZLrSom3venddoQo4Evp4AILZarGOdXfgYqSdf
	KWS5VlnAZJTPR
X-Gm-Gg: AfdE7ckJUqsXXbDENHGfRkMJZK8wx0xXNqH8Rdj4XrC3grg3FHiK9riqLjgZs8wacwL
	fKDtOJUBEuit+rrB2ahrfuSEpts0rdvo/Rz4FJHZJmqEwymq77Z201KAb5zN/GSj5AW43BlnMTa
	3KJlZo8a/pcNcWKIveTxlDyGyLiuHE15YIethzkm2XsGgCV9eAwd4bN2/AB4QbxmK4sH8ocbwBK
	CCkFu0Hm2Ito8qklUPGBHbc3emTEnWbi0dP26yWyob4sJhy0dvzZIoMQE0MP9LW2t6kb11MKHBS
	7t/J97LwMR0VbzvdsRUbXbZikLc5F/xVK+kdGKTrRkKKd9KXNxqtyu22a1x2NW1/OqC7pRLWbC1
	6IeZnijTj3PUFzwIaiAcrbUP/iQo2xcLCcL3oBci1+rHFeGGsyBh5Ql26oGrb9dY7mM7qkTeV/0
	q0gmxWTOOaL/ju8aYLDI8BpRcWhVDc7A==
X-Received: by 2002:a05:600c:3150:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-4953c1624bdmr714135e9.17.1784055187650;
        Tue, 14 Jul 2026 11:53:07 -0700 (PDT)
Received: from [192.168.254.124] ([2001:9e8:2fb:8201:c26a:83ef:161a:409b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508725c0bsm94908715e9.2.2026.07.14.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 20:53:03 +0200
Message-Id: <178405518337.194693.16062290686593842402.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784055186; l=4160;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=ZdMjtjALJ9INUjixbUCM2kZrdun7GikDbIME1A+PLD4=;
 b=GZ6jzOrhucR05WwmvOfO9a6YYLoB752Rjv/H4tteyWXK0nQoP0J4vtOVuXDGA+QefmBBarWe8
 Ma1Cg3Obz4gAvCucwwSYpECAuo9Mbmv2Y1RTdL+yzoGUgXHEqBazp7d
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Enable the VUART over PCI for the AST2600. Activate it only if the
> 'aspeed,vuart-over-pci' property flag is set on an
> 'ast2600-vuart' compatible node.
> 
> The AST2600 has 2 VUART that are usable over PCI. These are already defined as
> the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.
> 
> Sets the BMC PCI device enable bits, sets the PCI class code to
> unassgined/device specific, and configures MSI interrupts.
> 
> There is no disable function. Removing this driver should not disable
> the BMC PCI device, as other drivers could use it.
> However, if all the drivers using it are removed, the
> BMC PCI device will still be activated, which is not ideal. But in reality,
> this is not a use case for a BMC, the drivers will never be removed.
> 
> This is useful on PCIe BMC expansion cards that use the AST2600, such as the
> ASUS Kommando IPMI Expansion Card.
> 
> Register initialisation taken from ASPEED 6.18 Kernel SDK.
> Add return code checks to each register write.
> Simplify the code and add macros.
> 
> The ASPEED_SCUC24 regmap update is missing a macro for 'BIT(14)'. I was
> unable to determine the purpose of this bit. In the AST2600 A3
> datasheet it is marked as 'reserved'. It is only used on the other
> revision. As I only have the AST2600A3, I was unable to try this code
> path. This BIT14 was set in the ASPEED SDK so I kept it.
> I can remove it and the untested path if necessary.

There's not even a reference in the datasheet changelog, so I suspect that it
has always been reserved.
I'd be in favour of removing it.

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 6afa2f4057e1..4d09c04cb972 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c

*snip*

> +static int aspeed_ast2600_vuart_over_pci_set_enabled(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 silicon_revision_id;
> +	struct regmap *scu;
> +	int rc;
> +
> +	u32 pcie_config_ctl = SCU_PCIE_CONF_BMC_DEV_EN_IRQ |
> +				SCU_PCIE_CONF_BMC_DEV_EN_MMIO |
> +				SCU_PCIE_CONF_BMC_DEV_EN_MSI |
> +				SCU_PCIE_CONF_BMC_DEV_EN_PCIE_BUS_MASTER |
> +				SCU_PCIE_CONF_BMC_DEV_EN_E2L |
> +				SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE |
> +				SCU_PCIE_CONF_BMC_DEV_EN;
> +
> +	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> +	if (IS_ERR(scu)) {
> +		dev_err(&pdev->dev, "failed to find SCU regmap\n");

dev_err(dev, ...) instead of &pdev->dev (defined above).

> +		return PTR_ERR(scu);
> +	}
> +
> +	/* update class code to be an Unassigned/device specific class device */
> +	if (regmap_write(scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000)) {
> +		dev_err(dev, "could not set PCI class code\n");
> +		return -EIO;
> +	}
> +
> +	if (regmap_update_bits(scu, ASPEED_SCU_PCIE_CONF_CTRL,
> +			       pcie_config_ctl, pcie_config_ctl)) {
> +		dev_err(dev, "could not set PCIe configuration\n");
> +		return -EIO;
> +	}
> +
> +	if (regmap_read(scu, ASPEED_SCU_SILICON_REVISION_ID, &silicon_revision_id)) {
> +		dev_err(dev, "could not read silicon revision\n");
> +		return -EIO;
> +	}
> +
> +	if (silicon_revision_id == AST2600A3_REVISION_ID)
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
> +					ASPEED_SCUC24_PCIDEV1_INTX_MSI_HOST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> +	else
> +		rc = regmap_update_bits(scu, ASPEED_SCUC24,
> +					/**
> +					 * The bit 14 is reserved in the Datasheet.
> +					 */

Even in the oldest datasheet that I've got (which was for A2 apparently) it is
marked as reserved.

Maybe some ASPEED folks can enlighten us what Bits 14 till 16 were used for on
A0-A2, and if they are relevant for PCIe INTx/MSI routing on the older silicons.

	Tan

-- 
Tan Siewert <tan.siewert@9elements.com>
