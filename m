From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Date: Thu, 17 May 2018 13:54:37 +0900
Message-ID: <20180517045437.GE20254@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, alexandre.belloni@bootlin.com, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-serial@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 15, 2018 at 12:22:24PM +0300, Radu Pirea wrote:
> On Mon, 2018-05-14 at 20:38 +0300, Andy Shevchenko wrote:

> > So, what is not going as expected in "SPI core takes care of CSs"
> > case?
> > Did you use oscilloscope for that?

> Yes, I used and CSs was not asserted. Anyway, I will will try again.

If the core chip select handling is not working properly for some reason
then the core chip select handling should be fixed rather than just open
coding in your driver - probably it's also broken for other users.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9CwwACgkQJNaLcl1U
h9AHmAf+MeZvNU8HPwcP+sQCno97dw8H+yoy3YJU9I0Dj3O2T7Oo92s9mWkZRvVo
sOKTcum4hVqmJFePu3boGmH63hfeD0QUOSm6kJr4xkSy1Sxz0ouOhlvI7LRe8XFK
e7cHXKAznizC8uLRLSmtfWJ1Yxs/Xp6f4ZHidVlXxlstZBp3pPNrf1Fp5l9fuHyn
SztnBBwxWDd+T0BolFLQttRrPK+QH8kbI4QGd+m7Nf+89x+FAWwsNKbFZE/J7A0A
J1ZHjrJ4Tby2CIG4dhx0EsBn57AyB+DxZJcCVYt66KyOcggs8kom3k+RxY8kXQNr
EDDh2ppYFrYMdZt1KnbLilNYeZ14Hw==
=UhMg
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
