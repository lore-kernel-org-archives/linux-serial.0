Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A93E743EC
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 05:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjI2FkA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjI2Fjd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 01:39:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3AA1AE
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2cee40de8so62180166b.1
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965966; x=1696570766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au5TjHif1NdZJ2Z7FrkXoOxh3rDBA3mHRRDa4P1Qy7A=;
        b=bbhcGyIDn/XHtayop1ONScEnDCLyGTMRomMTmeZAofjitENiGonQkKdWcLLh4Qr2w7
         cFh0WJ3L/5YY72cDiDQD4/JbcDylEQXEucdtrHtshfwVe4ukATDoapBuM6yXl4XaPMCG
         VLJRe87tDkXKTxGr0rxVGb+pwFKuox0zE5+hLuROIKe286r+bjIB9MAm2KHnWJaZc+m4
         Ass2BnhuDrxhgPwZAk1IMAsWITcNY6/qwOxEjJipIp4CnsskjLsHteqE/OzAOGHaXV5H
         ksHaNpHu6GkO781b3ftL6C4jOjfuMm5sFKR0qpptxNdxJSsnkJDsUdkYEcHonyI+aT+B
         GSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965966; x=1696570766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au5TjHif1NdZJ2Z7FrkXoOxh3rDBA3mHRRDa4P1Qy7A=;
        b=YsFjk7RDWk8mRHpTS1GGR+85y+jbhraGSO2pClKoqfBgtXyamEKl7YC/LVqusRawBZ
         zT2w84o5D5Fzm1uzCbMaXHdnQr878Lic32kQItkySLGalhxX6gY1tWZPlZnhLsBS1Iht
         r5Hg8LdPAQZevK1qorOVjsNQijmKnFNPMuaZNey7E6WzWyPWTFk17ogZ/bcsM6avRJ7+
         bvaSabIohf0o2g8MTxJo+jM54W82pZV3yv9qX2L7JcXiYF/w9CCKnhfhelpiSEN6xMTo
         egKgJQzAXydeLw3yh3UQNw19mawH/kpCNYh9G4rsXnseTHBSOaYEJ5q1ohCkm8JDfy3P
         KkAw==
X-Gm-Message-State: AOJu0YwqEcYIFaouhMg0Ss0kld5gWqOGQJOJY2UK8gYNO538ia/RW66T
        7sX0jI486EKZzGqg25M5i1HROQ==
X-Google-Smtp-Source: AGHT+IFum4h4g8el3Uw1w6DcCrPLqgJojSzrnCceoMYUy9pG/hToo9w/gNJaOE/EEubYcVZDtuSoyw==
X-Received: by 2002:a17:907:b60b:b0:9b2:cee1:1f82 with SMTP id vl11-20020a170907b60b00b009b2cee11f82mr1301071ejc.7.1695965965746;
        Thu, 28 Sep 2023 22:39:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:25 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/28] clk: renesas: rzg2l: lock around writes to mux register
Date:   Fri, 29 Sep 2023 08:38:50 +0300
Message-Id: <20230929053915.1530607-4-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SD MUX output (SD0) is further divided by 4 in G2{L, UL}. The divided
clock is SD0_DIV4. SD0_DIV4 is registered with CLK_SET_RATE_PARENT which
means a rate request for it is propagated to the MUX and could reach
rzg2l_cpg_sd_clk_mux_set_parent() concurrently with the users of SD0.
Add proper locking to avoid concurrent access on SD MUX set rate
registers.

Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- adapted delay_us to 10us
- adapted CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US to 200us; tested
  with this adjustements on RZ/G3S and RZ/G2L SoCs

 drivers/clk/renesas/rzg2l-cpg.c | 23 +++++++++++++----------
 drivers/clk/renesas/rzg2l-cpg.h |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 5343d04fd70d..0679f2c7649e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -189,6 +189,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	u32 shift = GET_SHIFT(hwdata->conf);
 	const u32 clk_src_266 = 2;
 	u32 msk, val, bitmask;
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -204,23 +205,25 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	 */
 	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
 	msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+	spin_lock_irqsave(&priv->rmw_lock, flags);
 	if (index != clk_src_266) {
 		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
 
-		ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
-					 !(val & msk), 100,
-					 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
-		if (ret) {
-			dev_err(priv->dev, "failed to switch clk source\n");
-			return ret;
-		}
+		ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
+						!(val & msk), 10,
+						CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+		if (ret)
+			goto unlock;
 	}
 
 	writel(bitmask | ((index + 1) << shift), priv->base + off);
 
-	ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
-				 !(val & msk), 100,
-				 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+	ret = readl_poll_timeout_atomic(priv->base + CPG_CLKSTATUS, val,
+					!(val & msk), 10,
+					CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+unlock:
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+
 	if (ret)
 		dev_err(priv->dev, "failed to switch clk source\n");
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 0b28870a6f9d..097fd8f61680 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -43,7 +43,7 @@
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
-#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	20000
+#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	200
 
 /* n = 0/1/2 for PLL1/4/6 */
 #define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * n))
-- 
2.39.2

