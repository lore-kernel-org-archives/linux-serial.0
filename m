From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/9] Serial slave device bus
Date: Fri, 20 Jan 2017 10:50:50 +0100
Message-ID: <20170120095049.772jojzx6c6fyfaa@earth>
References: <20170116225436.17505-1-robh@kernel.org>
 <7d6a8a629f8b618cdb09c9112d1e5986@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vaiwmimbg3c6epf4"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7d6a8a629f8b618cdb09c9112d1e5986-l3A5Bk7waGM@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msuchanek <msuchanek-l3A5Bk7waGM@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--vaiwmimbg3c6epf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 20, 2017 at 02:36:12AM +0100, msuchanek wrote:
> On 2017-01-16 23:54, Rob Herring wrote:
> > Here's a new version of the serdev bus support with all the review
> > feedback so far incorporated. I've left it named serdev for now pending
> > any further votes one way or the other, but I did rename the sysfs
> > visible
> > portions to "serial".
> >=20
> > There's still some discussion about what to do with devices that pass
> > thru
> > data to userspace unmodified like GPS and could still use tty device for
> > the data path. IMO, we should treat this as a separate problem following
> > this series. Drivers we want to convert to serdev and already in the
> > kernel don't need this functionality.
>=20
> The whole point of the serial bus is to simplify and clean up support for
> serial devices.
> If tty users cannot use the kernel support for automagic kill
> switches/resets/whatever with kernel GPIO or whatever framework and must
> continue supporting userspace GPIO and hacks for writing IO space from
> userland for their devices there is just no point.

> I mean it's fine to add support for your single pet device but if you are
> to support non-trivial number of devices they don't get all perfect kernel
> driver overnight. And if you need userspace GPIO for half of your devices
> you can just continue using it for all to *simplify* your userspace code.

This is definitely not about a single pet device. It helps for most
of the serial attached bluetooth chips. For example my work on the
Nokia N-series bluetooth driver is waiting for this series and
supporting the nokia bluetooth chips with userspace GPIOs is more
or less impossible with the data being handled in the kernel, since
GPIOs have to be toggled based on that data.

Also there is the kurobox, which uses a serial attached board reset
controller. It may not need extra GPIOs/regulators/whatever, but it
must have a full-in-kernel driver, so that 'reboot' works as expected ;)

> It has already happened for SPI devices and the implementation of the
> userspace access to SPI is dragging for years.

Talking about dragging for years: This series has been initially
discussed in 2014. Implementing this step-by-step looks sensible
to me.

-- Sebastian

--vaiwmimbg3c6epf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliB3XcACgkQ2O7X88g7
+pqV5RAAmTJE7riS/rcyZVyK6CUv4Lwh+p8A+Yyl2kuGqe4ReowR+uaAFDXYOtmj
Cis5veWp6rxtHTlqj+H533DYW3/Wv43JIWqI7fq5CF6fxn53cmW9FR9O7hoLqTkv
fTpO9N4qHRJpAUn9izU7lqVNqZG8pvULkn3gRUVUY0g0SLe5wCFi4YBAFt9u96Cc
IFoQJA0syseC69nptEGv7IPj8I5yM436rfp3ImJB2oQy5zoRHorxy7i8UXRJpcAB
iVV14mJ+20kCfsYpfitkhVdYyJ6vgjmAeMk7cGNX43agWWOh1UKG5kf38/BeBy9s
ylsJhax5jEpDYZR0syrSjoFFIeb3hbaGZDZawOhdHpFxygYPt3iCnMn/oKugJIqR
5XLJkke+ftEFvwPM7lToefuY5ADr0cvhpQ8mMLOIcx/W2wy92O9jBVhs9xxSIRdi
brDS0NpiyPR3V3ypIOmb13NkOFCOHVnyLonmQDqDIHgcSJtWQtCQKiwD3qyuVb77
PwgOeKJG4ffkSPwB59kB+/Z1u6h7Zt3FadlsH2b6h1FWU6raDBqIeI+yKFDSxHi/
ph/p+UCLPagXMp5R++6BfCFC9iy3JnR1VdxNOD9+4phGs4xd7S1RIjvEg1+lKLvA
RuXQkdNzfLBNLUdtaMIhvzX/VWeNQg/ng5QPJZbpPYhX3Qf/KkY=
=ZKvi
-----END PGP SIGNATURE-----

--vaiwmimbg3c6epf4--
