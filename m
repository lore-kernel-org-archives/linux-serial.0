Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F050C4332B
	for <linux-serial@archiver.kernel.org>; Thu, 18 Mar 2021 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8B964F1D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Mar 2021 19:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhCRTMQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Mar 2021 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhCRTLt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Mar 2021 15:11:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA4C06174A;
        Thu, 18 Mar 2021 12:11:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso3619981pjb.4;
        Thu, 18 Mar 2021 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9luHhfTqWdvE85yqry4Cvgk9eeO5qokQbkeUs//YepA=;
        b=CnAzd4qMHj1kfTYJ06PTaTGhc/6rRFl4fqHxKpLDqPGh5viymPV3iJWqMad2vMaIyx
         e/Yy8vpwfOiH/SBLPln+EArhgdd8JpJPHXT/cbLBl3mBLrmw1spVfr21FZRXmXS2GKpc
         azuJvP5uIAHP/ukrw/D4Imy1JvpDqJhSpIoVMRfp6rETodwK6XBGUHtl4oTT1xTgeuOD
         NUCbs9bQ59Ljg7L6F2f4or/fsOXd+selTl4mcLStQJ8nEOmpU4v7cxvfRrT9uo7LtFcW
         UYqSoB57UTTFw0BAQUr4oHm7WU95gD6F+F0jeg2Lf9YLDYPAFZ0dIvQWre1qpcJGaqx6
         Tpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9luHhfTqWdvE85yqry4Cvgk9eeO5qokQbkeUs//YepA=;
        b=LMaV3TM65hVUcOk+v3t/vK3CboMhHveGfskYfaJeqtkXOxMpeSnOZdfrL5Y9hsElfo
         ZD2s0o9/UyIgBZdfjglP8wsRXWzbsjjvErLXBrE4zTHxIhFE4e35a4GjwX/jNPDMEwDs
         LJ3H2++lF+ZKw5H7n6f1kmCU/RBMqH8WkLsN3IxAmuTmRxxfN64BBtbfytjCiXbD2LNO
         2HIuWgk9CPls+1Ckl/PEvDQM/DqO6gcw3BabiW8/qJNuFL+sMJRPc87gfTUkeiKrV68n
         +k3AuwC8vtLwp0nDL0Hf8kZPIOHTT0npXpb3iuZbIjAOB6AJHHgAYPzGqTGXCDtyiZ64
         QdHg==
X-Gm-Message-State: AOAM531F7vUKPpGAxTWwqmnEbHlw+UMwSLgYYYFNasbUhrx4GDLiIb/U
        0QVXyGJ2+ZfcQKnitgy1x6OaMPxcpBU=
X-Google-Smtp-Source: ABdhPJyNgYTH3Rw2FplX6nIAzZOEXGRrFbeVfwIQnAtcoM8j/db2sG2hFy641zzNSJY9/A0a8RMSbA==
X-Received: by 2002:a17:90a:2a46:: with SMTP id d6mr5754702pjg.197.1616094708365;
        Thu, 18 Mar 2021 12:11:48 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id na8sm3020711pjb.2.2021.03.18.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:11:48 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Thu, 18 Mar 2021 15:11:30 -0400
Message-Id: <20210318191131.35992-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318191131.35992-1-alcooperx@gmail.com>
References: <20210318191131.35992-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add DT bindings for the Broadcom 8250 based UART driver. This
UART is based on an 8250 but adds additional functionality. The
additional features include the ability to use DMA for transfers and
a baud rate clock system that is more accurate at high baud rates.
This UART is backward compatible with the standard 8250 UART.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/serial/brcm,bcm7271-uart.yaml    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
new file mode 100644
index 000000000000..46c62745f901
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm7271-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom 8250 based serial port devicetree bindings
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+description: |+
+  The Broadcom UART is based on the basic 8250 UART but with
+  enhancements for more accurate high speed baud rates and support
+  for DMA.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm7271-uart
+          - brcm,bcm7278-uart
+
+  reg:
+    minItems: 1
+    maxItems: 5
+
+  reg-names:
+    description: The UART register block and optionally the DMA register blocks.
+    oneOf:
+      - items:
+          - const: uart
+      - items:
+          - const: uart
+          - const: dma_arb
+          - const: dma_rx
+          - const: dma_tx
+          - const: dma_intr2
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    const: sw_baud
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description: The UART interrupt and optionally the DMA interrupt.
+    minItems: 1
+    items:
+      - const: uart
+      - const: dma
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@840d000 {
+        compatible = "brcm,bcm7271-uart";
+        reg = <0x840d000 0x20>;
+        reg-names = "uart";
+        interrupts = <0x0 0x62 0x4>;
+        interrupt-names = "uart";
+        clocks = <&scmi_clk 190>;
+        clock-names = "sw_baud";
+    };
+
+    serial@840e000 {
+        compatible = "brcm,bcm7271-uart";
+        reg = <0x840e000 0x20>,
+              <0x840e080 0x8>,
+              <0x840e100 0xa8>,
+              <0x840e200 0x4c>,
+              <0x840e300 0x30>;
+        reg-names = "uart", "dma_arb", "dma_rx", "dma_tx", "dma_intr2";
+        interrupts = <0x0 0x62 0x4>, <0x0 0x75 0x4>;
+        interrupt-names = "uart", "dma";
+        clocks = <&scmi_clk 190>;
+        clock-names = "sw_baud";
+    };
-- 
2.17.1

