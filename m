From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Date: Mon, 9 Jul 2018 14:04:35 +0800
Message-ID: <20180709140435.3996588b@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
        <20180704170310.56772d77@xhacker.debian>
        <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
        <20180705143921.6a8aeb50@xhacker.debian>
        <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 6 Jul 2018 20:37:09 +0300 Andy Shevchenko wrote:

> On Thu, 2018-07-05 at 14:39 +0800, Jisheng Zhang wrote:
> > > On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:  
> 
> My comments below.
> 
> > > > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's
> > > > a
> > > > valid divisor latch fraction register. The fractional divisor
> > > > width is
> > > > 4bits ~ 6bits.    
> > > 
> > > I have read 4.00a spec a bit and didn't find this limitation.
> > > The fractional divider can fit up to 32 bits.  
> > 
> > the limitation isn't put in the register description, but in the
> > description
> > about fractional divisor width configure parameters. Searching
> > DLF_SIZE will
> > find it.  
> 
> Found, thanks.
> 
> > From another side, 32bits fractional div is a waste, for example,
> > let's
> > assume the fract divisor = 0.9, 
> > if fractional width is 4 bits, DLF reg will be set to UP(0.9*2^4) =
> > 15, the
> > real frac divisor =  15/2^4 = 0.93;
> > if fractional width is 32 bits, DLF reg will be set to UP(0.9*2^32) =
> > 3865470567
> > the real frac divisor = 3865470567/2^32 = 0.90;  
> 
> So, your example shows that 32-bit gives better value. Where is
> contradiction?

The gain -- 0.03 is small, the pay is expensive ;)

> 
> > > I would test this a bit later.  
> 
> It reads back 0 on our hardware with 3.xx version of IP.

Thanks. So the ver check could be removed.

>   
> > > > +	unsigned int		dlf_size:3;    
> > > 
> > > These bit fields (besides the fact you need 5) more or less for
> > > software
> > > quirk flags. In your case I would rather keep a u32 value of DFL
> > > mask as
> > > done for msr slightly above in this structure.  
> > 
> > OK. When setting the frac div, we use DLF size rather than mask, so
> > could
> > I only calculate the DLF size once then use an u8 value to hold the
> > calculated DLF size rather than calculating every time?  
> 
> Let's see below.
> 
> > > > +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > > > baud);    
> > > 
> > > If we have clock rate like 100MHz and 10 bits of fractional divider
> > > it
> > > would give an integer overflow.  
> > 
> > This depends on the fraction divider width. If it's only 4~6 bits,
> > then we are fine.  
> 
> True.
> 
> > > 
> > > 4 here is a magic. Needs to be commented / described better.  
> > 
> > Yes. divisor = clk/(16*baud) = BRD(I) + BRD(F)
> > "I" means integer, "F" means fractional
> > 
> > 2^dlf_size*clk/(16*baud) = 2^dlf_size*(BRD(I) + BRD(F))
> > 
> > clk*2^(dlf_size - 4)/baud = 2^dlf_size*((BRD(I) + BRD(F))
> > 
> > the left part is "DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> > baud)",
> > let's assume it equals quot.
> > 
> > then, BRD(I) = quot / 2^dlf_size = quot >> dlf_size, this is where
> > "quot >> d->dlf_size" below from.
> > 
> > BRD(F) = quot & dlf_mask = quot & (~0U >> (32 - dlf_size))  
> 
> Yes, I understand from where it comes. It's a hard coded value of PS all
> over the serial code.
> 
> And better use the same idiom as in other code, i.e. * 16 or / 16
> depends on context.
> 
> > > > +	*frac = quot & (~0U >> (32 - d->dlf_size));
> > > > +    
> > > 
> > > Operating on dfl_mask is simple as
> > > 
> > > u64 quot = p->uartclk * (p->dfl_mask + 1);  
> > 
> > Since the dlf_mask is always 2^n - 1, 
> > clk * (p->dlf_mask + 1) = clk << p->dlf_size, but the later
> > is simpler
> >   
> > > 
> > > *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> > > return quot;  
> > 
> > quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud)
> > *frac = quot & (~0U >> (32 - d->dlf_size))
> > return quot >> d->dlf_size;
> > 
> > vs.
> > 
> > quot = p->uartclk * (p->dfl_mask + 1);
> > *frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
> > return quot;
> > 
> > shift vs mul.
> > 
> > If the dlf width is only 4~6 bits, the first calculation can avoid
> > 64bit div. I prefer the first calculation.  
> 
> OK, taking that into consideration and looking at the code snippets
> again I would to
>  - keep two values
> 
> // mask we get for free because it's needed in intermediate calculus
> //
> and it doesn't overflow u8 (4-6 bits by spec)
> u8 dlf_mask;
> u8 dlf_size;
> 
>  - implement function like below
> 
> unsigned int quot;
> 
> /* Consider maximum possible DLF_SIZE, i.e. 6 bits */
> quot = DIV_ROUND_CLOSEST(p->uartclk * 4, baud);
> 
> *frac = (quot >> (6 - dlf_size)) & dlf_mask;
> return quot >> dlf_size;
> 
> Would you agree it looks slightly less complicated?

Nice. I will follow this solution.

> 
> > > > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > > +	serial_dl_write(up, quot);    
> 
> (1)
> 
> > > 
> > > At some point it would be a helper, I think. We can call
> > > serial8250_do_set_divisor() here. So, perhaps we might export it.  
> > 
> > serial8250_do_set_divisor will drop the frac, that's not we want ;)  
> 
> Can you check again? What I see is that for DW 8250 the
> _do_set_divisor() would be an equivalent to the two lines, i.e. (1).

My bad, I mixed it with get_divisor.

> 
> And basically at the end it should become just those two lines when the
> rest will implement their custom set_divisor().

yes, makes sense. Will send a new version soon.
