Return-Path: <SRS0=qiNw=65=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C44C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F7B207C4
	for <linux-serial@archiver.kernel.org>; Fri, 15 May 2020 13:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEONRN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 May 2020 09:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgEONRH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 May 2020 09:17:07 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 May 2020 06:17:07 PDT
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D26C061A0C
        for <linux-serial@vger.kernel.org>; Fri, 15 May 2020 06:17:07 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:ad37:48f9:900a:523e])
        by albert.telenet-ops.be with bizsmtp
        id f1C32200o1TfvYq061C3mq; Fri, 15 May 2020 15:12:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jZa8B-0006QT-JB; Fri, 15 May 2020 15:12:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jZa8B-0006V8-Gq; Fri, 15 May 2020 15:12:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: serial: renesas,scifa: Remove part numbers from comments
Date:   Fri, 15 May 2020 15:12:02 +0200
Message-Id: <20200515131202.24949-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The conversion to json-schema accidentally retained some SoC part
numbers in comments for compatible values.  Drop them, as they're part
of the compatible values anyway.

Fixes: 384d00fae8e51f8f ("dt-bindings: serial: sh-sci: Convert to json-schema")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on:
"[PATCH v2 03/10] dt-bindings: serial: renesas,scifa: Document r8a7742 bindings"
https://lore.kernel.org/dmaengine/1588542414-14826-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com

Rob: as you have taken:

+ 8908a822663f6958 dt-bindings: serial: renesas,scif: Document r8a7742 bindings
+ 3cf1601ab00ce558 dt-bindings: serial: renesas,scifb: Document r8a7742 bindings
+ 65994c09bc66d724 dt-bindings: serial: renesas,hscif: Document r8a7742 bindings

can you please take this one, and its dependency, too?

Thanks!

 .../bindings/serial/renesas,scifa.yaml           | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scifa.yaml b/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
index 97ddd76d700f78ca..78b8e20dd34db322 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scifa.yaml
@@ -24,14 +24,14 @@ properties:
 
       - items:
           - enum:
-              - renesas,scifa-r8a7742      # R8A7742 RZ/G1H
-              - renesas,scifa-r8a7743      # R8A7743 RZ/G1M
-              - renesas,scifa-r8a7744      # R8A7744 RZ/G1N
-              - renesas,scifa-r8a7745      # R8A7745 RZ/G1E
-              - renesas,scifa-r8a7790      # R8A7790 R-Car H2
-              - renesas,scifa-r8a7791      # R8A7791 R-Car M2-W
-              - renesas,scifa-r8a7793      # R8A7793 R-Car M2-N
-              - renesas,scifa-r8a7794      # R8A7794 R-Car E2
+              - renesas,scifa-r8a7742      # RZ/G1H
+              - renesas,scifa-r8a7743      # RZ/G1M
+              - renesas,scifa-r8a7744      # RZ/G1N
+              - renesas,scifa-r8a7745      # RZ/G1E
+              - renesas,scifa-r8a7790      # R-Car H2
+              - renesas,scifa-r8a7791      # R-Car M2-W
+              - renesas,scifa-r8a7793      # R-Car M2-N
+              - renesas,scifa-r8a7794      # R-Car E2
           - const: renesas,rcar-gen2-scifa # R-Car Gen2 and RZ/G1
           - const: renesas,scifa           # generic SCIFA compatible UART
 
-- 
2.17.1

