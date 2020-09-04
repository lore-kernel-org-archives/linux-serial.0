Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924DAC433E2
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6390D20772
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599233113;
	bh=AsONb93CXsGCysEwXEAxnPU7VWFjSTyiaEX2pb1M2ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HA727YhMVqfdJAEgp4KCKoba7Ysm/JytpcU8sf6oq4wLHlqX2j5Kh3Qso3Y033hO5
	 hdJS75ZuRz2fA/YChWS2kaRirOw93Dk5x6cwhS/IQ0DEvx8vUkaaNhN10HLiMAMN7w
	 ksbPacAAaMnPrbJJMDNy3t1BYrHcZoQDId6AZSVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgIDPZE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbgIDPY4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DEF20772;
        Fri,  4 Sep 2020 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233095;
        bh=AsONb93CXsGCysEwXEAxnPU7VWFjSTyiaEX2pb1M2ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDpqGE7KH8BNydNe5y8eAGpsNvjKveDRcRWy/plCr6Zn+t+lb/me7GDRN3F98FfMK
         VIaoZuwzOlnAA1eMW+icWk5gDnZmWYnCkSo60x2a11m+TrFMCeDG0tzx5dqZPYq5gF
         e6IMCVUblw5xbGOYT9yDPPQ+uLCnIJ4etg6bSX6o=
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
Subject: [PATCH v3 08/14] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
Date:   Fri,  4 Sep 2020 17:23:58 +0200
Message-Id: <20200904152404.20636-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DTSes with new i.MX 8M SoCs use two compatibles so update the binding to
fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000: compatible:1: 'syscon' was expected
    From schema: Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
    compatible: ['fsl,imx8mn-ocotp', 'fsl,imx8mm-ocotp', 'syscon'] is too long

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: efuse@30350000:
    compatible: Additional items are not allowed ('syscon' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Remove moved compatibles.
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index 1c9d7f05f173..5a7284737229 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -19,21 +19,29 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,imx6q-ocotp
-          - fsl,imx6sl-ocotp
-          - fsl,imx6sx-ocotp
-          - fsl,imx6ul-ocotp
-          - fsl,imx6ull-ocotp
-          - fsl,imx7d-ocotp
-          - fsl,imx6sll-ocotp
-          - fsl,imx7ulp-ocotp
-          - fsl,imx8mq-ocotp
-          - fsl,imx8mm-ocotp
-          - fsl,imx8mn-ocotp
-          - fsl,imx8mp-ocotp
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6q-ocotp
+              - fsl,imx6sl-ocotp
+              - fsl,imx6sx-ocotp
+              - fsl,imx6ul-ocotp
+              - fsl,imx6ull-ocotp
+              - fsl,imx7d-ocotp
+              - fsl,imx6sll-ocotp
+              - fsl,imx7ulp-ocotp
+              - fsl,imx8mq-ocotp
+              - fsl,imx8mm-ocotp
+          - const: syscon
+      - items:
+          - enum:
+              - fsl,imx8mn-ocotp
+              # i.MX8MP not really compatible with fsl,imx8mm-ocotp, however
+              # the code for getting SoC revision depends on fsl,imx8mm-ocotp
+              # compatible.
+              - fsl,imx8mp-ocotp
+          - const: fsl,imx8mm-ocotp
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.17.1

