Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD7438495;
	Tue, 29 Sep 2026 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663792; cv=none; b=TU/jNv6m6GiY4edtsoZWhzROrl//nOdxrF4YPeUCO2pfvfxqw+gs0WxloWxfStVeZuaqtc3K2hOOW/J7LZtC32AnCzWAnC2Ho4iG7/+m+At2TclONj0AoIhFnh/yZ294eb6oB9SH7PbZpgTHNUif8lpMi9cuDN8n7ebwSk5uU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663792; c=relaxed/simple;
	bh=O29b+GT4Ll0witNKFr3qdQKjp+kOp7cT2cLzKE3vawM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHyDJEq498SsBkZehnjI/aPcdfxnNUCILDko6JXs6I5pOD6sTh2H7CVliIZQiEf2GiD4j6te4npE54IlofGRCWNyRG69hbdA31B9jcck3ExvqFpAaWZ7UISuCxAnsaRdSgF6HbfYt4R4X+MYIzgdv7fTb+5z1Emna0782UANUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMZXwo5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMZXwo5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C31F00893;
	Tue, 29 Sep 2026 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663791;
	bh=ukhdfHyooHk8uiIysY2W1PAtOO+m4p47/3kwBKFwiMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMZXwo5/TTzmnHjpbsbm3l7KD6qM7KYF9QF4g620SRTncw5OKGs1mZUUmsYgB+naL
	 t9j84UdGUdJuHVk8u9lU+mxjvDkO83L5GK4ltsox3xI6XaAEVbcsW6DR9ACerrd/g4
	 gWT3S7F1D2jSkAlQvJSfeTZIXzDIu/SVaU/kjadPzg+KPpDtDtNOPklxhwJg2V44+P
	 EtpEZzM7dllu2b6Oj0PIJUx5eUj8vZH1RKJzzPzEren3e1p0pev3IxYfBquntC/9/s
	 FbU1dD1QMIkBsqJ6fdUdtkrD1mAlSWwM8hyVg1xwAXU+YRgsK9womFbwc1P9EhO7jq
	 9qesGOGjsEwEw==
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
Subject: [PATCH 19/20] dt-bindings: arm: berlin: Add Synaptics SL261X SoC and RDK board
Date: Tue, 29 Sep 2026 14:14:16 +0800
Message-ID: <20260929061417.20733-20-jszhang@kernel.org>
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

Add devicetree binding for the Synaptics SL261X SoCs and corresponding
RDK boards.

The SL261X include five pin-to-pin compatible SoCs: SL2611, SL2613,
SL2615, SL2617, and SL2619.

The corresponding RDK boards are based on the these SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/arm/marvell,berlin.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.yaml b/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
index 4e8442980dcb..30d94059e2f2 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
@@ -41,5 +41,25 @@ properties:
               - marvell,berlin4ct-stb
           - const: marvell,berlin4ct
           - const: marvell,berlin
+      - items:
+          - enum:
+              - syna,sl2611-rdk
+          - const: syna,sl2611
+      - items:
+          - enum:
+              - syna,sl2613-rdk
+          - const: syna,sl2613
+      - items:
+          - enum:
+              - syna,sl2615-rdk
+          - const: syna,sl2615
+      - items:
+          - enum:
+              - syna,sl2617-rdk
+          - const: syna,sl2617
+      - items:
+          - enum:
+              - syna,sl2619-rdk
+          - const: syna,sl2619
 
 additionalProperties: true
-- 
2.53.0

