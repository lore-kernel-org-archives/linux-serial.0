Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C262C61DA4
	for <linux-serial@archiver.kernel.org>; Sun, 19 Feb 2023 14:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBSOXS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Feb 2023 09:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBSOXS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Feb 2023 09:23:18 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA9CF778;
        Sun, 19 Feb 2023 06:23:17 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CB20285131;
        Sun, 19 Feb 2023 15:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676816594;
        bh=xqUsQHaWM0qX+ei7lkSB1cjJ4zw6XOWlTC6EWJiXAQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpVs0b2D4a+/yys3PxAyHDlualGzidPIjpSbJGVVf7V8ejlGibz3F9OhK+cpXJGNv
         CRMXLhwyhS34iMi9TPJGtzHXcbqmRElccHnZpVaA6hmtVkLfKNSTKCj++rfQvrc4tz
         giAdsJ0c3dzrlYevrgg2sCZqLy7Wkady7yWqfbSjDB3P1Wm78bAg6H8pgCNEiMpCiI
         SmtP1nNX4HDL5Y8IJzyBOiu/j4fQUNDMeMjDow7AG9QlDcPmPF52MIMzYrs4CLV0TF
         EnYZnV/QaP5kS6C5c2CTdIP9X9yEosTWRSB/D7vwt9MejnyBFtxH7s/y0WE0b/LFhg
         qcJU0Zj/jVWZA==
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
Subject: [PATCH v2 2/2] dt-bindings: serial: imx: Document mandatory clock properties
Date:   Sun, 19 Feb 2023 15:22:50 +0100
Message-Id: <20230219142250.10176-2-marex@denx.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230219142250.10176-1-marex@denx.de>
References: <20230219142250.10176-1-marex@denx.de>
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
V2: Drop the assigned-clock-*
---
 .../devicetree/bindings/serial/fsl-imx-uart.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index c22aab8c55f83..40414247d61a3 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -49,6 +49,14 @@ properties:
   reg:
     maxItems: 1
 
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
@@ -96,12 +104,16 @@ properties:
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
@@ -110,6 +122,9 @@ examples:
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

