Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F7FC54E94
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjAWPOG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjAWPNz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA929413
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r9so11123541wrw.4
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iisYcPXooI57UtkAF+HOVcsh+51Ufy433rxJDACay30=;
        b=rI16xsFZkU0eDWMTKFE0Ksxp73pnRnnVBuMI8tFbs3EAC+MtLCqM+X8v/vyycGcC5O
         USAChlzuDrcJtFWE5zuLInbgnGCpGbxV8/dQRqPYk53NiBrGIVppJYgEQ2zfRv7+YKSa
         YgXA+r7Uufexm6x2hExkt/4SgVNyVq8GFmMZhbUftDEvVH7LmMktBcLLpFBqx5/chHt2
         TeE20n5vBOYzlQtPwurLAxPiVEG5XNohtEKAMDt/NqKy4AnRpg/zhqZY49jckFfZ1deg
         CtvZBVIzioBWs9VynvZ2UYazAhmLq1ctmNt+zbnVQ5BlNz377YWULvNPKig7igJrEKyo
         vs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iisYcPXooI57UtkAF+HOVcsh+51Ufy433rxJDACay30=;
        b=Q4B6VDM1/r36rv8miFbh2AjdMc8vusLoB0VH4c3J+q5/1ZVbcQGUojygzwy/HB0nqC
         H5SSJ51tPlX2chH/wocgmkOuMwMPtTwi1h5/QOnig8BnwgjBqaRybiwyWfSi9rNX55ho
         wx57UiBrhXcxOwFQvc0VEa851tZ0q+9xJAwkuwWkSkcDiLFqppSXGpxwWdhQF0kf4qYk
         G0lqCph5vSbnWMvTscYYT8HiPSld8SD95I/t/Tisx44hfYdhfmYW9yTzioRoP+DrCQIo
         QrO4xq9rRir9lmP97DXO3XvDyX8iUcd/5Xkr7KaFqOo6Q1ywYrEEf/Xl4jGoOP/kYhlT
         PVjA==
X-Gm-Message-State: AFqh2koTzX+6+JOLJLWQMTI3RJ8ZVjYp046+LzKp29YnqLuEIyFcj9ls
        np4YHUzxcZihlHPC0KXloMJjEw==
X-Google-Smtp-Source: AMrXdXt0/G7OJJgG09MWKAInBglkrtPYNcF28o6o5Fy6XNeVCLITjCuzgG4Lr6rNnIfwWhChDqTogg==
X-Received: by 2002:a05:6000:3c2:b0:2bd:d45c:3929 with SMTP id b2-20020a05600003c200b002bdd45c3929mr23730627wrg.54.1674486807943;
        Mon, 23 Jan 2023 07:13:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:27 -0800 (PST)
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
Subject: [PATCH 08/13] dt-bindings: serial: fsl-lpuart: drop rs485 properties
Date:   Mon, 23 Jan 2023 16:12:57 +0100
Message-Id: <20230123151302.368277-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The binding references rs485 schema, so there is no need to list its
properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 74f75f669e77..b1e81a6451a6 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -64,9 +64,6 @@ properties:
       - const: rx
       - const: tx
 
-  rs485-rts-active-low: true
-  linux,rs485-enabled-at-boot-time: true
-
 required:
   - compatible
   - reg
-- 
2.34.1

