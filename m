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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53CFC433DB
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD82F65230
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCHRGM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHRFk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Mar 2021 12:05:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCAC06174A;
        Mon,  8 Mar 2021 09:05:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 16so362685pgo.13;
        Mon, 08 Mar 2021 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cdMQ+elftUjyjH7USNh/5P6aP07uQ7uF9FmZt+gwpFI=;
        b=RfZ1wsHqlDnmVhiGue1XHZymF4TNogL6v+eLIC7NgRvsjZNckJDohE8C/iYejkty2U
         61s4Z7Q3+9rtK8clTFpbVrJ1ypNGTOCKGX/fqcltSfv//ELDJG2yZQ+KQOhCKzdyJvEM
         CQ5XOhp8gnUaVJeiwm+uF20MPc4aZhZqE6GAxqXr6SMYGnckJ1ts/WOgG5qulRJ1SAg6
         a8NP8e/PeyVIrpSbeLCZYlj89sbD86ZfJmyD3J4WDeDw4koa5UkfNaJb1dVq6Erkb+Kh
         h3XZhgmH/Wp5fWLTA/jVkKYU1WiQgrU3NQ9A+6PTgDaL0vJJM6MLd/8aV+3V0CJ9ToGT
         nAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cdMQ+elftUjyjH7USNh/5P6aP07uQ7uF9FmZt+gwpFI=;
        b=iTw/Zr98dlSi2pFd0UFtzG1AFphCmKk+1kpWC1pRr1H9arHJ5IYinQ+bDnkYK/GjuN
         lX7or+7SMEvFgzjqn7ifCwUeAGldEfxjebd8XWOPKJ5cHnsCgLGR1CWCTMwzg0+06KWs
         ap3/Fbc7PzINijBPpP6phZIfNEqoLhhnLpxkYLHO3F/rfv0u+31YZ0TZ9T/LvWwvtE7Z
         GrSNNyaAk7ywZRljhS+RjNWzkCRy0wN35akPFRuWioD4Zdvv8TpYXjGepWTncJwkpLIK
         EWziSmh1LJzCJfGDH0ooVM+vUMtgMiDPnhLrfstlAwLLLCXBp2wSVzxD2BYTJ63u/nLn
         /jXg==
X-Gm-Message-State: AOAM531ZQUgL5uklecoFZ9TGLVGYgYV/Cn0zeoIKrXYFygAo8PcpJf0f
        mlU3cBQ4BD2wT5DiccRUVGezmtcFz1o=
X-Google-Smtp-Source: ABdhPJx0M3RFDCniC7Are3Lz8H4MpSC3APbgJXZuvNN/sOIRAYjw8azGe6jQckuElEtAk3AYKgcYHw==
X-Received: by 2002:a62:7f52:0:b029:1f3:7273:1242 with SMTP id a79-20020a627f520000b02901f372731242mr10199081pfd.70.1615223139931;
        Mon, 08 Mar 2021 09:05:39 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a21sm4980477pfh.31.2021.03.08.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:05:39 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Mon,  8 Mar 2021 12:05:21 -0500
Message-Id: <20210308170522.4272-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308170522.4272-1-alcooperx@gmail.com>
References: <20210308170522.4272-1-alcooperx@gmail.com>
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

