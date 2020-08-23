Return-Path: <SRS0=E9Is=CB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D4C433DF
	for <linux-serial@archiver.kernel.org>; Sun, 23 Aug 2020 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FDB20767
	for <linux-serial@archiver.kernel.org>; Sun, 23 Aug 2020 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598199443;
	bh=1X/cRmfopwt+rCsRoYRr5R5QW8XW/gYCIDl6hjON3qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UWHcZsgLPs/lAiv3Z71xpbqeJsC7vbRG6iVFC7RFO8qP4AUpUYCocniA9Dtt7E5ht
	 DntR0baC//22CwjGqWdDCKaLpqb5kWcYyyKxzUAZUrs8EVyBFaXdyaICMeqsTQKeGs
	 Yl0/cbS+UGdqt8/1MvtkJxRiaSaAoFpgQpiM3p40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHWQRS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgHWQRL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:11 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3BC72072D;
        Sun, 23 Aug 2020 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199431;
        bh=1X/cRmfopwt+rCsRoYRr5R5QW8XW/gYCIDl6hjON3qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmxIKuI0++TYe9fb9g6cyyUrwH9XYJ6k5PXI+/VqYSNFPo4x2EIXeD/6b3/YO/9Z5
         Nm0uZORFSVdiL8NVmYUoiu/w+rB3+zxfMAKDZ7eCd3+DeDav3kfCSYLNK4Lr5DRdlY
         vv+cL69/sf2gnMqWSl3I8uTPr85T8nzUd5PY3Bb8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 16/22] dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible matching
Date:   Sun, 23 Aug 2020 18:15:44 +0200
Message-Id: <20200823161550.3981-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
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

