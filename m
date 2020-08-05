Return-Path: <SRS0=nzNS=BP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD0C433E0
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 04:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B4722CB3
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 04:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHEE7F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:59:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60772 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEE7D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Aug 2020 00:59:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6865F2013D5;
        Wed,  5 Aug 2020 06:59:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C7072013E5;
        Wed,  5 Aug 2020 06:58:55 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3E5A9402E5;
        Wed,  5 Aug 2020 06:58:49 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, galak@codeaurora.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] dt-bindings: serial: Convert MXS auart to json-schema
Date:   Wed,  5 Aug 2020 12:54:18 +0800
Message-Id: <1596603259-5367-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596603259-5367-1-git-send-email-Anson.Huang@nxp.com>
References: <1596603259-5367-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the MXS auart binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 53 ------------
 .../devicetree/bindings/serial/fsl-mxs-auart.yaml  | 93 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml

diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
deleted file mode 100644
index 5c96d41..0000000
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* Freescale MXS Application UART (AUART)
-
-Required properties for all SoCs:
-- compatible : Should be one of fallowing variants:
-	"fsl,imx23-auart" - Freescale i.MX23
-	"fsl,imx28-auart" - Freescale i.MX28
-	"alphascale,asm9260-auart" - Alphascale ASM9260
-- reg : Address and length of the register set for the device
-- interrupts : Should contain the auart interrupt numbers
-- dmas: DMA specifier, consisting of a phandle to DMA controller node
-  and AUART DMA channel ID.
-  Refer to dma.txt and fsl-mxs-dma.txt for details.
-- dma-names: "rx" for RX channel, "tx" for TX channel.
-
-Required properties for "alphascale,asm9260-auart":
-- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
-- clock-names : should be set to
-	"mod" - source for tick counter.
-	"ahb" - ahb gate.
-
-Optional properties:
-- uart-has-rtscts : Indicate the UART has RTS and CTS lines
-  for hardware flow control,
-	it also means you enable the DMA support for this UART.
-- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
-  line respectively. It will use specified PIO instead of the peripheral
-  function pin for the USART feature.
-  If unsure, don't specify this property.
-
-Example:
-auart0: serial@8006a000 {
-	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
-	reg = <0x8006a000 0x2000>;
-	interrupts = <112>;
-	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
-	dma-names = "rx", "tx";
-	cts-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	dsr-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-	dcd-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
-};
-
-Note: Each auart port should have an alias correctly numbered in "aliases"
-node.
-
-Example:
-
-aliases {
-	serial0 = &auart0;
-	serial1 = &auart1;
-	serial2 = &auart2;
-	serial3 = &auart3;
-	serial4 = &auart4;
-};
diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
new file mode 100644
index 0000000..096ef05
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/fsl-mxs-auart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS Application UART (AUART)
+
+maintainers:
+  - Kumar Gala <galak@codeaurora.org>
+
+allOf:
+  - $ref: "serial.yaml"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-auart
+      - fsl,imx28-auart
+      - alphascale,asm9260-auart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+  clocks:
+    items:
+      - description: mod clock
+      - description: ahb clock
+
+  clock-names:
+    items:
+      - const: mod
+      - const: ahb
+
+  uart-has-rtscts: true
+  rts-gpios: true
+  cts-gpios: true
+  dtr-gpios: true
+  dsr-gpios: true
+  rng-gpios: true
+  dcd-gpios: true
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - alphascale,asm9260-auart
+then:
+  required:
+    - clocks
+    - clock-names
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    aliases {
+        serial0 = &auart0;
+    };
+
+    auart0: serial@8006a000 {
+        compatible = "fsl,imx28-auart";
+        reg = <0x8006a000 0x2000>;
+        interrupts = <112>;
+        dmas = <&dma_apbx 8>, <&dma_apbx 9>;
+        dma-names = "rx", "tx";
+        cts-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+        dsr-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+        dcd-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+    };
-- 
2.7.4

