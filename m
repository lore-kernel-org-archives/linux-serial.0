Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792599164;
	b=nwkGC2Z0e2qSnTLpMSjlhiosLdL5NfGSqi3cDGspIEKIpl1lb15eWJizVyvitaWC63xi
	 Y4gCeUMLAaU1QCLD2up3k92mSKi2yXBd0OcxbRtdRHNIhbfPBaB47dtizV8A9OpcDDvzZ
	 GgQNu5GL/FEDVC455J0WNgxt5D/Do0+ORZXYg/4S/2m9Z/56ebiJZU2DMY7dP7FjrJCuG
	 e9aVVAZH7FhrTitrZWw90SJCR36P2/JmV2kA57K98okIHYRUtq9yyZwCLJwvU3b3uhPRX
	 vkcA2XN7QXH0cJ4TQljK38FH5BQl0Ozy0gmrykWiSbvR5V2faXJuXC3+7XWfe0mdKxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599164;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NVcTs4+R4D4TM8lWcbqJP0vpXUWnEu+1cmq0y1Lvtx8=;
	b=H5etg7BWCNRxOS2srKI6FJtiXi5Bh6KxHMwPMSZ4JjM8LkrnOTXypn1lXbF3O8robtrS
	 jnAemaqxwnQcYo0wIBGc9q1zFf7pGe3Zokx3vQLb9d2Efz0tEUexOwGgR89RLmj0vxymS
	 Kw3272x/Gsq9tdbWCLFC6mtX6e9bhH2BRtL4CpPlPhzQHqMxgn1xh8zAHEFxFlM/vEy/V
	 nw1efkM5sKTAWa1cNMMvGliunJ14Y0UdtpEmiwVSuasEv1YehNeJnUoZG3SXrda8WWB6X
	 ZRz+UuAh8BiW6k+yL1hlVxzbI6iV5AcKA+Qe9UaBAdowd+219htwcmWj2zDxDeNmwZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTghwV97;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC722606BF23;
	Wed, 21 Oct 2026 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTghwV97
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792599163;
	b=fPHrv5Sc82ae2yut3nO/y9L74q+/EBWjgM49oXB31nxi4Y//p8UNR9VRNELz3adTM1k2
	 GiFCioVT15bJA7GQZczAnO2JpJex2HfKa9th7zYWjn4sOoFsfGqLYrU3JoWJuZ+6tC8ep
	 YBINigRXXoinx3n4Ekfm14zO3u8TFzO8Q0yZN4vH43l07oCOlqk77NAi8dUfXCJ1ePW49
	 Y4C+77y4PwUJMHbn35eqDUcktppINWcdsuhEAAd5mTEk/zkh4e6ELjC7mqqnkKqzNcRfw
	 HCuXOaiQe+IIrQIZzNL+2ZlBxMcrnpcaCVzRPiZUzCW6/Fl/+70spBnB74YZ4fGHvrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599163;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NVcTs4+R4D4TM8lWcbqJP0vpXUWnEu+1cmq0y1Lvtx8=;
	b=O7b+ctrGaWv7AeHDcUFGFXF2Gg3jp52/W9zcXEQzzB5HApIaD/e6NUnbEVwCs8XO7NAC
	 fEwQwhWTgrbEJvdCmIUDadBTstofFxBIJNIntqG5mYH4f6U7/ilkWHLxJBalaAfWIJOS5
	 YzBRh4n7Nm4SI01O3hIFF5/KAPBr1/1c2CGn+onso2mpIXsOTPz/aC1qt8drDNuHRnHfj
	 XQPxW5W8PhAzKjQs763TA0dS7gMpW9HCHqtDLOoNO9RXMw0nbapECfMhGgnLp4mTM1VxL
	 BBfYEXr+JMlhTwEVLcyGoggQkataOzux4AdOo6CWvRWo1knem+1uzKkBEbYoqawaiQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 07F891F01577;
	Wed, 21 Oct 2026 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599163;
	bh=NVcTs4+R4D4TM8lWcbqJP0vpXUWnEu+1cmq0y1Lvtx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PTghwV975aPK1WUIk4zZz3zHOBs420rXRt2hmeuPHj5TQbM5oQR6DbBEPa9mK3WK1
	 X9m0d+10E9LdUxKn26Q2fab55No4tihc7hllRLWhYSzpk77ZOLq6YXJi5pYR/u2iC2
	 CQf2fLBhCSWP/Uvb9wPgS8K9CFya7eYo6j0Ytzx9+CGxPrjlzTnR2NGi5D4vtPMeEA
	 9dFDcY2U5YKM3FwrDDLuxiDw5VIuJtKwMEx2mWk/KPWYSip4sLaA2itHbnNS+3kcP2
	 KLTIjhMwXVYBeYcKZR/VVsPmFK1s1mW6ZgdVvGYHS8JTV+lDNUKWFGiml1v8rHTgYu
	 6hTYIXUPJLAHg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB47A433EF;
	Wed, 21 Oct 2026 16:12:23 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Thu, 22 Oct 2026 00:11:17 +0800
Subject: [PATCH 20/27] dt-bindings: usb: rockchip: Add RK3572 DWC3
 controller
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
Message-Id: <20261022-add-board-ok3572-c-v1-20-0b0fd85a31ee@qq.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792599138; l=2999;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=iT5BkLeeMmmjRIQeuSIycaI/UXplV+prYKUmY7Ulxps=;
 b=v53jOqW6R2n7fnmg8g19Yw7h4T0AjT02bVfEk5sahYgQzXvZmOvgxh+pYAmDqwo1QrriCFURL
 PtaQ5zJEYipCdDZabXmFfxXkC5DXvBCRrr4RHaHwP9Kab8NEfd0cZhV
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Describe the PHP GRF register used to configure the DWC3 PIPE port before
controller discovery.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 .../bindings/usb/rockchip,rk3572-dwc3.yaml         | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,rk3572-dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,rk3572-dwc3.yaml
new file mode 100644
index 000000000000..47ff5e16dce6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/rockchip,rk3572-dwc3.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/rockchip,rk3572-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3572 DWC3 USB controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+  - Cunhao Lu <1579567540@qq.com>
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+
+properties:
+  compatible:
+    const: rockchip,rk3572-dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dma-coherent: true
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: suspend_clk
+      - const: bus_clk
+
+  phys:
+    minItems: 1
+    items:
+      - description: USB2 PHY
+      - description: USB3 PHY
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: usb2-phy
+      - const: usb3-phy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      PHP GRF and the controller's PIPE configuration register offset.
+    items:
+      - items:
+          - description: PHP GRF phandle
+          - enum: [0x14, 0x34]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - power-domains
+  - resets
+  - rockchip,grf
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3572-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/rockchip,rk3572-power-controller.h>
+    #include <dt-bindings/reset/rockchip,rk3572-cru.h>
+
+    usb@24400000 {
+        compatible = "rockchip,rk3572-dwc3";
+        reg = <0x24400000 0x400000>;
+        interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru CLK_REF_USB3OTG1>, <&cru CLK_SUSPEND_USB3OTG1>,
+                 <&cru ACLK_USB3OTG1>;
+        clock-names = "ref_clk", "suspend_clk", "bus_clk";
+        phys = <&u2phy1_otg>, <&combphy1 PHY_TYPE_USB3>;
+        phy-names = "usb2-phy", "usb3-phy";
+        power-domains = <&power RK3572_PD_PHP>;
+        resets = <&cru SRST_ARESETN_USB3OTG1>;
+        rockchip,grf = <&php_grf 0x34>;
+        dr_mode = "host";
+    };

-- 
2.34.1


