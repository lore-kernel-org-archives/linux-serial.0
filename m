Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C844349B7;
	Tue, 29 Sep 2026 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663783; cv=none; b=WjPd46pO8B+JrgkCmZr+d8jrQ1WEbSle6oW8LFfckJo1NPQcBop9TBvBBAV/dkdPbVTACnjqbizi182QNgfbNlkyj0dlSvZCT8KCEtKGgjwWepzH6s19eSrxMf3aHcQG86G8i3ApWOXBjoco1w5QmmR6uMpRUlnnOJWJ7P7XFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663783; c=relaxed/simple;
	bh=qFli2AfDIHRapNT78STYO1oie9BJZQJBe2Tt2U+trdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUEmG7edLGvomD3zCNF7tLoNUSodt9C46BMtmBnqhRncuTYKogprfkli66POoiDHkd+O5RmNSrOSouAibeg59VtOcahfQnUxWAFVCRJPpeJ35u2EJWrwFw/eXQiFsgXcxc7w8z84sFCSNTLKzn6Tl1U+l3Ci48eNrXKQuID3K7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drbxlan0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drbxlan0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FA51F000FF;
	Tue, 29 Sep 2026 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663781;
	bh=sK92kjwtQgzYzyqBYyYH3USgcFn3Hilolf2mqG5ssq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drbxlan0e0renGOqaBmek+B+M/uFa2zUEZ3rW4CDYMXLv77X+X5lL471r1bKByjf6
	 t7TmXeheEY0v9VSawd7sbdeGYfsstWv2yh+Q3YF21ylwZY2xcKqvi0/FNw9ynIIrGI
	 QxOgxmxOpG7xU4YGiswoksx4cO8HCAiUy0+7faHjQWDuj03kQ0zPGuZ0Pe7HstQbUz
	 Ej1nJb4okzWjpqgFtkzjglqomyKOJONL7M2ScbA3YOZNUs/DHtioCLPGKxedo9Jg4V
	 4JGsK4xXLd27aVJiRJN/rZOwpA9Ug9C0xGVFQXA8HtB9q8Nd07BIn7062LAoldlrzM
	 dD4VaURkMeaAg==
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
Subject: [PATCH 18/20] regulator: dt-bindings: sy8827n: support standard properties
Date: Tue, 29 Sep 2026 14:14:15 +0800
Message-ID: <20260929061417.20733-19-jszhang@kernel.org>
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

Support standard properties regulator.yaml, such as
regulator-active-discharge', 'regulator-always-on',
'regulator-boot-on', 'regulator-max-microvolt',
'regulator-min-microvolt', 'regulator-name' and on.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/regulator/silergy,sy8827n.yaml       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
index b222adabc7b4..0baf93ca67ca 100644
--- a/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
+++ b/Documentation/devicetree/bindings/regulator/silergy,sy8827n.yaml
@@ -31,7 +31,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: regulator.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.53.0

