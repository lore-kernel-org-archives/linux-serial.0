From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Support for Meilhaus serial boards - patch (kernel 2.6.28)
Date: Tue, 20 Jan 2009 14:22:57 +0100
Message-ID: <200901201423.00936.laurentp@cse-semaphore.com>
References: <497497E8.3050206@meilhaus.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17123168.XSqhRHoqUX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:47058 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745AbZATNXD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jan 2009 08:23:03 -0500
In-Reply-To: <497497E8.3050206@meilhaus.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Krzysztof Gantzke <k.gantzke@meilhaus.de>
Cc: linux-serial@vger.kernel.org

--nextPart17123168.XSqhRHoqUX
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 19 January 2009 16:10:32 Krzysztof Gantzke wrote:
> Dear Linux-serial team
> Meilhaus (PCI ID: 0x1402) ME90xx, ME91xx and ME93xx support added.
> The are RS232 and RS422/485 PCI serial boards.
> This patch was tested on x86 and x86_64 machines.
>
> Could you added this to main tree, please.

NAK. You should not add an ioctl to revert to RS232 mode but check=20
serial_rs485.flags in TIOCSRS485. Enable RS485 when SER_RS485_ENABLED is se=
t,=20
disable it otherwise.

You should also probably base your patch to 8250.c on top of Matthias Fuchs=
'=20
patch ('[PATCH V3] serial: Add ioctl to enable auto rs485 mode with some Ex=
ar=20
UARTs').

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart17123168.XSqhRHoqUX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl10DIACgkQlyYWY4YEWhUEUACcC/WVCVXbvyjYe95Qr6dflxTI
9FMAn1xQ2FbPgsJRRY3DzWj2KUSIWHFa
=6381
-----END PGP SIGNATURE-----

--nextPart17123168.XSqhRHoqUX--
