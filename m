Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792599167;
	b=x5TOF4oHI7PAZV+AXrsnQXF1d+yBey9spOU9qc1g6NeS+AxD2pCZI4TTO2bdVbJvK7FX
	 Sf34AYcZw51KiF5IBEuK2o8fDWHt6SqI38iUXGnJlkTDrS0+ue8gfEEHZUc/0ag45g0EG
	 l73RGFm/c4/oaVjDH8d67QgOzv7iLpBxBIG2OZERykvpWClk2feKoc8yV1fkc0Zt7pQx+
	 28QxcpCSCy34m+ujSyViAk7pmIjVzgnDtEV/9gTGw8tp6SyplEvB7Cc55r8Uaz5WB2P7s
	 F4BZKMRRwPaqx05MT4sJahfJnu5mCd1+3EoIvhQkgmSzFq22BpkPM7IWgncUi9UIVFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599167;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zkfqLadcVW45KsD7pwMyAPMYqlzB4N5YtGEGlXjDb2w=;
	b=Wb687ii5+rVBLfwewd8j7d2KqFGPjbxKM4Wc/zvEhqHDd0RxR2rnHecSJbmA1uPfbHhx
	 pBttPShyPyO9/kGrQDO1LTq977ZP+Fn+4+d4cznL9/k4OkT5teq3qAobwqY9L5wqaf+TL
	 tOSu5rplNJZvVLHZfC/lOqKrmnxWQafrfEptlhx/KzXt9NqmD22aqKHZDKDkV2LLJkURE
	 NMYNQooID8EexjdiW+OUN0EJO2YNcbTLgOgktrF32ES2Ces73Ln39NaPLUDYDEXSGRTd8
	 Zlp2dK9xggnSv6bUUtIErhz2sf41qA+ibPjxzMgUCWJhzjeTo1DJBcuZNzNV3CI83Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M48rDTx1;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D40606D8F3;
	Wed, 21 Oct 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M48rDTx1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599167;
	b=3QLD1QgmI5EgEMD8kCg23s9+QK/Ef0iCiyh5JtBXdH8TysVAsNQ6DE2u5oAClVU8jX9+
	 i2W+8n7aLF91qkksPcoZzCqRt6vFwpbqVlAeyHXeFs4o+Md15WRA+cxV8O07v+fitO7yB
	 c14xQDzWnWwA26BU0HTbf1GNM8JlUiM/10ghLTfa+QqkRAI1MHlWZI2PQE3JnUx8oNxfU
	 DGzY4jJAyN02kTBj0TIoIYoV1AGJox5WqfHY3lYkaLYI6egZlKR9TqHSp7spJi+Chl99I
	 ELrI1tX7eb/ZOHzocWCOXEIeFMPS70ZQVzdeNMalw1cBXKTXU2Jp0NKzd4c/78PQvSg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599167;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zkfqLadcVW45KsD7pwMyAPMYqlzB4N5YtGEGlXjDb2w=;
	b=K4VSuYS7lQqJ64BRhHsYTeKjjLDMfGUJM8NJ4v7WG/ZW9y3ILcFcWHQHZEytDyTNmTGJ
	 i6QyPviqV9Nofeo1jPdXuk/12KfMcO1KAku7LC9mzcVn5BsZ+URSQbrDBJD6hhwzXrl0Q
	 LW0asY4DtH8UG6XRfLCWIRqWJaY4jiABHrQWQQFnvOuUvs052A2X154T1IePHPTlf8pAT
	 PgqEW5F3PqYzP0VX5N1cOJoM1alqA/+vIpENgHfbmbA71at7WgYIIdbAm49ZrdUTSjGp+
	 af9DdkgfX/e7fDwQMXMeg1c3Fl9iL1mU4L3gSK5BGt28PDEMT12ioBgZlI35BDN+WRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ECC211F01576;
	Wed, 21 Oct 2026 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599167;
	bh=zkfqLadcVW45KsD7pwMyAPMYqlzB4N5YtGEGlXjDb2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=M48rDTx1fwShvy6+apX7Zah+Rc0dXmI3+aTBad4jiPlKp+RM5xabZDeBQS4jRO/s9
	 RX8Cw8IG3FrKg2zEBFi+Mu0RXrZZP9tueEAxFSTHLAWpaYJKHMQ5yHXRxoCcbzCd0Q
	 qXy8VhZBdy6WDYpSEwwj554c4mRv4k8JulIGNjlDyTNH8TO/w71vEPpsMmuvgL13hb
	 YW6r+hnHTF5qeoR5pHgzHvZ2b5szI43aGqSRTIKMLecXSxvYUcpBSSnsnl2zLO7bNi
	 fr5f7iY2+q1+UQQPVARPMGru8AIvGJeUzqFg+5GZBfXNliq4ggaSS5iRTkJam1Tioq
	 YtMGbCui7G4gw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C7A6B433FB;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:20 +0800
Subject: [PATCH 23/27] usb: dwc3: Configure RK3572 PIPE port before
 discovery
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
Message-Id: <20261022-add-board-ok3572-c-v1-23-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=2530;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=h5W+2vCeTnJq9csdidWq+DAD3u6T94cfAIF4kAYsWso=;
 b=JgKhkQkYYvj1vSafR0hKio8ahXnc0hk8CyRtyjQdwxIIZQYev4aN+8zACYBJOUlMgSQpvu3SB
 SOO/YLIkEiWDyGdl3tkSvR9xQJXkTc4rP1GaSxaHL42QX07bWlQbOdt
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Firmware may leave the USB3 PIPE port disabled, causing DWC3 to discover
only USB2. Configure the port before reading controller capabilities.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index ca69ac0eb07ce..11e71fc76be1a 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -22,6 +22,10 @@
 #define EIC7700_HSP_AXI_LP_XM_CSYSREQ	BIT(0)
 #define EIC7700_HSP_AXI_LP_XS_CSYSREQ	BIT(16)
 
+#define RK3572_PIPE_USB3		0x1100
+#define RK3572_PIPE_USB2_ONLY		0x0189
+#define RK3572_PIPE_WRITE_MASK		GENMASK(31, 16)
+
 struct dwc3_generic {
 	struct device		*dev;
 	struct dwc3		dwc;
@@ -85,6 +89,27 @@ static int dwc3_spacemit_k1_init(struct dwc3_generic *dwc3g)
 	return 0;
 }
 
+static int dwc3_rk3572_init(struct dwc3_generic *dwc3g)
+{
+	struct device *dev = dwc3g->dev;
+	enum usb_device_speed speed = usb_get_maximum_speed(dev);
+	struct regmap *grf;
+	u32 offset, value = RK3572_PIPE_USB2_ONLY;
+
+	grf = syscon_regmap_lookup_by_phandle_args(dev->of_node, "rockchip,grf",
+						   1, &offset);
+	if (IS_ERR(grf))
+		return dev_err_probe(dev, PTR_ERR(grf), "failed to get PHP GRF\n");
+
+	if (device_property_match_string(dev, "phy-names", "usb3-phy") >= 0 &&
+	    speed != USB_SPEED_LOW && speed != USB_SPEED_FULL &&
+	    speed != USB_SPEED_HIGH)
+		value = RK3572_PIPE_USB3;
+
+	/* Configure the PIPE port before the core reads its port count. */
+	return regmap_write(grf, offset, RK3572_PIPE_WRITE_MASK | value);
+}
+
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
 	const struct dwc3_generic_config *plat_config;
@@ -231,11 +256,17 @@ static const struct dwc3_generic_config eic7700_dwc3 =  {
 	.properties = DWC3_DEFAULT_PROPERTIES,
 };
 
+static const struct dwc3_generic_config rk3572_dwc3 = {
+	.init = dwc3_rk3572_init,
+	.properties = DWC3_DEFAULT_PROPERTIES,
+};
+
 static const struct of_device_id dwc3_generic_of_match[] = {
 	{ .compatible = "spacemit,k1-dwc3", &spacemit_k1_dwc3},
 	{ .compatible = "spacemit,k3-dwc3", },
 	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
 	{ .compatible = "eswin,eic7700-dwc3", &eic7700_dwc3},
+	{ .compatible = "rockchip,rk3572-dwc3", &rk3572_dwc3 },
 	{ .compatible = "starfive,jhb100-dwc3", },
 	{ /* sentinel */ }
 };

-- 
2.34.1


