From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 7/9] serdev: Introduce new bus for serial attached devices
Date: Tue, 10 Jan 2017 22:46:17 +0100
Message-ID: <20170110214617.GB2053@amd>
References: <20170106162635.19677-1-robh@kernel.org>
 <20170106162635.19677-8-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106162635.19677-8-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +static void serdev_ctrl_release(struct device *dev)
> +{
> +	struct serdev_controller *ctrl =3D to_serdev_controller(dev);
> +	ida_simple_remove(&ctrl_ida, ctrl->nr);
> +	kfree(ctrl);
> +}

Would it make sense to do something like to_serdev_controller(dev) =3D
NULL; there?

> +MODULE_AUTHOR("Rob Herring <robh@kernel.org");

Missing >.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh1VikACgkQMOfwapXb+vJpTwCdHxpRpKGXxge+AkN+kPGpKHt+
+VcAniREIgsO7OqHsrPBzNwIpY9awhS4
=6b3Z
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
