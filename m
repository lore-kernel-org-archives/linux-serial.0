Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530353;
	b=Nbk55Z4LyT9pNBc9d/yXtC+QwLR8xNi3kqABCx37Dh0WWFl6DMwYzZpQQdDlb79WGZLh
	 xT3+1snebId6G+O+t+j00+6VfbilhyDgIAIEw7g056wGDg6+ZMHhzvwGRIlBYGiP4Nf9U
	 TrDx7/+88I9o2nYacvpjblBXXquKsHypkYjXWs9FMvCzmnUlROb2YN8+IQBtOw5o/cUFz
	 F1egCtwKy+GXjLkz4Lkal1CiCVJXxIdzj78Gr70SBSbyZb7qzYCARUdl4QBDg1Tq4/kk5
	 a0ZeHbaIyeOsW7yfSEzZq0AgzoqyX0MeXcvKch+PJB9sRud/GNyLhF8+CV2tOQauIGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530353;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xlm70zJicMZ77PdEMVbRYRPtF07ul0gsfdGP8rkkP/0=;
	b=jw97zG9yd8usNEHuCJ1iC4xT7b0Dp7Yj7ceVSxBhJU54lJhDFzzqCrm8C+zf9u7+7Q4b
	 ipqQYMrldslWsLyonm8vdGn6LyZ3zjvcm+rXw1iheBTBQlnBTviuFCk6gpaXeveHMmqn9
	 iUmyx2SOsMJEvVi/Efhl+Aavs+rkQKTq9kGHuKZog354SUnV15ceByBPEhGppduvW0U7o
	 aAmuihF5IdhWxAE2mPZBwfHPqmS2g9hfAONOV8j2VlMJ4EBa0YmdHycZiGPSdObK6Tlzb
	 VgTPDGyamMIjve2uX5J4MOPQdm4HiWGboCL5mfrdnglcWITfvISvHI5cIkvQP3x6L7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8dU9Alg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D4606A324;
	Sun,  1 Nov 2026 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8dU9Alg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BE91F00919;
	Sun,  1 Nov 2026 10:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530352;
	bh=xlm70zJicMZ77PdEMVbRYRPtF07ul0gsfdGP8rkkP/0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=P8dU9Alg7dNejqGOtDAiPGLdjb7OVRTdUPw5/10mKpEjIjVVCFalD/HOhK3FbunKC
	 A/KZ5UoaT42jLXx60Yn+s8tc+5fCiA6F0IFwpS6pfSqrKyY/SeqaJk+7EZ68nzwXxX
	 WYAvAy6sqizSA9Y5txW1DQWq0rmEDc30vpDJIrN4aHnm/iCEHtjSTvemZ+RPwfdYbZ
	 i915xKFfgVJRluUmnNIOWDeZQOtBD849cI5q3eQHQTZQQqL++Xr3+Xm+ZXkHPeiOsS
	 O8tEizdg30ngq0w7KN3lpRoTY+2zUdbNYr4ewJoIwH1l8ZRb5tc/UD2jrkSuGDBPgM
	 N8z42dgQ0TKXw==
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 22/27] phy: rockchip-naneng-combphy: Add RK3572 support
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, 
 lee@kernel.org
In-Reply-To: <sashiko-outbox-181786@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-22-0b0fd85a31ee@qq.com>
 <sashiko-outbox-181786@kernel.org>
Date: Sun, 01 Nov 2026 16:22:26 +0530
Message-Id: <179353034684.2955.5901398331920172946.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978; i=mani@kernel.org;
 h=from:subject:message-id; bh=PV6+TwlxSS26CdoN0gMespT5APA2NOMOowYoRN7732Y=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsh6LvkmXFHPqu+jnbqWznXpxmt51zbNSDJYO7f7Yu3Ee
 c8ZK1pjOxmNWRgYuRhkxRRZ0pc6azV6nL6xJEJ9OswgViaQKQxcnAIwkRI99v/5otU24k0fq9rP
 Cq8IsLVU265bnSZW/mzx7AKdw8ncx/P/LZ3zt3PPoiUJPDO3lPH0RhxkOS1swBxbu+pT6f3t6xp
 EhJTqZNo3COTI6oeXHG3Q9nZqvGPYEtH7JzRW42lp/RJG3awZwr+bnlqXCfFckekOVLSQaftTWa
 zs//mUZ9c3791Hdi/o23/Do6Y2NPhL017RUwEMndv3P/gisESyI8W5Y6ZV9L4nlUr7X/m5fW4Sn
 Or7K3DiuWWGUik9PbbPBJbeWVEx68LmCa8adE0mXCwS4xVcq60s7M5p4W+/zerOk/z6l9MUynOZ
 eJfIVVzwZHBfYxZ74820Rx2RvzV/XUpy83vwYtI1mwlHAQ==
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-22 16:13 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] phy: rockchip-naneng-combphy: writel() clobbers SSC bit in rk3572_combphy_cfg()
> --
> 
> commit 9ca36a68e2ebd41ee7e126faeae68aae4fa05eae
> Author: Cunhao Lu <1579567540@qq.com>
> 
> phy: rockchip-naneng-combphy: Add RK3572 support
> 
> This commit adds configuration tables, register programming, and device tree
> matching support for the RK3572 combo PHY operating in PCIe, USB3, and SATA
> modes.
> 
> > diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > index 7843356a4dd47..e13a78ab57779 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > @@ -1000,6 +1000,204 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
> >  	.combphy_cfg	= rk3568_combphy_cfg,
> >  };
> >  
> > +static int rk3572_combphy_cfg(struct rockchip_combphy_priv *priv)
> > +{
> 
> [ ... ]
> 
> > +	switch (rate) {
> > +	case 24000000:
> > +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
> > +		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
> > +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
> > +			rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0xe << 2);
> > +
> > +			rockchip_combphy_updatel(priv, GENMASK(7, 0), 0x5f, 0xf << 2);
> > +		} else if (priv->type == PHY_TYPE_PCIE) {
> > +			/* PLL KVCO tuning fine */
> > +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
> 
> [ ... ]
> 
> > +	if (priv->ext_refclk) {
> > +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> > +		if (priv->type == PHY_TYPE_PCIE && rate == 100000000) {
> > +			writel(0x10, priv->mmio + (0x20 << 2));
> > +
> > +			writel(0x0c, priv->mmio + (0x1b << 2));
> > +
> > +			/*
> > +			 * Set up su_trim: T3_P1 650mv
> > +			 * CKRCV termination resistor adjust 11: Hi-Z
> > +			 */
> > +			writel(0x90, priv->mmio + (0xa << 2));
> > +			writel(0x43, priv->mmio + (0xb << 2));
> > +			writel(0xb8, priv->mmio + (0xc << 2));
> > +			writel(0x56, priv->mmio + (0xd << 2));
> > +		}
> > +	}
> > +
> > +	if (priv->enable_ssc) {
> > +		rockchip_combphy_updatel(priv, GENMASK(4, 4), BIT(4), 0x7 << 2);
> > +		/* PLL control SSC module period should be set */
> > +		rockchip_combphy_updatel(priv, GENMASK(5, 5), BIT(5), 0x20 << 2);
> > +
> > +		if (priv->type == PHY_TYPE_PCIE && rate == 24000000) {
> > +			/* xin24m T0_1 650mV */
> > +			writel(0x00, priv->mmio + (0x10 << 2));
> > +			writel(0x32, priv->mmio + (0x11 << 2));
> > +			writel(0x00, priv->mmio + (0x1b << 2));
> > +			writel(0x90, priv->mmio + (0x0a << 2));
> > +			writel(0x02, priv->mmio + (0x0b << 2));
> > +			writel(0x08, priv->mmio + (0x0c << 2));
> > +			writel(0x57, priv->mmio + (0x0d << 2));
> > +			writel(0x40, priv->mmio + (0x0e << 2));
> > +			writel(0x5f, priv->mmio + (0x0f << 2));
> > +			writel(0x10, priv->mmio + (0x20 << 2));
> 
> [Severity: Medium]
> Does this writel(0x10, priv->mmio + (0x20 << 2)) in rk3572_combphy_cfg()
> clobber the SSC period control bit that was just set above?
> 
> When priv->enable_ssc is true, rk3572_combphy_cfg() sets BIT(5) in register
> offset 0x20 << 2 via rockchip_combphy_updatel(). Immediately afterwards, when
> priv->type == PHY_TYPE_PCIE and rate == 24000000, this writel() overwrites the
> entire register at 0x20 << 2 with 0x10, clearing BIT(5) back to 0.
> 
> Should both this write and the writel(0x10, priv->mmio + (0x20 << 2)) in the
> priv->ext_refclk block above use rockchip_combphy_updatel() with GENMASK(4, 2)
> instead, matching how the 24 MHz and 100 MHz PHY_TYPE_PCIE cases update the
> PLL KVCO tuning field earlier in rk3572_combphy_cfg()?
> 

Looks valid.

- Mani


