Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14BCA0EE7
	for <linux-serial@archiver.kernel.org>; Tue, 12 Sep 2023 04:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjILExe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjILEwt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Sep 2023 00:52:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260110F3
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 21:52:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso6791955a12.1
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 21:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494355; x=1695099155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoCpw81yKfLo4VgDXItzmRw2QIwsF6c48cElOMC6EIw=;
        b=efNOZzaz2mrdrYrVz2KZBe32hb1eSXlS2tFMQ4NMoahGA3XAxUHEviSgw/HMyGy0/B
         CEZNceT+KnwaHQFSGL3o5Ng8YedDWmHdMIo5DZiWau3V8csdEwc6aqSwS3uXRGY3No9q
         DOaKOTQezTL3Wmx+HByicQ+A+hGxccvel3g4l2KSQKDqPRG+5qgRHZPuxarKLWOFPJTp
         M9Zxw4YoxrConb/40UaNZpceX7tpnj/hiRC09kSjDxvTM9ftODKFuIVre6j0h5BNAH7f
         0Dwe0+S6xrcrAosN+C6CfKzpZ/WEkBTQlh9IRRamQ0wCrzENLWoCwW9PtWEbychZXVEq
         YBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494355; x=1695099155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoCpw81yKfLo4VgDXItzmRw2QIwsF6c48cElOMC6EIw=;
        b=Ncwcis0Z8pU8WbhWpuFmtnCWD1qOEp2HN/CnJLtxa3IgjNwmbqPUhwQ/IdRmMoWbjX
         YyWrwncoXlgee0grmuko0hYsne4gDnMUD+FLpqrkM9AzAEbnT5K0M/fH3UewxSUs/O1s
         5HRvSquXnTSP1kMcrF3iDj6pyeOQpBvyrsSbPejrteBo0QCOoJzZHAUwW7HYgIl8fLDc
         ImhxWOC6FL8TYml4c2f2s917NG8wP/BvPih5f7G19jmQbu9C78qgV9hUUDF5gFC2vhfU
         tgooFM7FSCnaT4FBk3+MmaR+5uLQawIg0Wy0pFtkhNEn6HZDD45uDMPMmXN6X5T5vGRx
         L+aQ==
X-Gm-Message-State: AOJu0Ywv0effv8wDAWgDFJy4ZzXgf2LwVG25iTMxZeqotxykV4Tvt4pf
        fkyoOe3YfwV46RxHtCBeB5PEzw==
X-Google-Smtp-Source: AGHT+IF4gJ4l/dCvSevhNyicQ8r0uP2R1CJmeGlXUXe1057QGw/WFznmHIXupPF24lUa2/XA0gyFOA==
X-Received: by 2002:aa7:c48b:0:b0:522:1bdd:d41a with SMTP id m11-20020aa7c48b000000b005221bddd41amr9906905edq.4.1694494355421;
        Mon, 11 Sep 2023 21:52:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:35 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 09/37] clk: renesas: rzg2l: fix computation formula
Date:   Tue, 12 Sep 2023 07:51:29 +0300
Message-Id: <20230912045157.177966-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/clk/renesas/rzg2l-cpg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index d0d086d6dc51..b391c9548421 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -696,18 +696,22 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
 	unsigned int val1, val2;
-	unsigned int mult = 1;
-	unsigned int div = 1;
+	unsigned int div;
+	u64 rate;
+	s16 kdiv;
 
 	if (pll_clk->type != CLK_TYPE_SAM_PLL)
 		return parent_rate;
 
 	val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 	val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
-	mult = MDIV(val1) + KDIV(val1) / 65536;
+	kdiv = KDIV(val1);
 	div = PDIV(val1) << SDIV(val2);
 
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
+	rate = (u64)MDIV(val1) * parent_rate;
+	rate += ((long long)parent_rate * kdiv) / 65536;
+
+	return DIV_ROUND_CLOSEST_ULL(rate, div);
 }
 
 static const struct clk_ops rzg2l_cpg_pll_ops = {
-- 
2.39.2

