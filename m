From: Harald Welte <laforge@netfilter.org>
Subject: Re: Fix supprot for AFAVLAB 8port boards in 2.6.x
Date: Fri, 5 Mar 2004 15:13:07 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040305141307.GS1105@sunbeam.de.gnumonks.org>
References: <20040305112404.GJ1105@sunbeam.de.gnumonks.org> <40488B65.904@cronyx.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hUen2UJD5eWDKlb+"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:20928 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S262604AbUCEOWQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2004 09:22:16 -0500
Content-Disposition: inline
In-Reply-To: <40488B65.904@cronyx.ru>
List-Id: linux-serial@vger.kernel.org
To: Roman Kurakin <rik@cronyx.ru>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org


--hUen2UJD5eWDKlb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 05, 2004 at 05:15:01PM +0300, Roman Kurakin wrote:
> May be you didn't add support of more than four ports?

No, this is not the problem.   Please note that I am the person who
initially added support for the AFAVLAB boards to the linux serial
driver anyway ;)

Both the P028 and P030 are 8-port devices.  And linux only supports the
full eight ports with 2.4.x.  2.6.x needs the attached patch.

The first four ports eich have their own 'bar', the second four ports are
batched together within one 'bar'.

Which means that ports 0 to 3 are set up quite normal (bar =3D=3D idx,
offset =3D 0), but ports 4 to 7 have to be setup with bar =3D=3D 4 and and
offsets 0,8,16,24

> Best regards,
>                         Roman Kurakin

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--hUen2UJD5eWDKlb+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFASIrzXaXGVTD0i/8RAoEIAJ9RxUuX/LMYMc7HXagh+2AqBV8P7ACfegke
+zwgZIAQTeXue42KsDyr4wA=
=WAbF
-----END PGP SIGNATURE-----

--hUen2UJD5eWDKlb+--
