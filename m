Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D4C25B4E
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjAXJUJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjAXJUB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:20:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112B402F5
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so12366416wmb.0
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42Hfl1J4qT8SATIfnUTpADzmL78jDne+EhYGf6Qds8c=;
        b=BfLinym/cklYezWvUdj/D3yAkf3NS77r92L10AME1y3JOtClKrEyZemZUji43xEfmE
         1CTGJHL8LxpGTSF3AkvFqeVNgE+wNerxDjURu1GcsX8rSNVpDps+fEwxFUsL1xhzvIiB
         +JmwNDp9o2c47v+qoJpdwZjZjMOt18r0Fc2C4iVYdDxnRsFioUSNzd9hAO5fdSylxvpr
         UUpTk957V2QsLmu9PRjgqzFHSbSzImHl6JKpF9omsRIvzHfPuFAVkaXEXwuO1hzWJOBA
         0yl9HepBj47QjGkby3EUe8AYOG4bhg7R8UD5AgoB/ADnPyyfeGIxtjSl3t1dXmFoRS3j
         T0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42Hfl1J4qT8SATIfnUTpADzmL78jDne+EhYGf6Qds8c=;
        b=Ih8TukcaVoVIvMKj/u6WaMIK0XysfPGnh4UP9AntoNmwBlNdKkv4dN/prBjKLwlQTi
         njqjUqas9EcDNKXqgQxDeb/+0Tx4e4DGpYiaiWie2mjdlIOUdDEO9v7rNal8gm1jCKs9
         8Whm9iyzU4mXWQD144PDV4dnmGRNnvb5Qh/aYyRuxMe3QRLKFqyEpIPCyOXLf0mn5g9n
         cTBRToj6wMObGXY7r8rwwGoXeUZSqx5GRoOJR5OMd+Got2clH7X3Q5yhHa8uDQDDXPMJ
         +0AFmbIFx/EuQ+yUWqVqa2Z4yQrgC+MflQwfRCLbXTqf0t06U0kanLgyHUBU33+gU0xa
         fsuQ==
X-Gm-Message-State: AFqh2kp8c39IPgG52vfDf+79DtNaCaBAF6qM5UYCl9J7+tqygYp0I/jq
        cnE6/SMmBMSZol6OUr33EqovOw==
X-Google-Smtp-Source: AMrXdXs6ofs80YXfseUtI8imesuJyhITR5jNUBCkTkhOsWQiGBk4hZUL16Iu0n0uoxEvTPx24lzRdw==
X-Received: by 2002:a05:600c:540a:b0:3db:a3a:45ac with SMTP id he10-20020a05600c540a00b003db0a3a45acmr26791047wmb.32.1674551994306;
        Tue, 24 Jan 2023 01:19:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:19:53 -0800 (PST)
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
Subject: [PATCH v2 07/12] dt-bindings: serial: fsl-imx-uart: drop common properties
Date:   Tue, 24 Jan 2023 10:19:11 +0100
Message-Id: <20230124091916.45054-5-krzysztof.kozlowski@linaro.org>
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
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 9d949296a142..b431a0d1cd6b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -83,13 +83,6 @@ properties:
       are sensible for most use cases. If you need low latency processing on
       slow connections this needs to be configured appropriately.
 
-  uart-has-rtscts: true
-
-  rs485-rts-delay: true
-  rs485-rts-active-low: true
-  rs485-rx-during-tx: true
-  linux,rs485-enabled-at-boot-time: true
-
 required:
   - compatible
   - reg
-- 
2.34.1

