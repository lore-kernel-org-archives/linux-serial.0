Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD3DC25B4E
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAXJUf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjAXJUW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:20:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC340BFF
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:20:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so12331724wml.3
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0imGc0Sj0+U1qO38/MoeN3izcir/X2ZEBTXpN0rl4g=;
        b=CPxobIJe+YATUdVShDwFvEedr8RMcP704WVL8YG02+Iob0qOMVsaRzVKgi/UdLdUU3
         gS99+M49vYEyE6B2zC4wRJtJhQIUSmiBd8zU6TIBGHNjVnJUo1H4lqAFBjIRqxCa8/7u
         fW312YrEhd1LmL0WPkyAzqoyhbByHBITKwH5alfMEAx5a9x0A597UHvOZQLbIaDL42em
         cq2UdXfIR27iQAwIvwr1bMS9F1FTaDC6ukF2UuD8a7tlgDMLK65G1rzQxDx0cWgDwhpl
         JdZJQHpPGxMCwbPyYFgUZNehhlIXemwcN7Ju1kIVbk4fZ14iRf3CnJ9BTzuUH4OuAe5E
         rdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0imGc0Sj0+U1qO38/MoeN3izcir/X2ZEBTXpN0rl4g=;
        b=z889uN1LIUq9uFmSxVI/rODTEMzqm6CVN+XEPh/H+kw2y5nDf0stuJ4QLL4l8QblLK
         hO2aOslJuPkxX2Szk/KyB6VZs6M1UKVtTrJ3DOoDxUjqpJINa5fDYvdxjGgoek0Fhg9O
         5pHvvZ4yXVgRtYSpEqXTKR19A+i2gOXFRZcUzEjPgkO483YDBxGL3kYSgdkoxdkrXX7h
         5L77nKJzSv4RkcrJM8a9UMT0UZBdTM2IsJ0RdDVhf1DCTGKtEeWIsH9eL3DFYE6V33X2
         xJ/JA3lSJ9Y/DLkEsVkSVWymCPUAIAAnDUOKJCTjXwqwF893nyOC0/OP+ZFXoVVSVQ/S
         oQjA==
X-Gm-Message-State: AFqh2koHCLWwM79qKeBRk9NZngmCTOJzsw5H0xW2DcRK4mWx9xmg5Tyc
        MvbFTidl+WIVh+hhgGd7nmpDrw==
X-Google-Smtp-Source: AMrXdXvoKzAQYXHhE3iqhd9K3QqtBf5s1S6xQrft6zrb083L8IWCVu9+Yf4WKPAw9wUuVyhtxaOK/g==
X-Received: by 2002:a05:600c:540a:b0:3db:a3a:45ac with SMTP id he10-20020a05600c540a00b003db0a3a45acmr26791698wmb.32.1674552005467;
        Tue, 24 Jan 2023 01:20:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:20:04 -0800 (PST)
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
Subject: [PATCH v2 10/12] dt-bindings: serial: st,stm32-uart: drop common properties
Date:   Tue, 24 Jan 2023 10:19:14 +0100
Message-Id: <20230124091916.45054-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The binding references serial and rs485 schemas, so there is no need to
list their properties.  Simplify a bit by removing unneeded entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml          | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 85876c668f6d..1df8ffe95fc6 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -35,8 +35,6 @@ properties:
     description: enable hardware flow control (deprecated)
     $ref: /schemas/types.yaml#/definitions/flag
 
-  uart-has-rtscts: true
-
   rx-tx-swap: true
 
   dmas:
@@ -60,11 +58,6 @@ properties:
 
   wakeup-source: true
 
-  rs485-rts-delay: true
-  rs485-rts-active-low: true
-  linux,rs485-enabled-at-boot-time: true
-  rs485-rx-during-tx: true
-
   rx-threshold:
     description:
       If value is set to 1, RX FIFO threshold is disabled.
-- 
2.34.1

