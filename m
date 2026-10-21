Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599157;
	b=XXFP8B6cTjcg0/C+vrlDHpSzvOLglIjLaHoCB14rDPQ1vSpijqyFSW6PYm5g/NxF8Le+
	 siESTbHgl/WRgNtB+hx8P6WByEwEuhFNm654ASZKRxXyBr7VQ59qVMwsxx7n5yn21whqT
	 cOTfAzyozbb5BwWkuT9TkJqP/92sifIV2GixcHrqh5fdASE2wKHqM7RrMKoy/K5Z4qRZ7
	 f1Rcstv6CgGpkE7lf8BEoT7Kz6hhenoknSUKuGfQ95MtKeC793q3MZ1+9c/nv6ojEEUTJ
	 6OZ/asyaSxrV3MX+qifWHR8/JWwRVkenAixymF5DTJoiGO1JNshu2dOfNfg6V0wc8jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599157;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LOPkZEV6Cm2zaHtJqPrEJTh7x8w9jJnwNm2gyHPm88Q=;
	b=hibf6KV6ClBgS6l3SWmAOpKGCf34yo04loz49tIr33qo/DhvyrPKppyluVfQiOnZnTG0
	 xqIUyHPjh4LfkEeNUgvFHdqOgDbALsWf4tQ4pcDg+28v+EcBdnjxGCbFEM4fAcsafbvUv
	 Z8IiDT974ToevFTe7nDfMziY03mu5Lpm0DW+uFy64biDA55sQ/+eRHuGlHajfKP6+ZxxM
	 e2CICDJoCb7Siz7vEXWSLykxcw6iwcH08GsVte4RbQtz4+UwyOmWXRXJR2G8rHS4XYDcB
	 1OIZb+mvYLDCmDeJ975d97h/GG5Ct5w7hJbBFFApUVkyY1feDeu8I/VWmVCgdydY0ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lIP/pfpW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2403606A326;
	Wed, 21 Oct 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lIP/pfpW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599156;
	b=Nn5eN3zND9AO039hVLcakMPEPZb79J5FuAJJg9wL1DPBP7yQX/hgSc0uX1r3rqAR4Cnj
	 Zn9HVZgSq6eR8/hZmFwkDrp/7PJHN3jBmfqRfpDxx0AnBVuDQp+HsUMheMpNc1kdP4vb8
	 0kgTSqMvswX/d2284L6zOXa38biJfzFzweCxoikrFVloGdPNhDDC9V5HYFEyBqrdsgyxS
	 CIgiosAShkDymQrsZyvaHTk5DpucGToBo9CLuosYjTQeNoM0MMqp18H/oeP4AM77s0WTI
	 Mdtb+UflE1TKVQab72Na/72BNsEe/Io1vCc9SxZxiVTJI+XXFgSKBfUmX1rFUPcHWpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599156;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LOPkZEV6Cm2zaHtJqPrEJTh7x8w9jJnwNm2gyHPm88Q=;
	b=Uu21q7/2wf64uiFrXoNdZJwrOVwYcFIjZzGmHkC0wOpWs2QsPPIqOtZjR3B0nkPe3zM6
	 fruS5f4gxiobQZjwWT5NUDU+QjYXErvu2E+lJMCwpVV3VhLX7CC6MOZYq9MN8A3pdOSKr
	 MpKDhchUb2ApYDveY2ZlD6NFjAUp1rsrVgN1AzcFsR00R+hgq2HmLacJQjoOPfR7r7OlS
	 sd93kfo7cynp7Xg6gJEilap97kEPpm9SClAbG/7nnOqBoBsm6YedCSLge1CmjReSZ95ec
	 G3vhsiAg9NRomluT7L7ND507gXxkf/ebW6YMDZJgpoodl7hwmVXeWC24YcKzbnRNDGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1931E1F000D3;
	Wed, 21 Oct 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599156;
	bh=LOPkZEV6Cm2zaHtJqPrEJTh7x8w9jJnwNm2gyHPm88Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lIP/pfpWUFpy9qgoPyKa4emTxXZ8kgvTtxk/JSQxpcjWxuQ1p0JMiS7no4f7ReuLF
	 Efc2wUDXKVdgYuoUNRPt6cFvm61HLeeMbEjy6cD6phkgcWQqV3nD214+6jX8cN7/d5
	 gSA1k9h306xntCtJhd52XmLgketNv1oE6f2fPmjvI1FRk0dqpCYWcUyHV1axKPfygT
	 qSNh5rO4QL9AA0JTFRCExo9biKSvumcMnCVXUdm33hhhIN4DsvgvtDfwekGpSyuqBK
	 EGFycHyjz0OgpyAK950Y4mjS0KPB5yUY1nH4I4kqbmdi5ool87v+hWduceC4gxBVoc
	 bU44WzJhdyZLQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 75B1F433D5;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:11 +0800
Subject: [PATCH 14/27] dt-bindings: net: rockchip-dwmac: Add RK3572
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
Message-Id: <20261022-add-board-ok3572-c-v1-14-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=1343;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=K0gxmniHOFyS01yuDpywB04Gh4PRTh2NilGC49wF0Uw=;
 b=OW/ekGJbf8lwNEJWQYNfv3I5mTkDqbhiK8fSThBAA6vigH0ZL6//v8ZHW4Ee27ozpu2t/IsRo
 PGs709KxeCcBq41j/NY9kIAySAoZFX0TROVz+O/VTBtFCliJJ/ZCfYn
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the RK3572 GMAC compatible using the snps,dwmac-4.20a fallback.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349c..83b0a81b4f3b7 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -27,6 +27,7 @@ select:
           - rockchip,rk3506-gmac
           - rockchip,rk3528-gmac
           - rockchip,rk3568-gmac
+          - rockchip,rk3572-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
           - rockchip,rv1108-gmac
@@ -54,6 +55,7 @@ properties:
               - rockchip,rk3506-gmac
               - rockchip,rk3528-gmac
               - rockchip,rk3568-gmac
+              - rockchip,rk3572-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
               - rockchip,rv1126-gmac
@@ -137,6 +139,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3572-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
     then:

-- 
2.34.1


