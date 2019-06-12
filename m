From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Date: Wed, 12 Jun 2019 12:16:21 +0300
Message-ID: <20190612091621.GA9224@smile.fi.intel.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
 <20190611124415.GT9224@smile.fi.intel.com>
 <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
 <20190611144828.GX9224@smile.fi.intel.com>
 <12e5180e-b4a0-e5fa-bcad-ddc8103d644c@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12e5180e-b4a0-e5fa-bcad-ddc8103d644c@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 12, 2019 at 10:13:05AM +0200, Stefan Roese wrote:
> On 11.06.19 16:48, Andy Shevchenko wrote:
> > On Tue, Jun 11, 2019 at 04:02:54PM +0200, Stefan Roese wrote:
> > > On 11.06.19 14:44, Andy Shevchenko wrote:
> > > > On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
> > 
> > > > >    static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
> > > > >    {
> > > > >    	serial_out(up, UART_MCR, value);
> > > > > +
> > > > > +	if (up->gpios) {
> > > > > +		int mctrl_gpio = 0;
> > > > > +
> > > > > +		if (value & UART_MCR_RTS)
> > > > > +			mctrl_gpio |= TIOCM_RTS;
> > > > > +		if (value & UART_MCR_DTR)
> > > > > +			mctrl_gpio |= TIOCM_DTR;
> > > > > +
> > > > > +		mctrl_gpio_set(up->gpios, mctrl_gpio);
> > > > > +	}
> > > > >    }
> > 
> > > > >    static inline int serial8250_in_MCR(struct uart_8250_port *up)
> > > > >    {
> > > > > -	return serial_in(up, UART_MCR);
> > > > > +	int mctrl;
> > > > > +
> > > > > +	mctrl = serial_in(up, UART_MCR);
> > > > > +
> > > > > +	if (up->gpios) {
> > > > > +		int mctrl_gpio = 0;
> > > > > +
> > > > > +		/* save current MCR values */
> > > > > +		if (mctrl & UART_MCR_RTS)
> > > > > +			mctrl_gpio |= TIOCM_RTS;
> > > > > +		if (mctrl & UART_MCR_DTR)
> > > > > +			mctrl_gpio |= TIOCM_DTR;
> > > > > +
> > > > > +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
> > > > > +		if (mctrl_gpio & TIOCM_RTS)
> > > > > +			mctrl |= UART_MCR_RTS;
> > > > > +		else
> > > > > +			mctrl &= ~UART_MCR_RTS;
> > > > > +
> > > > > +		if (mctrl_gpio & TIOCM_DTR)
> > > > > +			mctrl |= UART_MCR_DTR;
> > > > > +		else
> > > > > +			mctrl &= ~UART_MCR_DTR;
> > > > > +	}
> > > > > +
> > > > > +	return mctrl;
> > > > >    }
> > > > 
> > > > These are using OR logic with potentially volatile data. Shouldn't we mask
> > > > unused bits in UART_MCR in case of up->gpios != NULL?
> > > 
> > > Sorry, I don't see, which bits you are referring to? Could you please be
> > > a bit more specific with the variable / macro meant (example)?
> > 
> > I meant that we double write values in the out() which might have some
> > consequences, though I hope nothing wrong with it happens.
> 
> Where is the double write to a register? Sorry, I fail to spot it.

Not to the one register. From the functional point of view the same signal is
set up twice: once per UART register, once per GPIO pins.

> > In the in() we read the all bits in the register.
> > 
> > As now I look at the implementation of mctrl_gpio_get_outputs(),
> > I think we rather get helpers for conversion between TIOCM and UART_MCR values,
> > so, they can be used in get_mctrl() / set_mctrl() and above.
> 
> Do you something like this in mind?

More likely

static inline int serial8250_MCR_to_TIOCM(int mcr)
{
	int tiocm = 0;

	if (mcr & ...)
		tiocm |= ...;
	...

	return tiocm;
}

static inline int serial8250_TIOCM_to_MCR(int tiocm)
{
	... in a similar way ...
}

> Plus the use of these macros in this patch of course.

No macros, please.

-- 
With Best Regards,
Andy Shevchenko
