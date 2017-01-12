From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: fsl_lpuart: Remove the alias node dependence
Date: Thu, 12 Jan 2017 08:26:34 +0100
Message-ID: <20170112072634.GA21645@kroah.com>
References: <1481704412-19208-1-git-send-email-yao.yuan@freescale.com>
 <20170111072450.GA9980@kroah.com>
 <AM5PR0402MB2900E8FCF2807A52E28B94B289790@AM5PR0402MB2900.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM5PR0402MB2900E8FCF2807A52E28B94B289790@AM5PR0402MB2900.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yao Yuan <yao.yuan@nxp.com>
Cc: Yuan Yao <yao.yuan@freescale.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 12, 2017 at 02:27:45AM +0000, Yao Yuan wrote:
> On Wed, Jan 11, 2016 at 04:33:32PM +0800, Greg KH wrote:
> > On Wed, Dec 14, 2016 at 04:33:32PM +0800, Yuan Yao wrote:
> > > From: Yuan Yao <yao.yuan@nxp.com>
> > >
> > > Numbering the ttyLPn space should not depend on the generic name
> > > "serial<n>".
> > >
> > > If don't add the alias node like:"serial0 = &lpuart0;", then lpuart
> > > will probe failed:
> > > [    0.773410] fsl-lpuart 2950000.serial: failed to get alias id, errno -19
> > >
> > > So remove the alias node dependence, and add the support for allocate
> > > the line port automatically.
> > >
> > > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index a1c6519..c6d639f 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -231,6 +231,8 @@
> > >  #define DEV_NAME	"ttyLP"
> > >  #define UART_NR		6
> > >
> > > +static DECLARE_BITMAP(linemap, UART_NR);
> > 
> > Why a bitmap?
> 
> Because I think the bitmap is enough to meet the need.
> Are there any shortcomings for bitmap used here?
> 
> > 
> > > +
> > >  struct lpuart_port {
> > >  	struct uart_port	port;
> > >  	struct clk		*clk;
> > > @@ -1963,9 +1965,13 @@ static int lpuart_probe(struct platform_device
> > > *pdev)
> > >
> > >  	ret = of_alias_get_id(np, "serial");
> > >  	if (ret < 0) {
> > > -		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> > > -		return ret;
> > > +		ret = find_first_zero_bit(linemap, UART_NR);
> > > +		if (ret >= UART_NR) {
> > > +			dev_err(&pdev->dev, "port line is full, add device
> > failed\n");
> > > +			return ret;
> > > +		}
> > 
> > Does this really remove the alias dependancy?
> > 
> > Please use an idr or ida for this instead of a bitmap.
> > 
> 
> Hi Greg,
> 
> Thanks for your review.
> 
> Is there any advantage for use an idr or ida instead of bitmap?

Yes, it makes it so that we don't have to hand-audit your code for
proper use of a bitmap.  Using an idr is easy, and is obvious when you
do it correctly.  That's why using common apis is good for everyone, you
want someone else to be able to review your code.

thanks,

greg k-h
