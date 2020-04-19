Return-Path: <SRS0=g+Oc=6D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9651DC38A30
	for <linux-serial@archiver.kernel.org>; Sun, 19 Apr 2020 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8AA2075E
	for <linux-serial@archiver.kernel.org>; Sun, 19 Apr 2020 20:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSUTh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:19:37 -0400
Received: from v6.sk ([167.172.42.174]:45476 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSUTg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Apr 2020 16:19:36 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id DD6DA610CF;
        Sun, 19 Apr 2020 20:19:04 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/2] dt-bindings: serial: Move Marvell compatible string to 8250 binding doc
Date:   Sun, 19 Apr 2020 22:17:15 +0200
Message-Id: <20200419201716.679090-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419201716.679090-1-lkundrak@v3.sk>
References: <20200419201716.679090-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These ports are compatible with NS8250 and handled by the same driver.
Get rid of the extra document that fails to document the properties that
are actually supported.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
 Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 55700f20f6ee8..a543702859e2f 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -26,6 +26,8 @@ Required properties:
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
 	- "nuvoton,npcm750-uart"
+	- "mrvl,mmp-uart"
+	- "mrvl,pxa-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
diff --git a/Documentation/devicetree/bindings/serial/mrvl-serial.txt b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
deleted file mode 100644
index d744340de887c..0000000000000
--- a/Documentation/devicetree/bindings/serial/mrvl-serial.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-PXA UART controller
-
-Required properties:
-- compatible : should be "mrvl,mmp-uart" or "mrvl,pxa-uart".
-- 
2.26.0

