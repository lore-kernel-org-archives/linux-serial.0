Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A1C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365CE6113D
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 07:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKJHyI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 02:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKJHyH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 02:54:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CABC061764;
        Tue,  9 Nov 2021 23:51:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id iq11so873836pjb.3;
        Tue, 09 Nov 2021 23:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhwgA5KZpQzcImnrQ/Yk0t0tGhbd6PAtYzs0+kj/fzk=;
        b=SWDvhazasvFFmH9B2XuJO/CGW5I0XXc328BCPhvJ2v0hZ84dxfkJCespP8ff5zmSbV
         6fzaDbpNyP3VuQussIsemdtoX2TU9P4boV4fielGJI42Rj+HggtbaeyCkLKUPQUsU3hk
         fA63xAq8kFHHZI07bNWcBG42P3gHuxpW0liIPTsjqXNPe66Xuik61aLrIRCmooyEZpbH
         mZgBFtQiOPz5w76dKBKdDD7SyZL6kodUIgkHkx22vFNU4BbzqKZl7GDzJxTeHRtKlO9/
         mE/ncc3YZbAXgkmYLhgcSRwERR0Clfz5gPduQ6NoGkF1D4XgSrgIquoXMYuZdsKJ/n87
         xAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhwgA5KZpQzcImnrQ/Yk0t0tGhbd6PAtYzs0+kj/fzk=;
        b=yIUrpFMnqyO8dN7cse4Q0X9h2dKP9i7o3FdbOtDInMPZQsN8aQb86iZ+rV9uMb8vjq
         VcbCgNU6FjpzPrCE/MdieorJYy7B84vJeNEcakuc+yVzSqSAA5WwEV9Q6L2464riUiwF
         P2UCLu1h1hKpNR6CQy5dZiDEKrVsN+Z/b+l+8Qs41dF3JImeV8CdqD1DpPNDO/HpkA8C
         7h2fCrf+Xj1hAuG9vs+KDtXSlA5/OWwgffeZ0hgGJSgGp1oLZo3gyN7SPzcyS92sEOpX
         iXrCryB4MdHKRnE8A9iVRUR9L/xSiz8YeU479Us0OBh4nV0PoNwjxBkS+v0uZA7QT16u
         RVcQ==
X-Gm-Message-State: AOAM531QPpNKx+HmVgOWpWHNb01R6sCPId42ZBvY0iV0YD8/032fvrQN
        qXsnjmec5cuYpKf7BLMcZrg=
X-Google-Smtp-Source: ABdhPJwwgVJY0kqXOFZA67Gdb0sATkzqnxMzD598krpyOD7+k+QU2y6/uXqdk+vd3vhsj9aofHPHXw==
X-Received: by 2002:a17:90a:2843:: with SMTP id p3mr14723416pjf.176.1636530678833;
        Tue, 09 Nov 2021 23:51:18 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id p20sm9131838pfw.96.2021.11.09.23.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 23:51:18 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v2 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Wed, 10 Nov 2021 15:51:09 +0800
Message-Id: <1636530670-6995-2-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636530670-6995-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1636530670-6995-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v2:
 - Addressed all comments from Mr. Rob Herring.

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 157 +++++++++++++++++++++
 MAINTAINERS                                        |   5 +
 2 files changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..3f46f3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
+
+maintainers:
+  - Tony Huang <tony.huang@sunplus.com>
+  - Hammer Hsieh <hammer.hsieh@sunplus.com>
+  - Wells Lu <wells.lu@sunplus.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-uart
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: UADMA
+          - pattern: '^PERI[0-1]$'
+      - items:
+          - const: HWUA
+          - pattern: '^PERI[0-1]$'
+
+  resets:
+    maxItems: 1
+
+  which-uart:
+    description:
+      UA1-4 support DMA mode, UA0 support PIO mode only.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 3, 4]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - sunplus,sp7021-uart-rxdma
+          - sunplus,sp7021-uart-txdma
+then:
+  required:
+    - clock-names
+    - which-uart
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    aliases {
+            serial0 = &uart0;
+            serial1 = &uart1;
+            serial2 = &uart2;
+            serial10 = &uartdmarx0;
+            serial20 = &uartdmatx0;
+            serial11 = &uartdmarx1;
+            serial21 = &uartdmatx1;
+    };
+
+    // UART0 PIO mode only
+    uart0: serial@9c000900 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000900 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x28>;
+        resets = <&rstc 0x18>;
+    };
+
+    // UART1 PIO mode
+    uart1: serial@9c000980 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000980 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x29>;
+        resets = <&rstc 0x19>;
+    };
+
+    // UART1 DMA mode for RX
+    uartdmarx0: serial@9c008980 {
+        compatible = "sunplus,sp7021-uart-rxdma";
+        reg = <0x9c008980 0x40>;
+        interrupt-parent = <&intc>;
+        interrupts = <138 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x2f>, <&clkc 0x1b>;
+        clock-names = "UADMA", "PERI0";
+        resets = <&rstc 0x1f>;
+        which-uart = <1>;
+    };
+
+    // UART1 DMA mode for TX
+    uartdmatx0: serial@9c008a00 {
+        compatible = "sunplus,sp7021-uart-txdma";
+        reg = <0x9c008a00 0x40>, <0x9c008880 0x80>;
+        clocks = <&clkc 0x2d>, <&clkc 0x1b>;
+        clock-names = "HWUA", "PERI0";
+        resets = <&rstc 0x1d>;
+        which-uart = <1>;
+    };
+
+    // UART2 PIO mode
+    uart2: serial@9c000800 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000800 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x2a>;
+        resets = <&rstc 0x1a>;
+    };
+
+    // UART2 DMA mode for RX
+    uartdmarx1: serial@9c0089c0 {
+        compatible = "sunplus,sp7021-uart-rxdma";
+        reg = <0x9c0089c0 0x40>;
+        interrupt-parent = <&intc>;
+        interrupts = <139 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x2f>,	<&clkc 0x1f>;
+        clock-names = "UADMA", "PERI1";
+        resets = <&rstc 0x1f>;
+        which-uart = <2>;
+    };
+
+    // UART2 DMA mode for TX
+    uartdmatx1: serial@9c008a40 {
+        compatible = "sunplus,sp7021-uart-txdma";
+        reg = <0x9c008a40 0x40>, <0x9c008900 0x80>;
+        clocks = <&clkc 0x2d>, <&clkc 0x1f>;
+        clock-names = "HWUA", "PERI1";
+        resets = <&rstc 0x1d>;
+        which-uart = <2>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..f2ee40c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

