Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79464C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E39F6112E
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKCReQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:34:16 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:52969 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230384AbhKCReP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Nov 2021 13:34:15 -0400
X-IronPort-AV: E=Sophos;i="5.87,206,1631545200"; 
   d="scan'208";a="99379500"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2021 02:31:38 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EF13440B516D;
        Thu,  4 Nov 2021 02:31:35 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/3] dt-bindings: serial: renesas,scif: Make resets as a required property
Date:   Wed,  3 Nov 2021 17:31:25 +0000
Message-Id: <20211103173127.13701-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103173127.13701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211103173127.13701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make "resets" as required property for RZ/G2L. On RZ/G2L the devices
should be explicitly pulled out of reset for this reason make "resets"
as required property.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 6b8731f7f2fb..df052dec7e63 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -151,6 +151,7 @@ if:
     compatible:
       contains:
         enum:
+          - renesas,scif-r9a07g044
           - renesas,rcar-gen2-scif
           - renesas,rcar-gen3-scif
 then:
-- 
2.17.1

