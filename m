Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06721C2D0E2
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AAE20772
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599233161;
	bh=rOlkyLq/MJZ1DAenvWhfuxACksm2nB3ySP8n+l1ST3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKV0b1ydj+hlobqKNmB8eAdxWonxTOgtnc5b75a5lUb+F+azMsBVyZF8FUjCVS/HG
	 jdCB/XqsfI1YWPggJba6K7AcZmT+BsB8p6XLGOHHNHgg+Mjx3bqFvqkJ+iOHvwyA6a
	 tQPaf7lvlfW4k3ZpJNpDhw91j9qoHvTnYbZotFGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgIDP0A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbgIDPZK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:25:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F855207EA;
        Fri,  4 Sep 2020 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233109;
        bh=rOlkyLq/MJZ1DAenvWhfuxACksm2nB3ySP8n+l1ST3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaqVKv+51CMd2e9jRYvN5mgOE1tx7YFjPJhMSEGmg2XQ3ymKdZ66xjmWr5W96AsNt
         Sbp14LlTgVHVTrIkUavHwuloFSKQ9BRKfxRR3HfhdVUcWfFWEdsI2H+I0PoII5XAdD
         SVG53WgpDzJUZak63DFMEuU0uXbaXBR35ZNkTiXQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 11/14] dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
Date:   Fri,  4 Sep 2020 17:24:01 +0200
Message-Id: <20200904152404.20636-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible:0: 'fsl,imx8mm-gpmi-nand' is not one of ['fsl,imx23-gpmi-nand', 'fsl,imx28-gpmi-nand', 'fsl,imx6q-gpmi-nand', 'fsl,imx6sx-gpmi-nand', 'fsl,imx7d-gpmi-nand']
    From schema: Documentation/devicetree/bindings/mtd/gpmi-nand.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible: ['fsl,imx8mm-gpmi-nand', 'fsl,imx7d-gpmi-nand'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: nand-controller@33002000:
    compatible: Additional items are not allowed ('fsl,imx7d-gpmi-nand' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml     | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 3201372b7f85..28ff8c581837 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -20,12 +20,18 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-gpmi-nand
-      - fsl,imx28-gpmi-nand
-      - fsl,imx6q-gpmi-nand
-      - fsl,imx6sx-gpmi-nand
-      - fsl,imx7d-gpmi-nand
+    oneOf:
+      - enum:
+          - fsl,imx23-gpmi-nand
+          - fsl,imx28-gpmi-nand
+          - fsl,imx6q-gpmi-nand
+          - fsl,imx6sx-gpmi-nand
+          - fsl,imx7d-gpmi-nand
+      - items:
+          - enum:
+              - fsl,imx8mm-gpmi-nand
+              - fsl,imx8mn-gpmi-nand
+          - const: fsl,imx7d-gpmi-nand
 
   reg:
     items:
-- 
2.17.1

