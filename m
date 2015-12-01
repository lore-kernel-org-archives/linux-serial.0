From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Tue, 1 Dec 2015 12:21:00 +0000
Message-ID: <20151201122100.GB4036@xora-haswell.xora.org.uk>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org>
 <1443609530-21524-4-git-send-email-graeme.gregory@linaro.org>
 <14968240.IklpWf8GZo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <14968240.IklpWf8GZo@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 01, 2015 at 03:21:47AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, September 30, 2015 11:38:50 AM Graeme Gregory wrote:
> > In ACPI this device is only defined in SBSA mode so
> > if we are probing from ACPI use this mode.
> > 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > ---
> >  drivers/tty/serial/amba-pl011.c | 32 +++++++++++++++++++++-----------
> >  1 file changed, 21 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index fd27e98..55209aa 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2368,18 +2368,28 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> >  	if (!uap)
> >  		return -ENOMEM;
> >  
> > -	uap->clk = devm_clk_get(&dev->dev, NULL);
> > -	if (IS_ERR(uap->clk))
> > -		return PTR_ERR(uap->clk);
> > -
> > -	uap->vendor = vendor;
> > -	uap->lcrh_rx = vendor->lcrh_rx;
> > -	uap->lcrh_tx = vendor->lcrh_tx;
> > -	uap->fifosize = vendor->get_fifosize(dev);
> > +	/* ACPI only defines SBSA variant */
> > +	if (!ACPI_COMPANION(&dev->dev)) {
> 
> It would read more straightforward if you did
> 
> 	if (ACPI_COMPANION(&dev->dev)) {
> 		<handle the ACPI case>
> 	} else {
> 		<handle the non-ACPI case>
> 	}
> 

This was something I debated about whether to put the ACPI case or the
common case first. I can certainly reverse it.

> > +		uap->clk = devm_clk_get(&dev->dev, NULL);
> > +		if (IS_ERR(uap->clk))
> > +			return PTR_ERR(uap->clk);
> > +
> > +		uap->vendor = vendor;
> > +		uap->lcrh_rx = vendor->lcrh_rx;
> > +		uap->lcrh_tx = vendor->lcrh_tx;
> > +		uap->fifosize = vendor->get_fifosize(dev);
> > +		uap->port.ops = &amba_pl011_pops;
> > +		snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
> > +				amba_rev(dev));
> > +	 } else {
> > +		uap->vendor	= &vendor_sbsa;
> > +		uap->fifosize	= 32;
> > +		uap->port.ops	= &sbsa_uart_pops;
> > +		uap->fixed_baud = 115200;
> > +
> > +		snprintf(uap->type, sizeof(uap->type), "SBSA");
> 
> This looks sort of heavy-handed.
> 
> Is this the only possible configuration of the device in the ACPI case?
> 

As far as I can tell yes, but ARM haven't actually published a document
to state that as fact.

This does replace the platform_probe that Russel was unhappy about for
the ACPI case.

Graeme

