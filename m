Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB36C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21387610A0
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 13:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhHSNtq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbhHSNtq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Aug 2021 09:49:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CDAC061575;
        Thu, 19 Aug 2021 06:49:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so13082168lfr.11;
        Thu, 19 Aug 2021 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcd3Ew/0S2MQDasYF7ODVmsRCEeC4AAQAE5enh/njaU=;
        b=qHsAP5ZoDviH4gvXX/R/6ocPw2hnM33wOqZSW2C0QCpCkoZYjIvNYnsTWQUUDXMRIP
         uSlwV3Wj7YGQcRyQK/UN4NrvV0GMQDNs69kIkyIVbkwMoCG76stV/i3pufTBWHsoaD+c
         owdBgsZ4n/U9LHAwHLj1NhCLDJRcDZkT/5VfTNPMa5XJd+4o+PhgDX/FtcCq/hQigHd8
         tqZ/gyc/ZdAP1ba75Za+RYgq+5ndurJpkqjS4D/p3Zo7P4qFwQ8EPQbzgKxl59zWEw42
         PDy5dAPTGQD1sNtDzZAifPkBOI3kZKQV0s9O0Rv7f7HMwBmIJ+6D7GBYDSQrWM/lzIg2
         WqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcd3Ew/0S2MQDasYF7ODVmsRCEeC4AAQAE5enh/njaU=;
        b=WuZPZII26IIKeEnbO38+zkR4E9iuEB0HI4VfCO5viRw6yuY2ZWH2nHaKlC47XWmyI/
         yzyfVwZY0sEEP+E+pY9t8d1g9kjy9rAJQQGKQzN7RC7OFFwF9aXWO3DyBLphsTf+J3cN
         IwPuIufANTc77hcVdSgHwYJL461vS1blPCtuXyOJDSz4A87oKXzLdj0xmIbL3dMwIoe/
         KrHfvhtCWCVCqVVXfHvPJ9uOp+qDDEJHAs6WrClSeaqkzA0BbkNnAodQhEvz0YgdzeYb
         8KE8bC0rSLw3+Ax5SioXmxo+sSvCqMH8ZSwMeIp5hmO6cmuQ7zZpL38xHwthPNNq3A1P
         ZRUQ==
X-Gm-Message-State: AOAM5330unggSPIjKZdnpuKvNXt4dJENyjB+w+VHcyzzeVyoxkyf6EYL
        JbD1KCNX0QhnkEGh+V9E3ew=
X-Google-Smtp-Source: ABdhPJy7atDVHoUfG8iQvpdQpfwFJJNZhQ/7r/ZOo8GiKCQGfvJGvqqZj4NAqCF3AcNnakpdZ7Ryxg==
X-Received: by 2002:a05:6512:1082:: with SMTP id j2mr10635889lfg.560.1629380948240;
        Thu, 19 Aug 2021 06:49:08 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id u2sm314115lfd.43.2021.08.19.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:49:07 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: serial: brcm,bcm6345-uart: convert to the json-schema
Date:   Thu, 19 Aug 2021 15:48:59 +0200
Message-Id: <20210819134859.19537-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

In example periph_clk@0 was replaced with periph_clk to fix validation.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I've verified this binding using the
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
---
 .../bindings/serial/brcm,bcm6345-uart.txt     | 36 ------------
 .../bindings/serial/brcm,bcm6345-uart.yaml    | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
deleted file mode 100644
index 8b2b0460259a..000000000000
--- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* BCM63xx UART
-
-Required properties:
-
-- compatible: "brcm,bcm6345-uart"
-
-- reg: The base address of the UART register bank.
-
-- interrupts: A single interrupt specifier.
-
-- clocks: Clock driving the hardware; used to figure out the baud rate
-  divisor.
-
-
-Optional properties:
-
-- clock-names: Should be "refclk".
-
-Example:
-
-	uart0: serial@14e00520 {
-		compatible = "brcm,bcm6345-uart";
-		reg = <0x14e00520 0x18>;
-		interrupt-parent = <&periph_intc>;
-		interrupts = <2>;
-		clocks = <&periph_clk>;
-		clock-names = "refclk";
-	};
-
-	clocks {
-		periph_clk: periph_clk@0 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <54000000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
new file mode 100644
index 000000000000..0d4d03fc58ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm6345-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM63xx UART
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm6345-uart
+
+  reg:
+    maxItems: 1
+    description: The base address of the UART register bank
+
+  interrupts:
+    description: A single interrupt specifier
+
+  clocks:
+    description: >
+      Clock driving the hardware; used to figure out the baud rate divisor
+
+  clock-names:
+    const: refclk
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    serial@14e00520 {
+        compatible = "brcm,bcm6345-uart";
+        reg = <0x14e00520 0x18>;
+        interrupt-parent = <&periph_intc>;
+        interrupts = <2>;
+        clocks = <&periph_clk>;
+        clock-names = "refclk";
+    };
+
+    clocks {
+        periph_clk: periph_clk {
+            compatible = "fixed-clock";
+            #clock-cells = <0>;
+            clock-frequency = <54000000>;
+        };
+    };
-- 
2.26.2

