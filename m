Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB5C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 21 Oct 2022 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJUOCn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJUOCf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Oct 2022 10:02:35 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED327A890
        for <linux-serial@vger.kernel.org>; Fri, 21 Oct 2022 07:02:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:8c7:6dd8:b0ce:eea6])
        by albert.telenet-ops.be with bizsmtp
        id ae2J280065BCT2h06e2Jms; Fri, 21 Oct 2022 16:02:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1olsbJ-000et5-M9; Fri, 21 Oct 2022 16:02:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1olsbJ-001KuI-12; Fri, 21 Oct 2022 16:02:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: serial: renesas,scif: Document r8a779g0 support
Date:   Fri, 21 Oct 2022 16:02:16 +0200
Message-Id: <8a2d04651f04a97d652395b4d933af5c3c8d5b5b.1666360789.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document support for the Serial Communication Interface with FIFO (SCIF)
in the Renesas R-Car V4H (R8A779G0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index f930e7f1349fcea8..f81f2d67a1ed453c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -67,6 +67,7 @@ properties:
           - enum:
               - renesas,scif-r8a779a0     # R-Car V3U
               - renesas,scif-r8a779f0     # R-Car S4-8
+              - renesas,scif-r8a779g0     # R-Car V4H
           - const: renesas,rcar-gen4-scif # R-Car Gen4
           - const: renesas,scif           # generic SCIF compatible UART
 
-- 
2.25.1

