Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B5C38142
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjAWPOg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjAWPOG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:14:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195B298EA
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so11101623wrz.12
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ne6RtXQyQ2xZokD/urqvcvyti0fGO7udq2uYUhjl4=;
        b=ydh2zyAbOx3hE1kJAVrZrsefQuSR8jHADM5MS6sVbbZct0miuoC7KZrzryx7Yvz3pM
         K16L74uX6totfds7MApM5Y7/ETAzTOUeQyjnsu7YJWhRb1e6Y6zZ5iKrI9fd9Z+ik4Dw
         Mx6ADqiiYoLJz/GmClacx1yB+vBuevPj1fAynGEWxi0kk2i6wujebP0QRpxiZEZK43xC
         exATrdrAix3IOyt9hk6dBblyy/TJ1Q6w/MLeQTrnrViuZQwlPgnDv/gOlQKlIFR9iUIl
         KNdDPqCjuLM3V15JfBwvd9jXRLoQtiDIUuoq/41Qp7KCUva41ZYJA99YGXWMG2c0Gh4L
         +S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3ne6RtXQyQ2xZokD/urqvcvyti0fGO7udq2uYUhjl4=;
        b=pqNQDAubGi0rUfV7B9KI986ZybUyc85A5b3e4e66uCQjZIZZUPSAZ0gl5W+nVoSFLc
         2BLixMx2LN3fngS1NETqAbIJKJWUPYuYwFZUKosuTbE3QlnrMazWQbC2irWYYgvIVWzY
         pWziHrnRNAbkUIzmTLsRX84pQKbE66aSAeCy7z7I5Y+T4Y7lXsfTZEN2VI88NsBjE5fO
         7KCueCUakfMgSKkxnxCUjF9NrfhzqyFvf62Oz2bKZyHuyjpFRRIYMYw6ZfqRrK6drJm5
         tjlNTJtO0iSrk5BXxuPHNkdsBAyncm56IlHUW+XB/cjrpM6KQRLtJS98UeiN/zn235Kl
         xw/w==
X-Gm-Message-State: AFqh2kpglv7q6uqqw0yMqdXIluFawsviXlPGABZvslNWm0Fd2Tv/nUd1
        qIc/+yO/eew/TFw810Fefebmeg==
X-Google-Smtp-Source: AMrXdXsviEDUzv3yh0GoS6/F0WtPaxs3pJyKMS9EUX0zyAfxGzLvqcSCV0/YUD0sMeKUCYfXL73u0w==
X-Received: by 2002:a5d:6404:0:b0:2bc:5115:f072 with SMTP id z4-20020a5d6404000000b002bc5115f072mr23077077wru.50.1674486817972;
        Mon, 23 Jan 2023 07:13:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:37 -0800 (PST)
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
Subject: [PATCH 12/13] dt-bindings: serial: drop unneeded quotes
Date:   Mon, 23 Jan 2023 16:13:01 +0100
Message-Id: <20230123151302.368277-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Cleanup by removing unneeded quotes from refs.  No functional impact
except adjusting to preferred coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml            | 4 ++--
 .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml       | 2 +-
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml    | 4 ++--
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml      | 2 +-
 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml   | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index badaf6d5b6fe..2d0cac642427 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -203,12 +203,12 @@ properties:
     deprecated: true
 
   aspeed,lpc-io-reg:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
 
   aspeed,lpc-interrupts:
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 2
     maxItems: 2
     description: |
diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 8b643bae3c7b..920539926d7e 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -16,7 +16,7 @@ maintainers:
   - Chester Lin <clin@suse.com>
 
 allOf:
-  - $ref: "serial.yaml"
+  - $ref: serial.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index b431a0d1cd6b..4cbe76e1715b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Fabio Estevam <festevam@gmail.com>
 
 allOf:
-  - $ref: "serial.yaml"
-  - $ref: "rs485.yaml"
+  - $ref: serial.yaml#
+  - $ref: rs485.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 26c3593fa98b..ab81722293d3 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Fugang Duan <fugang.duan@nxp.com>
 
 allOf:
-  - $ref: "rs485.yaml"
+  - $ref: rs485.yaml#
   - $ref: serial.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
index 14c7594c88c6..6a400a5e6fc7 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Fabio Estevam <festevam@gmail.com>
 
 allOf:
-  - $ref: "serial.yaml"
+  - $ref: serial.yaml#
 
 properties:
   compatible:
-- 
2.34.1

