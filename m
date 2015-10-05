From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] sc16is7xx: null ptr check
Date: Mon, 5 Oct 2015 08:31:28 +0200
Message-ID: <20151005063127.GX3982@pengutronix.de>
References: <1441015287-14240-1-git-send-email-sean.nyekjaer@prevas.dk>
 <20151004202316.GV3982@pengutronix.de>
 <56120E09.7060702@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56120E09.7060702-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean =?iso-8859-1?Q?Nyekj=E6r?= <sean.nyekjaer-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

[fix quoting, adding broonie and linux-spi to addressees]

On Mon, Oct 05, 2015 at 07:43:37AM +0200, Sean Nyekj=E6r wrote:
> On 2015-10-04 22:23, Uwe Kleine-K=F6nig wrote:
> >On Mon, Aug 31, 2015 at 12:01:27PM +0200, Sean Nyekjaer wrote:
> >>If a wrong compatible flag in specified, the of_match_device
> >>returning null.
> >>Implemented check and if NULL then returning -ENODEV.
> >>
> >>Signed-off-by: Sean Nyekjaer <sean.nyekjaer-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
> >>---
> >>  drivers/tty/serial/sc16is7xx.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >>diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc=
16is7xx.c
> >>index 72ffd0d..2fce9fb 100644
> >>--- a/drivers/tty/serial/sc16is7xx.c
> >>+++ b/drivers/tty/serial/sc16is7xx.c
> >>@@ -1320,6 +1320,8 @@ static int sc16is7xx_spi_probe(struct spi_dev=
ice *spi)
> >>  	if (spi->dev.of_node) {
> >>  		const struct of_device_id *of_id =3D
> >>  			of_match_device(sc16is7xx_dt_ids, &spi->dev);
> >>+	if (!of_id)
> >>+		return -ENODEV;
> >
> >Did you see a problem here? I wonder if this can ever trigger. In th=
e
>
> Yes i did :-)
>
> >commit log you wrote "If a wrong compatible flag in specified, ...",=
 but
> >then the probe function isn't called at all, is it?
> >
> >>  		devtype =3D (struct sc16is7xx_devtype *)of_id->data;
> >>  	} else {
>=20
> Here you can see code snippet of the dtb that triggered the NULL
> pointer dereference:
>     sc16is750@1 {
>         compatible =3D "sc16is750";
>         spi-max-frequency =3D <2000000>;
>         reg =3D <1>;
>         clocks =3D <&clk14m>;
>         interrupt-parent =3D <&gpio7>;
>         interrupts =3D <5 2>;
>     }
>=20
> And what my dtb should have looked like:
>     sc16is750@1 {
>         compatible =3D "nxp,sc16is750";
>         spi-max-frequency =3D <2000000>;
>         reg =3D <1>;
>         clocks =3D <&clk14m>;
>         interrupt-parent =3D <&gpio7>;
>         interrupts =3D <5 2>;
>     }

The relevant driver details are:

static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] =3D =
{
	...
	{ .compatible =3D "nxp,sc16is750",        .data =3D &sc16is750_devtype=
, },
	...
	{ }
};

=2E..

static const struct spi_device_id sc16is7xx_spi_id_table[] =3D {
	...
	{ "sc16is750",  (kernel_ulong_t)&sc16is750_devtype, },
	...
	{ }
};

So in the broken case the device in question was bound to the
sc16is7xx driver because the compatible name was matched by the
id_table and not the of_match_table. My first thought was that in this
case the spi_device's dev->of_node should not be set, but after having
thought a bit more I think this is right.

But the .probe routine could be a tad more clever here:

	devtype =3D of_device_get_match_data(&spi->dev);
	if (!devtype) {
		const struct spi_device_id *id_entry =3D spi_get_device_id(spi);

		/* Do I need to check id_entry being !=3D NULL here? */
		devtype =3D (struct sc16is7xx_devtype *)id_entry->driver_data;
		flags =3D IRQF_TRIGGER_FALLING;
	}

Apart from that using "flags =3D IRQF_TRIGGER_FALLING" iff the device w=
as
probed via spi_id_table is strange.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
