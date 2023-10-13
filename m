Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BECDB47E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Oct 2023 14:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjJMOTe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Oct 2023 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMOTe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Oct 2023 10:19:34 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F2BB;
        Fri, 13 Oct 2023 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=9wNEH2MA8M1s/Qr4YPOBRw250B9hQqRc12JjWQy+lKU=; b=KjFBWQNB7Dh3C35ghq7bBGStTl
        liPjFDolBJLU3aLnlbT1hWCjm2f79tkHfQk6Lb4LvLp579iML++RpV0kEiEixAYJ319qtYVDLJlmD
        rDh2vHfYNWGMdHhQbTBAhq3fr9gh4/faUPlHDgMws1fQWHbI8xvoJcvC4bA6EL5gAuDM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40430 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qrJ0j-0005Ve-8e; Fri, 13 Oct 2023 10:19:29 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Fri, 13 Oct 2023 10:19:24 -0400
Message-Id: <20231013141925.3427158-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013141925.3427158-1-hugo@hugovil.com>
References: <20231013141925.3427158-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 1/2] dt-bindings: serial: sc16is7xx: move 'allOf' block after 'required'
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The 'allOf' block should go after the 'required' block according to DT
bindings best practices.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/serial/nxp,sc16is7xx.yaml      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 207dae3d0ffa..5dec15b7e7c3 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -70,16 +70,16 @@ properties:
       minimum: 0
       maximum: 1
 
-allOf:
-  - $ref: /schemas/spi/spi-peripheral-props.yaml#
-  - $ref: /schemas/serial/serial.yaml#
-  - $ref: /schemas/serial/rs485.yaml#
-
 required:
   - compatible
   - reg
   - interrupts
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/serial/serial.yaml#
+  - $ref: /schemas/serial/rs485.yaml#
+
 oneOf:
   - required:
       - clocks
-- 
2.39.2

