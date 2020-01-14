Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1055BC33CB2
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA262467C
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0Lncu1ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgANMeD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:34:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35992 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727044AbgANMd7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 07:33:59 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ECWbZi023934;
        Tue, 14 Jan 2020 13:33:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=4Zw+r/mcuIQdGav3Gfbbdj8AtLqPaIWXCkURYNpxfY4=;
 b=0Lncu1efiEmSixKOeiOFmG4NByddmwwfZngVxnuNYqWjU7aPH7j0P1iCQpdDpYsbqdNj
 je/J2b1vm99dJ5ug1ZBQUETdhFe8abMWibYKr/zXL5DPdgRpBky41NGh/p8ZzBDIRMD9
 N2Ds3/0YRoPrAYYrWS/A6ebAYp4CgjitvWEpqnUcNRg44oJz+9nxRFJH28blG8dNLjaw
 mtnXzT4KQIBYU1GfVM9ngo3dFHFQhs4mCH9RSlpJEAoz/EE8Y7/jsdEdi9S3xEWouGWp
 NQCQSvWgsV8XTCVqA/1AE4ySCYbmwM+2buLLr4v52k6EYzlclFL/rg4z8KMQut8Ttj3C aQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf7jpddg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 13:33:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A8B010003B;
        Tue, 14 Jan 2020 13:33:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D7292AD9EB;
        Tue, 14 Jan 2020 13:33:34 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 13:33:34
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <fabrice.gasnier@st.com>,
        <erwan.leray@st.com>, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/2] dt-bindings: serial: Convert STM32 UART to json-schema
Date:   Tue, 14 Jan 2020 13:33:29 +0100
Message-ID: <20200114123329.3792-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200114123329.3792-1-benjamin.gaignard@st.com>
References: <20200114123329.3792-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert STM32 UART bindings to json-schema.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 80 ++++++++++++++++++++++
 .../devicetree/bindings/serial/st,stm32-usart.txt  | 57 ---------------
 2 files changed, 80 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
new file mode 100644
index 000000000000..238c44192d31
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/st,stm32-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Erwan Le Ray <erwan.leray@st.com>
+
+title: STMicroelectronics STM32 USART bindings
+
+allOf:
+  - $ref: rs485.yaml
+
+properties:
+  compatible:
+    enum:
+      - st,stm32-uart
+      - st,stm32f7-uart
+      - st,stm32h7-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  label:
+    description: label associated with this uart
+
+  st,hw-flow-ctrl:
+    description: enable hardware flow control
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    items:
+      enum: [ rx, tx ]
+    minItems: 1
+    maxItems: 2
+
+  wakeup-source: true
+
+  rs485-rts-delay: true
+  rs485-rts-active-low: true
+  linux,rs485-enabled-at-boot-time: true
+  rs485-rx-during-tx: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    usart1: serial@40011000 {
+      compatible = "st,stm32-uart";
+      reg = <0x40011000 0x400>;
+      interrupts = <37>;
+      clocks = <&rcc 0 164>;
+      dmas = <&dma2 2 4 0x414 0x0>,
+             <&dma2 7 4 0x414 0x0>;
+      dma-names = "rx", "tx";
+      rs485-rts-active-low;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
deleted file mode 100644
index 8620f7fcbd50..000000000000
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-* STMicroelectronics STM32 USART
-
-Required properties:
-- compatible: can be either:
-  - "st,stm32-uart",
-  - "st,stm32f7-uart",
-  - "st,stm32h7-uart".
-  depending is compatible with stm32(f4), stm32f7 or stm32h7.
-- reg: The address and length of the peripheral registers space
-- interrupts:
-  - The interrupt line for the USART instance,
-  - An optional wake-up interrupt.
-- clocks: The input clock of the USART instance
-
-Optional properties:
-- resets: Must contain the phandle to the reset controller.
-- pinctrl: The reference on the pins configuration
-- st,hw-flow-ctrl: bool flag to enable hardware flow control.
-- rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
-  linux,rs485-enabled-at-boot-time: see rs485.txt.
-- dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
-- dma-names: "rx" and/or "tx"
-- wakeup-source: bool flag to indicate this device has wakeup capabilities
-- interrupt-names, if optional wake-up interrupt is used, should be:
-  - "event": the name for the interrupt line of the USART instance
-  - "wakeup" the name for the optional wake-up interrupt
-
-
-Examples:
-usart4: serial@40004c00 {
-	compatible = "st,stm32-uart";
-	reg = <0x40004c00 0x400>;
-	interrupts = <52>;
-	clocks = <&clk_pclk1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usart4>;
-};
-
-usart2: serial@40004400 {
-	compatible = "st,stm32-uart";
-	reg = <0x40004400 0x400>;
-	interrupts = <38>;
-	clocks = <&clk_pclk1>;
-	st,hw-flow-ctrl;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
-};
-
-usart1: serial@40011000 {
-	compatible = "st,stm32-uart";
-	reg = <0x40011000 0x400>;
-	interrupts = <37>;
-	clocks = <&rcc 0 164>;
-	dmas = <&dma2 2 4 0x414 0x0>,
-	       <&dma2 7 4 0x414 0x0>;
-	dma-names = "rx", "tx";
-};
-- 
2.15.0

