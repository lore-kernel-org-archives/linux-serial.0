Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792599167;
	b=unDQq/dHbzjXpxtxm1D0ponNGhK7hn9M3ThDyeuMPPCk9Cn6dvLAG0Tys3XHC1S2eNPH
	 IWKO4FSUD9ov5TudpdoHEQN/AF/Lmbw0NOXLcYhg3Uz+u0HTS5dwVTAweZ/vf4JMuHhOR
	 8kwcF//rAH0DlE770NRqOzQm9Fg9ZGNo3jTkv9rkTo/ZRB6hcWEjHpfXHyLoCUp6Qlc9t
	 XIvTMUAhqbcoibtGpVELat6RH3LMstwV6FB6cjVA/Eme0Vckox82AzmCe+5jWvf5iVgUs
	 GElr2LSHkbt33WPRk/AKHi3xYjq2zoJukzDnreRKOwuH3f4r+fiiYZ5M4wMkt6EYvhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599167;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WY4ZEuURDiNmK6i91k8nTN7t5MwK2F4DFp8c3nugGjQ=;
	b=oZxDILYDNQdbw25YQJJXe0W5+6gMVSj2rTppoCoVH4xG7HjNI9OBVn+kOmju0Ii9JuUR
	 1xO0HhiIcCZwDueGNDzr+ui97c9oHlogSHkTnwd66LJx1SaXcIcIFPIFVwshzOSOfN6ks
	 2yJIw22aPIzCY71t3GQgMK5Zzxi9ZwaoyXUX2WD7p3hDzmAVPRRIyrm5DG0t9HJIySA3o
	 pcYWLfz3MSU5rRFeDIgJrXxfKOCNnC25pBNf5arcyS1JYCYrZDsy3eZ2MTtzXhJe9hsVK
	 wEcGg5hXa//icRUJIwl/MOE+GNB4xQX2nShVJqDuPWVnim3QQ0CPabCuOQCGxs4ud3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVyRte7O;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35424606D8D6;
	Wed, 21 Oct 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVyRte7O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599167;
	b=F1nNxbkL0HCIHcwZjQSrnBoAQnmZ0hnbUS6ou5xBu1fU0qljua5JS/FlpYNeJKxlPQ/T
	 gpOhuwKGvIa1QWJu0FZDr1hb+uJIO5EgLUifpldcTmWRVIlzC72RbVGMUDokKhn/sp71N
	 txvQLQGwdH393iYsK/5wHjWKbT99UrnAaiczrkRfGo7kK8u+WTsNXpYni0vzvYnhXoVDR
	 JbPrlHGlan3ZnT4i0Oy2nK/nG8roqWtpz4WPvWeBS+T7tyHLdaL8pqPvDn3hMMsrp3Tw5
	 wZfx5dqq1yS4fARMcOaL7gfouXR7rVP+/Sfgt/FVTOqFh60c58/H6usGuuDJ51fTDYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599167;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WY4ZEuURDiNmK6i91k8nTN7t5MwK2F4DFp8c3nugGjQ=;
	b=nQK8xh/DjcgKgmyia2+vsCRqvzAGT4Bd33Tfx5qa9QkSo5gY+/yt9/2CD7EiLKlDjXRb
	 00nhC+ainc8J3SGZ1Ao7K7WxfmjAAwm82tp0RO12GCP9iN9D8KjTmAq6ONAsvXQcPTuL3
	 krzj1MaHiIBq8QuzMHk+z1UucBSrS6g8KsCTQ5NljHnOmUazO+HPQNFq/fcDDKGbwDU8h
	 MOYIZt/7GcMk//BtzSeXTP078P60siwlrg3wxUaBUSUw5lkm/UVueWB8Ow1pspzFrNxM3
	 VL6V7mL5aiy5m/33Tw7/2KhvL3uVDIx6w2GHTbzoO9yfDTE+3kjL9FGYSZDNPO8EPjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3020D1F0181C;
	Wed, 21 Oct 2026 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599167;
	bh=WY4ZEuURDiNmK6i91k8nTN7t5MwK2F4DFp8c3nugGjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BVyRte7O+s0++5dHWfsecjHtxug9ZFuLNSJ9tEbpqdN3rEOmIXTRwdcShlfdnRcvg
	 RP6yK38tDsVfGtQ2F7fj4rsh3xSBFXxzAXXHbudwGaA6y5Mkltj67ytYXOXF18xCrh
	 eNIQZb6AJsHHtrgG+OKKy78BOps1665649Y1czPC9ecbeF5+f3vfHv/U3KjWCbnloj
	 hj9Di+cTZeO9fQsCtsqtTrwygbypjBGzGW7WMMSBEDsPYZl9ljbzgg4ZaLbUuMYdu9
	 Rqk+Agz4vTCPYgBS8q78o+4T00PfCjZWZ0rPpCyU96iQHDxfX0mw3pJWRj9MG81eWA
	 2UKlRzB77rQrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D927E43404;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:22 +0800
Subject: [PATCH 25/27] dt-bindings: arm: rockchip: Add Forlinx OK3572-C
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
Message-Id: <20261022-add-board-ok3572-c-v1-25-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=940;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=oauBPTMgwrpEfcYOz8hlG+zW49i1/JZ++ifkxeoDUZ4=;
 b=n2lIa41639g6ID0rghs3WoNNMv7QeAjmDoPk8c0SVRA3+qL8scQhxIssd4e0qw1PHqJhVeq/R
 SluQoGY23TuBCWO1u9LnwDxY6ogyJVzIFE5riu34wg3crDq98cgOfX+
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

The board uses the FET3572-C system-on-module and falls back to the
RK3572 SoC compatible.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index a799bb843f74..2880ea741e73 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -331,6 +331,12 @@ properties:
           - const: forlinx,fet3588-c
           - const: rockchip,rk3588
 
+      - description: Forlinx OK3572-C with FET3572-C
+        items:
+          - const: forlinx,ok3572-c
+          - const: forlinx,fet3572-c
+          - const: rockchip,rk3572
+
       - description: FriendlyElec NanoPi R2 series boards
         items:
           - enum:

-- 
2.34.1


