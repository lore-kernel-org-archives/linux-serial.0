Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C8E743EC
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 05:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjI2Flm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjI2Fks (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 01:40:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793061BCF
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a65f9147ccso1775919766b.1
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965992; x=1696570792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YwuLgv86cPyGl/Q9QiLo3L9zSgzmkr29pUnhaXKw20=;
        b=pCGX6PvfrdtVw8XnSHPIeHjN/TUaA0R4Dr+LYNL4H1fyYO7b10Wkd9ni4Hn8I0MbR3
         4jRxovNzi8Qj6e+Q56h+MUhgM0x4vyt7vJwy9YdJQvWhe+E1/v4usor+PEnt5cGef3Jy
         HE36k/WgdrQwrcYJKRSO5lfs+Y7MsNgap9A2L5jmuwJrIjQFWX/TQFWlbB+oMcYaf9bJ
         NqAEG4AEqQG3I7RNxfHzjTx2GA/0hg6cvBTzm2ZsAlajWPkA/Ojc7fVNi1SttCuYUvGo
         qZKw/P0gly1QQ3wFPGf5tplP30dAtOAYMllcdGXBvTcIvhhoqHccgR0wFnXzYcFJV/IT
         YkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965992; x=1696570792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YwuLgv86cPyGl/Q9QiLo3L9zSgzmkr29pUnhaXKw20=;
        b=W7uhGc9g7nSZhM8h6vvfbvZEBnfkiTuMasXFXmpZIJ1WXDXnvRvk9WuBy8jqjadpRm
         qgyKfhyrFNjg9iqKQqy5lkWNbAN6QMlsyux5q7Xrmh0LR8gFYtkuI+httKyaMXhzcL0h
         68oISOrIAz7KgqpUShMo3obmYOlJajBRhboBsCYnA2YjNTRoM3xjn/ifLzGFK3fOryTV
         oAK4XboyytdAiR4CYWFvsCm/1Ev5e3wQgRiOjbND1sQeKv9OxvV9kgxo4Uk13w5vNTbW
         0HurePvi1Eu3OQkxeo0qX2JxFFV5WFvG4AMEsCtHhSKpwQd0mXl89K92qXAm9xTvYyjk
         xEuw==
X-Gm-Message-State: AOJu0YyZp7nVzqvK98q1HyFTs06ZEICg4YzD4t+eZup2KObEPJak1ZLC
        0w+YpR5gmWl8k83KB9BHZYzbXw==
X-Google-Smtp-Source: AGHT+IEXwarvffNSeOzlyRj6UStVxwkwWgD3IItelaJ8tdcyvIPhnC7iKAhCem4gJGu4cNt9nB28IQ==
X-Received: by 2002:a17:906:5a4e:b0:9b2:d367:d818 with SMTP id my14-20020a1709065a4e00b009b2d367d818mr723684ejc.38.1695965992017;
        Thu, 28 Sep 2023 22:39:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:51 -0700 (PDT)
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
Subject: [PATCH v2 16/28] pinctrl: renesas: rzg2l: adapt function number for RZ/G3S
Date:   Fri, 29 Sep 2023 08:39:03 +0300
Message-Id: <20230929053915.1530607-17-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On RZ/G3S PFC register allow setting 8 functions for individual ports
(function1 to function8). For function1 register need to be configured
with 0, for function8 register need to be configured with 7.
We cannot use zero based addressing when requesting functions from
different code places as documentation (RZG3S_pinfunction_List_r1.0.xlsx)
states explicitly that function0 is GPIO.

For this add a new member to struct rzg2l_hwcfg that will keep the
offset that need to be substracted before applying a value to PFC register.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- in commit description mentioned that function0 is GPIO
- collected tags

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 7256d99fd552..73d8a84af04a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -136,9 +136,11 @@ struct rzg2l_register_offsets {
 /**
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
+ * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
+	u8 func_base;
 };
 
 struct rzg2l_dedicated_configs {
@@ -221,6 +223,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin_desc;
 	unsigned int *psel_val, *pin_data;
 	struct function_desc *func;
@@ -246,9 +249,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
-			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i]);
+			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
 
-		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
+		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
 	}
 
 	return 0;
-- 
2.39.2

