From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] cpm_uart: Fix break generation
Date: Thu, 24 Jul 2008 17:52:39 +0200
Message-ID: <200807241752.42543.laurentp@cse-semaphore.com>
References: <200806261338.19358.laurentp@cse-semaphore.com> <200807241621.58719.laurentp@cse-semaphore.com> <EFAF51F5-D2A4-4A8F-AB94-0A746B67E190@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6878992.uEPgOi7UoZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:30749 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329AbYGXPwp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 11:52:45 -0400
In-Reply-To: <EFAF51F5-D2A4-4A8F-AB94-0A746B67E190@kernel.crashing.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, scottwood@freescale.com

--nextPart6878992.uEPgOi7UoZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 24 July 2008, Kumar Gala wrote:
>=20
> On Jul 24, 2008, at 9:21 AM, Laurent Pinchart wrote:
>=20
> > When generating a break condition on a serial port, the CPM must be =20
> > told beforehand how long the break should be. Unfortunately, this =20
> > information is not available through the current serial break handling
> > API. This patch works around the problem by requesting a 32767 characte=
rs
> > break followed by a 0 characters break after the requested duration. The
> > CPM will stop the first break when the second one is requested. This mi=
ght
> > not work with future CPM revisions.
>=20
> What do you mean by future CPM revision?  Do you mean QE?

I was thinking about minor revisions of the CPM2 silicon as described in ht=
tp://www.freescale.com/files/32bit/doc/app_note/AN2291.pdf

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6878992.uEPgOi7UoZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIpUoACgkQ8y9gWxC9vpcd8QCgzP/gG1JAui9gBkJYZ7weLSYW
DKQAoLaXn+17pop5qEiejRBSCZmhjQOa
=Z40o
-----END PGP SIGNATURE-----

--nextPart6878992.uEPgOi7UoZ--
