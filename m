Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F84C61DA4
	for <linux-serial@archiver.kernel.org>; Sat, 18 Feb 2023 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBRWkQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 18 Feb 2023 17:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRWkP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 18 Feb 2023 17:40:15 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7FD15576;
        Sat, 18 Feb 2023 14:40:14 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E3A0685754;
        Sat, 18 Feb 2023 23:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676760012;
        bh=w44yS3t8CrsWkl32S0qz3S+DPitSF+ixPZhyPD5jjGc=;
        h=From:To:Cc:Subject:Date:From;
        b=E9Ytg+TMWnlN8cJYWgxx2zh4VxdglTn67PPIngVIkTJ1xt2C0fHjz+EfCMaGl9hNk
         Np2bJxCdHiQd7GsKfQ3f+g57CkQZ20LKig4v+NZyB3s5Wd2n2SEuRX3Ac6iTqmWT5H
         +4vmeU1Q7WbCbpPCypNt5aAMJk2OZt5HSSqaxIn+Qe2Eg2w939fyJYwa0PAGiOcZ8w
         0eXMsiZhG1KiQV8m1FOv/VRiQiOubvhCNyhNyT1FW5+mHIvcEiB+fnKFevYe3YUvV1
         mKVrO+LlMGC0EC4Sk1mhdIvj4221OBBY9ksqAfvrJBMLoxK7QF2Lqvg1ZwU6x36RXA
         hos8EqtuqKToQ==
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
Subject: [PATCH 1/2] dt-bindings: serial: imx: Document optional DMA properties
Date:   Sat, 18 Feb 2023 23:39:58 +0100
Message-Id: <20230218223959.116358-1-marex@denx.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART IP can be connected to DMA engine, document the properties in DT bindings.
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
 .../devicetree/bindings/serial/fsl-imx-uart.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 4cbe76e1715b7..c22aab8c55f83 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -49,6 +49,16 @@ properties:
   reg:
     maxItems: 1
 
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
   interrupts:
     maxItems: 1
 
@@ -100,6 +110,8 @@ examples:
         compatible = "fsl,imx51-uart", "fsl,imx21-uart";
         reg = <0x73fbc000 0x4000>;
         interrupts = <31>;
+        dmas = <&sdma 18 4 1>, <&sdma 19 4 2>;
+        dma-names = "rx", "tx";
         uart-has-rtscts;
         fsl,dte-mode;
     };
-- 
2.39.1

