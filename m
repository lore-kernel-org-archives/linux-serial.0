From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Wed, 02 Dec 2015 02:25:30 +0100
Message-ID: <2178575.bCf8IHH3MB@vostro.rjw.lan>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org> <14968240.IklpWf8GZo@vostro.rjw.lan> <20151201122100.GB4036@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151201122100.GB4036@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Tuesday, December 01, 2015 12:21:00 PM Graeme Gregory wrote:
> On Tue, Dec 01, 2015 at 03:21:47AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, September 30, 2015 11:38:50 AM Graeme Gregory wrote:
> > > In ACPI this device is only defined in SBSA mode so
> > > if we are probing from ACPI use this mode.

[cut]

> > > +		uap->clk = devm_clk_get(&dev->dev, NULL);
> > > +		if (IS_ERR(uap->clk))
> > > +			return PTR_ERR(uap->clk);
> > > +
> > > +		uap->vendor = vendor;
> > > +		uap->lcrh_rx = vendor->lcrh_rx;
> > > +		uap->lcrh_tx = vendor->lcrh_tx;
> > > +		uap->fifosize = vendor->get_fifosize(dev);
> > > +		uap->port.ops = &amba_pl011_pops;
> > > +		snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
> > > +				amba_rev(dev));
> > > +	 } else {
> > > +		uap->vendor	= &vendor_sbsa;
> > > +		uap->fifosize	= 32;
> > > +		uap->port.ops	= &sbsa_uart_pops;
> > > +		uap->fixed_baud = 115200;
> > > +
> > > +		snprintf(uap->type, sizeof(uap->type), "SBSA");
> > 
> > This looks sort of heavy-handed.
> > 
> > Is this the only possible configuration of the device in the ACPI case?
> > 
> 
> As far as I can tell yes, but ARM haven't actually published a document
> to state that as fact.

At least a comment explaining what kind of information this is based on would
be useful.  Otherwise one has to wonder where this is coming from.

> This does replace the platform_probe that Russel was unhappy about for
> the ACPI case.

I can't really comment on that.

Thanks,
Rafael

