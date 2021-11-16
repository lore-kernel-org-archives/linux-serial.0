Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7887DC433FE
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617C16323A
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 07:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhKPHp6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 02:45:58 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:48885 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231324AbhKPHpn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 02:45:43 -0500
X-IronPort-AV: E=Sophos;i="5.87,238,1631545200"; 
   d="scan'208";a="100433332"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Nov 2021 16:42:37 +0900
Received: from localhost.localdomain (unknown [10.166.14.185])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A38BB4007536;
        Tue, 16 Nov 2021 16:42:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 04/16] dt-bindings: power: renesas,rcar-sysc: Document r8a779f0 SYSC bindings
Date:   Tue, 16 Nov 2021 16:41:18 +0900
Message-Id: <20211116074130.107554-5-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116074130.107554-1-yoshihiro.shimoda.uh@renesas.com>
References: <20211116074130.107554-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document bindings for the R-Car S4-8 (aka R8A779F0) SYSC block.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
index 99e8042ac111..62a49ca319ec 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
@@ -41,6 +41,7 @@ properties:
       - renesas,r8a77990-sysc # R-Car E3
       - renesas,r8a77995-sysc # R-Car D3
       - renesas,r8a779a0-sysc # R-Car V3U
+      - renesas,r8a779f0-sysc # R-Car S4-8
 
   reg:
     maxItems: 1
-- 
2.25.1

