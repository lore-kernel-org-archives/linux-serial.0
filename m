Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3AFC54EAA
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjAXJUY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjAXJUN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:20:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BC3FF26
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:20:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so10916421wmo.1
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf7sCIV+g7d4Io27nUeL8AFqRST4Uv3gC9DO+XLsu5c=;
        b=lJt9WL7RKgvvoDL5lBaSpU4gI2CocxNuvfSF7KVONAUJZs6yobUDwpIrRRcqnKcSlh
         aNDWJDYWKfjIEQmmfZgp4C5NLnLeNKnOJesf6wxCwj41xz8PqrRZ7tjSC8H8N0V4EEeX
         +xizfcHf3c82CKkFo7AQqRhYNYPvoRtBDK+EXg+6QmTy9xPPR8CBPOC8DoeiMSYrSbRs
         +2DI2O+4byNqNaZyrmaj3+gStKEZGYRL2VdyxtSesXHBrddWdYqIhFx4JI+GWpKz3Slh
         OWFvdMspBlVRsUsPNBB+Y+39reJ3/ujkk2aEvYLuP0fdQ6n4AIU3td9/81nygjPGkAD3
         XXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf7sCIV+g7d4Io27nUeL8AFqRST4Uv3gC9DO+XLsu5c=;
        b=a+TdUt22wbUReF/d9s2ZuaN/hAn1pECRaAprOW6l8VplEBmgbbiRkE2ezeEI+BUS6z
         J57AIo+NISnpfDVkHp6LNYpEPTLjp5aAl8Zb8+ljaKEwT+NE3wLSMb3tBUK8SJizdFYA
         LAjLdv1LxWT2p21j08dEofGSWQjWN1qF4N95MguDkitkgXTuCWht7IeKf0LpwUHJy6lr
         kz/xoCngLKtAQs2sfr6Gy/CUW9YEhaj1hcA85WdyCQcyAAxdMlv5aCV4v5t+O0EwbAe0
         3oYwAP1flbRckgh3Q5PfkLcB8l/jzzJCrs9PVfalgup6iVZ0XD0/JUtrgEoMfV2VROVo
         mbdw==
X-Gm-Message-State: AFqh2koNvP5AnmjK0/b7wGPs74Y8y3k4l5DkwcCxBNOmhBRe7HVoUdRZ
        hJ0WGNJTkbqAipjoYBqP4EVQiQ==
X-Google-Smtp-Source: AMrXdXujRawjXpcdvGx0/kXpoe2kFjce8Y2HGF30EtbJZyHYimc6YERQVrxgL3vyTREcg4RVSGKu7A==
X-Received: by 2002:a05:600c:3512:b0:3db:1665:2a98 with SMTP id h18-20020a05600c351200b003db16652a98mr22374802wmq.16.1674552001966;
        Tue, 24 Jan 2023 01:20:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:20:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 09/12] dt-bindings: serial: fsl-lpuart: allow other serial properties
Date:   Tue, 24 Jan 2023 10:19:13 +0100
Message-Id: <20230124091916.45054-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reference common serial properties bindings to allow typical serial
properties:

  imx8qxp-ai_ml.dtb: serial@5a060000: Unevaluated properties are not allowed ('uart-has-rtscts' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index b1e81a6451a6..26c3593fa98b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: "rs485.yaml"
+  - $ref: serial.yaml#
 
 properties:
   compatible:
-- 
2.34.1

