Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4191C7EE24
	for <linux-serial@archiver.kernel.org>; Wed, 31 May 2023 06:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjEaGk1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 May 2023 02:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjEaGk0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 May 2023 02:40:26 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C44C122;
        Tue, 30 May 2023 23:40:21 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 713E1201B9;
        Wed, 31 May 2023 08:40:19 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: serial: 8250_omap: add rs485-rts-active-high
Date:   Wed, 31 May 2023 08:40:13 +0200
Message-Id: <20230531064013.16551-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add rs485-rts-active-high property, this was removed by mistake.
In general we just use rs485-rts-active-low property, however the OMAP
UART for legacy reason uses the -high one.

Fixes: 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485 properties")
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Closes: https://lore.kernel.org/all/ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index eb3488d8f9ee..6a7be42da523 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -70,6 +70,7 @@ properties:
   dsr-gpios: true
   rng-gpios: true
   dcd-gpios: true
+  rs485-rts-active-high: true
   rts-gpio: true
   power-domains: true
   clock-frequency: true
-- 
2.25.1

