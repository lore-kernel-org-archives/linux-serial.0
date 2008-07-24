From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] 8250: Add PowerPC-style MMIO support to the 8250 driver
Date: Thu, 24 Jul 2008 14:34:24 +0200
Message-ID: <200807241434.31671.laurentp@cse-semaphore.com>
References: <200807241411.15735.laurentp@cse-semaphore.com> <20080724121425.GB9327@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1480591.lnF1KiNgaZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:48701 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752695AbYGXMed (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:34:33 -0400
In-Reply-To: <20080724121425.GB9327@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

--nextPart1480591.lnF1KiNgaZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 24 July 2008, Russell King wrote:
> On Thu, Jul 24, 2008 at 02:11:15PM +0200, Laurent Pinchart wrote:
> > This patch adds support for memory-mapped 8250-like UARTs on PowerPC
> > platforms.=20
>=20
> What is different about in_8() from readb() ?  Why can't PowerPC use
> readb()?

If I'm not mistaken, readb/readw/readl/writeb/writew/writel are PCI accesso=
rs, at least on the PowerPC platform.

I took a closer look at the read*/write* functions. When both PCI indirect =
IO and PCI extended error handling are disabled, read*/write* are translate=
d to little-endian MMIO accessors (in_8, in_le16, in_le32, out_8, out_le16,=
 out_le32). This is the case for most embedded PowerPC platforms where a 82=
50-like UART is likely to be connected directly to the MMIO space.

When PCI indirect IO or PCI extended error handling are enabled, the read*/=
write* functions perform PCI-specific logic. They can't be used as generic =
MMIO accessors.

As my platform (an MPC8248 processor) has no PCI support, and as all 8250 a=
ccess operations are 8-bit wide, readb/writeb will perform correctly.

I suppose we can drop the patch until someone with an embedded PowerPC plat=
form requiring PCI indirect IO or PCI extended error handling comes up and =
complain. Those platforms are quite unlikely to have a 8250-like UART conne=
cted directly to the MMIO space.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1480591.lnF1KiNgaZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiIdtcACgkQ8y9gWxC9vpfrMQCfakZ/cuMoaYZzTW3y5+uo9/3Q
xeUAoMvD2XObIspHBkry3bt5QFeIF9iH
=iGLQ
-----END PGP SIGNATURE-----

--nextPart1480591.lnF1KiNgaZ--
