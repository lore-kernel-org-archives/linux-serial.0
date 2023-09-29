Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BFCE743EE
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 05:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjI2Fj7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjI2Fje (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 01:39:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E13F1B8
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so1759859966b.3
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965970; x=1696570770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnqQLNYZz3xo/Z2CLQzgm+cKizcANRje7hedbfOoLFU=;
        b=Hrado1MyFwyR7mvK71RCyzFzGbXu9MJSQDBMIk2zhzioAc+6XROHOWJB/cBcbuTfUF
         W9Fm6EFk+wf1A5DJSHTmyD1yLcFfzj8xGQQWeoVFGy481cmja3fakRuMwIxflcPE/ApU
         B8wXyUSU73HhUFi4TldIQZmkFSRLHg3zuT9GGd7OkoQYGf6r3Wz3ocGgmOCtOJ41uCUB
         tbGTrSoWpb65wx9bUoj55JsJJO3DN12Bvi6EE3ahDNonoccdVYvf0hN4igMSAq26ka9Y
         syyRKAzK93j3OAhtIpDxdWvlD6oqCH0yT7bA/E3zGxGdTf+fpKUzhNCiG6WLLiQJwwwK
         RmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965970; x=1696570770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnqQLNYZz3xo/Z2CLQzgm+cKizcANRje7hedbfOoLFU=;
        b=H/9emQoa4zG4cuE4Ji1ZOzVI2ui5ZB1E4TU3HPvXyVof37JcZ96dY26x803vk/IS9N
         mb8ibwsHtWUSaP30yN0ppFftZq628xE/tRhVVSaJJvjdQtAX9g8Wyp1LKBxUi0Lyk/qa
         jv05hPA8Rpg6mn3JHKEhvYVZLqvVVbNhjEus3kDd3xVl5WwrRb0F1O68H35aMHgrF97d
         nae1QetmcaRuRUpdd05nV6XAr4K/F6kQywo0tDSziLmOT1cmpk9u5yzRy4lwb0c4gbGy
         Gh6orFsVtRRKptzo2qnQ9UWLdkZs4Ty2EYE1ulqVa1DEgWJDHkuxPQPkLCaoun6hE2p4
         Yzow==
X-Gm-Message-State: AOJu0Yx7KDbdiGcqpZSpx7hrr6UO5jA9VK7izBJUuNdBtdL/XiEROLPm
        VRsNhDBh2iAMUinxLfCNVIFw0g==
X-Google-Smtp-Source: AGHT+IHQNetWLkVJ62VPE+HyiTqj5WFfnB+Bs5B1knSVeh9ea0t+7zjVn4DhCdK1IlZdfEVAxrGMkQ==
X-Received: by 2002:a17:906:3019:b0:9b2:73b3:29a1 with SMTP id 25-20020a170906301900b009b273b329a1mr3092024ejz.23.1695965969759;
        Thu, 28 Sep 2023 22:39:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:29 -0700 (PDT)
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
Subject: [PATCH v2 05/28] clk: renesas: rzg2l: fix computation formula
Date:   Fri, 29 Sep 2023 08:38:52 +0300
Message-Id: <20230929053915.1530607-6-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

According to hardware manual of RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf)
the computation formula for PLL rate is as follows:

Fout = ((m + k/65536) * Fin) / (p * 2^s)

and k has values in range [-32768, 32767]. Dividing k by 65536 with
integer variables leads all the time to zero. Thus we may have slight
differences b/w what has been set vs. what is displayed. Thus,
get rid of this and decompose the formula before dividing k by 65536.

Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- used mul_u64_u32_shr()

 drivers/clk/renesas/rzg2l-cpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 6f50f0329ecf..f411e428196c 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -695,18 +695,18 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
 	unsigned int val1, val2;
-	unsigned int mult = 1;
-	unsigned int div = 1;
+	u64 rate;
 
 	if (pll_clk->type != CLK_TYPE_SAM_PLL)
 		return parent_rate;
 
 	val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 	val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
-	mult = MDIV(val1) + KDIV(val1) / 65536;
-	div = PDIV(val1) << SDIV(val2);
 
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
+	rate = mul_u64_u32_shr(parent_rate, (MDIV(val1) << 16) + (s16)KDIV(val1),
+			       16 + SDIV(val2));
+
+	return DIV_ROUND_CLOSEST_ULL(rate, PDIV(val1));
 }
 
 static const struct clk_ops rzg2l_cpg_pll_ops = {
-- 
2.39.2

