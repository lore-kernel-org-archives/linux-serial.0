Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B49C64EC4
	for <linux-serial@archiver.kernel.org>; Sun, 19 Feb 2023 14:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBSOXT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Feb 2023 09:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBSOXS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Feb 2023 09:23:18 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00090F773;
        Sun, 19 Feb 2023 06:23:16 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 09DED830E9;
        Sun, 19 Feb 2023 15:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676816593;
        bh=YwYuJ4THKrUqwaPaod5OY9KB6nlV+P65S9SXqydHM2I=;
        h=From:To:Cc:Subject:Date:From;
        b=QSkdYOWGMWwyCR1RiN85cJs9tCPNhqeanVHlsAPaYQ99w8crYwuBdEpZxBPtSNnYb
         ZCcX0L1XAiDXmNNhKekDgGAGYZwrm2wFdv6xRmbrUBE6R5d86aNV5jfqjOaHYV9lQo
         04Ke/d3mI+6uBmc9gLh+E/4qbbeDX9KdwNb1Kd/5THePtGZBi6l+d2tFMlxbq7/5lS
         mP2QYcTL0hst5ayJxcrS91UonOhsnr6/PSm8A6tkGTuy+/qDRXwoGQATwUJq7zc9vZ
         4cIuPqWm4XIu58xyQd5ADXY5dhTENIP/noAxjvGcMCHfZXZmnR4z9o6UYsppXep8xf
         /QSqLJjgaSoNw==
From:   Marek Vasut <marex@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: serial: imx: Document optional DMA properties
Date:   Sun, 19 Feb 2023 15:22:49 +0100
Message-Id: <20230219142250.10176-1-marex@denx.de>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
V2: Add AB from Krzysztof
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

