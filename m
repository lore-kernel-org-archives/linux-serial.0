Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00674E743ED
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 05:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjI2Fkf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjI2FkH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 01:40:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD910E3
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1826936366b.1
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965978; x=1696570778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpN0QLxBB51x1Nk+kh/Ys3Cvl3llEXojNocKvCSavYw=;
        b=Mo/82Vc3Oo740y3P2YGnjmAvC+Gu5lThnTRTR1KVPkyKNyldRgGPjRnA4Xywxv6Xwn
         9FaE/jt7zkH5y99p0lHIzrYH7GZBw9bgdUgrnhxkUAw0Ydh6qSYZI/Wt7BoBByl7AMKI
         KQLHNUackcc4VzOqUfTvFltQZTbe60d+0Lclcwb/g+jqoHnfoTSV3iaPvxtO3jMAa7DF
         JTJS7MBzEAluZGE9eBO1HjYOin9riJyAMgPB2kKbX+h6OVR73ORvxV5UgWe9+x3RtOkQ
         vhsVxGPHHgoiAhxN3lFvtSGM0tuOpBZFXwS9hxAL9UdcgB+4FxhCxSBdqlnXjW99r0pI
         lJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965978; x=1696570778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpN0QLxBB51x1Nk+kh/Ys3Cvl3llEXojNocKvCSavYw=;
        b=PA2JVZGya3B9WPyux5qFV9pMAyDyvdEGvgkHIMJuQMLvhPs/Tm0hxbaA5YrAwOEozl
         iMHfxw+/pTDcbknGxyKSRs1G2FzjKS2Ch7FRew90uU9qn3/Pr5CZW/qy5FPFahegOLa4
         BdanKYGSOMSepgzz7eCapwPawI02OCctFTxYRgQq35xGjzRQMeqabaXw0+h+ncSMBT0e
         P0vesAaV+ziAfjIWZ9/e6ZL2hoPthIMbKqN1BoboqLUXTePHJlCORNufEzfLB+5jo/bi
         qTsB5Ff7DC66HxCrD+lhuOCjeFRrI0gMfauyozzpXkOGBWsxtA9n5rMJRIUt3uVN85TM
         6jKw==
X-Gm-Message-State: AOJu0YzlAp1j5Du/CL0fazoanHyzsTnUDOiYiahahqrCSxhew4EJpcO4
        u45PxuIAyuio7lEEet/Z/3kHrg==
X-Google-Smtp-Source: AGHT+IGwzC0gHVEPo+lwNiNdBQAkmIWWWi/mh3osxoDQwJ0KtBoTp0oWZ4DjfMzw7374tcbTvodRGw==
X-Received: by 2002:a17:906:7693:b0:9ae:6a9b:274e with SMTP id o19-20020a170906769300b009ae6a9b274emr2936288ejm.8.1695965977753;
        Thu, 28 Sep 2023 22:39:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:37 -0700 (PDT)
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
Subject: [PATCH v2 09/28] clk: renesas: rzg2l: remove CPG_SDHI_DSEL from generic header
Date:   Fri, 29 Sep 2023 08:38:56 +0300
Message-Id: <20230929053915.1530607-10-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Remove CPG_SDHI_DSEL and its bits from generic header as RZ/G3S has
different offset register and bits for this, thus avoid mixing them.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- s/form/from in commit description
- removed "G2UL_" prefix from macros' names
- collected tags

 drivers/clk/renesas/r9a07g043-cpg.c | 7 +++++++
 drivers/clk/renesas/r9a07g044-cpg.c | 7 +++++++
 drivers/clk/renesas/rzg2l-cpg.h     | 4 ----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 1a7a6d60aca4..e0ae25644e1a 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -14,6 +14,13 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index c597414a94d8..d4dcf5d896d4 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -15,6 +15,13 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 20da0c620b90..f5382333d327 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -19,7 +19,6 @@
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
 #define CPG_PL6_DDIV		(0x210)
-#define CPG_PL2SDHI_DSEL	(0x218)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
@@ -69,9 +68,6 @@
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 #define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
-#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
-#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
-
 #define EXTAL_FREQ_IN_MEGA_HZ	(24)
 
 /**
-- 
2.39.2

