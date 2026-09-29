Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E137AA9A;
	Tue, 29 Sep 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663672; cv=none; b=iJzJrHqgPU0Jopc/mzcWFRywd8dMTUvg9VKHogf78dpsxy9lUKOH77STcCVIDO6PIOwz6VfesfFhhiBScuUJ4++6j2l/4Wck0k59HI+bPTGX+q5XRys/FmjWDWfV6MuNqP3sz2VrBkYtFwB0B5HOU6AJwu9TU3qk+66+uDPiOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663672; c=relaxed/simple;
	bh=Ifgn1NmK05/Bnh67II9Fm2G2AHZP5BS5/4AqUUDWK/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgHQJ/v8+QLxastMB9v8bgQZ/ZEW4pPuCNrjULh1Oy9QcDPKCATOaV86BU8eyPUJ+QTfdJT/8uEo7uCnbCQSz4GN8DNQ2TxdqPLm/2h/EZOmmOhPOMsNQ0/6MTeegWFqubfwKkPplK83aZlivQ4fLkO4gBw0SZDQyho5yLCtShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/+FWEWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/+FWEWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB091F000FF;
	Tue, 29 Sep 2026 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663671;
	bh=lviEReV2O7qW3pWscfgsrfwXvtpl6JlQC75z8L+KR8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/+FWEWsZbpfnyRpenCgsAafCjYjw1JitjoDts7lYSsRjbn6FM+5C7Rel+jaZ/ZN1
	 GWuZsgOSkAWu74gLOfODfz5hbBlglv3TWq6rjC/8yCCxRQQzu7fziHxU8iDz+vY14A
	 yZhpOH6OQ9doUP7awqOTjUIWCm5K9+WLVM/czFNC4Da3Sc+CjeU0/yL6SB0gb/e0Mo
	 X89lO+eRCcVS/ksQ/BfzQXSzugX6er8lmVb2IpdxIuu0+Nem9eH5Ro0L/3SITtIkZy
	 MRI3AJbjQ/i4EERREmdYagucy2EjV/5TXJGyLb23IF+CFET/+zbChT+uByvmD7YcAF
	 2cgKMXYZnCHFw==
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
Subject: [PATCH 02/20] dt-bindings: i2c: dw: Add Synaptics sl261x i2c
Date: Tue, 29 Sep 2026 14:13:59 +0800
Message-ID: <20260929061417.20733-3-jszhang@kernel.org>
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

Add the compatible for the Synaptics SL261X SoC I2C controllers, which
are compatible with the Synopsys DesignWare I2C.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..ca2921865b97 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -43,6 +43,7 @@ properties:
               - mobileye,eyeq6lplus-i2c
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
+              - syna,sl261x-i2c
               - thead,th1520-i2c
           - const: snps,designware-i2c
 
-- 
2.53.0

