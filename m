Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE0C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 20 Apr 2022 08:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376871AbiDTIpu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376856AbiDTIpp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Apr 2022 04:45:45 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5DEB3B3E6;
        Wed, 20 Apr 2022 01:43:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,275,1643641200"; 
   d="scan'208";a="117435981"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Apr 2022 17:42:58 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 75AA3401073A;
        Wed, 20 Apr 2022 17:42:58 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 06/15] dt-bindings: clock: renesas,cpg-mssr: Document r8a779g0
Date:   Wed, 20 Apr 2022 17:42:46 +0900
Message-Id: <20220420084255.375700-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220420084255.375700-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add binding documentation for the R-Car V4H (R8A779G0) Clock Pulse
Generator.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
index e0b86214f0f5..e57bc40d307a 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
@@ -49,6 +49,7 @@ properties:
       - renesas,r8a77995-cpg-mssr # R-Car D3
       - renesas,r8a779a0-cpg-mssr # R-Car V3U
       - renesas,r8a779f0-cpg-mssr # R-Car S4-8
+      - renesas,r8a779g0-cpg-mssr # R-Car V4H
 
   reg:
     maxItems: 1
-- 
2.25.1

