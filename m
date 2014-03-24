From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] serial: efm32: properly namespace location property
Date: Mon, 24 Mar 2014 14:42:38 +0100
Message-ID: <20140324134238.GD2631@katana>
References: <1394813009-22796-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1394829731-25402-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58163 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbaCXNmm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2014 09:42:42 -0400
Content-Disposition: inline
In-Reply-To: <1394829731-25402-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-serial@vger.kernel.org, devicetree@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 09:42:11PM +0100, Uwe Kleine-K=F6nig wrote:
> While reviewing an i2c driver for efm32 that needs a similar property
> Wolfram Sang pointed out that "location" is a too generic name for someth=
ing
> that is efm32 specific. So add an appropriate namespace and fall back to =
the
> generic name in case of failure.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMDZOAAoJEBQN5MwUoCm2ruAP/RYhUgvNfJqmYJGIJ1MH/NjD
+DaZVUR2Lyj/jAqHJnemSXCkBqubTUvGM/wMsW3VFfpLPVpYVGtsDQXVOltLQgln
GBNADshA+JtuIPD99vaDbjT0JjxaIhvDjTuWTmfzp1tU1Z0nd1y2T0pJNE/9bZJr
5l82nGbweHJzR/uiHDDsFeHlHwaZrfPGM1LiurL9Ch/oq75V0f2qLV/+H2H/1ukR
HYiLrmSNAhBOUItOtAFtHMuYCvlpXip5kaQQcoowHEfBDyrtYTiHYO3tbYtHlOH2
0TlIjSmMGR0Ej3qcuucSJS03Be1Pn2bpXC0XyZTb88WhUpd5QIPcYHhNvgaBcua+
TR4UOVp9X4csi3l9l/aejvoYXc4Pk9ztPP4RTUV8rigw2A7nx5fZhfWG80FcMYQs
mbmfBKDkXX5xB53gWd3msFji4GAveRjG8b7kXY/Q0yIc1d9Lphs2O4pyz0i+94JS
FMk4g8aYfyL27jFZaARmb8zQTrNtlGkyMtoR9KPl904F9UHOnPy98Zq36nFUU3fI
u/4AZU2tLO/4q8O+LWVb/Tc+CltoAxZRRVOSitYWdkwibxtdUdpBIBWvkvYlByxa
2+FDjVIFj4mzieUFzBz6m3gYAzkC/9bmMulOW3JePfMvXKhs7DvirDS8kskrLPCi
azFmWxK/yS6oEpzu6uUG
=Gx+L
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
