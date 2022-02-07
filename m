Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5785C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  7 Feb 2022 14:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356734AbiBGOqs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391795AbiBGOWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Feb 2022 09:22:25 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5A64C0401E0;
        Mon,  7 Feb 2022 06:22:23 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,349,1635174000"; 
   d="scan'208";a="110511708"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Feb 2022 23:22:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.17])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 854C143487D0;
        Mon,  7 Feb 2022 23:22:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: serial: renesas,sci: Document RZ/G2UL SoC
Date:   Mon,  7 Feb 2022 14:22:13 +0000
Message-Id: <20220207142213.19552-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207142213.19552-1-biju.das.jz@bp.renesas.com>
References: <20220207142213.19552-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add SCI binding documentation for Renesas RZ/G2UL SoC. No driver changes
are required as generic compatible string "renesas,sci" will be used as
a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
 * Added Rb tag from Geert.
---
 Documentation/devicetree/bindings/serial/renesas,sci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci.yaml b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
index 8dda4e10e09d..bf7708a7a2c0 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - renesas,r9a07g043-sci     # RZ/G2UL
               - renesas,r9a07g044-sci     # RZ/G2{L,LC}
               - renesas,r9a07g054-sci     # RZ/V2L
           - const: renesas,sci            # generic SCI compatible UART
@@ -67,6 +68,7 @@ if:
     compatible:
       contains:
         enum:
+          - renesas,r9a07g043-sci
           - renesas,r9a07g044-sci
           - renesas,r9a07g054-sci
 then:
-- 
2.17.1

