Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957B2D838E;
	Tue, 29 Sep 2026 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663728; cv=none; b=LXIFKeAD/2NFLjvf3m3inljeEFYXzPcY1pNX4Te8dzRethhBMuJ1ow/IVUgcl5GUzHm6KPPKjGTGNDRMrD+FEjjwne2RYBheIlT0w1d8wkoC0Mw7feTwkcX6IQNzOnG94s8N5Pb4rvBaiL4Lmj5HP+RmJIgH8Ir3M+wUe8YSx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663728; c=relaxed/simple;
	bh=XLmJssCVJkA1/Te6UeXRnSW6CJ8AIhSyKaV3C+UgPbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1X8HEm59PPesShqIgn0okpXF3MMWZPg3/REXEEHdcqKbIYN6wCN8G+TDv61vDGfODZZt3JZjoK682K3zmoC8fDuGWngU+j+PfYgQruM47O/gmMgC6pWUtMMYGk0xukC1TGGyb1KPf4wNFSP5bn02WllWbvSFaWcMFepgmbaWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoKMsw2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoKMsw2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181B31F000FF;
	Tue, 29 Sep 2026 06:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663727;
	bh=qs7Pv/6laLnorp25cTK04GRAniiFvRyeZMCFj2Hg7g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoKMsw2doFkOWRT2sHbm3G6UhGfoq2bAumyM5KJxUCsLkuYRg1NuxFFoVwVomaWFn
	 pS6qXmVVUHgY1hR9XkUQ7JNsJkMkALujuBYsnyZXJzTVvyzjbK8kj9uuBqRZZvPai+
	 2dmoH5oY5GOCkQbUzrcGveWEaMPUKM33mwra1xX0wtXo4ucuzttAVRNE07ASHA99Pf
	 Pd/pYKFkzfov6kN+XLCVvNTiizA/uwFyFyxOEQJ+I//5BaX6wRL/oqy76OyJa73KAo
	 rnerS2hl3AFMNcvmQBORlA7qenVDjlmaxYWrUMlotr0LLZdI206sUwrT0wBY7AbZzz
	 gDPnIMSmhWaqw==
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
Subject: [PATCH 11/20] pinctrl: berlin: enable module build support
Date: Tue, 29 Sep 2026 14:14:08 +0800
Message-ID: <20260929061417.20733-12-jszhang@kernel.org>
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

For Android GKI + vendor_dlkm deployments, where vendor-specific
drivers must be kept separate from the GKI vmlinux and loaded as
modules from the vendor partition, we need to enable module build
support for berlin pinctrl drivers.

To acchive this goal:

1.Use devm_* APIs to alloc memory, so that we don't need to care free when
unloading.

2.Export two symbols which will be used by SoC pinctrl drivers.

3.Add MODULE_LICENSE and MODULE_DESCRIPTION

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/pinctrl/berlin/berlin.c | 27 ++++++++++++++-------------
 drivers/pinctrl/berlin/berlin.h | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index 7971339e269f..0c2179b98629 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -215,7 +215,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 	}
 
 	/* we will reallocate later */
-	pctrl->functions = kzalloc_objs(*pctrl->functions, max_functions);
+	pctrl->functions = devm_kcalloc(&pdev->dev, max_functions,
+					sizeof(*pctrl->functions), GFP_KERNEL);
 	if (!pctrl->functions)
 		return -ENOMEM;
 
@@ -230,13 +231,11 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 		}
 	}
 
-	new_functions = krealloc(pctrl->functions,
-				    pctrl->nfunctions * sizeof(*pctrl->functions),
-				    GFP_KERNEL);
-	if (!new_functions) {
-		kfree(pctrl->functions);
+	new_functions = devm_krealloc(&pdev->dev, pctrl->functions,
+				      pctrl->nfunctions * sizeof(*pctrl->functions),
+				      GFP_KERNEL);
+	if (!new_functions)
 		return -ENOMEM;
-	}
 
 	pctrl->functions = new_functions;
 	/* map functions to theirs groups */
@@ -257,10 +256,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 				function++;
 			}
 
-			if (!found) {
-				kfree(pctrl->functions);
+			if (!found)
 				return -EINVAL;
-			}
 
 			if (!function->groups) {
 				function->groups =
@@ -268,10 +265,9 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
 						     function->ngroups,
 						     sizeof(*function->groups),
 						     GFP_KERNEL);
-				if (!function->groups) {
-					kfree(pctrl->functions);
+
+				if (!function->groups)
 					return -ENOMEM;
-				}
 			}
 
 			groups = (const char **)function->groups;
@@ -327,6 +323,7 @@ int berlin_pinctrl_probe_regmap(struct platform_device *pdev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(berlin_pinctrl_probe_regmap);
 
 int berlin_pinctrl_probe(struct platform_device *pdev,
 			 const struct berlin_pinctrl_desc *desc)
@@ -341,3 +338,7 @@ int berlin_pinctrl_probe(struct platform_device *pdev,
 
 	return berlin_pinctrl_probe_regmap(pdev, desc, regmap);
 }
+EXPORT_SYMBOL_GPL(berlin_pinctrl_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("pinctrl library for Synaptics SoCs");
diff --git a/drivers/pinctrl/berlin/berlin.h b/drivers/pinctrl/berlin/berlin.h
index 7e7096842eda..8ff70d682593 100644
--- a/drivers/pinctrl/berlin/berlin.h
+++ b/drivers/pinctrl/berlin/berlin.h
@@ -20,6 +20,8 @@ struct berlin_desc_group {
 	u16				offset;
 	u8				bit_width;
 	u8				lsb;
+	u16				conf_offset;
+	u8				conf_bits;
 	struct berlin_desc_function	*functions;
 };
 
@@ -28,6 +30,19 @@ struct berlin_pinctrl_desc {
 	unsigned			ngroups;
 };
 
+#define BERLIN_PINCTRLCONF_GROUP(_name, _offset, _width, _lsb,		\
+		_conf_offset, _conf_bits, ...)				\
+	{								\
+		.name = _name,						\
+		.offset = _offset,					\
+		.bit_width = _width,					\
+		.lsb = _lsb,						\
+		.conf_offset = _conf_offset,				\
+		.conf_bits = _conf_bits,				\
+		.functions = (struct berlin_desc_function[]){		\
+			__VA_ARGS__, { } },				\
+	}
+
 #define BERLIN_PINCTRL_GROUP(_name, _offset, _width, _lsb, ...)		\
 	{								\
 		.name = _name,						\
-- 
2.53.0

