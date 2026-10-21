Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599163;
	b=a+kP1Pi4vt/5Ag5MwWismfhlJhd+diUW+yvA6JLkbHuj7ExILRlOPfrjVpvYwgp/SFX8
	 V2N3h7EYvM/itpejco+kV9h+uRkuF/vFycJfZ3VgGPVDvcsMtVV3T41SLWrzxTWQTiWuY
	 rX+RP1pc1QCB0MNZRlMb8VgikvFnm/T4TVzNaRLSk3FluNP/a2PkItSYu9IrdA4vFs74F
	 DW1lPG3y4ZjcO8K8hOzpp5x7OzGeIUY+fp3OKiFnkZDsFaNdos3UyG6UllklHCWBc5cqP
	 z4IELbf/LcsLh9JKauP6quAeic1G/rxJuiTdi3elKE+mllys3TLOzm4cEXYHZeL2lZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599163;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j4tXjeXuIFwdGre8TfOudfHUOYNQAoGCEGDBy7Hf0QE=;
	b=pZXiY10lUCcJTJSzjeDRVs3X/v3MCDMjzhOgnL22XWypdNNZVL8J75crdWJhu2i2UKha
	 2/JNpE54jlh3sbkseiNUbCyd+bQ0p2ruHq/7JrIadtcEc/ha/E0eJnJyrwnm6w6jQrqhS
	 al/Iept0d8Tmq87ra9GzMyR0h5uCiNSeKJiBkuM1dcDDtdEaeEkJ8J8upQ/tEo/dReHN/
	 ol3Lc4riHmqhIwYLBJfPCtg/fxw8PtFIbeIhZ4TErQH1VFklMa30ssuMd5GJv0TECfoWL
	 h81eXYOh16o21Fa27R+l+5rNHxsYOIDYNCgsMdlgekDtj9BMBiuW6JEdLalb20UsZAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMD32Tl1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A2606B6EA;
	Wed, 21 Oct 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMD32Tl1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599162;
	b=ozi+IGjhvg1DNwW+GXqGyhmUskXwOPp6KkSuEMiqL98XNo0+PwMHaCUxFQkG/0JTPG1o
	 HDlAiBNWWKWPBx9THW9mVZQeIS1kfVzDrI8RO23slBJdYNxE2yt/7SAP/np7Uzq6SeUCO
	 apywn4hPjG5Hbp5Y4kLA7VT4giSuc/thKZhx5T5SXJwu5xNbBF23SwxwH69/oqAHLUtj3
	 L7CeJs8bn+35M2G7kowYPwqC+cWBM2cDoYTWgAd2JYzOkbvL1jwJGSnOTlPZ531HzTB5g
	 JsNH4CvEM20CDG0JJCKya+xAyKh+Y1FeenJO96ixtRb+o/SOD26qqXYlNUh1FeP3glA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599162;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j4tXjeXuIFwdGre8TfOudfHUOYNQAoGCEGDBy7Hf0QE=;
	b=AQb7AJxif72qxD9iC7Z37Is4wpx9u7nw8aXhPn9i8V/KqSM94Vw7jkAhSTTvbuUnnHUp
	 ZreEbLhNNuXCuye+aSqw8jNv9C0X/QwhuETuQclfZQV2EDdJkjZij7sMXTLDGXMqdAdo7
	 tsjBZCIv0OehCUTXpAsJOFHbtk3o1Xygd/M3syVfHjE59FNB9p29n8U7OpfkFbmHK7tos
	 HofDu+trSHIuYvkXdJmrbWIMpealCT1803MEsUzvSE2zVSB+7iohZOx95Fp1jOLKLjoEe
	 I87lHWT+0yNOxVS6XwaQHlHnyjVqR5vbI3kjVUUij6hqc2Yea9OXTwphRwfTgKo5RNA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 633201F01803;
	Wed, 21 Oct 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599162;
	bh=j4tXjeXuIFwdGre8TfOudfHUOYNQAoGCEGDBy7Hf0QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kMD32Tl1bXFd1ZAqKdiO/aBapM3LQBXT6EpvcIvqoiQbM5TLTvvvj2bHLXBcXRLjJ
	 JtSnlDuVlpIUmll+KrdRfwrqb+C6aBnKAXG1VppnpPe9g+e18uX11v98Pj3q6nVton
	 b08JfsgSIAj/SpMGZT/Knj7neBIq3g1BHXo72eGNlwh3owKu4GSl1VGi2J9SpEn9Lx
	 Eh/cRFdZcftddTODB1zZ2E3n64erA7ycItOCoJ7Q/ywTJcc6YdJ8rHTHIht8BLvwgH
	 kvBxEd2piQLANRUaZes1PsC9CzYAJ+Gm/sAuU9/T+RNm+y2EgwamsWe6yp/vPVctFY
	 xk7oiaCJ6t2xQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7E6A8433DA;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:12 +0800
Subject: [PATCH 15/27] dt-bindings: thermal: rockchip: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-15-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1043;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=7k7vf74VdFarETYGBuBSnEXvPu9QBBXuBjc821VO3k8=;
 b=MiGBFVzdbKwSSpjdPn72pCR5H82wS/DLvQWUmjMShXqg0Rsc6AzPpC2HrRTVBRF2Se/JOaBPd
 b0g0HY0FTWOAOGDZRcF41L3Z5uMMjOioB4NkawGBAoyJtsTxdHDxs9Q
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 thermal sensor compatible.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 9fa5c4c49d76e..7102a581ef72b 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -21,6 +21,7 @@ properties:
       - rockchip,rk3368-tsadc
       - rockchip,rk3399-tsadc
       - rockchip,rk3568-tsadc
+      - rockchip,rk3572-tsadc
       - rockchip,rk3576-tsadc
       - rockchip,rk3588-tsadc
       - rockchip,rv1108-tsadc
@@ -151,6 +152,7 @@ allOf:
             contains:
               enum:
                 - rockchip,rk3568-tsadc
+                - rockchip,rk3572-tsadc
                 - rockchip,rk3576-tsadc
     then:
       patternProperties:

-- 
2.34.1


