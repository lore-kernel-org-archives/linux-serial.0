Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663ADE7D0B2
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 22:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjIUWVS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjIUWUs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 18:20:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15AA153D;
        Thu, 21 Sep 2023 10:57:30 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-410963ebf07so1512561cf.0;
        Thu, 21 Sep 2023 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319049; x=1695923849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIEs5IFkp0iH/kCWigHwr3kuVt14bZdFzb/PS8h27Zs=;
        b=jPTfFuaPPm5dmraoImJFAiPaN37Fn/U3aN18B+C/oSiRV4ZMzGCQUGWd421eKuUT16
         qDFgue98gCPwZtFIiVWvNE0CgWL5aDbuxxKduzpBoAIJmUn0n5wQSZ3i7Q/DNG8uVPgj
         imYejLkNft6urIvo9HgGBJCltAX5XPjMDJgMbLwyPX2aKNldwOW9K0dlCLwq8vDD7pgQ
         y4e5pJotkHlMVWb0LutKk9WBM/rTAWOdijgj/eEtEgkDrvD+Cd/hS+7mPXOoTVOx2lBG
         8qjc3IfoZG9oP9K2sMEr1LT5SLHklhE/XGc+5w4r3FOE0KeeZXGckj8auERMKHMa4g/c
         Uh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319049; x=1695923849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIEs5IFkp0iH/kCWigHwr3kuVt14bZdFzb/PS8h27Zs=;
        b=Sqg1yrchr2Jdmxym2998dNRgID34oPVtkRqxq4q3+9xuHiD8xGTdlH1CfhsWbyMzAK
         /H3QHcqtoa7MzmkNu8d7Jq3xUa27KN4UsaCT5G9jwvA8wFq29kggz8dsb8wuMRH8h72o
         LfBzP43N3JF05muPs+407K/NUg6F9gperjNdNMnroBjED44FXRTDbCalxEBy/+LuzNZj
         +C3e+HINM0Drx0IoFyXdjOsp8zyyf4Pfmp3vtU64+OGxTSYx3L1TWC49q0s1jOSHTCt1
         yxrMBPjj7oVypfhRVmU5WZadc+1MPjWHpeTQ5rJzJC0f3cfEaHnIWW8/xxmi02r39d9L
         iOaQ==
X-Gm-Message-State: AOJu0Yxxpj+tnp+VC4Vi5IZG23ZKJsad1tR+FrP8ejh8cTrY17AfN6S/
        iNgOl21psmiNqd50/vk9c+tOcxqjh00=
X-Google-Smtp-Source: AGHT+IGSIDTbIImaAWwLzFAoixWsqmeShFILnMKGDFq3KVz5kaSPNxsFz3aA8FcYmgQxO7YaDvUt5g==
X-Received: by 2002:a17:903:120b:b0:1c3:6d97:e897 with SMTP id l11-20020a170903120b00b001c36d97e897mr5328008plh.5.1695303478085;
        Thu, 21 Sep 2023 06:37:58 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3568:5db2:51a5:e134])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001bba373919bsm1470825plb.261.2023.09.21.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:57 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: serial: mxs: Fix compatible list
Date:   Thu, 21 Sep 2023 10:37:33 -0300
Message-Id: <20230921133733.224602-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

imx23 and imx28 are SoCs from the same family (mxs) and they share the
same AUART block, so the same programming model.

imx23 is the first member of this family. It had an AUART DMA erratum.
imx28 is the second member of this family and has this erratum fixed.

imx28.dtsi uses the following description:

compatible = "fsl,imx28-auart", "fsl,imx23-auart";

Make it valid so that the following schema warning could be avoided:

imx28-apx4devkit.dtb: serial@8006a000: compatible: ['fsl,imx28-auart', 'fsl,imx23-auart'] is too long
	from schema $id: http://devicetree.org/schemas/serial/fsl-mxs-auart.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- Improve the commit log to indicate that imx28 AUART is compatible
with imx23.
- Collected Conor's Acked=by tag.

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

