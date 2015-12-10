From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH-v8] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Thu, 10 Dec 2015 11:31:04 +0200
Message-ID: <20151210093104.GD4884@kuha.fi.intel.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
 <1445158908-9610-1-git-send-email-noamc@ezchip.com>
 <20151209131939.GA14285@kuha.fi.intel.com>
 <DB5PR02MB1141B69C5E327950511F4590D6E90@DB5PR02MB1141.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB5PR02MB1141B69C5E327950511F4590D6E90@DB5PR02MB1141.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>
List-Id: linux-serial@vger.kernel.org

Hi Noam,

On Thu, Dec 10, 2015 at 07:26:42AM +0000, Noam Camus wrote:
> >From: Heikki Krogerus [mailto:heikki.krogerus@linux.intel.com] 
> >Sent: Wednesday, December 09, 2015 3:20 PM
> 
> 
> >> @@ -171,7 +174,8 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
> >>  			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
> >>  				return;
> >>  			dw8250_force_idle(p);
> >> -			writel(value, p->membase + (UART_LCR << p->regshift));
> >> +			d->serial_out(value,
> >> +				      p->membase + (UART_LCR << p->regshift));
> >>  		}
> 
> >.. The way I see it, this is the only place where you would really need the
> >new private serial_in/out hooks, so why not just check the >iotype here and
> >based on that use writeb/writel/iowrite32be or what ever ..
> 
> In previous versions (V2) Greg dis-liked using iotype here this is why I added
> the private serial_in/serial_out

I couldn't find that comment in the thread? All he said in his
comment for this was that you should use real if condition instead of
the ternary operator you had there (condition ? true : false).

Why would it not be acceptable? If it would really not be acceptable
(which I don't believe) then you should simply duplicate the lcr
checking to dw8250_seria_out32be like it is done now in
dw8250_serial_out and dw8250_serial_out32, but there still is no need
for the private serial_in/out hooks.

I'm attaching a diff that I think would work as a good starting point
for you.

> >>  static void dw8250_setup_port(struct uart_port *p)  {
> >>  	struct uart_8250_port *up = up_to_u8250p(p);
> >> +	struct dw8250_data *d = p->private_data;
> >>  	u32 reg;
> >>  
> >>  	/*
> >>  	 * If the Component Version Register returns zero, we know that
> >>  	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
> >>  	 */
> >> -	reg = readl(p->membase + DW_UART_UCV);
> >> +	reg = d->serial_in(p->membase + DW_UART_UCV);
> >>  	if (!reg)
> >>  		return;
> >>  
> >>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> >>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
> >>  
> >> -	reg = readl(p->membase + DW_UART_CPR);
> >> +	reg = d->serial_in(p->membase + DW_UART_CPR);
> >>  	if (!reg)
> >>  		return;
> 
> >.. Here you could as well replace the direct readl calls with serial_port_in
> >calls.
> Again, if you meant here for using iotype it was rejected.

No, I mean instead of d->serial_in you could just use p->serial_in
here (which is the same as calling serial_port_in()).

> >> @@ -390,9 +434,19 @@ static int dw8250_probe(struct platform_device 
> >> *pdev)
> >>  
> >>  	err = device_property_read_u32(p->dev, "reg-io-width", &val);
> >>  	if (!err && val == 4) {
> >> -		p->iotype = UPIO_MEM32;
> >> -		p->serial_in = dw8250_serial_in32;
> >> -		p->serial_out = dw8250_serial_out32;
> >> +		p->iotype = of_device_is_big_endian(p->dev->of_node) ?
> >> +			    UPIO_MEM32BE : UPIO_MEM32;
> 
> >If this has to be tied to DT, do this check in dw8250_quirks.
> Thanks , I will move this to dw8250_quirks.
> 
> >>  	dw8250_quirks(p, data);
> >>  
> >> +	data->serial_in = _dw8250_serial_in32;
> >> +	data->serial_out = _dw8250_serial_out32;
> 
> >I don't think I understand what is going on here? You would never actually
> >even use _dw8250_serial_in32be/out32be, no?
> 
> >Maybe I'm misunderstanding something.
> This is a default in case  where "reg-io-width != 4".
> What is the case you see that they are not used? (_dw8250_serial_in32be is
> used from dw8250_setup_port just few lines below)

But dw8250_setup_port will call data->serial_in hook based on this
patch, which will now be pointing to _dw8250_serial_in32, not
_dw8250_serial_in32be?


Thanks,

-- 
heikki
