From: =?utf-8?q?S=C3=B8ren_holm?= <sgh@sgh.dk>
Subject: Re: Hardware flowcontrol on XR17D154
Date: Tue, 30 Aug 2011 13:27:04 +0200
Message-ID: <201108301327.04542.sgh@sgh.dk>
References: <201108301217.07468.sgh@sgh.dk> <20110830113433.618b2486@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cpe.ge-0-2-0-951.faaqnqu1.customer.tele.dk ([93.167.193.22]:33397
	"EHLO mail.mikrofyn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab1H3L1G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2011 07:27:06 -0400
In-Reply-To: <20110830113433.618b2486@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

Tirsdag den 30. august 2011 12:34:33 skrev Alan Cox:
>=20
> Can you explain what the underlying differences are first of all ?

The EFR register is as you wrote adjusted differently.

> If you just need to adjust a register differently then override
> serial_in/serial_out methods and figure out how to detect your device
> against others (or a way to probe it somehow).

I'm a bit in doubt as to which conclusions I am allowed to draw.

In 'autoconfig_16550a' I can see that a sepcific port type is set;

	if (status1 =3D=3D 6 && status2 =3D=3D 7) {
		up->port.type =3D PORT_16750;
		up->capabilities |=3D UART_CAP_AFE | UART_CAP_SLEEP;
		return;
	}

My particular uart resports (status1 =3D=3D 6 && status2 =3D=3D 6). If =
that is good=20
enough I can add another porttype and add the correct register address =
as=20
UART_EXAR_EFR in the header file.

Another thought could be to write 0xFF (or some other value) to the cor=
rect=20
EFR-register and read that byte to test if the register is present. The=
=20
problem here is that I do not how the bus reacts to writting/reading in=
valid=20
addresses.

--=20
S=C3=B8ren Holm
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
