Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599175;
	b=4tA4m/opQg0ouelj61uCMp92evlzIDqEjGnYXq5o3y+H33qjsNJK5/D4YhkTh8/RE8cj
	 hQoV06VzDXOr85HQMdBd3TYxWIXjsnwcVzClRz/02kXqTMmfJFMS43Ah0mVCW1a1NN59i
	 meJVHG09XxM4HOOfX/fAH1AjvCeIZFxm+kTzn/K5hDgZ3Arfz62dkHb0JH6COU/sqyQZZ
	 rX5ikvxzvF5ucOYAUbtHEVtHmShWlQ9PQwZR6TwZuk3Viko2T1Jw9hbvs0MQwxl0oVBwa
	 aFR7XwNotsvfW9HS1udMwqexbMA6pUjfBiItp7toLQnoZbh2tl+hyiCIV0MMeYlfO4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599175;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ILragtZYitjGhtnbajKHG/lL6QPsFimFt5+gHLVt/IM=;
	b=sY1QXSBxazpDFmbm40l6IS0SWyQ5/2t7WcjxhRhJtd32oKG7o+UebGkRxG5CHX258FOG
	 B8+eP22d/TVqyMBuFBfsV7KtdJVEMjY3EukijinxnUi2dRo9s1sDxzwH0lQTs8VIlNpi9
	 sfUQ5iKltkLSzcWSUYfhXsSttnIMCVUgBIpYK76BMFPpzEkjO91kr7iSWQKYVg5lQolCD
	 kDrs/e1heNbv/K6eyHr+y2WEar2lm6+5iVLSTwpwiv7wNsGkrROE7iJIMR+WtWNi/5ntM
	 Xm9V3Unyx3Qhqul1Rwe/NhfJdA5Zq9hCVjew87gvY9TpvXbX4urCZGRilLqWVeAuZgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWE31xmp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540D6071D9B;
	Wed, 21 Oct 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWE31xmp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599175;
	b=kF5ErG0FZ2vRHuvbTcE7LNgdDNOOrKSjmxNYUBIrIgCUlWmw3QaOCIrUVRg/qsbCF6D0
	 2C7d4iCqSxgmTvbQw9mqzTxgye/bRbPWov0SxZKJbJ6zWWw5OlHVdqDRT6eOsa+Zz1OmR
	 OVIhiZepqkAtDLWUBuOPhjI9ucOxbSH8F2Ba7VB/tltCim5ji5aE/ko2LYapSvee6+pzJ
	 ZtgTo4vI69P6fzOsKRpu1yK6iUpOX916nxiSwR3ET+Lz4O7u+RbvGP8s9sK/GSrw0IT8N
	 PE3KO44mthTuwRDqeDIq8l4d2AYv9RTmE/rqjDKrgK1D7GldjjLfVouUg4bL0CwhlQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599175;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ILragtZYitjGhtnbajKHG/lL6QPsFimFt5+gHLVt/IM=;
	b=yQ9uT6o0oFsxdh8bjov2m0tejlMpJz/SitfLNaJdIW1ByYHHhXDM8Sn4d38+v8Y85bAi
	 rN0BmotQE6owizBqWD9CjkN601DUgAJTqr2qnPacJ/cd0E8O9T5BcnmbOXxjEm71OODDG
	 BoE4roBwtLc8bJ/FVpsOvDaAYnWyBms+Qt99cfxSpQ5BxVNkPawK1bWtKEZDdaUQ0FiRD
	 Zo7qHF9CRQ8oWi8mPs1Olqtpph5DWzA6ZbHwDeFw/iWeM09Q4IahhPOILlkL2BBqPH2a6
	 tKWnT1VTGsDsYA2BC+FXI22TnEsmqTGoh8ix65ujXZlPMRKplohQZvo4VkzdKCM7Qrg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A53451F01574;
	Wed, 21 Oct 2026 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599175;
	bh=ILragtZYitjGhtnbajKHG/lL6QPsFimFt5+gHLVt/IM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GWE31xmp+j9UwoKcUCPYYpp8MPl0PpvHfFc8ox0Q6pMhUmuJ+5Vg7A3NAAN8znPcE
	 UADPuyS0UqWMNh4mWTzeYMZzs6f1tUwBGK12hLaUZuJpUF4tgAb8lq33RZYMxXxehB
	 ppny1EeljAfdxhzTTvImAWyCRlnbDlEvQAIBIaKuOdDpjuH6VLhMu74cPiEdvhc5Fw
	 OAs6kZYazn3cnDEppO8KmLKAI/WwXObzICdFsKciLo4GZjtuuetJWLMlMrcdAyLbuN
	 1ax4GTcwuqwpHGLO2B1TX/rA6HHS6UN0uAR5wq41+LKW7/+0r9l0hKg37vJTBiEIqq
	 rk3SiavFLLTEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B54D9433F3;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:18 +0800
Subject: [PATCH 21/27] phy: rockchip-inno-usb2: Add RK3572 support
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
Message-Id: <20261022-add-board-ok3572-c-v1-21-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=6030;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=MPl2FQncIHhIqjcsF+b7mqwRNlggJx2lRqAwXBLUJcg=;
 b=csHlm1OtXnrb4d6G2om1X16+yZzKXaej9famSMbN4YeXs2pQos5crLHMU00zCwyO8NPws/R4G
 ThNK60Wm1bgCtYcGsnwq4TVPa+qGIyky4o2MpdjfhBQxaY5DACYpBGf
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Support both RK3572 USB2 PHY instances.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 136 ++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 7d8a533f24aea..16a36e68cb6d3 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1544,6 +1544,49 @@ static int rk3528_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 	return 0;
 }
 
+static int rk3572_usb2phy_tuning(struct rockchip_usb2phy *rphy)
+{
+	u32 reg = rphy->phy_cfg->reg;
+	struct clk *refclk;
+	unsigned long rate;
+	u32 val;
+	int ret;
+
+	refclk = devm_clk_get(rphy->dev, "phyclk");
+	if (IS_ERR(refclk))
+		return PTR_ERR(refclk);
+	rate = clk_get_rate(refclk);
+	if (rate != 24000000 && rate != 26000000)
+		return -EINVAL;
+
+	ret = regmap_write(rphy->grf, reg + 0x0004,
+			   GENMASK(18, 16) | (rate == 24000000 ? 2 : 6));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(rphy->grf, reg + 0x0010, &val);
+	if (ret)
+		return ret;
+	if (val & BIT(13)) {
+		ret = regmap_write(rphy->grf, reg + 0x0010, BIT(29));
+		if (ret)
+			return ret;
+		ret = rockchip_usb2phy_reset(rphy);
+		if (ret)
+			return ret;
+	}
+
+	/* Set the normal line-state filter interval. */
+	ret = regmap_write(rphy->grf, reg + 0x0020, 0x30100);
+	if (ret)
+		return ret;
+	/* Increase HS voltage by 5.89% and double pre-emphasis current. */
+	ret = regmap_write(rphy->grf, reg + 0x000c, GENMASK(27, 24) | 0x0900);
+	if (ret)
+		return ret;
+	return regmap_write(rphy->grf, reg + 0x0010, GENMASK(20, 19) | 0x0010);
+}
+
 static int rk3576_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 {
 	int ret;
@@ -2126,6 +2169,98 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3572_phy_cfgs[] = {
+	{
+		.reg = 0x0,
+		.num_ports	= 1,
+		.phy_tuning	= rk3572_usb2phy_tuning,
+		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x00c0, 1, 1, 0, 1 },
+				.bvalid_det_st	= { 0x00c4, 1, 1, 0, 1 },
+				.bvalid_det_clr = { 0x00c8, 1, 1, 0, 1 },
+				.idfall_det_en	= { 0x00c0, 4, 4, 0, 1 },
+				.idfall_det_st	= { 0x00c4, 4, 4, 0, 1 },
+				.idfall_det_clr = { 0x00c8, 4, 4, 0, 1 },
+				.idrise_det_en	= { 0x00c0, 3, 3, 0, 1 },
+				.idrise_det_st	= { 0x00c4, 3, 3, 0, 1 },
+				.idrise_det_clr = { 0x00c8, 3, 3, 0, 1 },
+				.ls_det_en	= { 0x00c0, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x00c4, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x00c8, 0, 0, 0, 1 },
+				.disfall_en	= { 0x00c0, 6, 6, 0, 1 },
+				.disfall_st	= { 0x00c4, 6, 6, 0, 1 },
+				.disfall_clr	= { 0x00c8, 6, 6, 0, 1 },
+				.disrise_en	= { 0x00c0, 5, 5, 0, 1 },
+				.disrise_st	= { 0x00c4, 5, 5, 0, 1 },
+				.disrise_clr	= { 0x00c8, 5, 5, 0, 1 },
+				.utmi_avalid	= { 0x0080, 1, 1, 0, 1 },
+				.utmi_bvalid	= { 0x0080, 0, 0, 0, 1 },
+				.utmi_id	= { 0x0080, 6, 6, 0, 1 },
+				.utmi_ls	= { 0x0080, 5, 4, 0, 1 },
+			}
+		},
+		.chg_det = {
+			.cp_det		= { 0x0080, 8, 8, 0, 1 },
+			.dcp_det	= { 0x0080, 8, 8, 0, 1 },
+			.dp_det		= { 0x0080, 9, 9, 1, 0 },
+			.idm_sink_en	= { 0x0010, 5, 5, 1, 0 },
+			.idp_sink_en	= { 0x0010, 5, 5, 0, 1 },
+			.idp_src_en	= { 0x0010, 14, 14, 0, 1 },
+			.rdm_pdwn_en	= { 0x0010, 14, 14, 0, 1 },
+			.vdm_src_en	= { 0x0010, 7, 6, 0, 3 },
+			.vdp_src_en	= { 0x0010, 7, 6, 0, 3 },
+		},
+	},
+	{
+		.reg = 0x2000,
+		.num_ports	= 1,
+		.phy_tuning	= rk3572_usb2phy_tuning,
+		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x2000, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x20c0, 1, 1, 0, 1 },
+				.bvalid_det_st	= { 0x20c4, 1, 1, 0, 1 },
+				.bvalid_det_clr = { 0x20c8, 1, 1, 0, 1 },
+				.idfall_det_en	= { 0x20c0, 4, 4, 0, 1 },
+				.idfall_det_st	= { 0x20c4, 4, 4, 0, 1 },
+				.idfall_det_clr = { 0x20c8, 4, 4, 0, 1 },
+				.idrise_det_en	= { 0x20c0, 3, 3, 0, 1 },
+				.idrise_det_st	= { 0x20c4, 3, 3, 0, 1 },
+				.idrise_det_clr = { 0x20c8, 3, 3, 0, 1 },
+				.ls_det_en	= { 0x20c0, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x20c4, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x20c8, 0, 0, 0, 1 },
+				.disfall_en	= { 0x20c0, 6, 6, 0, 1 },
+				.disfall_st	= { 0x20c4, 6, 6, 0, 1 },
+				.disfall_clr	= { 0x20c8, 6, 6, 0, 1 },
+				.disrise_en	= { 0x20c0, 5, 5, 0, 1 },
+				.disrise_st	= { 0x20c4, 5, 5, 0, 1 },
+				.disrise_clr	= { 0x20c8, 5, 5, 0, 1 },
+				.utmi_avalid	= { 0x2080, 1, 1, 0, 1 },
+				.utmi_bvalid	= { 0x2080, 0, 0, 0, 1 },
+				.utmi_id	= { 0x2080, 6, 6, 0, 1 },
+				.utmi_ls	= { 0x2080, 5, 4, 0, 1 },
+			}
+		},
+		.chg_det = {
+			.cp_det		= { 0x2080, 8, 8, 0, 1 },
+			.dcp_det	= { 0x2080, 8, 8, 0, 1 },
+			.dp_det		= { 0x2080, 9, 9, 1, 0 },
+			.idm_sink_en	= { 0x2010, 5, 5, 1, 0 },
+			.idp_sink_en	= { 0x2010, 5, 5, 0, 1 },
+			.idp_src_en	= { 0x2010, 14, 14, 0, 1 },
+			.rdm_pdwn_en	= { 0x2010, 14, 14, 0, 1 },
+			.vdm_src_en	= { 0x2010, 7, 6, 0, 3 },
+			.vdp_src_en	= { 0x2010, 7, 6, 0, 3 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
 	{
 		.reg = 0x0,
@@ -2378,6 +2513,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3528-usb2phy", .data = &rk3528_phy_cfgs },
 	{ .compatible = "rockchip,rk3562-usb2phy", .data = &rk3562_phy_cfgs },
 	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
+	{ .compatible = "rockchip,rk3572-usb2phy", .data = &rk3572_phy_cfgs },
 	{ .compatible = "rockchip,rk3576-usb2phy", .data = &rk3576_phy_cfgs },
 	{ .compatible = "rockchip,rk3588-usb2phy", .data = &rk3588_phy_cfgs },
 	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },

-- 
2.34.1


