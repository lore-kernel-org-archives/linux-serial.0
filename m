Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB340C6379F
	for <linux-serial@archiver.kernel.org>; Sat, 18 Feb 2023 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBRWkR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 18 Feb 2023 17:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRWkP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 18 Feb 2023 17:40:15 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62D815577;
        Sat, 18 Feb 2023 14:40:14 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9E7AE8575D;
        Sat, 18 Feb 2023 23:40:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676760013;
        bh=i66OwvU88QCAVFI+NzcpInratk+LIJ9Xg5770zvPt48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9Wx9YAgUPH2g/dLQ7W/cwsGf8CLP46Jx5yGj921OGvUFq+CBkxiFTxNHXIgHvta0
         krlZybUmX/+Snb7SWUZZ6QTlJH2lbQEVlvAmTcw7ljlBBvLnXWSJKWgoxzgwi/Pa9p
         3W7Tm0ZNF+itDQaPa9sS7Z8ZvDaAJ/k+zf4NqHR4U3ZOK9VbvwOoupo/dCSBO+vBew
         Cnv+gqnFHvWy71D6B+sjcmVGVWvigZPNw9LF7+ZgKOFvOzk4B3NigWb8K+ed5Jj9io
         /f2LKbB9VBOfpa1h6ohzaONWR3sUSLN55xow4NkMRIeXqkkLVrZpbZ06onCzbqWNe7
         LSaOi2YwD+Zfg==
From:   Marek Vasut <marex@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: serial: imx: Document mandatory clock properties
Date:   Sat, 18 Feb 2023 23:39:59 +0100
Message-Id: <20230218223959.116358-2-marex@denx.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218223959.116358-1-marex@denx.de>
References: <20230218223959.116358-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART IP must be connected to clock, document the properties in DT bindings.
Update example to match Linux arch/arm/boot/dts/imx51.dtsi .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
---
 .../bindings/serial/fsl-imx-uart.yaml         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index c22aab8c55f83..d42061331aba3 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -49,6 +49,18 @@ properties:
   reg:
     maxItems: 1
 
+  assigned-clocks: true
+  assigned-clock-rates: true
+  assigned-clock-parents: true
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: per
+
   dmas:
     items:
       - description: DMA controller phandle and request line for RX
@@ -96,12 +108,16 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - interrupts
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/imx5-clock.h>
+
     aliases {
         serial0 = &uart1;
     };
@@ -110,6 +126,9 @@ examples:
         compatible = "fsl,imx51-uart", "fsl,imx21-uart";
         reg = <0x73fbc000 0x4000>;
         interrupts = <31>;
+        clocks = <&clks IMX5_CLK_UART1_IPG_GATE>,
+                 <&clks IMX5_CLK_UART1_PER_GATE>;
+        clock-names = "ipg", "per";
         dmas = <&sdma 18 4 1>, <&sdma 19 4 2>;
         dma-names = "rx", "tx";
         uart-has-rtscts;
-- 
2.39.1

