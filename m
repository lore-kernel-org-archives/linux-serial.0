Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6C3C55ABD
	for <linux-serial@archiver.kernel.org>; Fri, 13 Nov 2020 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5E220857
	for <linux-serial@archiver.kernel.org>; Fri, 13 Nov 2020 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgKMGvv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Nov 2020 01:51:51 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:47683 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgKMGvv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Nov 2020 01:51:51 -0500
X-IronPort-AV: E=Sophos;i="5.77,474,1596466800"; 
   d="scan'208";a="62357456"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Nov 2020 15:51:49 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A62E2401351A;
        Fri, 13 Nov 2020 15:51:49 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     gregkh@linuxfoundation.org
Cc:     geert+renesas@glider.be, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 RESEND] dt-bindings: serial: renesas,scif: Document r8a779a0 bindings
Date:   Fri, 13 Nov 2020 15:51:36 +0900
Message-Id: <1605250296-30570-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

R-Car V3U (R8A779A0) SoC also has the R-Car Gen3 compatible
SCIF ports, so document the SoC specific bindings.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
 I should have sent this patch to Greg. I confirmed this patch can be
 applied into next-20201112. So, I resend this now.
 
 Changes from v1:
 - Add Reviewed-by Geert.
 - Add Acked-by Rob.
 https://patchwork.kernel.org/patch/11760273/

 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index f589ac7..ae29183 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -60,6 +60,7 @@ properties:
               - renesas,scif-r8a77980     # R-Car V3H
               - renesas,scif-r8a77990     # R-Car E3
               - renesas,scif-r8a77995     # R-Car D3
+              - renesas,scif-r8a779a0     # R-Car V3U
           - const: renesas,rcar-gen3-scif # R-Car Gen3 and RZ/G2
           - const: renesas,scif           # generic SCIF compatible UART
 
-- 
2.7.4

