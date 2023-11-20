Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED9C54E76
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 08:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjKTIGk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 03:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTIGk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 03:06:40 -0500
X-Greylist: delayed 659 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 00:06:34 PST
Received: from mxe-1-522.seznam.cz (mxe-1-522.seznam.cz [IPv6:2a02:598:128:8a00::1000:522])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D1B4
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 00:06:33 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxe-78cbc4b585-zzm5x
        (smtpc-mxe-78cbc4b585-zzm5x [2a02:598:128:8a00::1000:522])
        id 26254a2dd8d1f88726abc435;
        Mon, 20 Nov 2023 09:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
        s=szn20221014; t=1700467582;
        bh=bXaPvd+CaRF/Ui64SAKpYYmS8L9oBJ6a2i7Wkgr8t0I=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:References:
         In-Reply-To:Mime-Version:X-Mailer:Content-Type:
         Content-Transfer-Encoding;
        b=Wmpih0OGHwS7MpYWGU4Bkbp539jgQra/XzlqEyI891Svc6sER4yOgNrAvpLTI5d0m
         6kiXeKYi6j+GBFwgymmiqVzWGBxjNLgBXfIONcZeMZwQtYuKH3+ePQ34phGA2g7v4l
         U0LgX4v4pDh/k61L7fw4WPFz6MroJn2fwRM42PwxVax0ZdNr+ocEOGRMNrLbX0le1K
         30H7+FvMBGqsWUVc8wmmtF9BUrd0358x9Ri9DflmRNlwAzpHRAsvujXjjCwSZ86+Lf
         tKyXJkU/a36HdgIRWKd2vMdZBJz1SsIolbFkYLsLP7Hj5cithzkXTAfWZhu6BW1zfT
         zootCTEd95czQ==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Mon, 20 Nov 2023 08:55:19 +0100 (CET)
From:   "Tomas Paukrt" <tomaspaukrt@email.cz>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
Cc:     <linux-serial@vger.kernel.org>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v2=5D_serial=3A_core=3A_Add_option_to_en?=
        =?utf-8?q?able_RS485_mode_via_GPIO?=
Date:   Mon, 20 Nov 2023 08:55:19 +0100 (CET)
Message-Id: <2cZ.ZZqF.1YADr1CLFoQ.1bMn3d@seznam.cz>
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
        <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
In-Reply-To: <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
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
 Documentation/devicetree/bindings/serial/rs485.yaml |  4 ++++
 drivers/tty/serial/serial_core.c                    | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documen=
tation/devicetree/bindings/serial/rs485.yaml
index 9418fd6..7a72f37 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -47,6 +47,10 @@ properties:
       later with proper ioctl.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-mode-gpio:
+    description: GPIO pin to enable the RS485 mode at boot time.
+    maxItems: 1
+
   rs485-rx-during-tx:
     description: enables the receiving of data even while sending data.=

     $ref: /schemas/types.yaml#/definitions/flag
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_=
core.c
index f1348a5..f1bf0b9 100644
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
 
