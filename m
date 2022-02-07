Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD9C352A1
	for <linux-serial@archiver.kernel.org>; Mon,  7 Feb 2022 14:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiBGOqQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383620AbiBGOWV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Feb 2022 09:22:21 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 424C2C0401DA;
        Mon,  7 Feb 2022 06:22:19 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,349,1635174000"; 
   d="scan'208";a="110511704"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Feb 2022 23:22:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.17])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 444A843487D0;
        Mon,  7 Feb 2022 23:22:16 +0900 (JST)
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
Subject: [PATCH v2 1/3] dt-bindings: serial: renesas,scif: Remove redundant renesas,scif-r9a07g054
Date:   Mon,  7 Feb 2022 14:22:11 +0000
Message-Id: <20220207142213.19552-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch removes redundant "renesas,scif-r9a07g054" from binding
documentation as it uses renesas,scif-r9a07g044 fallback.

Whilst remove the additional renesas,scif-r9a07g054 from Items.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
 * Added Rb tag from Geert.
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index ba5d3e0acc63..461392091579 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -73,7 +73,6 @@ properties:
       - items:
           - enum:
               - renesas,scif-r9a07g044      # RZ/G2{L,LC}
-              - renesas,scif-r9a07g054      # RZ/V2L
 
       - items:
           - enum:
@@ -167,7 +166,6 @@ if:
           - renesas,rcar-gen3-scif
           - renesas,rcar-gen4-scif
           - renesas,scif-r9a07g044
-          - renesas,scif-r9a07g054
 then:
   required:
     - resets
-- 
2.17.1

