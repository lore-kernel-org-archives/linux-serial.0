Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F3C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 20:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A9B64EBF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBSUiY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSUiX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 15:38:23 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A4C061786;
        Fri, 19 Feb 2021 12:37:43 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m2so5670966pgq.5;
        Fri, 19 Feb 2021 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cdMQ+elftUjyjH7USNh/5P6aP07uQ7uF9FmZt+gwpFI=;
        b=KxFh64Wi2PLidK0cjEdHFthsJQhdSIBrAXywqFow21HnGN/p0nG1zx9V4f3rczifyc
         7u2Dqj1NFGEMoJbQGUaRtRWkkxT/06CNtFRIghBWMbE5/iMwncJ3RK34kCP+00R+3uvu
         J98D5NhPypfWOLyvp/xcl7CBpy0aSmtulRv9KOEsmhySr+s5e40ub4OYL67BSOvhP1mn
         JmX3/WVOHaZlicAWN76uUpz8yQ71CCAsuA3a8lfUDIMAEbAYxSb2C9oIjBhkAA4CrF7m
         cskclVZOYZvg0XnA+m8SLfWZHlzksthX5arvItL/jvLXOT3PFk3Fut7BUnfEGjVkkJNs
         IRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cdMQ+elftUjyjH7USNh/5P6aP07uQ7uF9FmZt+gwpFI=;
        b=t1oZ/BCBwK43WnOHXOzl2+jbNqB/yrGnhNVQ342DJ9+/HfLPhPLstb/UewkljXZHHd
         WSb1DEn3dwP+PusBXg6gqQTvyBZNFH6PI6YedeXFvQ04ZbKrKnf6Jl/gKo21c8Zc/srZ
         q3GkW5Ir9vo5M2k1xHcdCOzSv8nUDPjyGfNZijfy1/aDUWk2LlxZNsSKOSr/lQ8+MERJ
         d/JTPQxH6itF16i2F17qc/KPfcuZPfQ6hEDbxeIvrVY0F3W05lVUhfP1aVX1DRQM6+9u
         iagNBW5dOMq/Nh5aIZxsjrElZWlDwT4VonadlcoCQrDG+8VOYjduzSZgW1wEX7nYVp9I
         HtOw==
X-Gm-Message-State: AOAM531WBWvKBMwph6TtpctX2BvlEUzTs4qri2UyCH5Lk+vGXn/zfbZr
        vccmp4y89PDXq5COq4qLdUJI2k/FDro=
X-Google-Smtp-Source: ABdhPJxdMaincxlNYljBSw6BpJFZf/lA/XFaNKF1lfXFvlJ7KBHToM2hCs8Is0RNaEPsfObqWYZYkA==
X-Received: by 2002:a62:17c3:0:b029:1ec:f673:6805 with SMTP id 186-20020a6217c30000b02901ecf6736805mr11101882pfx.73.1613767062345;
        Fri, 19 Feb 2021 12:37:42 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i2sm9040152pjj.35.2021.02.19.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 12:37:42 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Fri, 19 Feb 2021 15:37:07 -0500
Message-Id: <20210219203708.49056-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210219203708.49056-1-alcooperx@gmail.com>
References: <20210219203708.49056-1-alcooperx@gmail.com>
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
 .../bindings/serial/brcm,bcm7271-uart.yaml    | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
new file mode 100644
index 000000000000..f3d58e613480
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -0,0 +1,96 @@
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
+description: |+
+  The Broadcom UART is based on the basic 8250 UART but with
+  enhancements for more accurate high speed baud rates and support
+  for DMA.
+
+properties:
+  $nodename:
+    pattern: "^serial@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm7271-uart
+          - brcm,bcm7278-uart
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
+    oneOf:
+      - items:
+          - const: uart
+      - items:
+          - const: uart
+          - const: dma
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
+additionalProperties: false
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

