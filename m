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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47E6C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7641161A07
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCYSxa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYSxX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 14:53:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CAEC06174A;
        Thu, 25 Mar 2021 11:53:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l123so2986755pfl.8;
        Thu, 25 Mar 2021 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KKFXv174RD/lMHqlz6ciqqrlWwy6B8R6DZMkz4CsZNg=;
        b=X7vV5cjiLbDZm9ZlyBo3xEeLGQ3lmkDdgcK8VGlVPGIlYml4oKBhO5bok59Ihz/dIa
         LVKz9U1LAWXw+FlQ1sl0Y6iVwzFjapYuhlwlljGyGApVUTZ/Xe5hFrXJJGrjUOpln+Pc
         sV9EZrqepxrxq0k8EyAmgzsXOrrQE4R2V7PajiFocFTbK34LZOzkHJ9KRQkpDikjmINQ
         /eOX2XbV9bV8/GnZAbNCl3VtuLH48PTNEHAWNotanNFZpCAgHlhusNmhITiGZ80KltKZ
         8ljSnJbMWizkIHjoo6x9k8gmkvMA8OguilQ9nf4Ww7rDo2l1/okaRWnkLu5jjgSi+QXb
         lAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KKFXv174RD/lMHqlz6ciqqrlWwy6B8R6DZMkz4CsZNg=;
        b=cRV5X2S5QGfHVyfIXgbFVCmIz3mPA6gvfSnwXLskSyW4fpUdskP42i8mCKKRrSNQXP
         KrntcBcTFq3BnGtYszj/vOWR/oN7W2AeG1TgSRxUOVrGDmdrbtFkhkHLYZPDBcwUomOH
         XlnoWgK6aNMToRSANrvF9wZxQ2nlDzkknIcwNTZ+aOhICMqRahsT22U5SI5GU3E7eUUs
         fRJpYwf3L7fqLHuc/GdotTzWhbpEJ8OCO/iP47rmce4Kq3NdFv8J9J0xG4fcVCOiT1j0
         /zC31tUql6Xwd1N156ZFyJ6R6ycJqR05C4+Sj/8DkTyqTqnjMb8PYUYGjvGW45YVjbb3
         EQVA==
X-Gm-Message-State: AOAM530PEFiTf+SgZU1d+ImJF8XhXsgbLHWVfx5+0GFmzR7ub3wUnHrY
        mEXnGoc3lTQB7cfQcrKCOy4ywb/VOlg=
X-Google-Smtp-Source: ABdhPJxJgZ8nMopnYWExsA0kl2HHJ+NBh/nw2k7072WArHKTHjDZdC0URsua0r3WexffoKatWjUcXA==
X-Received: by 2002:a17:902:b684:b029:e6:8efd:fb00 with SMTP id c4-20020a170902b684b02900e68efdfb00mr11539866pls.16.1616698402394;
        Thu, 25 Mar 2021 11:53:22 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k11sm6085961pjs.1.2021.03.25.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 11:53:22 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Thu, 25 Mar 2021 14:52:55 -0400
Message-Id: <20210325185256.16156-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325185256.16156-1-alcooperx@gmail.com>
References: <20210325185256.16156-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add DT bindings for the Broadcom 8250 based UART driver. This
UART is based on an 8250 but adds additional functionality. The
additional features include the ability to use DMA for transfers and
a baud rate clock system that is more accurate at high baud rates.
This UART is backward compatible with the standard 8250 UART.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

