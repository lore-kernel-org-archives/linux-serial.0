Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A3AC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD5A61165
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 09:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhI0Jjo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233587AbhI0Jjn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Sep 2021 05:39:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5084660F70;
        Mon, 27 Sep 2021 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632735486;
        bh=YvZ8+EYP6Kx2ess16cAP1V0LgSEnQgSq0pH6BzBFXDk=;
        h=From:To:Cc:Subject:Date:From;
        b=JkcEyn0BxKS6a9+ADuzrtgSnYtcTKhotOrP2L51XhwB58yNwJSaLGbh9F596X22XX
         e5CP9c5DZGQvOfxkWHR5KKk4EG2wTuLtyP9W+2Z9XnjguAp95WYf2cGhfeY5o7xwVH
         O01VBQt601bQ6LHoYBNzGXU221uBXvZV+rafYNjhkYTjqKxlG5xIDj2mrzZQbVLIke
         r0UDDKDqzwdD4oJNOIesy+ugonoV5gmzx+imWBn8FVJdijtCOydz+mRsSzWRlZNZWI
         VTaKjaI8hFmDsJwJ2wQiev3nKXMUY6jYTfLb4bw3UJv4u93m7F3+avf2MASFzGStAg
         eZWV0l555JWrQ==
Received: by pali.im (Postfix)
        id 0582AC83; Mon, 27 Sep 2021 11:38:03 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Fix reporting real baudrate value in c_ospeed field
Date:   Mon, 27 Sep 2021 11:37:04 +0200
Message-Id: <20210927093704.19768-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In most cases it is not possible to set exact baudrate value to hardware.

So fix reporting real baudrate value which was set to hardware via c_ospeed
termios field. It can be retrieved by ioctl(TCGETS2) from userspace.

Real baudrate value is calculated from chosen hardware divisor and base
clock. It is implemented in a new function serial8250_compute_baud_rate()
which is inverse of serial8250_get_divisor() function.

With this change is fixed also UART timeout value (it is updated via
uart_update_timeout() function), which is calculated from the now fixed
baudrate value too.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---

I have tested this change on device with 8250 compatible UART. I have not
tested it on PORT_NPCM nor on UPF_MAGIC_MULTIPLIER hardware, as I do not
have such.

Tested device has 250 MHz base clock for 8250 UART. When I set baudrate to
115200, then ioctl(TCGETS2) reported B115200 CBAUD flag and value 114890 in
c_ospeed field.

This result is correct as HW for baudrate 115200 is using UART divisor 136,
which results in correct reported baudrate: 250000000/(16*136) = 114890
---
 drivers/tty/serial/8250/8250_port.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 66374704747e..dc6900b2daa8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2584,6 +2584,19 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
 	return serial8250_do_get_divisor(port, baud, frac);
 }
 
+static unsigned int serial8250_compute_baud_rate(struct uart_port *port,
+						 unsigned int quot)
+{
+	if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8001)
+		return port->uartclk / 4;
+	else if ((port->flags & UPF_MAGIC_MULTIPLIER) && quot == 0x8002)
+		return port->uartclk / 8;
+	else if (port->type == PORT_NPCM)
+		return DIV_ROUND_CLOSEST(port->uartclk - 2 * (quot + 2), 16 * (quot + 2));
+	else
+		return DIV_ROUND_CLOSEST(port->uartclk, 16 * quot);
+}
+
 static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 					    tcflag_t c_cflag)
 {
@@ -2714,11 +2727,14 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 
 	baud = serial8250_get_baud_rate(port, termios, NULL);
 	quot = serial8250_get_divisor(port, baud, &frac);
+	baud = serial8250_compute_baud_rate(port, quot);
 
 	serial8250_rpm_get(up);
 	spin_lock_irqsave(&port->lock, flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
+	if (tty_termios_baud_rate(termios))
+		tty_termios_encode_baud_rate(termios, baud, baud);
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
@@ -2750,6 +2766,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	baud = serial8250_get_baud_rate(port, termios, old);
 	quot = serial8250_get_divisor(port, baud, &frac);
+	baud = serial8250_compute_baud_rate(port, quot);
 
 	/*
 	 * Ok, we're now changing the port state.  Do it with
-- 
2.20.1

