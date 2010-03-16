From: Richard =?ISO-8859-1?Q?R=F6jfors?=
	<richard.rojfors@pelagicore.com>
Subject: [PATCH] serial: timbuart: Make sure last byte is sent when port is
 closed
Date: Tue, 16 Mar 2010 08:34:07 +0100
Message-ID: <1268724847.4472.10.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:58623 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab0CPHz6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Mar 2010 03:55:58 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 3591224ADA
	for <linux-serial@vger.kernel.org>; Tue, 16 Mar 2010 08:34:08 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org

This patched fixes a problem in early versions of the FPGA IP.

In certain situations the IP reports that the FIFO is empty, but a byte=
 is
still clocked out. If a flush is done at that point the currently clock=
ed
byte is canceled.
This causes incompatibilities with the upper layers when a port is clos=
ed,
it waits until the FIFO is empty and then closes the port. During
close the FIFO is flushed -> the last byte is not sent properly.

Now the FIFO is only flushed if it is reported to be non-empty. Which
makes the currently clocked out byte to finish.

Signed-off-by: Richard R=C3=B6jfors <richard.rojfors@pelagicore.com>
---
diff --git a/drivers/serial/timbuart.c b/drivers/serial/timbuart.c
index 7bf1026..aaa1217 100644
--- a/drivers/serial/timbuart.c
+++ b/drivers/serial/timbuart.c
@@ -69,10 +69,13 @@ static void timbuart_start_tx(struct uart_port *por=
t)
=20
 static void timbuart_flush_buffer(struct uart_port *port)
 {
-	u8 ctl =3D ioread8(port->membase + TIMBUART_CTRL) | TIMBUART_CTRL_FLS=
HTX;
+	if (!timbuart_tx_empty(port)) {
+		u8 ctl =3D ioread8(port->membase + TIMBUART_CTRL) |
+			TIMBUART_CTRL_FLSHTX;
=20
-	iowrite8(ctl, port->membase + TIMBUART_CTRL);
-	iowrite32(TXBF, port->membase + TIMBUART_ISR);
+		iowrite8(ctl, port->membase + TIMBUART_CTRL);
+		iowrite32(TXBF, port->membase + TIMBUART_ISR);
+	}
 }
=20
 static void timbuart_rx_chars(struct uart_port *port)

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
