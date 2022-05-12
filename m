Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E10C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 12 May 2022 07:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350961AbiELH1A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 May 2022 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350963AbiELH07 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 May 2022 03:26:59 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E7811312B7;
        Thu, 12 May 2022 00:26:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,218,1647270000"; 
   d="scan'208";a="119461813"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 May 2022 16:26:57 +0900
Received: from localhost.localdomain (unknown [10.226.93.50])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 28DAB400A115;
        Thu, 12 May 2022 16:26:53 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5] dt-bindings: serial: renesas,em-uart: Add RZ/V2M clock to access the registers
Date:   Thu, 12 May 2022 08:26:49 +0100
Message-Id: <20220512072649.7879-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The RZ/V2M SoC has an additional clock to access the registers. The HW
manual says this clock should not be touched as it is used by the
"ISP Firmware".

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
 - Move clock properites to top level
v4:
 - Removed "optional" from description of clock to access the registers
v3:
 - New patch added
---
 .../bindings/serial/renesas,em-uart.yaml      | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
index 332c385618e1..b25aca733b72 100644
--- a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
@@ -9,9 +9,6 @@ title: Renesas EMMA Mobile UART Interface
 maintainers:
   - Magnus Damm <magnus.damm@gmail.com>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -30,10 +27,31 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: UART functional clock
+      - description: Internal clock to access the registers
 
   clock-names:
-    const: sclk
+    minItems: 1
+    items:
+      - const: sclk
+      - const: pclk
+
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g011-uart
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
 
 required:
   - compatible
-- 
2.34.1

