From: Sean Young <sean@mess.org>
Subject: Re: [PATCH 2/2] 8250: blacklist IR ports
Date: Fri, 7 Sep 2012 10:30:20 +0100
Message-ID: <20120907093020.GA26788@pequod.mess.org>
References: <cover.1346969721.git.sean@mess.org>
 <a9565dd624c186917c71a4e431e6bcab712dbf08.1346969721.git.sean@mess.org>
 <20120907010135.6a4d0a20@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pequod.mess.org ([93.97.41.153]:60841 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab2IGJaX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 05:30:23 -0400
Content-Disposition: inline
In-Reply-To: <20120907010135.6a4d0a20@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Fri, Sep 07, 2012 at 01:01:35AM +0100, Alan Cox wrote:
> On Thu,  6 Sep 2012 23:20:32 +0100
> Sean Young <sean@mess.org> wrote:
> 
> > These ports should not be probed, but we need to keep track of them so we
> > can prevent the legacy (non-PNP) probe of serial ports from touching them
> > too.
> 
> I want to have a think about getting the ordering right so we don't
> shuffle the ports on existing boxes for the first half. For the second
> part

If pnp lists serial devices in a different order than the legacy devices 
or a singular one which is not the same as ttyS0, things probably will look 
different. Not sure what can be done or anything needs to be done.

> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  drivers/tty/serial/8250/8250.c     | 16 ++++++++++++++--
> >  drivers/tty/serial/8250/8250_pnp.c | 23 ++++++++++++++++++-----
> >  include/linux/serial_core.h        |  3 ++-
> >  3 files changed, 34 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
> > index bc25874..ea9166b 100644
> > --- a/drivers/tty/serial/8250/8250.c
> > +++ b/drivers/tty/serial/8250/8250.c
> > @@ -290,6 +290,9 @@ static const struct serial8250_config uart_config[] = {
> >  				  UART_FCR_R_TRIG_00 | UART_FCR_T_TRIG_00,
> >  		.flags		= UART_CAP_FIFO,
> >  	},
> > +	[PORT_IR] = {
> > +		.name		= "IR port"
> 
> Please use "CIR port". We have SIR and FIR serial ports (IrDA) too that we
> do drive via tty. PORT_8250_CIR for the type might be best too - it means
> the tools know what they are looking at and can report it sensibly.

At least for the nsc-ircc driver, user space must manually remove the
the uart driver and then load the nsc-ircc driver. This patch also 
fixes that for nsc-ircc devices. It should work although I am unable to 
find the hardware to test it on yet, I used to have one of these. Testers 
would be appreciated. See:

> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
> index 28bf830..6ab2ce1 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -362,6 +362,12 @@ static const struct pnp_device_id pnp_dev_table[] = {
>  	{	"PNPCXXX",		UNKNOWN_DEV	},
>  	/* More unknown PnP modems */
>  	{	"PNPDXXX",		UNKNOWN_DEV	},
> +	/* IR ports -- should not be probed. We should keep track of them
> +	   to prevent the legacy serial driver from probing */
> +	{	"WEC1022",		IR_PORT	},

Winbond CIR

> +	{	"NSC6001",		IR_PORT },
> +	{	"HWPC224",		IR_PORT },
> +	{	"IBM0071",		IR_PORT },

nsc-ircc IRDA

>  	{	"",			0	}
>  };

I should have been more explicit about this, possibly in comments. For now 
I am happy to remove those and rename the port PORT_8250_CIR if you prefer.


Sean
