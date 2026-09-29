Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1041D4F4;
	Tue, 29 Sep 2026 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663742; cv=none; b=ay4ak0C66ePbCY72+J+Y3rXWisrmsen9+D9DbPapqv4nfIhXALe9GGmTIo4i5pwhQT7LGFacJdG2FbAT3SvtoMTa7l0mKv2URazOzAVL2AC7fFvv7ZDt8yYYe3c9EjsJ72QaUeHJQMoxrU+TGUmgo3XuMIIGnLPUKGxwdnZQ6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663742; c=relaxed/simple;
	bh=zZhjwoVAfzsELfUxFk0opF3soqeVRrcR5j2e50oaQTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndYcuUjZxmuc6GxNFT+aiRfW38p2SbSk28LboKGKpYH5eCJGSWkUBrrKTxmtNOaN1TbeMrL3OTwPsWtrAwQVSnn1qf+SNHl3L2X/xJchv/ay8HcltZHDoRx7fYawKPuODdQyfro3KKs00qAHsZF6bBaGxrtedBekTHyvh0NzhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMxb0IDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMxb0IDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4291F000FF;
	Tue, 29 Sep 2026 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663741;
	bh=z2AGKqHG/UsA+CBxwXm4Xs+da1+7l4bQqt5uAiwnyZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gMxb0IDutUsTygy3vWlGjnapMxUReMRrdMI3VsEQ+o71SMPS9PUddSdb4x99ucrny
	 ZNslnbEkcon3MiI/fXrtaSGdwN8W8FARUo9GoGg0lTFrU/wrrkbTF4Tc5YSLl0iwAp
	 DS73l1+Oc4mN4fek0bPz7M6UTIGgcD6O7j8nbM2xc7zpZJ93fzjvN8dc4Hnz3Jf9tQ
	 QHk50OcHPQ9c3In/g7ULKARijXMcSNbBABLqB6x/ZOfnRNfOGXTWQMPBTx66DwIFZu
	 CWKEWFURRCTWkL9EqAUgySPsZatSUPFHFh8JDAnqiPVlLQdDFlQrkyS1m84HnzbfaR
	 +fa+2uDeRO9Fg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/20] dt-bindings: pinctrl: berlin: Support Synaptics SL261X SoCs
Date: Tue, 29 Sep 2026 14:14:10 +0800
Message-ID: <20260929061417.20733-14-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the dt-bindings for pinctrl in Synaptics SL261X SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml
index 6ace3bf5433b..fb60a310a24e 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml
@@ -37,6 +37,8 @@ properties:
           - marvell,berlin4ct-soc-pinctrl
           - marvell,berlin4ct-system-pinctrl
           - syna,as370-soc-pinctrl
+          - syna,sl261x-soc-pinctrl
+          - syna,sl261x-system-pinctrl
 
   reg:
     maxItems: 1
@@ -44,8 +46,10 @@ properties:
 additionalProperties:
   description: Pin group configuration subnodes.
   type: object
-  $ref: /schemas/pinctrl/pinmux-node.yaml#
-  additionalProperties: false
+
+  allOf:
+    - $ref: /schemas/pinctrl/pinmux-node.yaml#
+    - $ref: /schemas/pinctrl/pincfg-node.yaml#
 
   properties:
     groups:
@@ -60,6 +64,8 @@ additionalProperties:
     - groups
     - function
 
+  unevaluatedProperties: false
+
 allOf:
   - if:
       properties:
-- 
2.53.0

