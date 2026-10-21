Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599160;
	b=0ByKuNd653ihs41jGfqF/rHzXyzgHR0PYCKWh6Obp7QE1qVOenywM0wF4FhAR5cVMxTJ
	 U/YWgyTJe8R7P6738mcFutR7z6DfvXt5ClNcnfVbWs2fyqOicxCcaKUmULAP+Ai09hDjb
	 IO47Zm80zEjGjM8C837kMVnfZq/dL3HzjM3PDgqX0tabjSjhQ+B/tt4grRi2D3zTNHpHw
	 zGqyHx+f77sbU3fNMl4WZL7DAj2Xk2RkEuEI4wVrRCtFxCSgp+JjtAtoDtsXJxsdB7ZYX
	 DlileZ8xZpcHs/ybiJJ1pgOJc233I2u40pD2kImMbLX8zhdSwb26ZSC56cQzp/tlSLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599160;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y/aRDDf0tbbhcaRVo5zqbs8kQxH53mVifboQgC8oqlg=;
	b=hfRrYa+hheqynrfKklsoVNFqEXSRVYfNZHDgHp85QOcQ4uPcPUA2ZBpmytcMbd70LwNL
	 3gAfJfont0kqRz2jA+x+W+zvfkGYDKnR9632njp/3rviyfikIklWFXRsMceEM8FsOQVrF
	 An3zrZSv7vphM65VBfXAQGWfxDAxTqZqrXfRfdim7iScC5FPnyN8Kn31BOIPnsHhMSPX5
	 r5PYGf08/8oGc2V5mhpchqFslDRjYKH65Nds1UmWYcTfc1VFlzCoUYyKlaXpC7U2bHbOt
	 E1wDyhcW6JLmge5/7NnidyFQtP9YAOq5jmEF9JWnamcwNOj6fMcbaKzGnf43lArkMsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9RxlqBH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5760A5BD3;
	Wed, 21 Oct 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9RxlqBH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599159;
	b=eDDDNehLR1p2x7B8ned7VtqfH9eKEz93NM41AraLGyxHvh4NoHzPHBHHI/5k7BUhMjpk
	 z77BwI/58nrmq5QwqBA9BWfKryEiXqS6VB5Sg2lBShRCOODKXWqO9teXGIKrcpZDJzY+c
	 2tHsUCmRxnNLXmmr/Lbf9VfOFWWo8TtowUFmomMP1q57uNc8lCYQ51NerHUsQfRFwRRPA
	 rJ/vzTWdzOVZzzaTTxxg7CkO0mnYuBh5QbRuTFKCjTtLYDhw0tmSo4Ta/HAWzBxyXAB7f
	 gUofVPVYSa7n8kUKxP4i4qqRPvRLVpEJn2v4CbRb926TmrTek1eEI0XcVZOwhX0+xjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599159;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=y/aRDDf0tbbhcaRVo5zqbs8kQxH53mVifboQgC8oqlg=;
	b=fSWRq1A6qwGzlN3Uz39RW+c7Oioj6iIYomjt6eognaDKMJVjR3aJTacPNpYk6RG9nTLs
	 DMpKY+aQSRC3p4vSd2dzPN/kD+V881uouWvRZEmZpGZtVNkkK4TVOjghmLzsMJh4M+kDK
	 S4VolXmJsvAWGTUkRQ9fAdTNBeEykTqR8QMYkrTbmFpMrQa6JWFm25vgUHpUaQHrnq8+J
	 QGw0NGSoBFMIEorWQi+A4z99UODJr8PTmGvJOJAIEbUVKhm++6sLAUcvIHfTe5IAfTRHa
	 7EBJ+G9BDjPB6Dl8tFmBWedVONhp22xh8HRabHm1+V7rrVcglXRzmZbRuWzP3eUM9ww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EE9B91F000CD;
	Wed, 21 Oct 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599159;
	bh=y/aRDDf0tbbhcaRVo5zqbs8kQxH53mVifboQgC8oqlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a9RxlqBHCh3LZ2aCUU+jUEoQFCeF0J+QQ+UnAWpmrT3489+0AnXjcpb0shW68J91T
	 wded0xqNx9wjgauBxr4GIc36en1QYz1YPWkk629vOYR6+Fn6nCspoaPvf8Gxv13Cnl
	 1XwirC/n3T8LE/BF7nfiFZ+ExsPC9+PjbJkRlGGmZ897lyg2zLkADRdL/+szSFo/Nm
	 eXVvMhCQTWBEq9GEkXOEK1jyDgi+HPx4kqe/WdM+idxx6xvhCwp0xIFbFEzlpnFYcv
	 WchkdYtDJXmV37pXe2NV8B8MhQ3M73rOgZxgKKbJJ743z2wqulwbjGXEblSXE23OIZ
	 0r1Bf/jB8eu9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87663433DE;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:13 +0800
Subject: [PATCH 16/27] net: stmmac: dwmac-rk: Add RK3572 support
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
Message-Id: <20261022-add-board-ok3572-c-v1-16-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=2887;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=Rg9amKxMbRRIlhFsyxhoXU1NtXTBv4uhUyFMSA2skGM=;
 b=RlAQCZ0baz8YNd+Fe9U9uTTuBsNuYyNIkkmM+sLmCxpFmmJfRH2JQSdcgqoVkpSpp4l5+IsQp
 ugoGbndipGsB56oFRJkFSBRBu0gv0dr6kL+awbNU6Vp7rpINPT9yOUy
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Configure RGMII delays and clocks for both RK3572 GMAC controllers,
using GMAC-specific GRF registers.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 72bdbcb5e863..1a22233179ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -872,6 +872,58 @@ static const struct rk_gmac_ops rk3568_ops = {
 	},
 };
 
+#define RK3572_VCCIO0_3_VO_IOC_CON1		0x10608
+#define RK3572_VCCIO1_2_4_VI_IOC_CON1		0x12604
+#define RK3572_VCCIO5_6_IOC_MISC0		0x14630
+#define RK3572_PHP_GRF_GMAC0_CON		0x0070
+#define RK3572_NVM0_GRF_GMAC1_CON		0x0020
+
+static int rk3572_init(struct rk_priv_data *bsp_priv)
+{
+	switch (bsp_priv->id) {
+	case 0:
+		bsp_priv->gmac_grf_reg = RK3572_PHP_GRF_GMAC0_CON;
+		break;
+	case 1:
+		bsp_priv->gmac_grf_reg = RK3572_NVM0_GRF_GMAC1_CON;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	bsp_priv->clock_grf_reg = bsp_priv->gmac_grf_reg;
+	return 0;
+}
+
+static void rk3572_set_to_rgmii(struct rk_priv_data *bsp_priv,
+				int tx_delay, int rx_delay)
+{
+	u32 val = GRF_FIELD(14, 8, rx_delay) | GRF_FIELD(6, 0, tx_delay) |
+		  GRF_FIELD(15, 15, !!rx_delay) | GRF_FIELD(7, 7, !!tx_delay);
+
+	if (bsp_priv->id == 1) {
+		regmap_write(bsp_priv->php_grf, RK3572_VCCIO0_3_VO_IOC_CON1, val);
+		regmap_write(bsp_priv->php_grf, RK3572_VCCIO5_6_IOC_MISC0, val);
+	} else {
+		regmap_write(bsp_priv->php_grf, RK3572_VCCIO1_2_4_VI_IOC_CON1, val);
+	}
+}
+
+static const struct rk_gmac_ops rk3572_ops = {
+	.init = rk3572_init,
+	.set_to_rgmii = rk3572_set_to_rgmii,
+	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
+	.gmac_rmii_mode_mask = BIT_U16(3),
+	.clock.io_clksel_io_mask = BIT_U16(7),
+	.clock.gmii_clk_sel_mask = GENMASK_U16(6, 5),
+	.clock.rmii_clk_sel_mask = BIT_U16(5),
+	.clock.rmii_gate_en_mask = BIT_U16(4),
+	.supports_rmii = true,
+	.php_grf_required = true,
+	.regs_valid = true,
+	.regs = { 0x29d20000, 0x2a040000, 0 },
+};
+
 /* VCCIO0_1_3_IOC */
 #define RK3576_VCCIO0_1_3_IOC_CON2		0X6408
 #define RK3576_VCCIO0_1_3_IOC_CON3		0X640c
@@ -1629,6 +1681,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
 	{ .compatible = "rockchip,rk3506-gmac", .data = &rk3506_ops },
 	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
 	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
+	{ .compatible = "rockchip,rk3572-gmac", .data = &rk3572_ops },
 	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
 	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },
 	{ .compatible = "rockchip,rv1108-gmac", .data = &rv1108_ops },

-- 
2.34.1


