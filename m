Return-Path: <SRS0=nzNS=BP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA2C433DF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 04:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74ED5207FC
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 04:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHEE7N (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:59:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36182 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEE7E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Aug 2020 00:59:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EFD51A037B;
        Wed,  5 Aug 2020 06:59:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E77C61A0448;
        Wed,  5 Aug 2020 06:58:56 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6512C4032B;
        Wed,  5 Aug 2020 06:58:50 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, galak@codeaurora.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] dt-bindings: serial: Convert NXP lpuart to json-schema
Date:   Wed,  5 Aug 2020 12:54:19 +0800
Message-Id: <1596603259-5367-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596603259-5367-1-git-send-email-Anson.Huang@nxp.com>
References: <1596603259-5367-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the NXP lpuart binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/serial/fsl-lpuart.txt      | 43 ------------
 .../devicetree/bindings/serial/fsl-lpuart.yaml     | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
deleted file mode 100644
index e7448b9..0000000
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Freescale low power universal asynchronous receiver/transmitter (lpuart)
-
-Required properties:
-- compatible :
-  - "fsl,vf610-lpuart" for lpuart compatible with the one integrated
-    on Vybrid vf610 SoC with 8-bit register organization
-  - "fsl,ls1021a-lpuart" for lpuart compatible with the one integrated
-    on LS1021A SoC with 32-bit big-endian register organization
-  - "fsl,ls1028a-lpuart" for lpuart compatible with the one integrated
-    on LS1028A SoC with 32-bit little-endian register organization
-  - "fsl,imx7ulp-lpuart" for lpuart compatible with the one integrated
-    on i.MX7ULP SoC with 32-bit little-endian register organization
-  - "fsl,imx8qxp-lpuart" for lpuart compatible with the one integrated
-    on i.MX8QXP SoC with 32-bit little-endian register organization
-  - "fsl,imx8qm-lpuart" for lpuart compatible with the one integrated
-    on i.MX8QM SoC with 32-bit little-endian register organization
-- reg : Address and length of the register set for the device
-- interrupts : Should contain uart interrupt
-- clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- clock-names : For vf610/ls1021a/ls1028a/imx7ulp, "ipg" clock is for uart
-  bus/baud clock. For imx8qxp lpuart, "ipg" clock is bus clock that is used
-  to access lpuart controller registers, it also requires "baud" clock for
-  module to receive/transmit data.
-
-Optional properties:
-- dmas: A list of two dma specifiers, one for each entry in dma-names.
-- dma-names: should contain "tx" and "rx".
-- rs485-rts-active-low, linux,rs485-enabled-at-boot-time: see rs485.txt
-
-Note: Optional properties for DMA support. Write them both or both not.
-
-Example:
-
-uart0: serial@40027000 {
-		compatible = "fsl,vf610-lpuart";
-		reg = <0x40027000 0x1000>;
-		interrupts = <0 61 0x00>;
-		clocks = <&clks VF610_CLK_UART0>;
-		clock-names = "ipg";
-		dmas = <&edma0 0 2>,
-			<&edma0 0 3>;
-		dma-names = "rx","tx";
-	};
diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
new file mode 100644
index 0000000..1b955f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale low power universal asynchronous receiver/transmitter (lpuart)
+
+maintainers:
+  - Kumar Gala <galak@codeaurora.org>
+
+allOf:
+  - $ref: "rs485.yaml"
+
+properties:
+  compatible:
+    enum:
+      - fsl,vf610-lpuart
+      - fsl,ls1021a-lpuart
+      - fsl,ls1028a-lpuart
+      - fsl,imx7ulp-lpuart
+      - fsl,imx8qxp-lpuart
+      - fsl,imx8qm-lpuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ipg clock
+      - description: baud clock
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: baud
+    minItems: 1
+    maxItems: 2
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  rs485-rts-active-low: true
+  linux,rs485-enabled-at-boot-time: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    serial@40027000 {
+        compatible = "fsl,vf610-lpuart";
+        reg = <0x40027000 0x1000>;
+        interrupts = <0 61 0x00>;
+        clocks = <&clks VF610_CLK_UART0>;
+        clock-names = "ipg";
+        dmas = <&edma0 0 2>, <&edma0 0 3>;
+        dma-names = "rx","tx";
+    };
-- 
2.7.4

