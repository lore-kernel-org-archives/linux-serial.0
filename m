From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv2 6/8] serial: imx: add runtime pm support
Date: Tue, 11 Aug 2015 09:51:28 -0700
Message-ID: <20150811165126.GA4686@localhost.localdomain>
References: <1439256949-626-1-git-send-email-edubezval@gmail.com>
 <1439256949-626-7-git-send-email-edubezval@gmail.com>
 <CAOMZO5CCAd3_nYw2M1qPEevzJaymMi0oAn6FqGih3HbhvrYc9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CCAd3_nYw2M1qPEevzJaymMi0oAn6FqGih3HbhvrYc9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2015 at 12:02:58AM -0300, Fabio Estevam wrote:
> On Mon, Aug 10, 2015 at 10:35 PM, Eduardo Valentin <edubezval@gmail.com> =
wrote:
>=20
> >  static int imx_poll_get_char(struct uart_port *port)
> >  {
> > -       if (!(readl_relaxed(port->membase + USR2) & USR2_RDR))
> > -               return NO_POLL_CHAR;
> > +       int ret;
> > +
> > +       pm_runtime_get_sync(sport->dev);
> > +       if (!(readl_relaxed(port->membase + USR2) & USR2_RDR)) {
> > +               ret =3D NO_POLL_CHAR;
> > +               goto mark_last;
> > +       }
> >
> > -       return readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
> > +       ret =3D readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
> > +
> > +mark_last:
> > +       pm_runtime_mark_last_busy(sport->dev);
> > +       pm_runtime_put_autosuspend(sport->dev);
>=20
> You should return ret here.
>=20
> > +static int serial_imx_runtime_resume(struct device *dev)
> > +{
> > +       struct imx_port *sport =3D dev_get_drvdata(dev);
> > +
> > +       clk_enable(sport->clk_per);
>=20
> clk_enable() may fail.
>=20
> > +       clk_enable(sport->clk_ipg);
>=20
> Same here.
>=20
> > @@ -2096,6 +2212,8 @@ static int imx_serial_port_resume(struct device *=
dev)
> >         struct platform_device *pdev =3D to_platform_device(dev);
> >         struct imx_port *sport =3D platform_get_drvdata(pdev);
> >
> > +       clk_prepare_enable(sport->clk_per);
>=20
> clk_prepare_enable() may fail.
>=20
> > +       clk_prepare_enable(sport->clk_ipg);
>=20
> Ditto.


agreed on all. resending this one with the above suggestions/fixes applied.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVyigJAAoJEMLUO4d9pOJWPmoIAI3qqKHGwuYrECGiQ0DRGYG2
+YEqlAA4X2FpClmXGqD/jvlPWmZudoaG8eP35RTTyBOIdR9A68McdlJWZh2puNBC
7Z8Ut8ePsHJn/y1lq/9yZZBJwPd6/vm/wkGjs0QorggCGyALVXatw3MyI6MOe4cR
BKpeErie1N/7fgfNheuT6UYpbe9rQvuuLxKATRDRJC6PW/uMeoACfTwLaYN6wQ2v
7KIwYb8EFe/s1VMjlv7JS2Qw1s95iCgiC3s65I54jwbr0wdNZptF9SK5HZPqiXmw
t5KWFEfu+cqR9pu2RjfKkonkN8KfEp62yq9Fow2jQ7Kb2aWEiWLmvWXz7xAR+wU=
=UcnL
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
