From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] Fix oops in the 8250 serial driver when accessing a removed device
Date: Tue, 22 Jul 2008 18:31:50 +0200
Message-ID: <200807221831.54473.laurentp@cse-semaphore.com>
References: <200807221737.06224.laurentp@cse-semaphore.com> <20080722165408.38a75a57@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8395108.ssrReYOOyO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:26298 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654AbYGVQcE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jul 2008 12:32:04 -0400
In-Reply-To: <20080722165408.38a75a57@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

--nextPart8395108.ssrReYOOyO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Russell,

On Tuesday 22 July 2008, Alan Cox wrote:
> > When a plug-and-play 8250 device is detected, the driver reuses one of =
the
> > dummy ports. If that device is later removed, the port goes pack to the
> > dummy ports pool. The capabilities field is not reset, which causes a o=
ops
> > when trying to access the port.
>=20
> Some day we need to allocate new dummy ports so there is always one free.
>=20
> > This patch resets the capabilities field when a 8250 device is
> > unregistered.=20
>=20
> Looks good to me. Would appreciate Russell's view though.

Could you please review the patch (available at http://marc.info/?l=3Dlinux=
=2Dserial&m=3D121674107306179&w=3D2) ? I'd like it to go into 2.6.27 if pos=
sible.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart8395108.ssrReYOOyO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiGC3oACgkQ8y9gWxC9vpeaWQCgzETpVqE5n9CJIIqWI4J/7leG
xvQAn1hrgMO1Py/BnORPLOG9bb2FAcSl
=OVR7
-----END PGP SIGNATURE-----

--nextPart8395108.ssrReYOOyO--
