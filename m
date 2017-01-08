From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 7/9] serdev: Introduce new bus for serial attached devices
Date: Sun, 8 Jan 2017 23:41:00 +0100
Message-ID: <20170108224100.japrs4eigyjbcloj@earth>
References: <20170106162635.19677-1-robh@kernel.org>
 <20170106162635.19677-8-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zlhzudj7phyl3ila"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106162635.19677-8-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--zlhzudj7phyl3ila
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jan 06, 2017 at 10:26:33AM -0600, Rob Herring wrote:
> [...]
>
> +static int serdev_device_match(struct device *dev, struct device_driver *drv)
> +{
> +	return of_driver_match_device(dev, drv);
> +}

Maybe add a TODO note here for ACPI/platform support?

> [...]
>
> +int serdev_device_open(struct serdev_device *serdev)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->open)
> +		return 0;
> +
> +	return serdev->ctrl->ops->open(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(serdev_device_open);

I would expect an error code if a serdev has no controller / open
method assigned?

> [...]
>
> +static int of_serdev_register_devices(struct serdev_controller *ctrl)
> +{
> +	struct device_node *node;
> +	struct serdev_device *serdev = NULL;
> +	int err;
> +	bool found = false;
> +
> +	for_each_available_child_of_node(ctrl->dev.of_node, node) {
> +		if (!of_get_property(node, "compatible", NULL))
> +			continue;
> +
> +		dev_dbg(&ctrl->dev, "adding child %s\n", node->full_name);
> +
> +		serdev = serdev_device_alloc(ctrl);
> +		if (!serdev)
> +			continue;
> +
> +		serdev->dev.of_node = node;
> +
> +		err = serdev_device_add(serdev);
> +		if (err) {
> +			dev_err(&serdev->dev,
> +				"failure adding device. status %d\n", err);
> +			serdev_device_put(serdev);

missing continue here?

> +		}
> +		found = true;
> +	}
> +	if (!found)
> +		return -ENODEV;
> +
> +	return 0;
> +}

-- Sebastian

--zlhzudj7phyl3ila
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhyv/kACgkQ2O7X88g7
+pog2Q/+OvySADLzO/Iolioq37OxhzneX4AkeYb4Nc8AHMrsVToU+xKc30TVlesG
Zrh0tuhiVZ6dogG5H2RS3eXFOfeNHyxLqq4uphMKukcEkrmxvBhUCCzA+nFhqV7o
LfBpC3n4qiBwIY7ZKuhgLl1R7wVLUihNAxP8UDI7xETlEqoe3lpN75o08GX3aLO/
XbFWCPTcaQkH1fAr3DSO7g5EveTxOsHgfgugcRf1raZGU15uTxaWiM4ula458ReV
hV2LbGibJdK2XhdZyM0+UktNlVojEZSPdXcRU9fcQe6wHzcp0P6PSZrpfAjGIkX9
267/Z2XYpDUKLyY9n2PQaChlBWk8YkLHU/8fOyj6wt7/nYgbH21j171lTokiAeJ2
0d7/yFZjl/wZsBFNUfSXddCntzTH1v9xZWUI0DmraatXFDiIPlkeuHDGObZaX2Gw
NorFYAd1hoNaDlxc02/SPRoCdIfXA7i7zCfl2YPKMiEJHl2oyEkslGCt+2o2HdyI
7w0JLTQa7lVxdE2Ho7+VeNKuoyp106qZkqaHg5ccZt0DdxpQ54BVlojvQuknHju9
H37ztZjABj5JhOc5JUYN7149adJ6MgsLPYt38k2gi/ng5KHv3d1fzHgfjPMPUed6
5YKyvS8eRzVPgh6dY3Dvds4m5oFvAd7WK7bZdEL1wXoAJSxR138=
=aVIB
-----END PGP SIGNATURE-----

--zlhzudj7phyl3ila--
