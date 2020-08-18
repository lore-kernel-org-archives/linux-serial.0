Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86389C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 03:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2112072A
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 03:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRDkP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:40:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44622 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgHRDkK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 23:40:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A43972016D9;
        Tue, 18 Aug 2020 05:40:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C61842016D7;
        Tue, 18 Aug 2020 05:40:02 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4B125402BE;
        Tue, 18 Aug 2020 05:39:55 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, gregkh@linuxfoundation.org,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 2/5] dt-bindings: clock: Update i.MX23 example
Date:   Tue, 18 Aug 2020 11:34:42 +0800
Message-Id: <1597721685-9280-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Update the i.MX23 clock example to align with MXS AUART binding doc to
avoid below build error:

Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml:
   serial@8006c000: clocks: [[4294967295, 32]] is too short
Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml:
   serial@8006c000: 'dmas' is a required property
Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml:
    serial@8006c000: 'dma-names' is a required property

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change.
---
 Documentation/devicetree/bindings/clock/imx23-clock.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx23-clock.yaml b/Documentation/devicetree/bindings/clock/imx23-clock.yaml
index 66cb238..4028c1f 100644
--- a/Documentation/devicetree/bindings/clock/imx23-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx23-clock.yaml
@@ -87,6 +87,8 @@ examples:
     serial@8006c000 {
         compatible = "fsl,imx23-auart";
         reg = <0x8006c000 0x2000>;
-        interrupts = <24 25 23>;
+        interrupts = <24>;
         clocks = <&clks 32>;
+        dmas = <&dma_apbx 6>, <&dma_apbx 7>;
+        dma-names = "rx", "tx";
     };
-- 
2.7.4

