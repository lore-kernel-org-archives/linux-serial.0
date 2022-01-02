Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9610C433EF
	for <linux-serial@archiver.kernel.org>; Sun,  2 Jan 2022 17:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiABRtt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:49:49 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:42929 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiABRtt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Jan 2022 12:49:49 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2E79B300002D5;
        Sun,  2 Jan 2022 18:49:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 21ACADDCE5; Sun,  2 Jan 2022 18:49:44 +0100 (CET)
Message-Id: <e22089ab49e6e78822c50c8c4db46bf3ee885623.1641129328.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 2 Jan 2022 18:49:44 +0100
Subject: [PATCH] serial: pl011: Drop redundant DTR/RTS preservation on
 close/open
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Jochen Mades <jochen@mades.net>, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit d8d8ffa47783 ("amba-pl011: do not disable RTS during shutdown")
amended the PL011 serial driver to leave DTR/RTS polarity untouched on
tty close.  That change made sense.

But the commit also added code to save DTR/RTS state to an internal
variable on tty close and restore it on tty open.  That part of the
commit makes less sense:  The driver has no ->pm() callback, so the uart
remains powered after tty close and automatically preserves register
state, including DTR/RTS.

Saving and restoring registers isn't the job of the ->startup() and
->shutdown() callbacks anyway.  Rather, it should happen in ->pm().

Additionally, after pl011_startup() restores the state, the serial core
overrides it in uart_port_dtr_rts() if a baud rate has been set:

tty_port_open()
  uart_port_activate()
    uart_startup()
      uart_port_startup()
        pl011_startup()       # restores DTR/RTS from uap->old_cr
  tty_port_block_til_ready()
    tty_port_raise_dtr_rts    # if (C_BAUD(tty))
      uart_dtr_rts()
        uart_port_dtr_rts()   # raises DTR/RTS

The serial core also overrides DTR/RTS on tty close in uart_shutdown()
if C_HUPCL(tty) is set.  So a user-defined DTR/RTS polarity won't
survive a close/open cycle anyway, unless the user has set the baud rate
to zero and disabled hupcl on the tty.

Bottom line is, the code to save and restore DTR/RTS has no effect.
Remove it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
---
Not cc'ing Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
(author of commit d8d8ffa47783) because that e-mail address appears
to be unreachable (no MX records in the DNS, only A records,
and their IP addresses don't respond on port 25).

 drivers/tty/serial/amba-pl011.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7ca4f0da8309..1f1df46242f9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -230,7 +230,6 @@ struct uart_amba_port {
 	unsigned int		im;		/* interrupt mask */
 	unsigned int		old_status;
 	unsigned int		fifosize;	/* vendor-specific */
-	unsigned int		old_cr;		/* state during shutdown */
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
 	bool			rs485_tx_started;
@@ -1805,8 +1804,8 @@ static int pl011_startup(struct uart_port *port)
 
 	spin_lock_irq(&uap->port.lock);
 
-	/* restore RTS and DTR */
-	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
+	cr = pl011_read(uap, REG_CR);
+	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE;
 
 	if (port->rs485.flags & SER_RS485_ENABLED) {
@@ -1883,7 +1882,6 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 	uap->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
 	spin_lock_irq(&uap->port.lock);
 	cr = pl011_read(uap, REG_CR);
-	uap->old_cr = cr;
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
 	pl011_write(cr, uap, REG_CR);
@@ -2699,7 +2697,6 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 
 	index = pl011_probe_dt_alias(index, dev);
 
-	uap->old_cr = 0;
 	uap->port.dev = dev;
 	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
-- 
2.33.0

