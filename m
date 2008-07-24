From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 15:18:10 +0200
Message-ID: <200807241518.13909.laurentp@cse-semaphore.com>
References: <200807241347.33261.laurentp@cse-semaphore.com> <20080724132746.1a961584@lxorguk.ukuu.org.uk> <20080724125210.GD9327@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1580070.gQIjkt6xvP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:13796 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533AbYGXNSQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 09:18:16 -0400
In-Reply-To: <20080724125210.GD9327@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

--nextPart1580070.gQIjkt6xvP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 24 July 2008, Russell King wrote:
> On Thu, Jul 24, 2008 at 01:27:46PM +0100, Alan Cox wrote:
> > > On devices which don't support hardware RS485, what should be done is
> > > the termios bit remains clear, so that programs can tell if the port
> > > doesn't support it (as per POSIX.)
> >=20
> > Or the serial layer should do it in software.
> >=20
> > > I would also stress that this feature should be limited to enabling
> > > _hardware_ RS485 support, and not software emulation of that.  The
> > > reason being is that with plain 16550 UARTs, the best you can do=20
> > > with interrupts is to know when the last character is transferred out
> > > of the transmit holding register into the transmit shift register - in
> > > other words, before the last character has finished transmission.
> >=20
> > So the 16550 sucks, that's not true of everyone elses uarts.
>=20
> It's true of all 8250 compatibles which don't have hardware RS485
> support.  I think that's all of them except 16850 and 16960.
>=20
> > > Basically, software RS485 is very yucky, and we've always resisted
> > > having that support in the kernel.

I agree as well. Implementing various type of flow control emulation would =
require some kind of real-time support and lots of hacks to work around har=
dware issues. The serial core is complex enough as it is today.

> > Agreed entirely. Which takes us more and more to the setserial path even
> > if it means standardising some setserial bit to get everyone back in li=
ne.
>=20
> I don't have a problem with that, except one question: CRTSCTS.
>=20
> A while back, there were people asking for:
> 1. handshaking on DTR/DSR rather than RTS/CTS.
> 2. a different handshaking method for RTS/CTS (where you assert
>    RTS to ask for permission to send when you actually have something
>    to send.)
>=20
> Should CRTSCTS be a global "enable some kind of flow control" bit and
> setserial be used to configure the actual flow control method
> (conventional RTS/CTS, DTR/DSR, alternate RTS/CTS, RS485 on RTS,
> RS485 on DTR) ?

That sounds nice, although the CRTSCTS will not mean much anymore. I suppos=
e the new setserial option will have a 'RTS/CTS handshake' default value, s=
o that current drivers will exhibit the correct behaviour.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1580070.gQIjkt6xvP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIgRUACgkQ8y9gWxC9vpe6bQCgoYqgXay/ABBnz9pU0DwcUCLt
+CcAoNJkbXd9MOeQ9EoJyv979E0CtQEx
=uNIu
-----END PGP SIGNATURE-----

--nextPart1580070.gQIjkt6xvP--
