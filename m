Return-Path: <SRS0=gGpx=DC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01DBC4727F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 21:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD621D7F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601069220;
	bh=4OopqUnEcTLExYZaWDXGbYmtSJpJSUEIHusGmHSfRjM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=usvF/l62vQB5ZZMnsrnhrjrq/0KyGuVPvBwzBpp+NUzyZRtGRxI8hd7Ptk+Xz+IH0
	 L322uF58jmtPP9g6Lb8E8myc66iv1GdJ0pBMQSwmCrny0hJ3170aHZf71jMMNkDFWm
	 rmdrnIZgLH/40/Y9Qf2We1UPecfRxAT75Pl9WFeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgIYV07 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Sep 2020 17:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgIYV07 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Sep 2020 17:26:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B3A21741;
        Fri, 25 Sep 2020 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601069219;
        bh=4OopqUnEcTLExYZaWDXGbYmtSJpJSUEIHusGmHSfRjM=;
        h=From:To:Cc:Subject:Date:From;
        b=TRg+gzv8xHv7fEkMRd/1a1i/a5WES6YobP0sJlSf+wX35TMMHqzDpkQQT5tnlROGd
         AvmWhMGlJQdcmHJb6KyA+A+++a+0H0Wkz9J6MCVWMJpVzfL6Afva5ElMqSNnmue04N
         e0RQqNIu4lMstQTXH9f3JV1vkqrEQCDQzFZQLnhE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: serial: fsl-imx-uart: fix i.MX 53 and 6 compatible matching
Date:   Fri, 25 Sep 2020 23:26:49 +0200
Message-Id: <20200925212649.23183-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The i.MX 53 and i.MX6Q DTS use two compatibles, i.MX 6SL/6SLL/SX three
so update the binding to fix dtbs_check warnings like:

  serial@21ec000: compatible: ['fsl,imx6q-uart', 'fsl,imx21-uart'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/serial/fsl-imx-uart.yaml          | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 3d896173b3b0..9ff85bc6859c 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -18,8 +18,6 @@ properties:
     oneOf:
       - const: fsl,imx1-uart
       - const: fsl,imx21-uart
-      - const: fsl,imx53-uart
-      - const: fsl,imx6q-uart
       - items:
           - enum:
             - fsl,imx25-uart
@@ -28,12 +26,18 @@ properties:
             - fsl,imx35-uart
             - fsl,imx50-uart
             - fsl,imx51-uart
+            - fsl,imx53-uart
+            - fsl,imx6q-uart
           - const: fsl,imx21-uart
       - items:
           - enum:
             - fsl,imx6sl-uart
             - fsl,imx6sll-uart
             - fsl,imx6sx-uart
+          - const: fsl,imx6q-uart
+          - const: fsl,imx21-uart
+      - items:
+          - enum:
             - fsl,imx6ul-uart
             - fsl,imx7d-uart
             - fsl,imx8mm-uart
-- 
2.17.1

