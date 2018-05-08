From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Date: Tue, 8 May 2018 15:40:47 +0200
Message-ID: <20180508134047.zocurxwelw3a24ti@earth.universe>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
 <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wb2m4rdd5yi7wpt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--6wb2m4rdd5yi7wpt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 08:43:51AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> > This properly unmaps DMA SG on device shutdown.
> >=20
> > Reported-by: Nandor Han <nandor.han@ge.com>
> > Suggested-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/tty/serial/imx.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 3ca767b1162a..6c53e74244ec 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port =
*port)
> >  	u32 ucr1, ucr2;
> > =20
> >  	if (sport->dma_is_enabled) {
> > -		sport->dma_is_rxing =3D 0;
> > -		sport->dma_is_txing =3D 0;
> >  		dmaengine_terminate_sync(sport->dma_chan_tx);
> > +		if (sport->dma_is_txing) {
> > +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> > +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> > +			sport->dma_is_txing =3D 0;
> > +		}
>=20
> did you find this because the kernel crashed or consumed more and more
> memory, or is this "only" a finding of reading the source code? If the
> former it would be great to point out in the commit log, if the latter,
> I wonder if this is a real problem that warrants a stable backport.

A bit of both. One of Collabora's customers had a (scarce) kernel crash
in imx-serial and modified multiple things in the driver. The crash is
gone, but it's not clear which change fixed it. I could not
reproduce the crash so far and I'm currently rebasing and splitting
their changes into upstreamable portions with proper patch
descriptions. From reading the source this looked like a real issue.

-- Sebastian

--6wb2m4rdd5yi7wpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrxqN0ACgkQ2O7X88g7
+poWCxAApwb98MM1VPGr5cibDrJ6pXjGtIPTfVz+WOsUW48kopVs1HHs4p+o6LZm
GB6j/4WvDQ6oG37WX+9b2URX+w76GzfDSpivNQw2b1nX/8m9tSn09vrGTfz2nFN+
j76CldlfNH9UYcz0ejUd2lcO0ESVji55H6YeFCRdBa3vrboN4Oh1eoMPZI+hOoI5
AX97Cjt/TEzYVpl+/F3SPvneRMrKfc81SDHL0f5NLMt4NXTx7qWh7ekRnjzDyjTs
axm/Trh5hrMuYQmo32IKMafBYJuw2bPLQFc748VtU19AoZt3Y7yX0U6cGpWyM9RF
WDMvEnotr3IEhw8Et041ReLMlPClOfO6e+6xUTjZnIuPMhzBsw+tI5z5x25tAGx+
GHEXihMsjysVptFLHWq/eyOxi5LC9DywMtzHa2ayYAZudiKIUbVjRlM+Fdziv00W
TfLnx8b6ry1bpENooOzTY5k3Cb9u0UL81aHqM4ZdVhiMiaLY9cOpFPMv5D8SV7S5
HjtpDpeonXnbNPk1zkBfTNGp6RNtMZ3E1zbIUjX5N5vyO6d+k1UOAEUxFYbFhzGt
HFjJx+iLTCGF/NLOp9QY0u13NDNYgmYBCkMTqGKZcsRYP/2qlR+QY9rHwilsLBnR
NKCoIMV+qNLYtWoUE6l98HpuVmBadpGNLoPgGeohtg5t2ztnyos=
=wYO1
-----END PGP SIGNATURE-----

--6wb2m4rdd5yi7wpt--
