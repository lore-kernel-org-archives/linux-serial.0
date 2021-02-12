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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E045BC433E9
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2B264EA1
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhBLT6e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhBLT6c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Feb 2021 14:58:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D5C061756;
        Fri, 12 Feb 2021 11:57:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r38so336713pgk.13;
        Fri, 12 Feb 2021 11:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cdMQ+elftUjyjH7USNh/5P6aP07uQ7uF9FmZt+gwpFI=;
        b=avy6Z5FQyVaz47QEGUKoNp3iUwKNUUY28/Yi3NmSJEQo8u0fltmxBHJxj8iVbbCIYk
         7XY3m7M205/bzuKVNkxgNq3urgAEBwZW9PvAx2IWuQyT3iratnqCdcIvHKhR81vYiidn
         aoUu7aRVH/oF7ytPhv7PckjJYKHsM/9Y/8wi1ugM+ktQlj4Cy4mqZh6kncNxxhkDuPSt
         E2UJuPW8EvN9tRo5iY4vCUpJDbTv2fSbLU4SZLzmqcNmvujhEweGE0Cwvjwxo+NGkNwW
         jEyEtBOFu8gibvu6sBE478okvXrDGLFa0lR+/g6BckJM8krj65E+a71ep+JGEg1A6p1D
         rz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cdMQ+elftUjyjH7USNh/5P6aP07uQ7uF9FmZt+gwpFI=;
        b=AtEMO/CYUQ+sZ9EI4CnXDv6EVQyYmX5mW1oqBm1BXegphAjQo+e+JGa8ai0FZakQNY
         JYuY4F01Bgft4R48HNJ7pV43Ve09X1j57ZHEAVjNLJ3bOtCFwvc6Pvq7D7ByGsO3S5xo
         85hduQVLYz6KTQlyoV0F5BbmX+G3rYsZTBNr8hcIvDPVKoZty4nycfoau+BMiqCviKRi
         aGB0WprTBouXdYNyl/ktAAyDMAl6b9PVT6gm3Pp7A4xQynuxFQSYbl0WvdAV3u1/66nW
         rdM9EdVXYkVPFZag6WkqzhKXTEJ64GX9BN32yVb4Ku2z2rQv+SOb+MvE3t9OrwJDRBuP
         Lz7A==
X-Gm-Message-State: AOAM532vwtT3WiUedlc47szRydZs079jTZ47GlEMnkjDQZyQMx9IbgQN
        NYlj/VrRJsGtg2LZlxpzLUSry9HiBpk=
X-Google-Smtp-Source: ABdhPJyUMBIIsoHC8bdPQ1ce/1mGWNxqcOoMqQLqSbzKI566WBN84h5yoweFGo2TxGx0v3dj224MDg==
X-Received: by 2002:a65:4083:: with SMTP id t3mr4755254pgp.150.1613159871667;
        Fri, 12 Feb 2021 11:57:51 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id t25sm10003819pgo.87.2021.02.12.11.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 11:57:51 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Fri, 12 Feb 2021 14:57:35 -0500
Message-Id: <20210212195736.45328-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212195736.45328-1-alcooperx@gmail.com>
References: <20210212195736.45328-1-alcooperx@gmail.com>
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

