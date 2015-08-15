From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv3 6/8] serial: imx: add runtime pm support
Date: Fri, 14 Aug 2015 18:20:35 -0700
Message-ID: <20150815012034.GC4125@localhost.localdomain>
References: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
 <1439313687-28502-7-git-send-email-edubezval@gmail.com>
 <20150815002312.GA26089@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150815002312.GA26089@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 05:23:12PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Aug 11, 2015 at 10:21:25AM -0700, Eduardo Valentin wrote:
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
> >=20
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  drivers/tty/serial/imx.c | 224 +++++++++++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 178 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 50abb60..9447a55 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -39,6 +39,9 @@
> >  #include <linux/of_device.h>
> >  #include <linux/io.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeup.h>
> > =20
> >  #include <asm/irq.h>
> >  #include <linux/platform_data/serial-imx.h>
> > @@ -219,6 +222,7 @@ struct imx_port {
> >  	unsigned int            saved_reg[10];
> >  	bool			context_saved;
> > =20
> > +	struct device		*dev;
>=20
> Do you really need this pointer?  Can't you get it from the platform
> device that you have access to that sport is the data?

Actually, not really. I can change the code to the one in sport. I will
be resending soon.

>=20
> thanks,
>=20
> greg k-h

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVzpPbAAoJEMLUO4d9pOJWnlsH/1b4Ji9lCWOpD/KINN1Ftoe8
J0urYPb9rcRkP/mQvW2cQrV5DIWToyYR3HEeAqgTT6ZZ8wQrCJE1RRpFAMrC6g+S
1lJOtuLfozF1kWNbYD1q61w/u/IjnZBUqxtkxWtuRmNP/8msRbst8nXuib/48cBY
GHCZNwtwz32eRvzvMAMxpc1A8NWp6bqsxHlJLnabGvD/Ur7VeyHy+1SAKNqpvesW
mBVCAxyvSWrv5eX5UEa+iLGwqvxsW3fCXNHpKnw3GgXUdwscnO9/GFVBRhm5tE+b
8EXJs5WuZzQvUQiZcHpt5P0tRqjzRoqlhMwe3XKvJq4m2daYkKQFIRUs7O8CEqg=
=IBqq
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
