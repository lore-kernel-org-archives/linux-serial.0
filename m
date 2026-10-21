Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599161;
	b=RDWW2ptEkuZVsIwMfP24w5MWq4xVo60AsO68fP8UtKlXrZ8hciXOW+H9EUnnTjddneMk
	 UALOeU7kuctFjdRU2s+pbsMqtzKv0t5GapP6CvxMasJ4Vr7nMoOH2t2WPkBZlLsBNfdat
	 UrwiZu1lbqlwmflxnuXMlfzsavqb/KGB70p3b7HpBt9UiIQcRfxAGFr1gTaygSIIR7WVN
	 lIxz4VhEyRMeYYJssAgjqo+uDu+tVTbUfJ59JC282LhQcWF5X13r33qtE1gpwUoWTC/cv
	 e8fpJK9Y/+Ixzgg91MbZW/fur2C8zg2Haa5tiRWfhjg+wybQjNlPtLB2+QbocP4xftA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T34yhw+q6rir5R3L28MrGG/qV2i0GHvwBSrR7IUn5Mg=;
	b=v5z9kxPmoU9BXZ5tqqJKRxDoNuPw84Ez/YwDjnnStyacgkMS8t+54DabNF6Aam22mNSs
	 k2LhAqSEB9j36tkouDGTvPsA1zriEvR8dPtfJE6Zq9hGNiXLJtnjqv37FmUipBK3C/+UW
	 pJXFTeixn0f5Ssm18XhWUawJFho2NlUYF6tCvlvZS/uN8EmM5HTWHxhJvTNY5yyiYKkdK
	 WZMyf7sexPMsyNUoZz6IHG2QEDw8iU0ah63EHAheFkngVtV1XsMx28qlWTx8CIFr4Gdvv
	 W1kaUEQB3dDaqrQ4WVHZzF6q9er585lcVxSjeB/f3BA8e3jxbAO12PhdPZ8Re6cl7qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G23A8IwM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7C60A4AC2;
	Wed, 21 Oct 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G23A8IwM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599161;
	b=q5NrWZn9CnfJmbbCz9WQvgmOFKVljqKOOVctD9C/aVaeL0x+CiIK7+V8l6BJv04ieF9T
	 wpKKqH0SYAieac5dTEK+RiFFRgbULW/LBFqq8BqRV8vDh8e5PQZcWkBwzhpj1e5nxlHwP
	 X/5n43o5dvIrhxLIWygd/ReLt4G/Dsbj/s+B7V/oA0SB7M9zX/iI2edcj7M5byfX2KuDQ
	 UlmMlAZSoaVVxp2bzaoVJWkBaikXgqqXmEtRCyPUoi6vLv4O6AHKCCZlHuA7pnB+oeHC+
	 YvYJ6fEvfSZDZMgDGpef5f8aAU/mXILRTFi/DwJaOlZ77hSSxKPh3KFXB5JVEvV6avw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=T34yhw+q6rir5R3L28MrGG/qV2i0GHvwBSrR7IUn5Mg=;
	b=o7xNqkEbkJh4c2uoFIb3K9iMsJnUOtIkg/Xek4Uywi4+OIRuhWmM1a9aNbsFMoeWJr+4
	 MfQZVg8mI3MvNlQbMEvgFHTO3UL+yNvN3cPHXvc/97mtj+qGdh+WNnR0MPOD0ebGRcYlh
	 W+lZzcD9CoR2Dka/dazBYR+8gK+vaSq0pPT00w/seHJ0jPCavRjQNvt9FDf5JcrnSpgzM
	 45DiggcF+h0z0uDefDNmEBZVtFoSkmysQ9+h8Y+QnmLmwwIR+evRkTHTmIrQofAaAzq6d
	 wYK55DeM0bCXRGppgiA3fwnSvmza7cpRa86V5FsazAM5tFHnWaeYwVTfJm34mVwM0aw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B36341F01808;
	Wed, 21 Oct 2026 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599161;
	bh=T34yhw+q6rir5R3L28MrGG/qV2i0GHvwBSrR7IUn5Mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=G23A8IwMWLA7peJSLgSP6V/9k+JzqHoPZDEyu7MXMzGMWi8pbeKSd4o4S5Xn+ebq0
	 M+J8dyb3ji9SG5jV4wNfqdCKwfLQ0LkygxJg14z/efJkLFLhocQru0SbhT0nL0YcEu
	 2Nc5NtnQdveULO9sTqyhYHuLaj8dw0qodcS0F/beZg8G/YWP8c6VaTz92Q0RW0oPU4
	 NYqVpel/5X1p0jn/ah8DgmUTdeMh0+hdTO9n6oQ/oH4tQMNlf8qyJJ51tVaFXe2iVg
	 8EWDxHnrAEOYW9jDtBprg+hur4yhyMemHtqgj9x4K3bCqwx5Zm1WgDsSde6QuKwZbC
	 4rxCmfjP8VPuA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 98F48433E6;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:15 +0800
Subject: [PATCH 18/27] dt-bindings: phy: rockchip-inno-usb2: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-18-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1216;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=tyofWfbav37+Vx71DGiRjN5QHlO0pDuivMsV2h/GBMY=;
 b=X7DW0svhCUiecPW44r1x/QO9bMQOLqT/ZPKNZt8JawdDT4dWqYtCPC4SG8L7jE/A3RULTp5B0
 V8GymDNGFVHAiQI3zM4SZ4tDEJ+Vk5JN2nsFMXSDqoZwT5Rqo9Idjng
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 USB2 PHY compatible.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index f50fc69fbbe49..9bb9295c332c3 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -23,6 +23,7 @@ properties:
       - rockchip,rk3528-usb2phy
       - rockchip,rk3562-usb2phy
       - rockchip,rk3568-usb2phy
+      - rockchip,rk3572-usb2phy
       - rockchip,rk3576-usb2phy
       - rockchip,rk3588-usb2phy
       - rockchip,rv1108-usb2phy
@@ -253,6 +254,19 @@ allOf:
         clock-names:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          const: rockchip,rk3572-usb2phy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


