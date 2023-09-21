Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60557E7D0A2
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 19:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIUTbr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjIUTbb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 15:31:31 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A1905ED;
        Thu, 21 Sep 2023 12:27:43 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 53273805CD;
        Thu, 21 Sep 2023 21:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695324461;
        bh=w4s+MYqnZ2xQI1Rv17N0ZTQU2qMqwYRQ1GkDMHi0qgo=;
        h=From:To:Cc:Subject:Date:From;
        b=v3WDDc4gsmyKWj6VTFziFLz2pdPGt8N0vSXCQWY0zmtZfUtxP7r66L9zAU7T7nbwN
         bGya2QCYn3BdxihQd/O0bbVVoz7f0cYdRTt8vg0Y2TcRsTQ4DdBe0C/tvGR1NwPAWD
         McmNjm/DBisTD1mm6PkuxOXYDvprXJz3uZlVI/1DnfA7C3+OzEqK+bA+kV7VlWi4HV
         I9WtU6BycS0bYchNQ5EA+BoCJtoNVwxfPcRJdukQZkR3B6I9MC5ipG80yznv6Mug/Y
         6GmETS3zUAPx+KgMxC806m6L2lRozP3Lo55XUKWWwTgf7TOvpeFkKfA4kkGiBEkItU
         dtcPyp98r8MCg==
From:   Marek Vasut <marex@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: imx: Document wakeup-source property
Date:   Thu, 21 Sep 2023 21:27:29 +0200
Message-Id: <20230921192729.71259-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The i.MX UART can be used as a wake-up source, document the 'wakeup-source'
property as allowed property.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 40414247d61a3..83035553044a2 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -70,6 +70,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  wakeup-source: true
+
   fsl,dte-mode:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
-- 
2.40.1

