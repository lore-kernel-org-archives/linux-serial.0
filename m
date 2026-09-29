Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE973D9DB6;
	Tue, 29 Sep 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663679; cv=none; b=QZAiMHy7OsLar7kko5q0n6XU4gtYrxhbrWSsJQNn6Xg6BaGZBoRwlHEyTYdBd+yDZK+CahrMVH+yLdJUVVkRRwNrtYz0DoePTrrl0BvlznU2c+v9MoN5lk+avKPShDP80yG782MMhtWNQ4OrinSc15BWQ0BS+TBdFvWoWTC+wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663679; c=relaxed/simple;
	bh=E2XDbnrlIIkDGqqWI7V6x9jvXg5PJbcXk85a4ZmSI7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx1c9LUa31ArQ9MenlJ3jKSKWzGqufm8pj0KhgfKks1TijE5SKljwQ4ctEgcEl/yPQyqmGW2nr6aB3F0GkfBDBuQidHFJLpWVZb6pBNcnFHZ/lBU4JQYztr5/KHBg8H48Rr4oyiPIQT9aj0D08LZaHcJdrJzEalIN5LjZcgocmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIWlK7cR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIWlK7cR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE21F00893;
	Tue, 29 Sep 2026 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663677;
	bh=BjWubQDEwzkTNxDwhBXrPCAtpvohKMIuJsfB/7fSVhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIWlK7cRn+wmNif0WwVG2cvDTmLijVqigoKVlGa0NWpYApY32nXw3rlAbBSqXeByG
	 N9tzOHiTZMqGH9FrL0Ifpc2qL6Vi5eavWG3dUqDl5RYg7eOoHx8i8y1gCnv0j7S+yM
	 wkLNDnjqxfeq7kmtJBsSq7LvciAt+wZdu7VjAKq4wtdD3r5zJaberM5ccMhayTDC5j
	 2S4YuyRnTTw10Ihd+48YTvnzJni+J9gCf3G7vUpMiznxnJnaiJPIw++SxpSqQxrezl
	 /kKaPnu1uGRrKP0vZqS5l5wUtTvDR0XxC2G+v3TgHLkJo1EHX2dK0N2nSD3NAa0J6b
	 KX9Nko3ELS6vg==
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
Subject: [PATCH 03/20] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl261x spi
Date: Tue, 29 Sep 2026 14:14:00 +0800
Message-ID: <20260929061417.20733-4-jszhang@kernel.org>
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

Add the compatible for the Synaptics SL261X SoC SPI controllers, which
are compatible with the Synopsys DesignWare APB SSI.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 1e70c6804d5d..7090de9fa8d3 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -62,6 +62,7 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
               - sophgo,sg2042-spi
+              - syna,sl261x-spi
               - thead,th1520-spi
           - const: snps,dw-apb-ssi
       - description: Vendor controllers compatible with v1.01a
-- 
2.53.0

