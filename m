Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3ADCA0EC3
	for <linux-serial@archiver.kernel.org>; Tue, 12 Sep 2023 04:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjILE41 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjILEzf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49D2716
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 21:53:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5009d4a4897so8743844e87.0
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494396; x=1695099196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6zni172EPkMtPz69wGx7L0Cqn38MpX9XG54vyOIJSM=;
        b=nXeFJDM4Wo0CvasZu5xzABSm3atIodSf/y/GhUp4d+oRiwuqyKGfpzY5u4gJ2NhlE7
         UqYauRvgCEaADHckImyHSdCZeeqb6Nn+ZMZWSeUNWGDbd5dpxD3oAyQRxjCY2sWS84h4
         mN/DIfjAd/ccw1OEB/uxRV+IoELrg+jTHNnZC6Lgr1Aw7Vt4VIrJBI1SHogCjqMKCsDt
         SP4Du/Tbs0+E03blalb/KTgDRat+PPiZXeTt+Jy8EWylo8xb+I2LUQxIypmO/S+nPY7N
         38KzGE5tv2SgSgxoy8nKiBnQDbgl4TRa54Lpf64XUm3CkDW1PnNcDyruwXM1tb3cFMHx
         g9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494396; x=1695099196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6zni172EPkMtPz69wGx7L0Cqn38MpX9XG54vyOIJSM=;
        b=AWRELWNXYluFSQOqs+eRZiIiBOK+vlUTaN2/DmR7ZaQKdPoTJUR8voeawHLFGrm9JA
         7ShhgI1FkqEVHx47IMYAOkrU0MANj+BVdka6AMcA9gcdeA55H9kUZhoL5Rua05WWfZLo
         5TeTd7lI0t3nCwmHqq4Gi6sM8l3nvE1Ij2r/eLbB7jLQKE8Xb3hAjlQj1pR9ab5bLHGe
         F/eTUC/Rucsoz8r7G8HOAGJFp3ibe6OxZc/6jPOlK+NiyhAOgRjQCY/lKEfMjl88iuLe
         DEmkSm0BEil4hOCKs22WZAj/0Hy3/0OrXZ055cPOpVPO/ESSLCA/COU1asE1ps2qquzh
         I/Yw==
X-Gm-Message-State: AOJu0YwKAIfj76pG++PPZbsj0HsGSIAtrgwRGfhLoy42HjfoWhKRtEzV
        MMffLC2sK/npx+sYWpqp61H8rQ==
X-Google-Smtp-Source: AGHT+IHDlb9wq4lWtTqsm769MlCMfUtIEsJBOBqdqAhbdRZyYlZ1Z3Dgz7YUnZBgGzqe6JHL73mhSw==
X-Received: by 2002:ac2:5052:0:b0:502:9fce:b6d4 with SMTP id a18-20020ac25052000000b005029fceb6d4mr7202030lfm.25.1694494396002;
        Mon, 11 Sep 2023 21:53:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:15 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 29/37] dt-bindings: pinctrl: renesas: document RZ/G3S SoC
Date:   Tue, 12 Sep 2023 07:51:49 +0300
Message-Id: <20230912045157.177966-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add documentation for pin controller found on RZ/G3S (R9A08G045) SoC.
Compared with RZ/G2{L,UL} RZ/G3S has 82 general-purpose IOs, no slew
rate and output impedance support and more values for drive strength
which needs to be expressed in microamp.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 145c5442f268..079e5be69330 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
+              - renesas,r9a08g045-pinctrl # RZ/G3S
 
       - items:
           - enum:
@@ -77,6 +78,26 @@ additionalProperties:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
 
+        - if:
+            properties:
+              compatible:
+                contains:
+                  enum:
+                    - renesas,r9a08g045-pinctrl
+          then:
+            properties:
+              drive-strength-microamp:
+                enum: [ 1900, 2200, 4000, 4400, 4500, 4700, 5200, 5300, 5700,
+                        5800, 6000, 6050, 6100, 6550, 6800, 7000, 8000, 9000,
+                        10000 ]
+          else:
+            properties:
+              drive-strength:
+                enum: [ 2, 4, 8, 12 ]
+              output-impedance-ohms:
+                enum: [ 33, 50, 66, 100 ]
+              slew-rate: true
+
       description:
         Pin controller client devices use pin configuration subnodes (children
         and grandchildren) for desired pin configuration.
@@ -89,14 +110,9 @@ additionalProperties:
             alternate function configuration number using the RZG2L_PORT_PINMUX()
             helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h>.
         pins: true
-        drive-strength:
-          enum: [ 2, 4, 8, 12 ]
-        output-impedance-ohms:
-          enum: [ 33, 50, 66, 100 ]
         power-source:
           description: I/O voltage in millivolt.
           enum: [ 1800, 2500, 3300 ]
-        slew-rate: true
         gpio-hog: true
         gpios: true
         input-enable: true
-- 
2.39.2

