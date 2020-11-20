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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEBCC64E75
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA1D206B6
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 19:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSnBMHjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKTTpv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgKTTpv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 14:45:51 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38142C0613CF;
        Fri, 20 Nov 2020 11:45:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so8170461pgm.9;
        Fri, 20 Nov 2020 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISDBl7x5aT3VMD5118I7MhqiM7zCHqmwmWuDdXc0/xo=;
        b=VSnBMHjxhoyb30+qkkl1QMHmtIiBs3ZDhVSxthSpa6SPPozuj3RO6PSS4+fVQPyEPP
         iC1zZ28Hs41uSSU83lDs9I19/VzDlB/3QR8AXgLQ3v3K7uhezj/2HgpSEKsFlp2UQos6
         P7UG47xK2kbx4YrCb5yjMtgYHEM9pj5FtO0kgAC1X3FIjjxtzwbY04V0fIKN8eRUoKF9
         M07ooFfOIooSh1tMtUvY4qHFWeqhylUEqkuRSrFtkpIgwZHJw7FUusSnKy8QoPDdgl3X
         8OfdXQKF41csZC7MUMrdFVT8j2MNH977FyNgUGPYIF3wcJ2xLbMd9FWXKahcggn9YGyY
         aKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISDBl7x5aT3VMD5118I7MhqiM7zCHqmwmWuDdXc0/xo=;
        b=g9+QuS9brWo/92r9cTDnuoX7jR7ne0qrn/wAARfTC1/bmsnu5qyhAWeH7rTCwOn+O6
         rwXPUeTIV8uK8l8BaeSn5AzyxGTT8VZi8qGh+hgd1lZQV7S2WNGY3TPr3qQS7ycHtqtl
         1TAl68ADAy8kNkDC7QKGNZ6fzT+HmK1Q4avPMM6LQTxZCnl2eF5usvEdpFN9B8BK0zd3
         Z9pOo8DDBXU0de6OYsoHHGB7k9LilX3EwS3Avi1BxlBqnAvy6Hgp9T0u6+NiFbNVk4Au
         HgAkpEVmZApPB1AX68vtOg2uV20bab1SX7q4iMfOS+c6sXgpqb07c/LpJH+lU+8vyhSS
         dvpQ==
X-Gm-Message-State: AOAM530Tuillq94uv5zE7pU/4R5jFw4apo64ahX39Go1+4hbzyFZUOIo
        zjbICVBIGAZZRXx//klPKMsZtMYiugA=
X-Google-Smtp-Source: ABdhPJzlDsClkVoWeLJDR9+Sx1MsdTg0WCB/wA/Qwl264pz3NaARVQJ1ZYnibVZcthOgqZHkKzAvVg==
X-Received: by 2002:a65:6396:: with SMTP id h22mr18517534pgv.232.1605901550511;
        Fri, 20 Nov 2020 11:45:50 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm3755884pgg.74.2020.11.20.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:45:50 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] dt-bindings: Add support for the Broadcom UART driver
Date:   Fri, 20 Nov 2020 14:43:04 -0500
Message-Id: <20201120194305.8847-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120194305.8847-1-alcooperx@gmail.com>
References: <20201120194305.8847-1-alcooperx@gmail.com>
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
 .../bindings/serial/brcm,bcm7271-uart.yaml    | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
new file mode 100644
index 000000000000..76aff2c21394
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -0,0 +1,94 @@
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

