From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] serial: imx: cleanup imx_uart_disable_dma()
Date: Tue, 8 May 2018 13:27:26 +0200
Message-ID: <20180508112726.nyxrebcuwwdq5npy@earth.universe>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-2-sebastian.reichel@collabora.co.uk>
 <20180508064047.v7wz7b4t5ta55hv7@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hldlbuxw4kvqlosc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508064047.v7wz7b4t5ta55hv7@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--hldlbuxw4kvqlosc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 08, 2018 at 08:40:47AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, May 07, 2018 at 11:36:09PM +0200, Sebastian Reichel wrote:
> > Remove unrelated CTSC/CTS disabling from imx_uart_disable_dma() and
> > move it to imx_uart_shutdown(), which is the only user of the DMA
> > disabling function. This should not change the driver's behaviour,
> > but improves readability. After this change imx_uart_disable_dma()
> > does the reverse thing of imx_uart_enable_dma().
> >=20
> > Suggested-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/tty/serial/imx.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index c2fc6bef7a6f..3ca767b1162a 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1291,18 +1291,13 @@ static void imx_uart_enable_dma(struct imx_port=
 *sport)
> > =20
> >  static void imx_uart_disable_dma(struct imx_port *sport)
> >  {
> > -	u32 ucr1, ucr2;
> > +	u32 ucr1;
> > =20
> >  	/* clear UCR1 */
> >  	ucr1 =3D imx_uart_readl(sport, UCR1);
> >  	ucr1 &=3D ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
> >  	imx_uart_writel(sport, ucr1, UCR1);
> > =20
> > -	/* clear UCR2 */
> > -	ucr2 =3D imx_uart_readl(sport, UCR2);
> > -	ucr2 &=3D ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> > -	imx_uart_writel(sport, ucr2, UCR2);
> > -
> >  	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> > =20
> >  	sport->dma_is_enabled =3D 0;
> > @@ -1447,7 +1442,7 @@ static void imx_uart_shutdown(struct uart_port *p=
ort)
> > =20
> >  	spin_lock_irqsave(&sport->port.lock, flags);
> >  	ucr2 =3D imx_uart_readl(sport, UCR2);
> > -	ucr2 &=3D ~(UCR2_TXEN | UCR2_ATEN);
> > +	ucr2 &=3D ~(UCR2_TXEN | UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
> >  	imx_uart_writel(sport, ucr2, UCR2);
> >  	spin_unlock_irqrestore(&sport->port.lock, flags);
>=20
> While this doesn't change behaviour (which is of course good and
> intended here) I wonder if changing RTS is right here.
>=20
> According to Documentation/serial/driver it is not.

Yes, looks like it should be removed completly. I suggest to keep
this in two different patches (move UCR2 handling first, then remove
RTS handling), so that we end up with simple and comprehensible patches.

-- Sebastian

--hldlbuxw4kvqlosc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrxiZsACgkQ2O7X88g7
+poXtg//egmX9sHgOFQsEbqhN3iiif0GU620EGZbtomR7qc21ZeQIa8EqUtmiXDS
ewuMWpAI/Ew0zWGv+BytTXOAtlaWE4P2oSK24jjVudhnoCm/ouBLrJWTKCrnIbYw
gYpxmpz9gKKfKseRjESy7b9DPAgS9KywabtS8/bNCcwvkEhiakgbSeUn5Uax+GaE
H/d21E6FqU10uLnQqCGfFoezksXG5mrMxlrC9/Wy+mvzfctmBPwmZJ4MLnaeFEdo
I6jktQ7kbxDwI9Lw5Tcs2RBNlZuNMh6DhvQrtYcUxjdyis4Z6+rIY761Znat4mwK
7Yz9e/k2kMawuk2ODEXXhEzHDdF0rKk4Tt5wxIDEmv8f7N1g2tQgx0zTzgj3JWT1
tWJy8sBT7Lh4DVxynm8BsFNPCi81yO0rH3hKMjnR19LsDtTIRhfoufXAmEKorbM7
W8acLGCSaNT0ZDEqCzKZGdPMvsq+o/CJ6iZiiUC9K2ZjXAav7m3p5TEbjXbL3GHU
sTDxdvK2MGqJG2Vj2dAG2VfuLyyTO/uegp9jT2jxSSvfgndJovp0IgMxAsvoLuyQ
4f4nuMOx491Z1TOPAhszcKfExw73Ak36Zoc5dm73XrfvWRwq1XtK+38igIHvuG6V
Z8xThKK+OeIU24ktiD2Fv6wIwsM9J6Y7ciGrjAxhYpEOxAIAIlw=
=9R1O
-----END PGP SIGNATURE-----

--hldlbuxw4kvqlosc--
