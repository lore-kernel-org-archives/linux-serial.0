From: Yao Yuan <yao.yuan@nxp.com>
Subject: RE: [PATCH] serial: fsl_lpuart: Remove the alias node dependence
Date: Thu, 12 Jan 2017 02:27:45 +0000
Message-ID: <AM5PR0402MB2900E8FCF2807A52E28B94B289790@AM5PR0402MB2900.eurprd04.prod.outlook.com>
References: <1481704412-19208-1-git-send-email-yao.yuan@freescale.com>
 <20170111072450.GA9980@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170111072450.GA9980@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Yuan Yao <yao.yuan@freescale.com>
Cc: "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 11, 2016 at 04:33:32PM +0800, Greg KH wrote:
> On Wed, Dec 14, 2016 at 04:33:32PM +0800, Yuan Yao wrote:
> > From: Yuan Yao <yao.yuan@nxp.com>
> >
> > Numbering the ttyLPn space should not depend on the generic name
> > "serial<n>".
> >
> > If don't add the alias node like:"serial0 =3D &lpuart0;", then lpuart
> > will probe failed:
> > [    0.773410] fsl-lpuart 2950000.serial: failed to get alias id, errno=
 -19
> >
> > So remove the alias node dependence, and add the support for allocate
> > the line port automatically.
> >
> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index a1c6519..c6d639f 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -231,6 +231,8 @@
> >  #define DEV_NAME	"ttyLP"
> >  #define UART_NR		6
> >
> > +static DECLARE_BITMAP(linemap, UART_NR);
>=20
> Why a bitmap?

Because I think the bitmap is enough to meet the need.
Are there any shortcomings for bitmap used here?

>=20
> > +
> >  struct lpuart_port {
> >  	struct uart_port	port;
> >  	struct clk		*clk;
> > @@ -1963,9 +1965,13 @@ static int lpuart_probe(struct platform_device
> > *pdev)
> >
> >  	ret =3D of_alias_get_id(np, "serial");
> >  	if (ret < 0) {
> > -		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> > -		return ret;
> > +		ret =3D find_first_zero_bit(linemap, UART_NR);
> > +		if (ret >=3D UART_NR) {
> > +			dev_err(&pdev->dev, "port line is full, add device
> failed\n");
> > +			return ret;
> > +		}
>=20
> Does this really remove the alias dependancy?
>=20
> Please use an idr or ida for this instead of a bitmap.
>=20

Hi Greg,

Thanks for your review.

Is there any advantage for use an idr or ida instead of bitmap?
I will hope to get your guidance.

Thanks.
