Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A1C11D00
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 02:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CB620722
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 02:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bP5C+o1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgBUCVl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:21:41 -0500
Received: from condef-08.nifty.com ([202.248.20.73]:36409 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCVk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 21:21:40 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 21:21:39 EST
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-08.nifty.com with ESMTP id 01L2CTsZ010953
        for <linux-serial@vger.kernel.org>; Fri, 21 Feb 2020 11:12:30 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01L2BcSM007985;
        Fri, 21 Feb 2020 11:11:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01L2BcSM007985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582251099;
        bh=S6KuamcJ1OBT86PX3D7Tj8TPgwjtQvO9qJMRN7CA9Sg=;
        h=From:To:Cc:Subject:Date:From;
        b=bP5C+o1tC+E9hv5J5syDpuFvhBqNpknB2WyJ2baKXHhcmVRh8GDmanjoZMpOBICj1
         Ox9d+M4ZoGw/UDKDaXlwh3sco0vjv0qP4UES/N+BqBz2+2Svj1OtjVBGv8RFpbzxcC
         0v8qtsDzHCf1LzijftYYXUqocPNu/b3PZ2LYJxyT9RExIh+Ud1cipy807XIIp9wqeE
         aNDG8CEs34N7buyci33PMVFul+CE20sY5dSbraNjTikAuktwQ3gTEZ0IRq7UohLs/x
         gUovN9s7BtNvCm7J1IBrdGxuT8VlB5YhJlN4Va1b4r0ocUAGlPAwJ5DOyEjjSNFUTK
         IvhAM71WAHlow==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert UniPhier UART to json-schema
Date:   Fri, 21 Feb 2020 11:11:36 +0900
Message-Id: <20200221021137.19443-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the UniPhier UART binding to DT schema format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../serial/socionext,uniphier-uart.yaml       | 46 +++++++++++++++++++
 .../bindings/serial/uniphier-uart.txt         | 22 ---------
 2 files changed, 46 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/uniphier-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
new file mode 100644
index 000000000000..09a30300850c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/socionext,uniphier-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier UART controller
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+properties:
+  compatible:
+    const: socionext,uniphier-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  auto-flow-control:
+    description: enable automatic flow control support.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    aliases {
+        serial0 = &serial0;
+    };
+
+    serial0: serial@54006800 {
+        compatible = "socionext,uniphier-uart";
+        reg = <0x54006800 0x40>;
+        interrupts = <0 33 4>;
+        clocks = <&uart_clk>;
+    };
diff --git a/Documentation/devicetree/bindings/serial/uniphier-uart.txt b/Documentation/devicetree/bindings/serial/uniphier-uart.txt
deleted file mode 100644
index 7a1bf02bb869..000000000000
--- a/Documentation/devicetree/bindings/serial/uniphier-uart.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-UniPhier UART controller
-
-Required properties:
-- compatible: should be "socionext,uniphier-uart".
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: phandle to the input clock.
-
-Optional properties:
--auto-flow-control: enable automatic flow control support.
-
-Example:
-	aliases {
-		serial0 = &serial0;
-	};
-
-	serial0: serial@54006800 {
-		compatible = "socionext,uniphier-uart";
-		reg = <0x54006800 0x40>;
-		interrupts = <0 33 4>;
-		clocks = <&uart_clk>;
-	};
-- 
2.17.1

