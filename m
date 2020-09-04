Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04EAC433E2
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10C12087E
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599233222;
	bh=g3o7tt+MugsYL++tcyWf98GZHjVPsCkdOLiyqZCrTPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nLfGUj9fiz9Hc3B0gXsUzOWvfWFKyTuyn4ci9M0bZogn4uHYLAfQ4/KxkWeOHkEQa
	 avxgURbZjnQUuIHjinFIyJWi2EESRSEKocQ1NK+bYHv358E1E87uBMa1guQsieBIpR
	 S38I2TNb9g99c1n8wcCdacoOoSlwahKrwtioUuiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgIDP1B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbgIDPYd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:33 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144C62074D;
        Fri,  4 Sep 2020 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233072;
        bh=g3o7tt+MugsYL++tcyWf98GZHjVPsCkdOLiyqZCrTPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvp3tLsxj+Tz4tpJJg9/Iws16vsVTfn4cqnHRQFd0/97FP/oVJnzW1uiArHnInweg
         yGz6XtT17i0HHAGBbOOPnRfA+VHYNpfvEfTCJ+zJkorCGwS/UGzGh9ds4TZdcf7kin
         EmQ/SZY+TweAb5oyuButZC0OsvZ4WUTx/H7H+8X0=
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
Subject: [PATCH v3 03/14] dt-bindings: serial: fsl-imx-uart: Add i.MX 8M compatibles
Date:   Fri,  4 Sep 2020 17:23:53 +0200
Message-Id: <20200904152404.20636-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible:0: 'fsl,imx8mm-pwm' is not one of ['fsl,imx1-pwm', 'fsl,imx27-pwm']
    From schema: Documentation/devicetree/bindings/pwm/imx-pwm.yaml

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible: ['fsl,imx8mm-pwm', 'fsl,imx27-pwm'] is too long

  arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: pwm@30660000:
    compatible: Additional items are not allowed ('fsl,imx27-pwm' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Fix subject prefix
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index cba3f83ccd5f..3d896173b3b0 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -36,6 +36,10 @@ properties:
             - fsl,imx6sx-uart
             - fsl,imx6ul-uart
             - fsl,imx7d-uart
+            - fsl,imx8mm-uart
+            - fsl,imx8mn-uart
+            - fsl,imx8mp-uart
+            - fsl,imx8mq-uart
           - const: fsl,imx6q-uart
 
   reg:
-- 
2.17.1

