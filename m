Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A56C05027
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjAWPNO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjAWPNO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C866D535
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h12so7120452wrv.10
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mD2MSQcoc4dUqM5mN85kRutri7MSD6je9fF7r46KJ3A=;
        b=MDCHyD/DppgASNZrrhUSjfzEdGsHr7Kz8YcSnZeXCFkB2Q3m1NYn5ir3s9xFQEM9Ih
         r/EgvHAHTRyx2Rl0HeA47sdHCFwKKJ87D5ItzP+ACb/UmbEl/jwc32KLiWF2WLI7G81M
         FLPkwyO9hvXc+75utLndnMV9UMJyce8pEiTCyVRWdFMjXdU6DipO1NsVKGqw3QSQdhmV
         kQd4yhhe9ZzIvLKfstipN8BrQpxvN8R6lagBzjQRLzSsVCJfT5Hsccw2V7xNzoo93W2J
         bMYcazl+nSP3Onh/+otLqvybwdhDXxbhwDvNQXBL7F9C7AtvDj4p8HBqtKHh9msqOs+o
         9DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mD2MSQcoc4dUqM5mN85kRutri7MSD6je9fF7r46KJ3A=;
        b=166tn/nqVZDWDiB+UvU7fBTPh8CokbA5kRNeGEZHHTClJ5SuqO4ZxyLUDlbzs5jQL3
         Q9ITjozz2fOjAsn7RzYoaNwk1AblWKskM8cQb7bO50tFJDp+ZmetPAkeE+vdfKeC+AiP
         uM2u2yeNKFBcR0PaR3lk7HCtqnxd+VSqwfq/MJpuUhQ1ZuSrW/jcX4MeRGlWgIBqcrTX
         uCoSN8cj/UFt3L245Fs+rcVxkOQhGX6YfqIGiuDcx/F5eXpyIJjXRvinZumVr4US+InM
         cO4AyTcnQSdCe6XjzDdH3cSYxDX8UL7ArzujMxXz9xcCzvN1N5qph4ywl02eJNB2LM5K
         15/g==
X-Gm-Message-State: AFqh2kpi+M4Mw/kvUp6J5Fljxo0UJrY0BJbrfwhBMxFsytzRHPTUCI09
        FsmdgZewcOPWsj1HqRTuYFhiuQ==
X-Google-Smtp-Source: AMrXdXudvFeY1MQe2u9dKeFf/Pkg70gCT8e98Ho6iYUtc8YoXVClgM8ziC4ZNwtjUY2hEr18RBBmpw==
X-Received: by 2002:a5d:4644:0:b0:2be:5cf8:2a83 with SMTP id j4-20020a5d4644000000b002be5cf82a83mr9678706wrs.37.1674486790953;
        Mon, 23 Jan 2023 07:13:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:10 -0800 (PST)
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
Subject: [PATCH 01/13] dt-bindings: serial: amlogic,meson-uart: allow other serial properties
Date:   Mon, 23 Jan 2023 16:12:50 +0100
Message-Id: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reference common serial properties bindings to allow typical serial
properties:

  meson-axg-jethome-jethub-j100.dtb: serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 7822705ad16c..7abf113c966c 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -19,6 +19,9 @@ description: |
   is active since power-on and does not need any clock gating and is usable
   as very early serial console.
 
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
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

