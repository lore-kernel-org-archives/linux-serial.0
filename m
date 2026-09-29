Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DF42CAEB;
	Tue, 29 Sep 2026 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663721; cv=none; b=CATrPKUWBMZJMwrS3kqaPOv9iuY99i8V72YhwbETi0Il26mc0Jvs4AdtnpwMRhcORO+ngIE+Y5ZJQwAQa94y19loqEActtN8TYNQHJ7xUCVeiwOj8l5J6RkjD/gz/hAvWUkqgcOFHqYJ6hwgUwFaugY4Fiwx1KupsXAABLmllYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663721; c=relaxed/simple;
	bh=bVPvTClOh/aV8XkygyOnoanT2j+30QLtdqQt/peZdgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZ9/PfG2uzQERA0laShLKOv6KhOb81f86dEDyzje+Ja4mEnFMvQc5Ft4wHeZp+iuqsCvDcKA4UkOvuN3Ao9fbhv3CxJKVBiLcEXGv9xJLdjzCTzoJ48l5x01Nnfxe/qOp3/sH9dlvsonaQrsRVZokaa0UfNyklmbf5E67bVBUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcJlJ7KO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcJlJ7KO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6491F00898;
	Tue, 29 Sep 2026 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663720;
	bh=dasai6+029pvmGcHPcV9e3g/wbYW2nmVd23Qohpfg+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gcJlJ7KOAmSvzOgI9dVaGdH7J4xOZv/lsglJ0tf3Ph7JIDX5ZqqGaw6hP+vJbK7Ki
	 EH3vT92W3MSXwbtsa6eprz+VSJpI0QHsgGCI6114L4HuKA0iyELudzKjGcAairVJNf
	 Ae4IN1pM4VRlgqK31dyVxQft6JeZOGwblBtXVUNmIVx078e0PSt5YN1H4UE8Prmgbk
	 cEjeUHdMPlRtcQW6qOh3Y3ok3G6ZULiQdWme9ec4GriWqtpk90LO1Ywa16OsrbwhAD
	 p9ta0v5WbHSVb+Ozn5qh7YZOmsdN0SnsvEGQxWTh07/gGb7SHkJs5qCfydFKn+tz98
	 tQlHccr5Wm5fA==
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
Subject: [PATCH 10/20] pinctrl: berlin: use u16 instead of u8 for the offset
Date: Tue, 29 Sep 2026 14:14:07 +0800
Message-ID: <20260929061417.20733-11-jszhang@kernel.org>
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

The u8 may not be enough for newer Synaptics SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/pinctrl/berlin/berlin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/berlin.h b/drivers/pinctrl/berlin/berlin.h
index 231aab61d415..7e7096842eda 100644
--- a/drivers/pinctrl/berlin/berlin.h
+++ b/drivers/pinctrl/berlin/berlin.h
@@ -17,7 +17,7 @@ struct berlin_desc_function {
 
 struct berlin_desc_group {
 	const char			*name;
-	u8				offset;
+	u16				offset;
 	u8				bit_width;
 	u8				lsb;
 	struct berlin_desc_function	*functions;
-- 
2.53.0

