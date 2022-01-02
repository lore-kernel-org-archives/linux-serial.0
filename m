Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67DCC433EF
	for <linux-serial@archiver.kernel.org>; Sun,  2 Jan 2022 17:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiABRnB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABRnB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Jan 2022 12:43:01 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97586C061761
        for <linux-serial@vger.kernel.org>; Sun,  2 Jan 2022 09:43:00 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 703972800B3D2;
        Sun,  2 Jan 2022 18:42:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 665EF53D8C; Sun,  2 Jan 2022 18:42:58 +0100 (CET)
Message-Id: <fcaff16e5b1abb4cc3da5a2879ac13f278b99ed0.1641128728.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 2 Jan 2022 18:42:44 +0100
Subject: [PATCH] serial: pl010: Drop CR register reset on set_termios
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pl010_set_termios() briefly resets the CR register to zero.

Where does this register write come from?

The PL010 driver's IRQ handler ambauart_int() originally modified the CR
register without holding the port spinlock.  ambauart_set_termios() also
modified that register.  To prevent concurrent read-modify-writes by the
IRQ handler and to prevent transmission while changing baudrate,
ambauart_set_termios() had to disable interrupts.  That is achieved by
writing zero to the CR register.

However in 2004 the PL010 driver was amended to acquire the port
spinlock in the IRQ handler, obviating the need to disable interrupts in
->set_termios():
https://git.kernel.org/history/history/c/157c0342e591

That rendered the CR register write obsolete.  Drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/amba-pl010.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index e744b953ca34..47654073123d 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -446,14 +446,11 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) == 0)
 		uap->port.ignore_status_mask |= UART_DUMMY_RSR_RX;
 
-	/* first, disable everything */
 	old_cr = readb(uap->port.membase + UART010_CR) & ~UART010_CR_MSIE;
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
 		old_cr |= UART010_CR_MSIE;
 
-	writel(0, uap->port.membase + UART010_CR);
-
 	/* Set baud rate */
 	quot -= 1;
 	writel((quot & 0xf00) >> 8, uap->port.membase + UART010_LCRM);
-- 
2.33.0

