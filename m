Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B8C433EF
	for <linux-serial@archiver.kernel.org>; Sun,  2 Jan 2022 17:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiABRqP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABRqO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Jan 2022 12:46:14 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73887C061761
        for <linux-serial@vger.kernel.org>; Sun,  2 Jan 2022 09:46:14 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4BF7A100DECB3;
        Sun,  2 Jan 2022 18:46:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1E06349148; Sun,  2 Jan 2022 18:46:11 +0100 (CET)
Message-Id: <f49f945375f5ccb979893c49f1129f51651ac738.1641129062.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 2 Jan 2022 18:45:44 +0100
Subject: [PATCH] serial: pl011: Drop CR register reset on set_termios
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Jochen Mades <jochen@mades.net>, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pl011_set_termios() briefly resets the CR register to zero, thereby
glitching DTR/RTS signals.  With rs485 this may result in the bus being
occupied for no reason.

Where does this register write originate from?

The PL011 driver was forked from the PL010 driver in 2004:
https://git.kernel.org/history/history/c/157c0342e591

Until this commit, the PL010 driver's IRQ handler ambauart_int()
modified the CR register without holding the port spinlock.

ambauart_set_termios() also modified that register.  To prevent
concurrent read-modify-writes by the IRQ handler and to prevent
transmission while changing baudrate, ambauart_set_termios() had to
disable interrupts.  On the PL010, that is achieved by writing zero to
the CR register.

However, on the PL011, interrupts are disabled in the IMSC register,
not in the CR register.

Additionally, the commit amended both the PL010 and PL011 driver to
acquire the port spinlock in the IRQ handler, obviating the need to
disable interrupts in ->set_termios().

So the CR register write is obsolete for two reasons.  Drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index dbc4b3e2b19c..7ca4f0da8309 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2073,9 +2073,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
-	/* first, disable everything */
 	old_cr = pl011_read(uap, REG_CR);
-	pl011_write(0, uap, REG_CR);
 
 	if (termios->c_cflag & CRTSCTS) {
 		if (old_cr & UART011_CR_RTS)
-- 
2.33.0

