Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECCEC54EB4
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjAXJQ3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjAXJQ0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:16:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14193FF3C
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:16:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so13187249wrv.7
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjUDPjFfIstrArrttGkIiPvgInIpWMnlY5IxKwKaSmM=;
        b=ht5LLAmNCXWk91VFJhzqk3ETiT3S9WKDG9n7Lx34WQTWnXdrGkZP64QQUAWkTtSXNa
         ligZsLEVT1/DBjRLdUveGHswtzvOyZziia9CJSqHYHxw6ygC5yzZG+P6MGFe1hewkplA
         /dTii7SzPpAqyO8zaMUwVmfKckjQAein0gvyeQgaBlVkfNUhzd3iZ3R32jVGlp8gek4A
         DYnlWns/Yp0181BU/8sD2FC7rZKX9/NW7gqpzGeubeDSWD4d3HvQWkzyFbp8B+8h4n+W
         eDhNjkxQv9MBYHh2wFwckrcgPT6ygEiKKtCDU5C7JxQpJOSSZGp8FmyBg/n5lNAQRJ93
         nuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjUDPjFfIstrArrttGkIiPvgInIpWMnlY5IxKwKaSmM=;
        b=yETVq++OZoh3xYER0/1Bt+0Jl+EkJJAMk/EqdwtBWQe14MG82qgtQYkqySbFUkF+Wr
         AqO612v/UQg+naMcmmM1St4FA1PKS6OUJkzo/aqigq8zv2NmxGb6qdJ/OoC43GPp4Bja
         bcVtu7XSuSuB5gi37mOQzH+t7Vty7jp0Kx0t8ghH+qpVL6DJIIY0rQ3S9p/A2hFmw7rN
         j/ZwnRY2gfmaspE2KxPu0zG3K6/IA1hdUyTLMqBkV+HXDI+7RYmFHHNe8tkDbDPRhq5z
         LH595bD1n2o2Vi0WT6VXbuY2FTD9ylHu94DVzadIv4jOS8LkIdsctctu78j/aQPivsSd
         pwXw==
X-Gm-Message-State: AFqh2kpVgc/rclOj4rHg9ZGol451jKlnxO/bzmLarwhHH9nauxXA850Q
        K9qOasoCxO94Tgzontryf3s9Qw==
X-Google-Smtp-Source: AMrXdXuIOcn5b9xxfQPmfx/uSv6bF6pKWJ7ZoEGBGaeCFLwbW79S6Ckn7BhmNXuURhSjuTgFfkIeIg==
X-Received: by 2002:adf:f14e:0:b0:242:728a:fa7 with SMTP id y14-20020adff14e000000b00242728a0fa7mr25807903wro.61.1674551777096;
        Tue, 24 Jan 2023 01:16:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003c71358a42dsm17882131wms.18.2023.01.24.01.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:16:16 -0800 (PST)
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
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/12] dt-bindings: serial: 8250: correct Nuvoton NPCM850 compatible
Date:   Tue, 24 Jan 2023 10:15:52 +0100
Message-Id: <20230124091602.44027-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Nuvoton NPCM850 UART is compatible with NPCM750, so add proper fallback
to match existing DTS and Linux driver.

Fixes: c8177f90b7c6 ("dt-bindings: serial: 8250: Add npcm845 compatible string")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 34b8e59aa9d4..badaf6d5b6fe 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -62,7 +62,6 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
-      - const: nuvoton,npcm845-uart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
@@ -92,6 +91,10 @@ properties:
           - enum:
               - ns16550 # Deprecated, unless the FIFO really is broken
               - ns16550a
+      - items:
+          - enum:
+              - nuvoton,npcm845-uart
+          - const: nuvoton,npcm750-uart
       - items:
           - enum:
               - ralink,mt7620a-uart
-- 
2.34.1

