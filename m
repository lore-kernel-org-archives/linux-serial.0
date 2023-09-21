Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35B7CD4938
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 00:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjIUAxV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 20:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIUAxU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 20:53:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAEF4;
        Wed, 20 Sep 2023 17:53:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bf3850bcd2so57065a34.1;
        Wed, 20 Sep 2023 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695257589; x=1695862389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1viNTB7ml3YlZmWdYbFPT33uvCHexvFTYEuiyesViWg=;
        b=NYzMLJ9o8vRK76+f91EN23U/ofuLaj4eahyMWqXDhtFB4QHsNCHzS1pXfbDx4+5M+s
         +K02LqWW63e74mMQbQ5x/uuSypY79cQIr81g0xcTt0rN3vZDb8XcBahXzGbMDVB4nfNz
         ALFvytj62NeWON2/gsntxHsymgdWl5dJ5sWsWlvNzRzitMdLqYHmbMPtVbSBTwrk5Cta
         GWJ1Q5eJ2wHfF6GR5S+i9t7BQUi6L1lySWDx6gEEu0g6bFP4ShKKwgNpr5dqU7/jrqV1
         0arEFlSi2SNmkGTMijrF2+hs2DzIOVtwtf8Ffhtfmg0occRRSPhySrAQJK8X8Gx4rUN0
         /Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695257589; x=1695862389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1viNTB7ml3YlZmWdYbFPT33uvCHexvFTYEuiyesViWg=;
        b=vOyEaB0wco/9S6zS2TO3Yre6n0ZSCjD6/Rrif6OVyJimIP4xBnQ3b8uCWQXqQMS7UO
         HimGN9bDRs7O4YV3IE+YZGa6/SQqM2T2GuWXcHOFffA9LvfhaERgNqucOEbJw5Vhj6/l
         JoXV2R7JXBIbfadRYfI7RlkPaQdr9V/BK559S2fxF4c5aOEA9jRaU+bPicD1mtgoCwvu
         qgVfc04VkugXBiCDxxiwJq5ASXISIdeF1pVHQ1GbZy6u1c9+zGEBgmc3nUeBDdKkjt5W
         GtOQJTdn1F8wz4rjrDhyvXFv8Uywn/L3rD+WVjf5I6gAPwlBuZYivqnohsAcElQN/JoU
         yEIA==
X-Gm-Message-State: AOJu0Yz1mSPdAsW4s5zYBau9zpHNedsD+nUg85J900s6mcWDtpO0hmih
        v0D3D8JLsR45qoWQ+q0U5Bg=
X-Google-Smtp-Source: AGHT+IFRYe9GGoG9K4C/xy6r6G5dhjlyflkNwm69SbbrvCIqL0gmLQF3pX4LvVF5T/srzn1h9ytY9Q==
X-Received: by 2002:a05:6830:6e9a:b0:6bc:a824:2750 with SMTP id ed26-20020a0568306e9a00b006bca8242750mr5195456otb.2.1695257588734;
        Wed, 20 Sep 2023 17:53:08 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7290:a7f7:69b2:711b])
        by smtp.gmail.com with ESMTPSA id v6-20020a9d7d06000000b006c09291cde6sm206863otn.0.2023.09.20.17.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 17:53:08 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: serial: mxs: Fix compatible list
Date:   Wed, 20 Sep 2023 21:52:58 -0300
Message-Id: <20230921005258.184705-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

imx28.dtsi uses the following description:

compatible = "fsl,imx28-auart", "fsl,imx23-auart";

Make it valid so that the following schema warning could be avoided:

imx28-apx4devkit.dtb: serial@8006a000: compatible: ['fsl,imx28-auart', 'fsl,imx23-auart'] is too long
	from schema $id: http://devicetree.org/schemas/serial/fsl-mxs-auart.yaml#

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/serial/fsl-mxs-auart.yaml   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
index 6a400a5e6fc7..da032effffe6 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
@@ -14,10 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-auart
-      - fsl,imx28-auart
-      - alphascale,asm9260-auart
+    oneOf:
+      - const: fsl,imx23-auart
+      - const: alphascale,asm9260-auart
+      - items:
+          - enum:
+              - fsl,imx28-auart
+          - const: fsl,imx23-auart
 
   reg:
     maxItems: 1
@@ -82,7 +85,7 @@ examples:
     };
 
     auart0: serial@8006a000 {
-        compatible = "fsl,imx28-auart";
+        compatible = "fsl,imx28-auart", "fsl,imx23-auart";
         reg = <0x8006a000 0x2000>;
         interrupts = <112>;
         dmas = <&dma_apbx 8>, <&dma_apbx 9>;
-- 
2.34.1

