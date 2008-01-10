From: JZabalza@cemitec.com
Subject: RE: Handling RTS
Date: Thu, 10 Jan 2008 09:27:06 +0100
Message-ID: <OF13421728.28514CCE-ONC12573CC.002D2F04-C12573CC.002E6D4E@cemitec.com>
References: <008101c852ff$36201730$a2604590$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cliente-24411.iberbanda.es ([83.230.159.89]:1031 "EHLO
	Morondo.cemitec.local" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750733AbYAJI0F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jan 2008 03:26:05 -0500
In-Reply-To: <008101c852ff$36201730$a2604590$@com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

linux-serial-owner@vger.kernel.org escribi=F3 el 09/01/2008 21:35:43:

> > -----Original Message-----
> > From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> > owner@vger.kernel.org] On Behalf Of JZabalza@cemitec.com
> > Sent: January 9, 2008 1:18 PM
> >=20
> > If there is not another way, which shall be the best strategy to=20
implement
> > this (activate RTS when uart is transmiting data and deactivate whe=
n
> > transmision is finish. It would be another protocol different but=20
similar
> > to RTS/CTS protocol) on linux driver (modifying serial_core.c  to=20
accept a
> > new CFLAG?) ?
>=20
> What UART are you using?  Some newer UARTs have built-in capabilities=
=20
for
> the RTS framing.  So instead of having to toggle RTS manually, you ca=
n=20
flip
> a bit and let the UART do it for you whenever it transmits...unless t=
hat
> won't work for you.
>=20

        Thanks for your response. I have a PC, so dmesg said=20

                serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

        How I said, I just handle RTS but from userland. This means a b=
ig=20
latency between RTS activation and begin out data. I want only reduce t=
his=20
latency activating RTS on driver. My question is, is this *protocol*=20
implemented actually or I must implement them.

Thank you very munch.



Jos=E9 Luis Zabalza

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
