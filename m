Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599162;
	b=AYmMC0ez16TdpFnFtZ+YQC0RYiTVmwusm3F8f6T4Rkj4l2oswBwZ7P032jXn5xHMkZ1f
	 qUg3nLEIvhEhVqbberO5QI8K7jVZw1xzDTe898JPVHA9GlOQoczmHDy04PAlSr3M64WHc
	 uHRWi2HACD9fcChDI0Dl+RnAQi+bG/WO4cj7EdMh76F+6BVPgEDKngHRSxpIA+0UnAVTH
	 qv3JZTGvAnulohBNd1VhXLhGz42Ss5FKb6UvfLe+lI/maljqmZZaS8+uLaCtN+YMCjz9Q
	 cw6aQPPwGEkqH5f4Y4iM0GK+I2wzcZbbUqGD8OROR/h3PAB5JYoo/bNhdxSwO10ZwkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599162;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ghjDVnN9LsVPKNNzN/vbJQ3mpejB87UEXyfdI53eas4=;
	b=XEggFpU4PaxtJ5ge0WmgsuEJHNSjPJoNqXj1sW1eWI7fZm/sCRnf8ySkjtcoAVPX+KrQ
	 46tUrQT9dhleYv4Em44/IrhfpDtT/yrJqKaC0v8/8B3G89SnefUQZdyl6ywQ6D6pV7dx7
	 +ehYPqD4HjnxNfUt2ns47dvYIAzKe42grJ7UQVO+s99xCfDKZGd1UOlLcgQp2+GU+/a6T
	 jxZZljFLqZNgRjFYl2zPrkXBY3usEbcH9xIk8kb3CvaFpfnFEcLXoqMb/CIXwIBhRkBPa
	 cVDMq8s+lMXzd0sAa7VH9nRPR0cl51ONMre4rzbN1/y/vFEj0EnVJD5sDtIrrFYTTOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OS9FO8kp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C47606B6C7;
	Wed, 21 Oct 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OS9FO8kp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599161;
	b=Vs2oLdwdtCxG8VhdrMLYaz0vHi7ljSe1TB/uRxUNjqtpPMWtThFaYLDZCGWNT84LUlEd
	 /YPxYBskqqNeAnpvMvfzCGIblJFPD8jcVnzfGJjIX54ghZ1lV/brR8XRzscr4Ddgdu9bd
	 QSzKFlwCpKskIWqxjHjIUuK3mWd9iwGrtgGICOARchQoEr/6/FxQix8PrZQjDzQBGsGYE
	 qZ406cElOGCXuGXCTpdNYPnPG4LyJLpElu6uapzuHmnY/ehG91kL96Nw5Tssh8RnOLF+q
	 gXkiai3aT56syhgfPDMthjm/Bp2JpuUVwjIrZEfFQidKdjr8OBQ8x+GvbbeD1qvFXIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ghjDVnN9LsVPKNNzN/vbJQ3mpejB87UEXyfdI53eas4=;
	b=2qIBjOX/KZu0C2VsLSKivqhFqBDOayBfJM1eH8JpVFrepZxVUDdm/HzH8uu95FL3ebaN
	 fmSDhzsIZ9bKXBdsDCypo4VwgLouJSD7zw6eLqohAROSkMztL3ZErOFlKCq6FI6d0adzM
	 l0QpSwGthT/demeOEbXIFXTk7YHwqimyhAeku5wpCLZdctlwKAC2sDP1BqlePMZdcCyj8
	 jQShBvjy7mUfaaUMqQxkvSLkQB6vd5ud/5Sc+QLv/mVxjDrswT5OUt8heGAGkm+vERaMh
	 vwUQbWR30xCj+RYyyLDLuHVjHZwkcYte8IFp55rN/D79zyy7MVeG9UqQ/BsFnH3sYMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0B141F01801;
	Wed, 21 Oct 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599161;
	bh=ghjDVnN9LsVPKNNzN/vbJQ3mpejB87UEXyfdI53eas4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OS9FO8kpM1qmt86zTHj/S+jVXfjlTgd5jVj/LdO1SJC1H/Hh91k7kVJhAwDnqB71B
	 U4rE6MP1xpwayMZl+8yqkpqmqshgVWC3Iad7n9Oo76vsyQBXxdb77TiUOBfiJAA6UE
	 xm1wLXkiK3u47W0OP9/e5XZTuS/Njx/ZxXrp2lVa0HVi3cYDGdFNsXzAEWWXSMslM0
	 IgiVASYBGVFFo1R8FcyUV4T2trX7mOXX2zpSR/w4B5VdmtklERh9MaFf/YTBotLNbz
	 q2m4W91n2THiI03gRWwdZWEA/Sexi8EDtw+5bjL7xIMK5aUdOR2Dy4yqiAbsFo0X6N
	 V8W2HbgEtRafg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D084433D1;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:10 +0800
Subject: [PATCH 13/27] dt-bindings: mmc: rockchip: Add RK3572 controllers
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
Message-Id: <20261022-add-board-ok3572-c-v1-13-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1519;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=sQ7kmloA49WrSzIqOzAxP/3d4RkCk4R1kcxdgqDQWos=;
 b=pqqKJGkd2U1YPXo/wn/BctY3QQzArrjEr1/m2ewIpOrS/UlTX1rRSsgpmqGc85FC4oFNDXrKO
 nVCbtKiT6XzC4OkVHRePSPO6HPP3iAfEoFVxQaAbRErJlDoPQIpFCFT
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 SD and eMMC compatibles using the RK3576 fallbacks.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml   | 1 +
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 21ecfaa454f45..08db29af3e969 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -50,6 +50,7 @@ properties:
       # for Rockchip RK3576 with phase tuning inside the controller
       - items:
           - enum:
+              - rockchip,rk3572-dw-mshc
               - rockchip,rv1103b-dw-mshc
           - const: rockchip,rk3576-dw-mshc
       - const: rockchip,rk3576-dw-mshc
diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index cd823a3ef2130..a4e04fedfd33d 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -13,6 +13,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: rockchip,rk3572-dwcmshc
+          - const: rockchip,rk3576-dwcmshc
       - items:
           - enum:
               - rockchip,rk3528-dwcmshc

-- 
2.34.1


