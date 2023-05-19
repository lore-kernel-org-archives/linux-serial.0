Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A539C77B7A
	for <linux-serial@archiver.kernel.org>; Fri, 19 May 2023 16:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjESQJ7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 May 2023 12:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESQJu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 May 2023 12:09:50 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85418C2;
        Fri, 19 May 2023 09:09:49 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 867BE213CD;
        Fri, 19 May 2023 18:09:47 +0200 (CEST)
Date:   Fri, 19 May 2023 18:09:43 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: DT checker RS485 unevaluated property, 8250 OMAP UART
Message-ID: <ZGefR4mTHHo1iQ7H@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,
while writing a new DT file I stumbled across this warning

.../arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dtb: serial@2810000: Unevaluated properties are not allowed ('rs485-rts-active-high' was unexpected)
	From schema: .../Documentation/devicetree/bindings/serial/8250_omap.yaml

The property is currently used in the OMAP serial driver

drivers/tty/serial/omap-serial.c
1511:	if (of_property_read_bool(np, "rs485-rts-active-high")) {

and a few DT files.

I do require it, despite being wrong, because of some legacy reasons [1].

Before commit 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485
properties") this property was allowed.

What should I do?
 - ignore the warning
 - send a patch to reintroduce `rs485-rts-active-high: true` in 8250_omap.yaml
 - something else?

I would be inclined to send the following patch, do you agree?

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index eb3488d8f9ee..e634e98aa994 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -70,6 +70,7 @@ properties:
   dsr-gpios: true
   rng-gpios: true
   dcd-gpios: true
+  rs485-rts-active-low: true
   rts-gpio: true
   power-domains: true
   clock-frequency: true

[1] https://lore.kernel.org/all/ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com/

Francesco

