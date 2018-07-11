From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
Date: Wed, 11 Jul 2018 17:23:13 +0300
Message-ID: <d2ba8f992c272543d689d87006e99c3bcf343605.camel@linux.intel.com>
References: <20180710110942.5b0a016e@xhacker.debian>
         <20180710111516.13b8c570@xhacker.debian>
         <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
         <20180711144125.7d4e6a73@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711144125.7d4e6a73@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-07-11 at 14:41 +0800, Jisheng Zhang wrote:
> On Tue, 10 Jul 2018 19:19:21 +0300 Andy Shevchenko wrote:

> > > +/*
> > > + * divisor = div(I) + div(F)
> > > + * "I" means integer, "F" means fractional
> > > + * quot = div(I) = clk / (16 * baud)
> > > + * frac = div(F) * 2^dlf_size
> > > + *
> > > + * let rem = clk % (16 * baud)
> > > + * we have: div(F) * (16 * baud) = rem
> > > + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) /
> > > (16
> > > * baud)
> > > + */

> > > +	quot = p->uartclk / (16 * baud);
> > > +	rem = p->uartclk % (16 * baud);
> > > +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud

> My python coding skill is limited. So I wrote a simple c program to
> do the check for common clks and baudrate combination. All passed. I
> paste the code here:
> 

OK, I wrote test case in Python:
https://gist.github.com/andy-shev/5e980f1d752617ba814725248556ac19

Looks good to me.

Please, send v6 and assume my Reviewed-by for entire series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
