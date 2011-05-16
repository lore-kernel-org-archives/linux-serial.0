From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Serial driver parity support
Date: Mon, 16 May 2011 22:23:51 +0100
Message-ID: <20110516222351.2469aca9@lxorguk.ukuu.org.uk>
References: <131E5DFBE7373E4C8D813795A6AA7F08034B055615@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57321 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754698Ab1EPVWU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 May 2011 17:22:20 -0400
In-Reply-To: <131E5DFBE7373E4C8D813795A6AA7F08034B055615@dlee06.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Watkins, Melissa" <m-watkins@ti.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> I wanted to check if you had any feedback or advice about my previous=
 query. =20

Kind of slipped off my list


> 1. The serial driver sets TTY_DRIVER_REAL_RAW.=A0 My understanding of=
  	TTY_DRIVER_REAL_RAW is that, if set, the driver will only send the 	=
minimum notifications of parity errors required or according to the 	c_=
iflags.=A0 For example, regarding parity errors:
>=20
>=20
>    ! (INPCK)=A0=A0=A0=A0     --  char with PE will be pushed as TTY_N=
ORMAL
>    INPCK & !(IGNPAR) --=A0 char with PE will be pushed as TTY_PARITY
>    INPCK & IGNPAR=A0=A0=A0=A0--=A0 char with PE will be discarded and=
 not pushed
>=20
> =A0=A0 =A0=A0=A0Is my understanding correct?

Basically it indicates the hardware behaves as Unix wants in the fast
path case of parity being ignored, break being ignored and no input che=
ck
being done. In day gone by it was useful for some block transfer stuff.

Nowdays its basically irrelevant because CPUs are vastly faster relativ=
e
to serial data rates (except USB 3G dongles perhaps) and almost all the
communications at high speed is PPP which doesn't have that fast path
anyway.


> 2. When receiving characters, I am pushing a block of characters (<=3D=
 16) at 	a time to the TTY data structure. =A0If a parity error occurs =
on the 8th 	character, should I push the entire block of data with the =
TTY_PARITY 	flag? =A0Or should I first push the first 7 characters with=
 the 	TTY_NORMAL flag and the 8th character separately with the TTY_PAR=
ITY 	flag? =A0

Provide the most accurate error information you can. So if you have byt=
e
accurate error flags then great.

> 3. Is there a priority given to BI, FE, and PE errors? =A0For example=
, if more 	than one of these errors occurs for a single character, shou=
ld all 	errors be flagged?=A0 Or is one error given priority, and (depe=
nding on 	the c_iflag settings) the character is pushed with the flag s=
et to 	this type of error?

The kernel only allows you to report one per byte. That's one of those
things that could be improved but nobody has ever been annoyed enough t=
o
fix. I would suggest the order of values is probably as good a priority
as any.

> 4. Should I ever push the parity bit to TTY? =A0Or should the parity =
bit 	always be removed first?

If the hardware doesn't remove it then yes you should mask it.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
