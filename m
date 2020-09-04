Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA354C43461
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D722074D
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599233139;
	bh=Dd93FE9oQpev+CVY2ipzNLkXaKzEf3vCB92IiF1lQ2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vuoiXq1gHb9maP6C71km01u4qNBvVc2C3menW7nAX5JwCQhCBPOyaHJMkPKbIs91g
	 b1C/qt0Wfq/cR6Dq5f2KsGp7yb+nl3GPFJG+fRoLieMqAqjxMDXei9NgHjP8ObIlip
	 UnqXmwPDV0HRPvmmgcw+UwAlpXKMPL1Hw0gaOKeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgIDPZ3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbgIDPZU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:25:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B200220772;
        Fri,  4 Sep 2020 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233119;
        bh=Dd93FE9oQpev+CVY2ipzNLkXaKzEf3vCB92IiF1lQ2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2g6yeunx3Er8BuGMgPm7rLE0oNqNL6t1jPmBNIWE1PGDPRu7FEN7h0TZI6XSmG5D
         6AMwT61dT9xL6JpEZjcNNzY9aXQ8wqaN9TUkG0S/rpylmqhSB+zNZxptTHmkhEFJiK
         ndzT/91ejUDsMmTe/jvdUAWhlr5rHwq5tXtYGa7Y=
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
Subject: [PATCH v3 13/14] dt-bindings: mtd: nand-controller: Fix matching with size-cells==1
Date:   Fri,  4 Sep 2020 17:24:03 +0200
Message-Id: <20200904152404.20636-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Most of Freescale/NXP GPMI device trees use size-cells==1 (even when
actually not needed except few boards).  This fixes dtbs_check warnings
like:

    arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: #size-cells:0:0: 0 was expected

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 40fc5b0b2b8c..0879e1108837 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -34,7 +34,10 @@ properties:
     const: 1
 
   "#size-cells":
-    const: 0
+    description:
+      Depends on your controller. Put zero unless you need a mapping between CS
+      lines and dedicated memory regions.
+    enum: [0, 1]
 
   ranges: true
 
-- 
2.17.1

