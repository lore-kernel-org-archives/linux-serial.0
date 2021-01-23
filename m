Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37035C433FE
	for <linux-serial@archiver.kernel.org>; Sun, 23 Jan 2022 04:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiAWEKV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 22 Jan 2022 23:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiAWEKV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 22 Jan 2022 23:10:21 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D4C06173B
        for <linux-serial@vger.kernel.org>; Sat, 22 Jan 2022 20:10:21 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 496D7100D9411;
        Sun, 23 Jan 2022 05:10:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 12B4A40DA1; Sun, 23 Jan 2022 05:10:17 +0100 (CET)
Message-Id: <85fa3323ba8c307943969b7343e23f34c3e652ba.1642909284.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 23 Jan 2021 05:10:14 +0100
Subject: [PATCH 1/2] serial: pl011: Fix incorrect rs485 RTS polarity on
 set_mctrl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Jochen Mades <jochen@mades.net>,
        "Su Bao Cheng" <baocheng.su@siemens.com>,
        "Su Bao Cheng" <baocheng_su@163.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jochen Mades <jochen@mades.net>

Commit 8d479237727c ("serial: amba-pl011: add RS485 support") sought to
keep RTS deasserted on set_mctrl if rs485 is enabled.  However it did so
only if deasserted RTS polarity is high.  Fix it in case it's low.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Signed-off-by: Jochen Mades <jochen@mades.net>
[lukas: copyedit commit message, add stable designation]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.15+
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1f1df46242f9..f64c475a1379 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1582,8 +1582,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int cr;
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
-		mctrl &= ~TIOCM_RTS;
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			mctrl &= ~TIOCM_RTS;
+		else
+			mctrl |= TIOCM_RTS;
+	}
 
 	cr = pl011_read(uap, REG_CR);
 
-- 
2.34.1

