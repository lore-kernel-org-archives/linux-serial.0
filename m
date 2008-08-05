From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Tue, 5 Aug 2008 11:41:04 +0200
Message-ID: <200808051141.07707.laurentp@cse-semaphore.com>
References: <014e01c8f63c$6d03dee0$2e01a8c0@acksys.local> <200808041637.02058.laurentp@cse-semaphore.com> <g779ul$7ih$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2100273.fbbF8nW5Ab";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:5325 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752808AbYHEJlK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2008 05:41:10 -0400
In-Reply-To: <g779ul$7ih$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grante@visi.com>
Cc: linux-serial@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>

--nextPart2100273.fbbF8nW5Ab
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 August 2008, Grant Edwards wrote:
> On 2008-08-04, Laurent Pinchart <laurentp@cse-semaphore.com> wrote:
> > On Monday 04 August 2008, Tosoni wrote:
> >> About the flags names -- CARTS, UART_FCTR_RS485
> >>=20
> >> May I suggest CRTSTOGGLE since it is known by that kind of name in oth=
er
> >> OS's :-)
> >
> > I like Russell's proposal of sticking to CRTSCTS and adding options to
> > setserial:
> >
> >> Should CRTSCTS be a global "enable some kind of flow control" bit and
> >> setserial be used to configure the actual flow control method
> >> (conventional RTS/CTS, DTR/DSR, alternate RTS/CTS, RS485 on RTS,
> >> RS485 on DTR) ?
> >
> > Any opinion on that ?
>=20
> Opposed.
>=20
>  1) CRTSCTS means something quite specific.

That's right, and this is my main concern.

>     Rather than overload that name for something unrelated, create a new
>     mode bit for the new mode.

We already have 3 distinct modes for RTS/CTS (see my mail from today 11:23:=
36 in this thread). If we add DSR/DTR hardware support we can easily get 5 =
or 6 modes. We will run out of bits in c_cflags.

>  2) Most of what's in setserial is useless and irrelevent to
>     non-PC-motherboard-16550-uart serial ports (the drivers for
>     which often don't support setserial).
>=20
> Let's just suck it up and do it the right way.

As the number of bits in c_cflags is not infinite we will need an ioctl to =
configure the desired hardware handshake mode (as most modes don't control =
the data flow I'd rather talk about hardware handshake which is a more gene=
ric name). We can either use one of the struct serial_struct reserved field=
s with TIOCSSERIAL, or create another ioctl.

> >> And further, it says was RTS will do, instead of why. Maybe
> >> someone could use it for something other than RS485 ?
> >
> > I agree with you here. The name should reflect that RTS is
> > used in 'envelope' mode (asserted during data transmission,
> > idle between frames).
>=20
> I don't really care what the name is.  "RTS toggle" or
> "half-duplex" is what everybody I know calls it.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2100273.fbbF8nW5Ab
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYIDMACgkQ8y9gWxC9vpem3ACfQt2FE3e7NKkbICohmtaVf6gW
zawAoKRBNXuo0dHa4wcvL/owivrNTO0V
=kbcY
-----END PGP SIGNATURE-----

--nextPart2100273.fbbF8nW5Ab--
