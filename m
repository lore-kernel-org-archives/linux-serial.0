Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A6C4332F
	for <linux-serial@archiver.kernel.org>; Fri,  4 Nov 2022 10:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiKDKnL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Nov 2022 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDKnK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Nov 2022 06:43:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF02613;
        Fri,  4 Nov 2022 03:43:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 21so7011809edv.3;
        Fri, 04 Nov 2022 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4MqsTTxjFBbRHnSsM38PsVaxjzlsoSDIyHWz7wH4SY=;
        b=Ix2doZSQpYfiHqjXG2va4uq+krp2oBXAUSiAFYjerHpknLcCyF6qPZ/HES8vjZprjm
         LFQQGAs7Ft2o8OC4iwiZvtt3HJwOJGz3dSdxZXyMTfMIvD9db+SFdq6GqR+139Bx1t/4
         VmUIfYNNELwNw67XEuwE2m59KeEGmC0KN1IbvdG3/5NBvqTLnDbGoeeaV+2N/jq7SmJa
         RdB6N9qn9fEtYB3bTT5alyOIcmC587/TW3uyy3lmVLomq+XarYPHos2JeXgUf5WrvYFn
         avo+Xvn/Znq9LfgTjQdK6ffqduIPbyJ3SESlrANF5vUjiT6ji5j7XjNrKaTcifArIpkp
         ItyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4MqsTTxjFBbRHnSsM38PsVaxjzlsoSDIyHWz7wH4SY=;
        b=E8+XeqnE48lGxFEMJtLxzVE92DQZ14VEqxWV9Gf9rKC4IW9QQZxbWm77LmIAO9QoB9
         JU/OYIsUHkg2enxjDwFtg8aiGjQ2t4FpvKxTaFB4lp4hpydqygBcoQvkXVgPHxZ6KgWg
         +QJ6130D2I1YU4UXMLKN9GsDiON8ZrgdIdWQV6l1NmTsCwdSzfBjPdfNtBClDzbg+yin
         Tc23bWFltFsYUfp3nz86vHq+bOGrFP4SQ6nEwAF72QpGDX3VbfBWtHj0HflcnW8YipAq
         OMk6A5DyTwiFMDREsA7MSy/pXKzuhSapPQU5yEOuSpsWG3VXXAel4HAYwdKZYUsY/pm7
         cj5g==
X-Gm-Message-State: ACrzQf3mPEUArwxykhwikLoksZ1Gn1ZTcmJYi0acp5Vkl3unhbkQYMi0
        FIdBJMQU2vvSI83veoCdAfWnnB8y0O8=
X-Google-Smtp-Source: AMsMyM4qsaU38ybnG5FdKbbfimKaJJ0F8Iux7nZNNNT+xUlFehOC5o4AhxiFzBBWhiBI09veRFHTfQ==
X-Received: by 2002:aa7:d65a:0:b0:462:7b99:d3b2 with SMTP id v26-20020aa7d65a000000b004627b99d3b2mr281577edr.248.1667558587944;
        Fri, 04 Nov 2022 03:43:07 -0700 (PDT)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j14-20020a1709062a0e00b007415f8ffcbbsm1638302eje.98.2022.11.04.03.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 03:43:07 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: arm,sbsa-uart: Convert to json-schema
Date:   Fri,  4 Nov 2022 11:43:03 +0100
Message-Id: <20221104104303.1534876-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the ARM SBSA UART device tree bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/serial/arm,sbsa-uart.yaml        | 37 +++++++++++++++++++
 .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
 2 files changed, 37 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

diff --git a/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
new file mode 100644
index 000000000000..afaa1ef7f2e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/arm,sbsa-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM SBSA defined generic UART
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+description:
+  This UART uses a subset of the PL011 registers and consequently lives
+  in the PL011 driver. It's baudrate and other communication parameters
+  cannot be adjusted at runtime, so it lacks a clock specifier here.
+
+properties:
+  compatible:
+    const: arm,sbsa-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+allOf:
+  - $ref: serial.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+...
diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
deleted file mode 100644
index 4163e7eb7763..000000000000
--- a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-* ARM SBSA defined generic UART
-This UART uses a subset of the PL011 registers and consequently lives
-in the PL011 driver. It's baudrate and other communication parameters
-cannot be adjusted at runtime, so it lacks a clock specifier here.
-
-Required properties:
-- compatible: must be "arm,sbsa-uart"
-- reg: exactly one register range
-- interrupts: exactly one interrupt specifier
-- current-speed: the (fixed) baud rate set by the firmware
-- 
2.38.1

