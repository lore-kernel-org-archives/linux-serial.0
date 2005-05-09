From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 12:05:28 +0100
Message-ID: <200505091205.28719.andyparkins@gmail.com>
References: <200505051650.38471.andyparkins@gmail.com> <m3br7klpz4.fsf@zoo.weinigel.se> <m37ji8lpof.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1203306.edh9M1OS41";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host3.360visontechnology.com ([195.102.65.187]:15100 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S261238AbVEILFb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 07:05:31 -0400
Received: from dvr ([127.0.0.1])
	by dvr with esmtp (Exim 3.36 #1 (Debian))
	id 1DV64n-0002wN-00
	for <linux-serial@vger.kernel.org>; Mon, 09 May 2005 12:05:29 +0100
In-Reply-To: <m37ji8lpof.fsf@zoo.weinigel.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--nextPart1203306.edh9M1OS41
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2005 May 09 10:22, Christer Weinigel wrote:
> Christer Weinigel <christer@weinigel.se> writes:
> >     do {
> >         ioctl(fd, TIOCSERGETLSR, &lsr);
> >     } while (lsr & TIOCSER_TEMT);
>
> Should be !(lsr & TIOCSER_TEMT), since the bit set means that the
> transmitter is empty.
>
> Note to self.  _Always_ check posted code one extra time.  :-/

Hurrah! What you suggest has given me exactly what I needed.  Thank you so=
=20
much.



Andy

=2D-=20
Dr Andrew Parkins, M Eng (hons), AMIEE


--nextPart1203306.edh9M1OS41
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCf0P4wQJ9gE9xL20RAij7AKClDZWIV4WK6eed41mTBVLRySXwZQCg0ewm
Lhob8VneqRH5dykA3KzS70g=
=nWr8
-----END PGP SIGNATURE-----

--nextPart1203306.edh9M1OS41--
