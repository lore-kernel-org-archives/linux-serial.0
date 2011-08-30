From: =?iso-8859-1?q?S=F8ren_holm?= <sgh@sgh.dk>
Subject: Re: Hardware flowcontrol on XR17D154
Date: Tue, 30 Aug 2011 15:14:13 +0200
Message-ID: <201108301514.13268.sgh@sgh.dk>
References: <201108301217.07468.sgh@sgh.dk> <201108301327.04542.sgh@sgh.dk> <20110830133221.304b27f0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cpe.ge-0-2-0-951.faaqnqu1.customer.tele.dk ([93.167.193.22]:35204
	"EHLO mail.mikrofyn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab1H3NOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2011 09:14:15 -0400
In-Reply-To: <20110830133221.304b27f0@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

> > My particular uart resports (status1 =3D=3D 6 && status2 =3D=3D 6).=
 If that is
> > good enough I can add another porttype and add the correct register
> > address as UART_EXAR_EFR in the header file.
>=20
> Try it and see. We can put it in -next for a while and then there wil=
l a
> release cycle duriing which any unfortunate clashes wil get resolved.

I will prepare and test a patch.

> Alternatively if it's a device attached to a specific platform create=
 it
> as a platform device of some kind in the board specific code and pick
> that up in the serial driver.
>=20
> > Another thought could be to write 0xFF (or some other value) to the
> > correct EFR-register and read that byte to test if the register is
> > present. The problem here is that I do not how the bus reacts to
> > writting/reading invalid addresses.
>=20
> The trouble is an extra register may in fact be part of some other de=
vice
> - it's generally not a great idea if there are other choices.

Ok. It did seem like a dangerous thing to do.

Thanks Alan

--=20
S=F8ren Holm
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
