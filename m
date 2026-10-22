Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685602;
	b=EAR3pOKe212gNHPrpYfZCXxVFgbgygkFlSs7AKL7htzwdeE1H+jTn6ga6juRAPAB6TRz
	 gY5yR7ZQtEdd8ml2alh94aGWNFlct8bjEd+MRLCBZaYb+KkWZPJkfMUFGYm4WLSBUTMUu
	 ouxjU7miUF9JmRvdIHL4jAMR1ekK+v0uKz/Lwc7CwgTrCr5dal+YltkrSAtrEkK9EOh/X
	 5CsuI2VTF9HmOH2pd76kgC6+/3pp1zX51T4sKt0ce9XmPBU3VKQgXvmrCjGZ62wecfB+3
	 H8KLtAVwmVgt4pdSea5GYxuWlag9a+kBdjLn4PkWooCbURkm36uhTMC7+8auqzXtKHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685602;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GtKmJl/OJ/zPWcGlJb7z095B9CDlkr6N8ZsDc0Umj/8=;
	b=oFRZ81HyZcAchATHcSSz15manJnCA9UT21daKYkQm9Ha9DsRAxuxqQTydhyYj9yjI/o5
	 iOMRkYsFBGLIeoVCHFl+vGIBqdyQ1x5UqLOep47Mze+uJT6tgyhdz/6PEgNHbjuFMJZ1X
	 gdc8fpbLAMxKYZ1AMeMg901hCeW/gwO35/thS2JBweNyiPDMGQSqjxmcGLbb+jgghV0II
	 XUSSJJzpCG+V1gCL3tC+SYrmY/RqDEhEulqOlJ9VYjGVXr2/qHmm2pqrw8fxvao0EX0GT
	 Xe+D7HspFJ5oLcRjtQmxinVBkqCbqPBmgL7oYQrlulXkr7KTFGBxD1u9Y3KcnAslJDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Afwv45BL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A746606A332;
	Thu, 22 Oct 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Afwv45BL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1864B1F01825;
	Thu, 22 Oct 2026 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685601;
	bh=GtKmJl/OJ/zPWcGlJb7z095B9CDlkr6N8ZsDc0Umj/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Afwv45BLfRoSr/LCrzMnPN3xbKsL2w/uyhEtITWPCaulCVh8UBat7G40qWb0JYMGI
	 v74DGov8B2TPueBokXcwe/KHtpSnjt6FKEI54NLUDzKI9/pM36CiKryA4f+60O5WEl
	 DPX+0Y5aTkrbEMEWqCplJiNKRaIW3IEio/HUaH7xJX7lvU1JQmXPqYxsKGiV5mvRHX
	 DkCO4Kx1DFAe4wW2KSuyQlE5SaI68rbSXsUeXzUyF9R6SifUwma2+Y99cONGUlvNzC
	 GOptXuteDueNqnnxojDyyB7/IjzMI46Hrw4HiN47Ene1WnP+MHHY/A4c0tNIf9yIhE
	 +Rl3VOVO34a/A==
Message-ID: <sashiko-outbox-181786@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/27] phy: rockchip-naneng-combphy: Add RK3572 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-22-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-22-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:20 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] phy: rockchip-naneng-combphy: writel() clobbers SSC bit in rk357=
2_combphy_cfg()
--

commit 9ca36a68e2ebd41ee7e126faeae68aae4fa05eae
Author: Cunhao Lu <1579567540@qq.com>

phy: rockchip-naneng-combphy: Add RK3572 support

This commit adds configuration tables, register programming, and device tree
matching support for the RK3572 combo PHY operating in PCIe, USB3, and SATA
modes.

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers=
/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 7843356a4dd47..e13a78ab57779 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -1000,6 +1000,204 @@ static const struct rockchip_combphy_cfg rk3568_c=
ombphy_cfgs =3D {
>  	.combphy_cfg	=3D rk3568_combphy_cfg,
>  };
> =20
> +static int rk3572_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{

[ ... ]

> +	switch (rate) {
> +	case 24000000:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
> +		if (priv->type =3D=3D PHY_TYPE_USB3 || priv->type =3D=3D PHY_TYPE_SATA=
) {
> +			/* Set ssc_cnt[9:0]=3D0101111101 & 31.5KHz */
> +			rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0xe << 2);
> +
> +			rockchip_combphy_updatel(priv, GENMASK(7, 0), 0x5f, 0xf << 2);
> +		} else if (priv->type =3D=3D PHY_TYPE_PCIE) {
> +			/* PLL KVCO tuning fine */
> +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);

[ ... ]

> +	if (priv->ext_refclk) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->type =3D=3D PHY_TYPE_PCIE && rate =3D=3D 100000000) {
> +			writel(0x10, priv->mmio + (0x20 << 2));
> +
> +			writel(0x0c, priv->mmio + (0x1b << 2));
> +
> +			/*
> +			 * Set up su_trim: T3_P1 650mv
> +			 * CKRCV termination resistor adjust 11: Hi-Z
> +			 */
> +			writel(0x90, priv->mmio + (0xa << 2));
> +			writel(0x43, priv->mmio + (0xb << 2));
> +			writel(0xb8, priv->mmio + (0xc << 2));
> +			writel(0x56, priv->mmio + (0xd << 2));
> +		}
> +	}
> +
> +	if (priv->enable_ssc) {
> +		rockchip_combphy_updatel(priv, GENMASK(4, 4), BIT(4), 0x7 << 2);
> +		/* PLL control SSC module period should be set */
> +		rockchip_combphy_updatel(priv, GENMASK(5, 5), BIT(5), 0x20 << 2);
> +
> +		if (priv->type =3D=3D PHY_TYPE_PCIE && rate =3D=3D 24000000) {
> +			/* xin24m T0_1 650mV */
> +			writel(0x00, priv->mmio + (0x10 << 2));
> +			writel(0x32, priv->mmio + (0x11 << 2));
> +			writel(0x00, priv->mmio + (0x1b << 2));
> +			writel(0x90, priv->mmio + (0x0a << 2));
> +			writel(0x02, priv->mmio + (0x0b << 2));
> +			writel(0x08, priv->mmio + (0x0c << 2));
> +			writel(0x57, priv->mmio + (0x0d << 2));
> +			writel(0x40, priv->mmio + (0x0e << 2));
> +			writel(0x5f, priv->mmio + (0x0f << 2));
> +			writel(0x10, priv->mmio + (0x20 << 2));

[Severity: Medium]
Does this writel(0x10, priv->mmio + (0x20 << 2)) in rk3572_combphy_cfg()
clobber the SSC period control bit that was just set above?

When priv->enable_ssc is true, rk3572_combphy_cfg() sets BIT(5) in register
offset 0x20 << 2 via rockchip_combphy_updatel(). Immediately afterwards, wh=
en
priv->type =3D=3D PHY_TYPE_PCIE and rate =3D=3D 24000000, this writel() ove=
rwrites the
entire register at 0x20 << 2 with 0x10, clearing BIT(5) back to 0.

Should both this write and the writel(0x10, priv->mmio + (0x20 << 2)) in the
priv->ext_refclk block above use rockchip_combphy_updatel() with GENMASK(4,=
 2)
instead, matching how the 24 MHz and 100 MHz PHY_TYPE_PCIE cases update the
PLL KVCO tuning field earlier in rk3572_combphy_cfg()?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D22
