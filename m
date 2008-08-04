From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 4 Aug 2008 16:36:59 +0200
Message-ID: <200808041637.02058.laurentp@cse-semaphore.com>
References: <014e01c8f63c$6d03dee0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2242724.WUIrsUdxRV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:12030 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755608AbYHDOhH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 10:37:07 -0400
In-Reply-To: <014e01c8f63c$6d03dee0$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

--nextPart2242724.WUIrsUdxRV
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 August 2008, Tosoni wrote:
> About the flags names -- CARTS, UART_FCTR_RS485
>=20
> May I suggest CRTSTOGGLE since it is known by that kind of name in other
> OS's :-)

I like Russell's proposal of sticking to CRTSCTS and adding options to sets=
erial:

> Should CRTSCTS be a global "enable some kind of flow control" bit and
> setserial be used to configure the actual flow control method
> (conventional RTS/CTS, DTR/DSR, alternate RTS/CTS, RS485 on RTS,
> RS485 on DTR) ?

Any opinion on that ?

> And further, it says was RTS will do, instead of why. Maybe someone could
> use it for something other than RS485 ?

I agree with you here. The name should reflect that RTS is used in 'envelop=
e' mode (asserted during data transmission, idle between frames).

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2242724.WUIrsUdxRV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiXFA4ACgkQ8y9gWxC9vpftFACcCkZCfXHLbOO1O8uPPHbUmwix
kk0An294Jt62FxeMaib1wZ5UiTI07wnL
=kLPT
-----END PGP SIGNATURE-----

--nextPart2242724.WUIrsUdxRV--
