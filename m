Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5DC61D97
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjAXJTy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjAXJTw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:19:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB33C2B6
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so12366277wmb.0
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbA6lJheuFk/8xFTT1ePhHPMDBY/JK/4xrBmt+OOi4U=;
        b=gyaMQF7LxN91BqAUGGwqgwsMO2hEdoTGvJ1VHPth0Vl8RgAka5nDpZvB74rufyb+Z0
         xV00CuvPEWQEr09/BVy1JzwjLcVogjv11FrOZXW+ugvwl0cfQHBRj3Bfa0yC15GWAl1t
         jXdQs2B6bMEn/Y1LezZLuXMYjROjGQRcLXxatD01tROgJfIaE5vqoJBuPDvdnubUBmHM
         uG17LU+D1qCJqe3hjfo9MtGoUGnnwKLsjTJUeCxXC2tNvX/cvNTUmEDgAPXYS0cmUL3i
         gTnni68xV+zWuVbwacWcJZ8jbWYQ5xcswPnGiChiZ+46OlyTOlunUIshv6Q7wrqIN36n
         NQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbA6lJheuFk/8xFTT1ePhHPMDBY/JK/4xrBmt+OOi4U=;
        b=ZSjSuZ7/onI+LGD4qsCk7U+XdaIdlXMrM0PfhKnaxZ8dqc/DheFss1uRbrokFm1zqc
         qmEZNfOQpAtVzuBQvPDIqd1rh4gLrVbGkjBJCg3oJksiuYzIDTNh2JA4axS4qKcV5I7Z
         iuWlIBStUrpySEc3G2XB6AI2F6jRGWQk5WpHHxgMOvSaYBIPJxmd4HwIFb7ChNElWgHt
         Ij8S6nqvpxeLT98VCmbu75FbvvBpcTsh7Uzun2IT9Fhev7mCn+Q1JcEIYak3r7kxrixZ
         +x6Flb0RtLs+2/d1nk6HsPhiwMqlCHcEJquUuRIBWVjfkb5Hd6Qf1aU44Sq4gWFhAZc3
         B28Q==
X-Gm-Message-State: AFqh2koFrIEnl0Me4LGEH5f5IuNbJqSm036YDZp2Xwmr5m4xh6MGNvbG
        IlNyd+mwMWLG4VYqT7dSt010rg==
X-Google-Smtp-Source: AMrXdXsuCK5QkrJAsWUR9ETP50ULGZWTSxGw8meu3uy8bzB1kS3qzFWy3OBucmJfla4MOZzaKSjqcA==
X-Received: by 2002:a05:600c:6001:b0:3da:f80a:5e85 with SMTP id az1-20020a05600c600100b003daf80a5e85mr26600878wmb.26.1674551990693;
        Tue, 24 Jan 2023 01:19:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:19:50 -0800 (PST)
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
Subject: [PATCH v2 06/12] dt-bindings: serial: 8250_omap: drop rs485 properties
Date:   Tue, 24 Jan 2023 10:19:10 +0100
Message-Id: <20230124091916.45054-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The binding references rs485 schema, so there is no need to list its
properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 53dc1212ad2e..7db8e5477b03 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -70,11 +70,6 @@ properties:
   dsr-gpios: true
   rng-gpios: true
   dcd-gpios: true
-  rs485-rts-delay: true
-  rs485-rts-active-low: true
-  rs485-rx-during-tx: true
-  rs485-rts-active-high: true
-  linux,rs485-enabled-at-boot-time: true
   rts-gpio: true
   power-domains: true
   clock-frequency: true
-- 
2.34.1

