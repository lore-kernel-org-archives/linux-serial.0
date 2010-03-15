From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] serial: Two branches the same in timbuart_set_mctrl()
Date: Mon, 15 Mar 2010 14:57:16 +0100
Message-ID: <4B9E3CBC.8020106@gmail.com>
References: <4B532CF5.7080000@gmail.com> <20100117181702.026269e9@lxorguk.ukuu.org.uk> <4B535ED8.2050703@gmail.com> <4B9E0160.5000900@pelagicore.com> <4B9E3747.9060400@gmail.com> <4B9E391A.5050808@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:48263 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936249Ab0CONzq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Mar 2010 09:55:46 -0400
In-Reply-To: <4B9E391A.5050808@pelagicore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@pelagicore.com>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

CTS is a read only bit and we are to stop signal RTS if modem line
TIOCM_RTS is not set.

Thanks for suggestions by Richard R=F6jfors.

Acked-by: Richard R=F6jfors <richard.rojfors@pelagicore.com>
Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/serial/timbuart.c b/drivers/serial/timbuart.c
index 7bf1026..823b9c5 100644
--- a/drivers/serial/timbuart.c
+++ b/drivers/serial/timbuart.c
@@ -219,7 +219,7 @@ static void timbuart_set_mctrl(struct uart_port *po=
rt, unsigned int mctrl)
 	if (mctrl & TIOCM_RTS)
 		iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
 	else
-		iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
+		iowrite8(0, port->membase + TIMBUART_CTRL);
 }
=20
 static void timbuart_mctrl_check(struct uart_port *port, u32 isr, u32 =
*ier)
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
