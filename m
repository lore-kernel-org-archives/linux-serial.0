Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A953BC2D0A7
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768BE208C7
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599233114;
	bh=sGtFPuXEsVbIrliCojcp2Mbe+DlIhAJbh8Iyk2PAwVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0cUsA8KZHWPhtsv3ig6yGpuCPyhgfcDo3fR/1kXjGcaQ6qz9qP1czdO8kExIpme7
	 kvsDo8fawtQ5r6SCuftjHrHcfMJ0aL/dN3WQUE6Hk7gXCvpKdKucRynxSOtd3TzT6+
	 iWb8YmRpz6ckiPKXtXt2bXEpB2J853lBkYWPZlns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgIDPZN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730890AbgIDPZG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:25:06 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191C020770;
        Fri,  4 Sep 2020 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233105;
        bh=sGtFPuXEsVbIrliCojcp2Mbe+DlIhAJbh8Iyk2PAwVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRirnnYd3FGxe0dUFdE8DvFE0FU/H0s3bbImFJXNJW7w9evOqWZTQvYfzxOY3YSJH
         UuGEI33eBHTyUJ/lPD9ZTMWgvqgfrMRjcrklGPX6f92Z508TII5K67hwppcAVQw5dC
         oBwibSc/29+qW9X+xSWPKGcoQ3CmZglEAs2qSsgY=
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
Subject: [PATCH v3 10/14] dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible matching
Date:   Fri,  4 Sep 2020 17:24:00 +0200
Message-Id: <20200904152404.20636-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The i.MX 8M DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-thor96.dt.yaml: interrupt-controller@32e2d000:
    compatible: ['fsl,imx8m-irqsteer', 'fsl,imx-irqsteer'] is too long
    From schema: Domentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml

  arch/arm64/boot/dts/freescale/imx8mq-thor96.dt.yaml: interrupt-controller@32e2d000:
    compatible: Additional items are not allowed ('fsl,imx-irqsteer' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/fsl,irqsteer.yaml       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 360a575ef8b0..3b11a1a15398 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -11,9 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8m-irqsteer
-      - fsl,imx-irqsteer
+    oneOf:
+      - const: fsl,imx-irqsteer
+      - items:
+          - const: fsl,imx8m-irqsteer
+          - const: fsl,imx-irqsteer
 
   reg:
     maxItems: 1
-- 
2.17.1

