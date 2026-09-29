Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B8A253340;
	Tue, 29 Sep 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663666; cv=none; b=bLWfKxQ1f1CQsDUAfNMqOjq7fmHtmgfll+/el3BiTOYW+AfbJK6MPmTygjLOZJiT4jkfuG9UmWKVXlu0aaexQRTFhHoF8nJXoBpB6gmH2dFbVPunNBYc+qkvgdU9gTIuhsuZMIGsF6htScBzEzu4KxAI2R9nTtPGGFumyRSEg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663666; c=relaxed/simple;
	bh=8IRIGclAm54DoEp0GahS/307obJyJf0VFYPnkG3LgPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbTdWj3+Cg/wyH3gQUDJJiic1Hep/7vZFC09xJVWadkGLscJpxIcWeOTaf5E380XBrQgmn8y2BQrSf3OGNW+1WUMMdjSiJFdacNBdVulNDYVZoVVV2A4jY8ifil0Xg0t1cJpL/3Cnd7qsIcYWF2Fe3I426xGSV5SR9w0+cJr2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9tbMXx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9tbMXx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F631F00893;
	Tue, 29 Sep 2026 06:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663665;
	bh=3x2ot6m9D0YAqTNHu1DbGx2MV4wgVy90cyvnp98bbGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9tbMXx8kYcztvxAmoSKjrMNdJHbmhF0a2fkDbNVvswQaRfytD9MaJ0+9MVWqgesE
	 c16Taz6yc8so+gftxT/gl7cGw4zkyeOZpMShoHBINFUSXp+84XR7STtMzUfRgqhtws
	 fyFCjNMdSJZLUluAvcPcLWWx0kravdiFTpD2RVfK68NimB1ncJ9ZjadTT7Zl528dBa
	 /OT9imjGKkkkFgwH/4p9dW6fS5B7Btru1/WdLQj2i1cs5LV22n5vbddWlFTvK5Wvwn
	 0Z86dAFEf9yr7InhqwQKC/hP1Ew8y0ljLy13JIUn14UkLyF7rSmIrnVN0zJVHo2unc
	 SzyRE0sURDT3g==
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
Subject: [PATCH 01/20] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics sl261x uart
Date: Tue, 29 Sep 2026 14:13:58 +0800
Message-ID: <20260929061417.20733-2-jszhang@kernel.org>
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

Add the compatible for the UARTs of the Synaptics SL261X, which are
compatible with the Synopsys DesignWare APB UART.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 664305de4986..7a80357230eb 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -34,7 +34,16 @@ allOf:
       properties:
         resets:
           minItems: 2
-    else:
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - starfive,jh7110-uart
+                - syna,sl261x-uart
+    then:
       properties:
         resets:
           maxItems: 1
@@ -80,6 +89,7 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
+              - syna,sl261x-uart
               - ultrarisc,dp1000-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
-- 
2.53.0

