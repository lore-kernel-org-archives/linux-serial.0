From: JZabalza@cemitec.com
Subject: RE: Handling RTS
Date: Mon, 21 Jan 2008 12:57:13 +0100
Message-ID: <OF09424E34.A1A575E5-ONC12573D7.00406A86-C12573D7.0041A4D2@cemitec.com>
References: <005401c856be$d8db3a00$8a91ae00$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cliente-24411.iberbanda.es ([83.230.159.89]:1736 "EHLO
	Morondo.cemitec.local" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758944AbYAUL4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2008 06:56:01 -0500
In-Reply-To: <005401c856be$d8db3a00$8a91ae00$@com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, linux-serial-owner@vger.kernel.org

linux-serial-owner@vger.kernel.org escribi=F3 el 14/01/2008 16:05:03:

> > From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> > owner@vger.kernel.org] On Behalf Of JZabalza@cemitec.com
> > Sent: January 10, 2008 3:27 AM
> > To: linux-serial
> > Subject: RE: Handling RTS
> >=20
> >         Thanks for your response. I have a PC, so dmesg said
> >=20
> >                 serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 165=
50A
> >=20
> >         How I said, I just handle RTS but from userland. This means=
 a=20
big
> > latency between RTS activation and begin out data. I want only redu=
ce=20
this
> > latency activating RTS on driver. My question is, is this *protocol=
*
> > implemented actually or I must implement them.
>=20
> I'm not an expert on the current 8250 driver, but I believe you will=20
have to
> implement your 485 control.
>=20

        I'm not an expert too, but my question is, if is posible and go=
od=20
idea modify common layer of serial linux driver (serial_core.c) to=20
implement a **walky-talky** protocol with RTS line, this is, activate R=
TS=20
when there are chars to transmit and deactivate when there is not any=20
character.

Thanks.


Jos=E9 Luis Zabalza

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
