Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F7C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 13:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D267A611C1
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 13:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhJGNg2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241606AbhJGNg1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 09:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AC80611C1;
        Thu,  7 Oct 2021 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633613674;
        bh=4wjtcTAxaenZW1j7DRxaTlTJN1KudhG8p4aKkq2DvOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UsM5KSY/sAom8geqF4dP1DlLlL2HUk7z/m+QnJ7RXbASSyt0OB3kIrtAqJldAmkoc
         Z/HgmWCxvDL5BqdOY/NqmJ6p4asvXm191Dm2Y5LxGsIPd4ITFXYMPk6XcUxJ3qM5T4
         6uSUcbTQZNVioylC6TGxgU3ZzA69vGNGtZgWeHnj4YSOd27xXlnulYSmFCCmP5a+HP
         Uj0ojtafMn4KXSoyLaxSgg7sFc6+WvbSDWbFvI9wBT9oXn3dOuCBV7Y5O6JcqCiq6f
         Y6n/NUP7LEkg8HvswQu7SQ39dfQw/eEBW4dchr0jV3CQUKANtrxc4BTaspKmgp4J4n
         jh0qfiS103npg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mYTXc-0007Y6-Ik; Thu, 07 Oct 2021 15:34:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] Revert "serial: 8250: Fix reporting real baudrate value in c_ospeed field"
Date:   Thu,  7 Oct 2021 15:31:46 +0200
Message-Id: <20211007133146.28949-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 32262e2e429cdb31f9e957e997d53458762931b7.

The commit in question claims to determine the inverse of
serial8250_get_divisor() but failed to notice that some drivers override
the default implementation using a get_divisor() callback.

This means that the computed line-speed values can be completely wrong
and results in regular TCSETS requests failing (the incorrect values
would also be passed to any overridden set_divisor() callback).

Similarly, it also failed to honour the old (deprecated) ASYNC_SPD_FLAGS
and would break applications relying on those when re-encoding the
actual line speed.

There are also at least two quirks, UART_BUG_QUOT and an OMAP1510
workaround, which were happily ignored and that are now broken.

Finally, even if the offending commit were to be implemented correctly,
this is a new feature and not something which should be backported to
stable.

Cc: Pali Rohár <pali@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index dc6900b2daa8..66374704747e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2584,19 +2584,6 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
 	return serial8250_do_get_divisor(port, baud, frac);
 }
 
-static unsigned int serial8250_compute_baud_rate(struct uart_port *port,
-						 unsigned int quot)
-{
-	if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8001)
-		return port->uartclk / 4;
-	else if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8002)
-		return port->uartclk / 8;
-	else if (port->type == PORT_NPCM)
-		return DIV_ROUND_CLOSEST(port->uartclk - 2 * (quot + 2), 16 * (quot + 2));
-	else
-		return DIV_ROUND_CLOSEST(port->uartclk, 16 * quot);
-}
-
 static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 					    tcflag_t c_cflag)
 {
@@ -2727,14 +2714,11 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 
 	baud = serial8250_get_baud_rate(port, termios, NULL);
 	quot = serial8250_get_divisor(port, baud, &frac);
-	baud = serial8250_compute_baud_rate(port, quot);
 
 	serial8250_rpm_get(up);
 	spin_lock_irqsave(&port->lock, flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
-	if (tty_termios_baud_rate(termios))
-		tty_termios_encode_baud_rate(termios, baud, baud);
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
@@ -2766,7 +2750,6 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	baud = serial8250_get_baud_rate(port, termios, old);
 	quot = serial8250_get_divisor(port, baud, &frac);
-	baud = serial8250_compute_baud_rate(port, quot);
 
 	/*
 	 * Ok, we're now changing the port state.  Do it with
-- 
2.32.0

