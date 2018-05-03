From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
Date: Thu, 3 May 2018 13:13:17 -0700
Message-ID: <20180503201317.GA19401@kroah.com>
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
 <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 03, 2018 at 02:13:53PM +0800, Chris Ruehl wrote:
> Hi Greg,
> 
> On Friday, April 20, 2018 02:13 PM, Uwe Kleine-König wrote:
> > Hello Chris,
> > 
> > On Fri, Apr 20, 2018 at 09:07:59AM +0800, Chris Ruehl wrote:
> > > Fix a problem introduced with
> > > commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
> > > result in non dte-mode imx-uart fail receive data.
> > > By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.
> > > 
> > > Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > > ---
> > >   drivers/tty/serial/imx.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index 91f3a1a..3d09933 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
> > >   		ucr3 = imx_uart_readl(sport, UCR3);
> > > -		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
> > > +		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
> > >   		if (sport->dte_mode)
> > >   			/* disable broken interrupts */
> > 
> > Doesn't 6df765dca378bddf994cfd2044acafa501bd800f fix this for you?
> > 
> > Best regards
> > Uwe
> > 
> 
> The IMX serial driver is broken in the 4.9.x tree since 4.9.89.
> Uwe's patch
> 
> 6df765dca378bddf994cfd2044acafa501bd800f
> 
> please apply to clear the situation.
> 
> I know you very busy! -

It's best to email stable@vger.kernel.org for stuff like this, as I
almost missed it...

Now queued up.

greg k-h
