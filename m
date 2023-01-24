Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9434BC54EAA
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjAXJQU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 04:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjAXJQQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 04:16:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A92C642
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:16:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so10898459wms.2
        for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2023 01:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxnGtIs+CoSyW5044hODkJ4+MUCbjhxjSL5Kp9ZnQxs=;
        b=YnllctxnH3lzgD+EkXJ5CBe2SM5+FtZnnqa8+mqthMSc3elP9JPGPtvV/flyiga+PS
         b1pRCxEhdDtKFeFVfI/LZkbUBcw0YboNJpAs/8/+8o1wdFB24iCTnrx6UNegp0WP4qMg
         QQMKC8yO+nslnWeq+qYPQ14csU2OLowneTeO0KSofM0UZc/h3IlunhdF7iul/AJ38HV+
         u1ymLwMmzKbmsahGx6cdNLzBM6OxVPGx3f1pgenpiZQHX8/Z81RdYPtImrfshukt6BGD
         xLgMMKXK2WuzeAAW/EjGokg7YujOukYKFUh0sZMIOxwilq0pufNSBEA5I4dzyUxXBkY5
         R6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxnGtIs+CoSyW5044hODkJ4+MUCbjhxjSL5Kp9ZnQxs=;
        b=GeQ4vuXo1snv07XxHx8lf8w5jN85dEuTrmi4egmP3iQxpLRIEnhpnApReiorgaFfYs
         goMgFWtPmEMnNMDNtm1Kgj5eLzVZcOMWPiYyrtvLXsVUDbemxbJyabIpcaS8BBw1xstg
         q25yrMm+1NSGCCiwtDiSmdl8B81l5tRHTgIAHn8K/FwVfGQQ/pY9dttNOAUxbz3LTP64
         fsbO5ZGcyyRDij4YNGfv+8RPpVu2MLq9rkwKfCvc4c1RXTguu4Gu4Te+4SLL+tF7v1yp
         9mbuqS78FuqB2kKzC66q/DZhZET5DjntrLAUqxGl/+9bd0v5WgN8Jniq9CKdaOo6XwCZ
         FGRw==
X-Gm-Message-State: AFqh2kpiGqPfpR10ExgnWMwUaF7lxMfWLhYCbwCDg952uSw27RhiG9wP
        5Lq97xetcZmL4I1y4ze90+8tGA==
X-Google-Smtp-Source: AMrXdXsuRP+oeoKqVLFWERXFxb8dM8qDl5/yxaY3j45oPHvjVh/Q6SrnrjtQEH+hcMQmOmf+j9YRWw==
X-Received: by 2002:a05:600c:434b:b0:3d9:cc40:a8dc with SMTP id r11-20020a05600c434b00b003d9cc40a8dcmr25619205wme.27.1674551773221;
        Tue, 24 Jan 2023 01:16:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003c71358a42dsm17882131wms.18.2023.01.24.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:16:12 -0800 (PST)
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
Subject: [PATCH v2 01/12] dt-bindings: serial: amlogic,meson-uart: allow other serial properties
Date:   Tue, 24 Jan 2023 10:15:51 +0100
Message-Id: <20230124091602.44027-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reference common serial properties bindings to allow typical serial
properties:

  meson-axg-jethome-jethub-j100.dtb: serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

---

Changes since v1:
1. Add tag
2. Use local path (not absolute to /schemas/serial/serial.yaml)
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 7822705ad16c..44cb3cf22bfb 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -19,6 +19,9 @@ description: |
   is active since power-on and does not need any clock gating and is usable
   as very early serial console.
 
+allOf:
+  - $ref: serial.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -69,7 +72,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

