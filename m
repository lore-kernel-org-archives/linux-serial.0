Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599164;
	b=XGM2br7qjuCmIonRGKqiNLZPIhNIwDZDexuCpa6TnYof/7A/IpVuSFw+Hn76seNxcEsr
	 y0zUKYcgYybJRNS8cB57uVkt6jCiEl7tQP9zjphpuCdf3siNwstbfBeTtsrFHFDirTd5I
	 Hw5TozBWdh1aAE6U1owp23yGZNUw1fKGMJNjhbREfLPklgfgEuFe9q8AbUtbtbT2qoheu
	 TtGT5c5JJ4+zhXJDt9Wx+HgHzRc88Gq3kdoD3Zzvzust5LRf+r1/bz1S4i94pAPp3vyL4
	 tDTIqTc9fwHgziKGEPJhHwFFMaMDYb7tbP6J3oQSUuAFpWLEPmWAqBGrSblFWpQX0Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599164;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vvkmrz90lF2pcovbtpnAs1y6acEdyFSaoxmdLGdJVnw=;
	b=mkZ5CiySl08Dq/im1mgC+WCBMxkQBEzuX/GGL1KjA5z2LzizneMxde4bN0bU6ehK0pnK
	 LrQf3OYbuQVXKaLGdUGQtjl3wo6WvaN861//RuJrNQ85Hs/Dh7LVL8tgbxg5Q/4lD0Yqb
	 4iUy8NDCeiCe1BVi1R586pyRbtWGPigA3VGQ1vUsPYuWZyuYX0ANsvZtRYAYwvFa8OxAo
	 Jh+wML9Bqi5uDxb3GDJhnRga/K74NvL3Em+1KZaqNU+e1TKsC/DmMwL7tTRCzJicp4+P7
	 IS2oc9cWgukYBnYqEXKsJ/JhE57zgxooaOP83g3JHomIDdti0yI+pNp3++WYU2dF8gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8tLQhpK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252E606B6E9;
	Wed, 21 Oct 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8tLQhpK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599162;
	b=hRjwswsJ2cA6o+Uu2TY91mTkXY8krS0qaNXTERwhDU+/Nqd1mbPlts3A8kR4iU1KxkmP
	 TLUUYPyiGXwCJn/wAqe6a3Wl1bsJ+8Dr2jjN2sYHVdCyLi2earaQ0PkcGr1FTT/rhfdej
	 uMWYyFQp59A75XQi/O52ejHFsrDjpcnurIBtHzwLDlafktqvD5pAvKMIAM3Q8qwqif+4U
	 SHcq0xdVl8zhN7trzGfXZ7kGvHhGM1ly2A9FTrZLI9QHweCgg8k3q/Zk72/FRv/i6R0hX
	 Ql03wX14U05g/viD4/zfbbXYeVVKX1RmpF9+OBDWTJTYhU4I00gw1GD+jtrq/CI2sbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599162;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vvkmrz90lF2pcovbtpnAs1y6acEdyFSaoxmdLGdJVnw=;
	b=HGqI/nBofxtkCG2a+eeIzQi92jI6OysttejGau4ZylA9VvBQXukfO+rJ91pQLO876i4X
	 RhCw5cXa1Jf7cunmA8su7L8ddh9NYMi8YQreZYtOQHRDdXGb8VCIKE0yK++lrjVflT9G5
	 Mq/1V8XOjH7AKZM6YhLS5JSZ2q9g2CeUfCkedjuDDY2d2ekZYpPLmu7yZuAkJb4ht9ZiM
	 +oRN/+NPFXW9KIF+PdplijB95Cy1BkJTrLT5++0rqvM9L7N47XpPlleRMGcRPlWYkBELJ
	 vyr87sdjYI/O1cXO8ig91qKDydSABmLI8AcG5cUwMKZZNF20FOOl8m1CDsZL2+d8r3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D1A2B1F01578;
	Wed, 21 Oct 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599162;
	bh=vvkmrz90lF2pcovbtpnAs1y6acEdyFSaoxmdLGdJVnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=e8tLQhpKYQT11o2C21bKcoAz6SfUW2e5dWrhH6ZHpn1Ot1WA9Me3qyt7RXaL1kDsc
	 uaZEX+IQyFIqWHmlGacFLu+btMD2o/ndxPklWJIvRPiW2YvFI00ZEm8vzgV5SI4q+D
	 RpRJJjPNj2zsEy30qbFt+42+o449sP8woMZQCHaT1ijilqLzgRD99B4v1UtUSXImNb
	 x28QitWcw0IF4ouE33JB2yufTTrBQEQbKMROqH7Lj/p9sIPQ27MQ/bmLnuQyzArE7r
	 MT16wciBoGwR+P1uTxF3KNSv5XUJmLtcBLv/S3azjIErQ9a2M991Ch/M98MIuTf6x6
	 4HSOrtvJBgshQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5C0C8433C9;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:08 +0800
Subject: [PATCH 11/27] dt-bindings: i2c: rk3x: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=799;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=Nx7+ntMd3JyypCSa/70viO2nR8hCpuFBxGmHD3dE47Y=;
 b=vZBl8Zt+3PSebnH2r6ILhisukiqHp80fAWguymShkduIHG3cLZaoRezGCGlFih4pVzb/lfVDO
 EGF0Q9iKVaBDbbgmigC8Jx1ymQfI4QjpxwQrw1EM57mcUJ142fiq1oS
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 I2C compatible using the RK3399 fallback.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 91805fe8f3936..bec2b9cfdd118 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -41,6 +41,7 @@ properties:
               - rockchip,rk3528-i2c
               - rockchip,rk3562-i2c
               - rockchip,rk3568-i2c
+              - rockchip,rk3572-i2c
               - rockchip,rk3576-i2c
               - rockchip,rk3588-i2c
               - rockchip,rv1126-i2c

-- 
2.34.1


