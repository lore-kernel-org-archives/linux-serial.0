From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 16:53:53 +0100
Message-ID: <200505091653.57855.andyparkins@gmail.com>
References: <200505051650.38471.andyparkins@gmail.com> <m3br7klpz4.fsf@zoo.weinigel.se> <m37ji8lpof.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1878879.RuaZjCTqG1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host3.360visontechnology.com ([195.102.65.187]:27447 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S261434AbVEIPyA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 11:54:00 -0400
Received: from dvr ([127.0.0.1])
	by dvr with esmtp (Exim 3.36 #1 (Debian))
	id 1DVAZy-0003eX-00
	for <linux-serial@vger.kernel.org>; Mon, 09 May 2005 16:53:58 +0100
In-Reply-To: <m37ji8lpof.fsf@zoo.weinigel.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--nextPart1878879.RuaZjCTqG1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2005 May 09 10:22, Christer Weinigel wrote:
> Christer Weinigel <christer@weinigel.se> writes:
> >     do {
> >         ioctl(fd, TIOCSERGETLSR, &lsr);
> >     } while (lsr & TIOCSER_TEMT);

In case you are interested, I found another problem (but this time a soluti=
on=20
too); my code is now (edited for brevity):

	do {
		ioctl(fd, TIOCSERGETLSR, &i);
	} while( !i & TIOCSER_TEMT );
	tcdrain( fd );

The tcdrain() at the bottom returns fast (presumably because the transmit=20
buffer is already empty) so the original problem is solved.  Without the=20
tcdrain() the port is left in a strange state - at random, future writes ar=
e=20
silently dropped.  The echo back when this happens is simply a NUL.  With t=
he=20
tcdrain() in place, that problem goes away as well.

Andy


=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart1878879.RuaZjCTqG1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCf4eVwQJ9gE9xL20RAqdAAJ9bW4322tf+wqr+CcP+6KKx6VkmGwCgzJ72
CypiognoGgZt0JWCls2AgIs=
=fssK
-----END PGP SIGNATURE-----

--nextPart1878879.RuaZjCTqG1--
