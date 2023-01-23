Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D6C38142
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjAWPOR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjAWPOA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:14:00 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFA12942F
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z5so11122519wrt.6
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf7sCIV+g7d4Io27nUeL8AFqRST4Uv3gC9DO+XLsu5c=;
        b=cqVYvO11OXKCMxWS2m2N8CuvmAo04795P3glA3/QShNfksesNCwdIiapFJIUxHx8cg
         3rS+IwE+nzmtwwJKmwEYmQW5HLkl7MmB54iys0Xhur69ZQg04gXhIFNjki1cNxhgM/hm
         KVdVtMqmIHX9lNjdkHzp2HS8EYbgPuXUYi8+63DnFvCutve84+4ZjO1HvGNqiyFO7QiQ
         0rkXFCKJMjZnLe10OEAwNQV/7I7wA0Qmxni0Mo/QqIeyhtr1qYNrtVfm7dhsM722pJ1P
         sPnDVVZr0HkwjgZyaHNJBlv/Mmd2HgHSPEa6D8zIE0r8kuGKh0CVafLNIOC929NHP8Cs
         Evnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf7sCIV+g7d4Io27nUeL8AFqRST4Uv3gC9DO+XLsu5c=;
        b=HVpzLOEVwSSuyKtRO0pJXAfW8TXtdr1p/jQUoa3rnUSKhzchn1zZ/BTGrVPs6WCi0y
         +TkeFI+CJrbbkcM0FU4PovaH3YALpX7SzrlzJg7wQa2rTAK1tiVhfY05aseX6qde8K6o
         xeBjyF885eon4bqZVXCLDE3pIlVLmbGJKdG0JpWoeSl830O/pCwTsbxQbhwbyfRUzM04
         v/iMw4QywQeAbD3F0aSayKTX6jln5WBg80gDCBuOjwODxr52L09F0SgtNcCmOibP+jrt
         mZd6EA/8vEaiDLqKCkJHJ6CaISrrJYQqeSPwhyF7bcQReXX4edbOk9mFHMhZev6ZXLjv
         ctOA==
X-Gm-Message-State: AFqh2kp6HllJyOKkMiDT+fMVlkyVoci1HSWQsXWvPb2BhuLziJBAyAVA
        mNLgwt1LwijndkhAs8lB+VaIVg==
X-Google-Smtp-Source: AMrXdXvPieFXZTI3YD37rAAxnRgL7EXzr2+7M2297WZ2GeWKED5O3/ADcQWZP+sLDJlxaXVyZ1+vHQ==
X-Received: by 2002:adf:edd1:0:b0:2bc:7d12:e736 with SMTP id v17-20020adfedd1000000b002bc7d12e736mr21123596wro.1.1674486810209;
        Mon, 23 Jan 2023 07:13:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:29 -0800 (PST)
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
Subject: [PATCH 09/13] dt-bindings: serial: fsl-lpuart: allow other serial properties
Date:   Mon, 23 Jan 2023 16:12:58 +0100
Message-Id: <20230123151302.368277-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
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

