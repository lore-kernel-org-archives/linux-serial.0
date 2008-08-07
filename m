From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH v1] 8250: add support for DTR/DSR hardware flow control
Date: Thu, 7 Aug 2008 10:32:14 +0200
Message-ID: <200808071032.16709.laurentp@cse-semaphore.com>
References: <20080806211438.GB20355@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1617761.7FS0RQYFOf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:44236 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860AbYHGIcW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Aug 2008 04:32:22 -0400
In-Reply-To: <20080806211438.GB20355@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1617761.7FS0RQYFOf
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wednesday 06 August 2008, Aristeu Rozanski wrote:
> This patch adds support for DTR/DSR hardware flow control on 8250 driver =
on
> x86 machines. It's done by adding a CDTRDSR flag to work just like CRTSCT=
S,
> which is not done on other architectures on purpose (so each maintainer c=
an
> allocate it).=20

It's funny, serial flow control hasn't been discussed for a long time, and =
you're the third person to start a flow control related thread on this mail=
ing list in a few days.

> This patch was tested with success with a serial printer configured with a
> small buffer and DTR/DSR flow control.
>=20
> This is based on the work of Michael Westermann
> (http://lkml.org/lkml/2007/8/31/133)=20
>=20
> Comments more than welcome.

Please read the '[PATCH/RFC] 8250: Auto RS485 direction control' thread for=
 background information. In a nutshell we need more than just CTS/RTS and D=
TR/DSR, and we don't have enough c_cflags bits. We will probably have to cr=
eate a new ioctl.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1617761.7FS0RQYFOf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiasxAACgkQ8y9gWxC9vpdQXACgpyNiK2ykVch+yyWjB6toQLaJ
5zcAoOE/dN52SgZlwX5jTyy5FhYPmdho
=g0nA
-----END PGP SIGNATURE-----

--nextPart1617761.7FS0RQYFOf--
