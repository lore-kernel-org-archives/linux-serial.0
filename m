Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47351C25B4E
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjAXJTx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjAXJTt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:19:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A53C2B6
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so560574wmq.1
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uL5KX+lq7Bh76mZga/YGxKAjqZK+AdDiUOgEFy1RwQ=;
        b=CqVtGiLsIQtBM5HC7e4JAs5ne7xOL0h7GAY2cRHqngOX6tAotoI4tdflCP332C9T1q
         ebm2ELFU1+Ug/a1y0TeWu9aGwQiLKKnWDSIEmwUZRAghplQkjWEQxaYBf5Ey4BE2k4jJ
         VK46ot2pwa00RBXGvfZYZg3SMXzA0Lh1pbW8jgf1rXVEeNuSnOQxiRAKaGRyvpkoNrei
         OJxD/0sU9CSdaNJ+wGU8nRten2J4szDCSGuQdFgJyR2vdcLR496YmAH/kCqa87QhjOTP
         DSyxz9sKiuG3/zXclPNhK65pMK0GXgVEoYgr0c13Sw0UIyWtsIz+fvqnELnsRql27WCf
         Jpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uL5KX+lq7Bh76mZga/YGxKAjqZK+AdDiUOgEFy1RwQ=;
        b=epvDOX/BiHYH7b8Fdkl5gGS10Sc+qo1+RBRS5rS2dVtNF0f48hZMJnaxAq+xPJkeMU
         bJm2o167sACkZmGAC2l3mOMvO9vMFDEL4fBGmq1OGcltaK+T3QhBKSrQFFWm6w2uzR44
         e2tQEMI0pkmQtm0XKdhZyJyrIWGeBo8SB7WG+OYK6+ntzvg+JguCQg/41lw0pn6cECDh
         yjN6JsQsgwKhUA9WoFN6rdhR/8BhDDZyWtdDP+YOWXrqdv5Y7maPhPek0kCZPqKNKWCu
         NaTqYXbjeQ/AI4U7IAshTkzaF14L1zEUrxtwgVTmz206cH04R5g0GdzX0DPIm+D9WHKL
         UWOg==
X-Gm-Message-State: AFqh2krKnLvgWK+dEODAiL8ZoEHoE+v7zmRZ8MC4GtQRi55TBk7yg1gB
        HC/UM8HhBN1B+C5sYooVun/HQQ==
X-Google-Smtp-Source: AMrXdXt6ZXjN2UR9CDMMCyR/xCneinHGOcEykSqybnBEASsnB1wxAPHlJm08OnK7Not9iguLyjZzVA==
X-Received: by 2002:a1c:7216:0:b0:3cf:614e:b587 with SMTP id n22-20020a1c7216000000b003cf614eb587mr27496678wmc.26.1674551987275;
        Tue, 24 Jan 2023 01:19:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003a84375d0d1sm13672242wmq.44.2023.01.24.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:19:46 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 05/12] dt-bindings: serial: cdsn,uart: add power-domains
Date:   Tue, 24 Jan 2023 10:19:09 +0100
Message-Id: <20230124091916.45054-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Few Xilinx DTS have power domains in serial node:

  zynqmp-zc1232-revA.dtb: serial@ff000000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
 .../devicetree/bindings/serial/cdns,uart.yaml   | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 0c118d5336cc..38925b79cb38 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -9,9 +9,6 @@ title: Cadence UART Controller
 maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -46,6 +43,9 @@ properties:
       port does not use this pin.
     type: boolean
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -53,6 +53,17 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: serial.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cdns,uart-r1p8
+    then:
+      properties:
+        power-domains: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

