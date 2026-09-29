Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363922D838E;
	Tue, 29 Sep 2026 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663686; cv=none; b=TGPeb12iyQCI3vOZ9hBHUGCTBegTi0cJuw6aI7EYb2pHTXOzgYXVjXOFnls2N+JpIdr8puMfZM++jCz6LG5qeWi1ZLjlAIfGX7We2coWB/5gGpj25/4zESuWdKQPkjVV87lLDFunaUosfhM1ytrNLkSFz6iIk4dYNvRl5ShmJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663686; c=relaxed/simple;
	bh=n7E+p4e5iOON8TeQHbohpe6dEZC8gR077uUmtWS/INo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtt+sJ43EIASM16QRPRZOl20SCLbuJoJzcSsR/7Bb6mJYe2XLRcEWC6LpRc9qH2YeEssXhdeBPJA3sIL+cLg6bUcUYgedDRre6WQ7/BHdykzc8dWaam4bi2q+Cg/MjcrDYQxYzPrmbtCkXETWQrF6IkTXHL9iu3OBGNjk6u2RY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAFY45Lt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAFY45Lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C01F000FF;
	Tue, 29 Sep 2026 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663685;
	bh=otsGCK9Yj0FElBYZytvrsZDWpB+j363zGrFV5pkZmKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JAFY45LtVIhVi9Pbv+FCoTzs4NYUgeyT3jEqFsvNubo+FTqtdxjXIE18uEA0IYLeR
	 cp/EG0wE3ChJ0iwyDOiq9gPASOkaf79pAO0V62AcXfapLsFQsu2M/pun0bUyYKXz5z
	 RlM+O+KFtsLDbQGwNaDKV1Si/KpI3C9jRxGNQw6exT79FAezUm6Y2XnJdn84QFfzGA
	 f2+pwQwnSOaYgUmqkrYHOXqqDjExJvLjvRTzzMLqRJnVeAJ5n4fBYSG7xWZlWQdVt5
	 HLJUnIO9SvrnRm+fjnXXarRdNFCLowKdRUle+cbly4PHw1eOA1gaKz5YTAK3HbX+Tu
	 uObzIXsgZ7OtQ==
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
Subject: [PATCH 04/20] dt-bindings: i3c: dw: support up to two reset lines
Date: Tue, 29 Sep 2026 14:14:01 +0800
Message-ID: <20260929061417.20733-5-jszhang@kernel.org>
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

The Synopsys DesignWare I3C master controller can have multiple reset
lines, such as core reset, apb reset, and dma reset.

Update the DT binding documentation to increase maxItems for the resets
property to 2.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index dc7ee38001d6..dcc21a7ab4c4 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -39,7 +39,7 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    maxItems: 2
 
   power-domains:
     maxItems: 1
-- 
2.53.0

