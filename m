Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D212FCDB47A
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 18:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjJKSta (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJKStZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 14:49:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30698CF
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:49:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so122967f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050158; x=1697654958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpmvATsaTcMJ19Dm+6zr7DE57EEBi8DlV0ssb1TyaVI=;
        b=Yn74MsWDY5XPIxWpuOLDgKRYUkcnYiGitzvhwywR8QfkbRU+zF9WMjJ+p0CQJUeyB/
         tFfICExNk8DX8LyNbb/+N2H34iAdT5OVnOY0VAfDb3PA8wuKdiIdK0fOc0OJcAqMrKgU
         v/vgiVcIQIwDUttWJUAJv9Nwv6U64Psiz+UZoE92e+iN5YN0ZM00RKi2fpsgkxF87aq5
         xkeVL/34rdo5dku0Loz8CZ6TQamfipbQ4ybSp04t54f22SPyybr+IyQQefpJIVqeEqS3
         VifF0KGZt63ANUdyt6ih/qBeedZtqWKd92M98Qq468ZWbePKJ4aSBDO9ZW7KLL/pnB8G
         NSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050158; x=1697654958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpmvATsaTcMJ19Dm+6zr7DE57EEBi8DlV0ssb1TyaVI=;
        b=dIl3aJZHDWZo036Pqx+Nu+Hx6iSLhaVRiDZXhx6Mk6Ge5uxbEMBfxsNlHVZAKKMYKD
         eekxujd8O49j/L0Zgv0b8cC5t2SvZJHNaJAG7FMao2+SoirEnKO07KbAV//A1XEYx/dn
         bXvpQZ5PEjmShJVujr0XddKaiUCLl6LYaz6LPXswuYrxPiIvPtzixjvJehDb9r69/jAS
         Cm3h+fS6+/AFYmA+VPZbiRivVZIsXzcIEgaEnX73pkiesK8/REY1LNetzL/75kMm2+Op
         AEeM6uz653kx/biUKiAC9PTzKVjE+RXy814ioZoYsxqnR/x0Mqq1EBMivg5jxdlaCKra
         oTZw==
X-Gm-Message-State: AOJu0YzfLPeRBGYwXZq3iF72Akz5++bEKntJ4ecSMnkppq+EK4BOJ3lI
        9FtQWRnnJ/DVE4p1DAJt6rRh2w==
X-Google-Smtp-Source: AGHT+IHAy75oAsFakfAP4prwtA4lP8VergujqRJdjvDK4geKc35P1aWpL2Iak1gQMuJSm2FE2tk89Q==
X-Received: by 2002:a5d:568e:0:b0:319:867e:97d7 with SMTP id f14-20020a5d568e000000b00319867e97d7mr19718489wrv.52.1697050158598;
        Wed, 11 Oct 2023 11:49:18 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm16003875wrp.116.2023.10.11.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:49:18 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/20] dt-bindings: arm: google: Add bindings for Google ARM platforms
Date:   Wed, 11 Oct 2023 19:48:08 +0100
Message-ID: <20231011184823.443959-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231011184823.443959-1-peter.griffin@linaro.org>
References: <20231011184823.443959-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This introduces bindings and dt-schema for the Google tensor SoCs.
Currently just gs101 and pixel 6 are supported.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/google.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/google.yaml

diff --git a/Documentation/devicetree/bindings/arm/google.yaml b/Documentation/devicetree/bindings/arm/google.yaml
new file mode 100644
index 000000000000..167945e4d5ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/google.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/google.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Tensor platforms
+
+maintainers:
+  - Peter Griffin <peter.griffin@linaro.org>
+
+description: |
+  ARM platforms using SoCs designed by Google branded "Tensor" used in Pixel
+  devices.
+
+  Currently upstream this is devices using "gs101" SoC which is found in Pixel
+  6, Pixel 6 Pro and Pixel 6a.
+
+  Google have a few different names for the SoC.
+  - Marketing name ("Tensor")
+  - Codename ("Whitechapel")
+  - SoC ID ("gs101")
+  - Die ID ("S5P9845");
+
+  Likewise there are a couple of names for the actual device
+  - Marketing name ("Pixel 6")
+  - Codename ("Oriole")
+
+  Devicetrees should use the lowercased SoC ID and lowercased board codename.
+  e.g. gs101 and gs101-oriole
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Google Pixel 6 / Oriole
+        items:
+          - enum:
+              - google,gs101-oriole
+          - const: google,gs101
+
+additionalProperties: true
+
+...
-- 
2.42.0.655.g421f12c284-goog

