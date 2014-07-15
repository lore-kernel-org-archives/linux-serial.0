From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 5/6] serial: 8250_dw: Add support for
 deferred probing
Date: Tue, 15 Jul 2014 09:00:33 +0200
Message-ID: <20140715070033.GF3745@lukather>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-6-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBJNFSOPAKGQEV7JM6MQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404892479-12222-6-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 03:54:38PM +0800, Chen-Yu Tsai wrote:
> The 8250_dw driver fails to probe if the specified clock isn't
> registered at probe time. Even if a clock frequency is given,
> the required clock might be gated because it wasn't properly
> enabled.
>=20
> This happened to me when the device is registered through DT,
> and the clock was part of an MFD, the PRCM found on A31 and A23
> SoCs. Unlike core clocks that are registered with OF_CLK_DECLARE,
> which happen almost immediately after the kernel starts, the
> clocks are registered as sub-devices of the PRCM MFD platform
> device. Even though devices are registered in the order they are
> found in the DT, the drivers are registered in a different,
> arbitrary order. It is possible that the 8250_dw driver is
> registered, and thus associated with the device and probed, before
> the clock driver is registered and probed.
>=20
> 8250_dw then reports unable to get the clock, and fails. Without
> a working console, the kernel panics.
>=20
> This patch adds support for deferred probe handling for the clock
> and reset controller.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxNGRAAoJEBx+YmzsjxAgPw8QAIN0tPNzUK9p+PH0UZ14T813
g6BCLztYWJueJ/tCsa3ZepX/JljL3kMFHp0SSOydckg6U6grIcj09nLomiCo/kK1
jhyoTpzBWu1qlDJF9ljURdfNcMj90R+LJmjXyg8ri7LOuLqcVNOkUk8iwGVPtAmx
Py1zteSEX4nuEXaCl34P9JdiFxbGfGZ2q7z0/6qTpDci2ATWoqg8THnrCh7+HcSW
as55hkJC5aMwrc3z3tGCkpf0ekNiCyhRv8ir4ULE06oc8NrPXt+PfWkwXv186J/s
TewFmhQ1Pt+GqgQTysAJIta7ViUlFRvShOJlvFwhQsOuZH5GILvQzDOnTabzw9nc
KVAKQoKrefKgd4IsDxK+X2P9XlPopCYKq55yXHPL8p4H/6xbravG3gIo8pHtz1bl
+Drlsmrc9AcTx1kXDXedQchl49r33bGyaVchVnVDdHBQpZnm64x00gpj22ilxQoQ
rFW+uf8J/Yy/PEH73hUHOklWk+Q1ga1MHS90bHth3AE3VCMm3rldjBlNBRW/pR1a
CvYJnakKKwrTbsOamaZVshL/kfsuNkjPp6/LzOVIQmKwWCuw8NAEdrikZNIjB2+Q
uoHpyft6vOJacAgn7037SU5J7Zs765LTmb/A+S5bipyNRIMNTcXZSDgDfQXD9HYe
Ac+ftTj2TApLNDJYpiCx
=HtMF
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
