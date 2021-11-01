Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC6C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7242A60F56
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhKAHvR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhKAHvO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 03:51:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B0C061714;
        Mon,  1 Nov 2021 00:48:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso617741pjb.2;
        Mon, 01 Nov 2021 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/y+sLqS9ZGixbqYFwxx7tMUHHOAVVVoCMA+j/HReKg=;
        b=Lhzxja+fLzVlp0qhmakHf63zDjI2pdCIGwy74p1JVYEGMdiN1G0lh+Y0b4hlx+S9Tt
         5/b26/nXtSLZbhm2R3KLJ2rIww60bWF/mAFZ+FhKavvuE1iBVNPamE+ym70vwqhvUJzv
         5IO1SB1tsHYpaHwymDJ606iT6uVsSaEN7nrYWtE8wQViWTu+ePx2E5mu3VZDnsj51kfg
         ey3mxgfavgA93yHHNyxn1QWZ00Vl6BdxPY9v9KHfiJWkeZegieSOA710+S5qS2TPSqvF
         7ZrU2Ffd5QVFQjd8U4b+3eIBldmWCM2RNlMLnVuonDyrCNQ6GWSZALKhosxQ2s1+XvyR
         B7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g/y+sLqS9ZGixbqYFwxx7tMUHHOAVVVoCMA+j/HReKg=;
        b=PEkB8nAlORitoQWrFbHBnFjHk5i4bK1USpzl1WS6tYS2jCqxxvk1jCfDKRXdId4gY/
         KEvO0SAIB3csU+eeAWPlsOBmmzgUeJV626E1Gx5JiYaYNWKsROmF38LIFkpOv1YBXfRE
         62V2lHXgoy2qlIpWwFpsvTJP1LsaWoRs1kW4lqmQSPmGjLdFbdj9pRjk1ileLSgTj2Et
         OlhepHtwGDCmlvAgFb3N7ffS1y5veq4hJsT74q9ImgoIkoZuSC8i0WWUzEIksr5Qewht
         9xPqotV6PUwVQM3o41weCsOMaIRRV4T062JdJ8LheD8hJbphUi+2ZdV0+ddeMWh86rD6
         TEwg==
X-Gm-Message-State: AOAM5305M5qaQQ99ryp00Qnh5XYbffRcE4dSVqYCrhee33EKZ6NeONem
        bnQcczYfyWkB4uUAYQ+3tr4=
X-Google-Smtp-Source: ABdhPJzLPa4TjP759/2mk70vN+s/CyZewWhNyculo5QzgJiHvhoU+n4nuI7ymvaxER2LQCqTl3QmKg==
X-Received: by 2002:a17:90b:1c0b:: with SMTP id oc11mr2868641pjb.237.1635752921308;
        Mon, 01 Nov 2021 00:48:41 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z14sm13639061pfe.78.2021.11.01.00.48.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:48:40 -0700 (PDT)
From:   "hammer.hsieh" <hammerh0314@gmail.com>
X-Google-Original-From: "hammer.hsieh" <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
Subject: [PATCH 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Mon,  1 Nov 2021 15:48:22 +0800
Message-Id: <1635752903-14968-2-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Signed-off-by: hammer.hsieh <hammer.hsieh@sunplus.com>
---
 .../devicetree/bindings/serial/sunplus,uart.yaml   | 116 +++++++++++++++++++++
 MAINTAINERS                                        |   5 +
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,uart.yaml
new file mode 100644
index 0000000..f2ca9ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,uart.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sunplus,uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC UART Controller Device Tree Bindings
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
+        - const: UADMA
+        - const: PERI0
+      - items:
+        - const: UADMA
+        - const: PERI1
+      - items:
+        - const: HWUA
+        - const: PERI0
+      - items:
+        - const: HWUA
+        - const: PERI1
+
+  resets:
+    maxItems: 1
+
+  which-uart:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 3, 4]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/sp-sp7021.h>
+    #include <dt-bindings/reset/sp-sp7021.h>
+    aliases {
+            serial0 = &uart0;
+            serial1 = &uart1;
+            serial10 = &uartdmarx0;
+            serial20 = &uartdmatx0;
+    };
+
+    uart0: serial@9c000900 {
+      compatible = "sunplus,sp7021-uart";
+      reg = <0x9c000900 0x80>;
+      interrupt-parent = <&intc>;
+      interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clkc UA0>;
+      resets = <&rstc RST_UA0>;
+    };
+
+    // UART1 PIO mode
+    uart1: serial@9c000980 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000980 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc UA1>;
+        resets = <&rstc RST_UA1>;
+    };
+
+    // UART1 DMA mode for RX
+    uartdmarx0: serial@9c008980 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c008980 0x40>;
+        interrupt-parent = <&intc>;
+        interrupts = <138 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc UADMA>, <&clkc PERI0>;
+        clock-names = "UADMA", "PERI0";
+        resets = <&rstc RST_UADMA>;
+        which-uart = <1>;
+    };
+
+    // UART1 DMA mode for TX
+    uartdmatx0: serial@9c008a00 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c008a00 0x40>, <0x9c008880 0x80>;
+        clocks = <&clkc HWUA>, <&clkc PERI0>;
+        clock-names = "HWUA", "PERI0";
+        resets = <&rstc RST_HWUA>;
+        which-uart = <1>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..f863e97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

