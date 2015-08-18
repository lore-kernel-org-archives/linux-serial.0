From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv4 2/4] serial: imx: add runtime pm support
Date: Mon, 17 Aug 2015 17:28:25 -0700
Message-ID: <20150818002823.GA11188@localhost.localdomain>
References: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
 <1439613468-22366-3-git-send-email-edubezval@gmail.com>
 <2095117.mcCCLIRizo@amdc1976>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2095117.mcCCLIRizo@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, khilman@kernel.org
List-Id: linux-serial@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bartlomiej,

On Mon, Aug 17, 2015 at 05:40:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
>=20
> Hi,
>=20
> On Friday, August 14, 2015 09:37:46 PM Eduardo Valentin wrote:
> > This change introduces the runtime pm support on imx serial
> > driver. The objective is to be able to idle the uart
> > port whenever it is not in use while still being able
> > to wake it up when needed. The key changes in this patch are:
> > 1. Move the clock handling to runtime pm. Both, ipg and per,
> > are now handled in the suspend and resume callbacks. Only
> > enabling and disabling the clocks are handled in runtime
> > suspend and resume, so we are able to use runtime pm
> > in IRQ context.
> > 2. Clocks are prepared in probe and unprepared in remove,
> > so we do not need to prepare (may sleep) in runtime pm.
> > 3. We mark the device activity based on uart and console
> > callbacks. Whenever the device is needed and we want to
> > access registers, we runtime_pm_get and then mark its
> > last usage when we are done. This is done also across
> > IRQs and DMA callbacks.
> > 4. We reuse the infrastructure in place for suspend and
> > resume, so we do not need to redo wakeup configuration,
> > or context save and restore.
> >=20
> > After this change, the clocks are still sane, in the sense
> > of having balanced clock prepare and enable.
>=20
> The clock changes in this patch seem to make this driver
> non-functional with CONFIG_PM=3Dn.  Have you tested your
> changes with CONFIG_PM=3Dn?

This is a valid point. I tried it yes, but maybe because in my
environment I had another user of the pll3_80m I did not see
issues with PM=3Dn. Now after sanitizing my .config, executing
the system with only the uart port / console as user of pll3_80m,
I see the uart console hanging because the uart clocks get gated.

>=20
> Generally the driver should not depend on PM support to
> enable its clocks.  We had this issue in few Exynos-specific
> drivers not that long time ago..
>=20

No doubt here. I am checking the best way to cover for this case.
Probably I will go for adding the support via the pm_clk*
infrastructure, as already suggested by khilman.

Thanks for spotting this.

BR,

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV0nwhAAoJEMLUO4d9pOJWCt8H/3sD5S/dHI/J/Awk/79pyDHW
1wqmBi3XYWkBFKVU1hZRh6XzODSukgfOPo3S7OY5JrwYJjf+ewB0OxzOMNhoDwOu
Ur9cUJF2aU5QjRtuyInNyQiJrjaepGQ+JR9rzbN33spdU6kaDMReCMGk+DolskO1
rBKcQ+hCv+eI29Rr6lvXio9PO2eHNa1xMJmo9aQ2KBcGD9CXj0YxnVFYFWc8RfQ/
NpB4kfvluWzQKp+WidJNhGXLLiX92WcmAjdm0JHNPg8mkvRlbcl5FyUwL3U8Toy6
GKEG/s87MWJKVoPEhLifYfvZoCoUj3b4mgYyuJl/0eplhA8de8FePsRREe4hyFU=
=FkG0
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
