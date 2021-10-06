Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D8C43217
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC82A611C5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 13:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbhJFN2f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:28:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40836 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238815AbhJFN2Z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 09:28:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44C13201A4C;
        Wed,  6 Oct 2021 15:26:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37323201A46;
        Wed,  6 Oct 2021 15:26:32 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98A7D2029F;
        Wed,  6 Oct 2021 15:26:31 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 10/11] dt-bindings: i2c: imx-lpi2c: Add i.MX8DXL compatible match
Date:   Wed,  6 Oct 2021 16:26:03 +0300
Message-Id: <1633526764-30151-11-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633526764-30151-1-git-send-email-abel.vesa@nxp.com>
References: <1633526764-30151-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add i.MX8DXL lpi2c compatible to the bindings documentation.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
index acf2d5f45f4e..f277b4de5344 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
@@ -17,10 +17,12 @@ properties:
     oneOf:
       - enum:
           - fsl,imx7ulp-lpi2c
+          - fsl,imx8dxl-lpi2c
           - fsl,imx8qm-lpi2c
           - fsl,imx8qxp-lpi2c
       - items:
           - enum:
+              - fsl,imx8dxl-lpi2c
               - fsl,imx8qm-lpi2c
               - fsl,imx8qxp-lpi2c
           - const: fsl,imx7ulp-lpi2c
-- 
2.31.1

