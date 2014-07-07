From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 7/9] ARM: sunxi: select MFD_SUN6I_PRCM when sun8i arch
 support is enabled
Date: Mon, 7 Jul 2014 11:00:20 +0200
Message-ID: <20140707090020.GH16262@lukather>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-8-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55197 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbaGGJFE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jul 2014 05:05:04 -0400
Content-Disposition: inline
In-Reply-To: <1404399349-20237-8-git-send-email-wens@csie.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sunxi@googlegroups.com


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:55:47PM +0800, Chen-Yu Tsai wrote:
> Select the MFD_SUN6I_PRCM option when sun8i arch is enabled in order to
> get the PRCM (Power/Reset/Clock Management) related drivers compiled.
>=20
> Also select ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER to make sure
> the reset controller drivers are compiled.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTumGkAAoJEBx+YmzsjxAgqbsP/1CvFWJSEXJKpnvbJ1VVDqkF
RiI3E6gErbr4yJXewUXj31y+7s5Gen3cj2+N7HUA4PdbYpbFVELCPqtycUyy3Yxi
SXgfZ4daWB3iYvTkHZGpVWw8SnhnQgtCo2hRgey0xNAtpl1LCgxPVgUHxhWx1OkC
uqhAa/1XKU2+m5K2EHE/PJe/E6u65Djjrpj/NnQKuMSl/1FpABWVOiqRp8IgNpYi
ubtTW+clDS7FY1TCdHoTg8MabfiYOCS4P1I7T0m0m2RcO1HYo9QWW4X2BJw/FHtO
HHbZhks+j2dC2a5ehq6ezCIyGPHP1Tkj/a86Pl0PbR4DGlPXZrYSUadzxZO9H4xl
+6PVPJxlaotIfBzyZtmONta2feUixKm6wWDv1itjdtWNk8dQbXearnOTYMOfN97R
PbDZTs0ahuslXYPQsGLrHw33Nzq4kwqGEWbf7aNkGiWR2OTFEA7MGoXF83wtkFkH
lJJZXWk8tvFJS/hH+Tr/OjJMI8JdwT1EAh143Eg7Uyq55gdXGGktbSdhUSC0utO+
xq5ZeY24NWdL071Iel1ns5UKLrUXMQmUxzgqBKkW4e5eGFKkpSkb0+NoQhgQD230
1bHuMeyJJ76riTDMhPQOo69GJM5ROvzgbQst0X1qJg7vZFlTakKNB4BxADal3SdJ
JyMdQGsQie6zzv8TwPd6
=m5v+
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
