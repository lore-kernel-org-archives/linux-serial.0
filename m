Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3172C54EB4
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjAWPOf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjAWPOG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:14:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346FF298CE
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d2so11108175wrp.8
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQrsbaoWMRqz/6zcr+gxlvsS+z2BwQ6sf3IkSGfrHIg=;
        b=DrZkJqf8Lx/ikr2BhspNugPkwAK39BkOWz2sYI9KIsWgPfrmz3MxCIAlThf9eQMRoU
         0jFC/YJ/sI0ZvwfIPyUKQOcYKAjNBgQZ903EVlEmHIJERffJSuQbWtWQOQplD4P6xzXT
         vjbQhlypnRB9rEdBr17ZgPxaIuIfR28dVJhRctEPx+xF8mt3sF7Xn9NHD/tFZthCCP3J
         N9cjFd21wGYV/rg0RlP7ggPd5GuxBxGv3h40ZGahorcp0z8jWPFrnpEgdSfOiixLtos9
         M3vRGjxu6YizEJCkQmiusSvfeahaywTgfrHTZygFlKjEDsvmsqohvwqFgejQlMBcqr7Z
         7qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQrsbaoWMRqz/6zcr+gxlvsS+z2BwQ6sf3IkSGfrHIg=;
        b=LiLzyaXoGBoQe98Hx2RsJdzWFjaCfOnzM2/Q7Ihqflrr0rshnhSvCLKm/7ZqgOWIs6
         PYea7c2GUmb8tsHk4s0cpXSoxeA8RqimQ3wotuNCLL7Qz/QAvSLTEgYPcVpO9VA++D1l
         jZJ1+/TfOjQDz079P7bKeivhy9ZNQEFS4hBrK8Ub9aOnd8L61Ej1Xpsirq4ND8+7kMcG
         SwwXGPWGK/lWAXmM1V/1zmmmNB1uQQSSdxyCHBDSef9Fc0sdljMRSkC1fM8rxbvHDcGX
         ha43qF9YgQGC+2tUQ+M9wThpokfQQSyUIzl5HGhsf04gNzRTetGoxaFaTzle/LskB4q2
         yhyQ==
X-Gm-Message-State: AFqh2koGaSs0hqTLvghcAu5LT1Rf1oBzdlWZVbKOnc+g4ObSIsny+2FI
        HBmfKGNpB1w/QfryXc8UHrFwkQ==
X-Google-Smtp-Source: AMrXdXs32d96ovFaMtHszqx/rc2fx1h5rF19uqq0L+W7R44WRoQBW69g+WiSqNVd5szTAMO6f6ULYA==
X-Received: by 2002:adf:f9ca:0:b0:2bf:9424:c163 with SMTP id w10-20020adff9ca000000b002bf9424c163mr9542845wrr.57.1674486815043;
        Mon, 23 Jan 2023 07:13:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:34 -0800 (PST)
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
Subject: [PATCH 11/13] dt-bindings: serial: restrict possible child node names
Date:   Mon, 23 Jan 2023 16:13:00 +0100
Message-Id: <20230123151302.368277-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The re-usable serial.yaml schema matches every property with ".*"
pattern, thus any other schema referencing it will not report unknown
(unevaluated) properties.  This hides several wrong properties.  It is
a limitation of dtschema, thus provide a simple workaround: expect
children to be only of few names matching upstream usage (Bluetooth,
GNSS, GPS and MCU).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 11e822bf09e2..21992e9a3c2b 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -96,7 +96,7 @@ then:
     rts-gpios: false
 
 patternProperties:
-  ".*":
+  "^bluetooth|gnss|gps|mcu$":
     if:
       type: object
     then:
-- 
2.34.1

