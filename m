Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C67C54E76
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 21:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjKTVpz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjKTVpy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 16:45:54 -0500
Received: from mxe-2-adb.seznam.cz (mxe-2-adb.seznam.cz [IPv6:2a02:598:64:8a00::1000:adb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC12A4
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:45:48 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxe-b7dc65f8c-m6chn
        (smtpc-mxe-b7dc65f8c-m6chn [2a02:598:64:8a00::1000:adb])
        id 212f4ebbdfdbfc1121a1c0a3;
        Mon, 20 Nov 2023 22:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
        s=szn20221014; t=1700516722;
        bh=KOJZarIYC0hLYr1MwPUV/ajt9MnhOl+KmxMTugbvoGU=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:References:
         In-Reply-To:Mime-Version:X-Mailer:Content-Type:
         Content-Transfer-Encoding;
        b=Kvix8Pp/zUz0y0ZYzgjEEs7VC9aUeRm/B/5Pc46Sxl4XBK/JhDXCJDDF4RU68/Ms9
         YxmjNPJznY8P3+eheHYm0E5gu8LTOJ1gA8U0CrNpNY0vrjcnavo9S2G1AFrT1J6//L
         2maxtaCmsa0ShUhfAFHt0qWNW8fekU7kjxf6qXydiv4wFmfxIkLKjpwvlrQUgNdS8h
         SCui9fOSg29t7UDYERiWS8XHj1jIJ2pwiESD8Gi4NztMMaPVU33NtaaVJoBjVzDNNk
         0Q8LSQTM1nye7SbJtqhqzhjRynCu4OqHc4mgu/PVXgDJziL3z8BFBylDagRQVWbKS9
         8xN8CbYvd3hcw==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Mon, 20 Nov 2023 22:45:20 +0100 (CET)
From:   "Tomas Paukrt" <tomaspaukrt@email.cz>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     <linux-serial@vger.kernel.org>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v3_1/2=5D_serial=3A_core=3A_Add_option_t?=
        =?utf-8?q?o_enable_RS485_mode_via_GPIO_?=
Date:   Mon, 20 Nov 2023 22:45:20 +0100 (CET)
Message-Id: <3Nj.ZZr}.5RaPRe7D8AB.1bMzDm@seznam.cz>
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
        <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
        <2cZ.ZZqF.1YADr1CLFoQ.1bMn3d@seznam.cz>
        <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
In-Reply-To: <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add an option to enable the RS485 mode at boot time based on
the state of a GPIO pin (DIP switch or configuration jumper).
The GPIO is defined by the device tree property "rs485-mode-gpio".

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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
 
