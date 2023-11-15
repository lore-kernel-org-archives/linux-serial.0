Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB5C2BB3F
	for <linux-serial@archiver.kernel.org>; Wed, 15 Nov 2023 20:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjKOUJr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Nov 2023 15:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbjKOUJq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Nov 2023 15:09:46 -0500
X-Greylist: delayed 148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 12:09:42 PST
Received: from mxh-2-5c5.seznam.cz (mxh-2-5c5.seznam.cz [IPv6:2a02:598:64:8a00::1000:5c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15D198
        for <linux-serial@vger.kernel.org>; Wed, 15 Nov 2023 12:09:42 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxh-79d7c99cff-kt4c7
        (smtpc-mxh-79d7c99cff-kt4c7 [2a02:598:64:8a00::1000:5c5])
        id 13024961edf6fbcb138cc779;
        Wed, 15 Nov 2023 21:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
        s=szn20221014; t=1700078980;
        bh=E7/v3eh3BfnRSzUiV6uFiYnJsjZ+Y17axIMDYxc4Cg4=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=Ii+mDWBjJ0gecPlUjdN4KiydWJiNkuE+mKJtviksfS+A6FtKbDXyk89fiE8mxIZpc
         0DhhGcEog1FUsh7IbjSreYu7dadTqUcSiFY2e7mI0oHQwO4c2VAQmCiUJ/00cnaicn
         sP3cPHW2OtcavxkPN5yDDHy8LpPC22X/Add4F9zmR8a/7dEomNK/RkFEJzA6CPYL9C
         fzZ8EgYiowS2siaP3g+USAiCUHLmjoeCfagug+xuWJvpG0vuxFXv2C1M19JtwHS27J
         hyQxMFUJ4jAI2KhrSODKZyH8/mF9Kyn3cnNlzCOguvxZAjp1hmD4VxmH0T2rkBpTV6
         nFkojMF6cYkyw==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Wed, 15 Nov 2023 21:07:00 +0100 (CET)
From:   "Tomas Paukrt" <tomaspaukrt@email.cz>
To:     <linux-serial@vger.kernel.org>
Subject: [PATCH] serial: core: Add option to enable RS485 mode via GPIO
Date:   Wed, 15 Nov 2023 21:07:00 +0100 (CET)
Message-Id: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch provides an option to enable the RS485 mode at boot time
based on the state of a GPIO pin (DIP switch or configuration jumper).
The GPIO is defined by the device tree property "rs485-mode-gpio".

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_=
core.c
index f1348a5..444d7fd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3603,6 +3603,18 @@ int uart_get_rs485_mode(struct uart_port *port)
 	}
 
 	/*
+	 * Enable the RS485 mode based on the state of a GPIO pin.
+	 */
+	desc =3D devm_gpiod_get_optional(dev, "rs485-mode", GPIOD_IN);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-mode-gpio\n"=
);
+	if (desc) {
+		if (gpiod_get_value(desc))
+			rs485conf->flags |=3D SER_RS485_ENABLED;
+		devm_gpiod_put(dev, desc);
+	}
+
+	/*
 	 * Disabling termination by default is the safe choice:  Else if many
 	 * bus participants enable it, no communication is possible at all.
 	 * Works fine for short cables and users may enable for longer cables.=

-- 
2.7.4
 
