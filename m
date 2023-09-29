Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA2E743EE
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 05:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjI2FkG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjI2Fj7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 01:39:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F771A5
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad810be221so1839278466b.2
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965971; x=1696570771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tx8IsOEvb8qkvUy2Or6MBahI0OwwMce9fHoVPFho48=;
        b=C4lp08O6yska7znKdYMmclZfGa3X6+zuJBT3DJfQ5oFKoe9K9y7j8LuAzgRiYdNfmh
         5hzYKxAleR/W+F4qeYhKDx7HWinwO/whkxrbHVI84w6dN9Qxh8shf/x62wyy5g3zPsCa
         N1xq1GjBB50q7BwpUN8RchxaYfphycRls3aHGCMsN6VgFjWAV3CozP37FGuU4/UTU3DO
         kyeR1VNOoMj2Lsxg085moJky6ahF+z7OABVZtHX1No3Cx6kOPD8g2YcOCdTgXJ/JV+GT
         EhyqUJC8cET6tgiAFt3jBN2SCqRgCIBNp2WEeDqwpwcBUuhJcyKyymOgsL6y79be6J/l
         3mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965971; x=1696570771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tx8IsOEvb8qkvUy2Or6MBahI0OwwMce9fHoVPFho48=;
        b=vgAqYv7DFSdHfXJ/jyMXgjRMJW4ZjE/rI9dzmx/TVSDqUvmNZ0JmnHk3fN2PIywvLi
         KHOXi9oIDNovpopYTJkb1rcB1bSRkPUrufy0pvidZeeQqtRqxEzYOcYJPIWctN7asmOm
         ZEKb/4xNp1eQqKqdUt6TErKbBjtv4vmSvHmoEZcklaAbITPojnwh+Z+H+hk7pkN03Hbg
         HyvbwrFcF1H+jHakWXL4g2LBs5lxEk0DmiRr8+ykNAfQbLgBJkJ3fl3X8oLHzGEjpPCT
         RnfLIWc1mZGYOH7ATozUh/kud9xmzTLD59PQQ7DKFzzqjxYPYVmlgxsE8qAbtuxcpIbV
         H1aQ==
X-Gm-Message-State: AOJu0YwYrFx1LEaMGCH/rUIZI+SkP7wpJPKmEAD1DHkdoPZnnMReFJ1M
        le186BMQpiqLQb7y+M8II5hkQA==
X-Google-Smtp-Source: AGHT+IFssgixc+IrMTS/V7svcvYp3mqrtz9kBpFjxlgOV+eCYx41PSPSVkMAV0EmJXCg9RRV7OOD1A==
X-Received: by 2002:a17:906:845b:b0:9ae:695a:fed1 with SMTP id e27-20020a170906845b00b009ae695afed1mr2909592ejy.1.1695965971645;
        Thu, 28 Sep 2023 22:39:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:31 -0700 (PDT)
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
Subject: [PATCH v2 06/28] clk: renesas: rzg2l: remove critical area
Date:   Fri, 29 Sep 2023 08:38:53 +0300
Message-Id: <20230929053915.1530607-7-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
to hardware register. There is no need to protect the instructions that set
temporary variable which will be then written to register. With this only
one write to one clock register is executed thus locking/unlocking rmw_lock
is removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- removed also the spinlock
- s/reduce/remove in patch title

 drivers/clk/renesas/rzg2l-cpg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index f411e428196c..d936832e098f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -895,7 +895,6 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	struct rzg2l_cpg_priv *priv = clock->priv;
 	unsigned int reg = clock->off;
 	struct device *dev = priv->dev;
-	unsigned long flags;
 	u32 bitmask = BIT(clock->bit);
 	u32 value;
 	int error;
@@ -907,14 +906,12 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 
 	dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
 		enable ? "ON" : "OFF");
-	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	value = bitmask << 16;
 	if (enable)
 		value |= bitmask;
-	writel(value, priv->base + CLK_ON_R(reg));
 
-	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	writel(value, priv->base + CLK_ON_R(reg));
 
 	if (!enable)
 		return 0;
-- 
2.39.2

