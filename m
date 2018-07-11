From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
Date: Wed, 11 Jul 2018 14:41:25 +0800
Message-ID: <20180711144125.7d4e6a73@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
        <20180710111516.13b8c570@xhacker.debian>
        <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Tue, 10 Jul 2018 19:19:21 +0300 Andy Shevchenko wrote:

> On Tue, 2018-07-10 at 11:15 +0800, Jisheng Zhang wrote:
> > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits.
> > 
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly tries to get the fractional divisor width during
> > probe, then setups dw specific get_divisor() and set_divisor() hook.  
> 
> Thanks for an update, my comments below.
> 
> > +/*
> > + * divisor = div(I) + div(F)
> > + * "I" means integer, "F" means fractional
> > + * quot = div(I) = clk / (16 * baud)
> > + * frac = div(F) * 2^dlf_size
> > + *
> > + * let rem = clk % (16 * baud)
> > + * we have: div(F) * (16 * baud) = rem
> > + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16
> > * baud)
> > + */
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{  
> 
> unsigned int base_baud = baud * 16;

Good point. will send a new version.

> 
> > +	unsigned int quot, rem;
> > +	struct dw8250_data *d = p->private_data;
> > +
> > +	quot = p->uartclk / (16 * baud);
> > +	rem = p->uartclk % (16 * baud);
> > +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud);
> > +  
> 
> While it looks indeed better, I would rather like to have a confirmation
> it's working as designed.
> 
> For example, when I did some calculus, I cooked a preliminary check in
> Python (easy and fast to prototype), for example:
> https://gist.github.com/andy-shev/06b084488b3629898121 in Python, or
> commit 9df461eca18f ("spi: pxa2xx: replace ugly table by approximation")
> in the kernel.
> 
> Or another one here https://gist.github.com/andy-shev/8b2a73aeca2874f4cc
> 89 and commits c1a67b48f6a5 ("serial: 8250_pci: replace switch-case by
> formula for Intel MID"), 21947ba654a6 ("serial: 8250_pci: replace
> switch-case by formula")

My python coding skill is limited. So I wrote a simple c program to
do the check for common clks and baudrate combination. All passed. I
paste the code here:


#include <stdio.h>
#include <assert.h>
#include <math.h>

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

#define DIV_ROUND_CLOSEST(x, divisor)(			\
{							\
	typeof(x) __x = x;				\
	typeof(divisor) __d = divisor;			\
	(((typeof(x))-1) > 0 ||				\
	 ((typeof(divisor))-1) > 0 ||			\
	 (((__x) > 0) == ((__d) > 0))) ?		\
		(((__x) + ((__d) / 2)) / (__d)) :	\
		(((__x) - ((__d) / 2)) / (__d));	\
}							\
)

static unsigned int baud[] = {9600, 19200, 38400, 57600, 115200, 230400,
				460800, 921600, 1843200, 3250000, 4454400,
				576000, 1152000, 500000, 1000000, 1500000,
				2000000, 2500000, 3000000, 3500000, 4000000};

static unsigned int clk[] = {25000000, 50000000, 100000000, 133000000, 200000000};

static void check(int baud, int clk, int dlf_size)
{
	unsigned int rem, frac, quot;
	unsigned int base_baud = baud * 16;
	float div, divf;

	quot = clk / base_baud;
	rem = clk % base_baud;
	frac = DIV_ROUND_CLOSEST(rem << dlf_size, base_baud);

	div = (float)clk / base_baud;
	divf = div - (int)div;
	divf *= (1 << dlf_size);

	assert(quot == (int)div);
	assert(frac == (int)round(divf));
	printf("checked %d %d %d %d %d\n", baud, clk, dlf_size, quot, frac);
}

int main()
{
	int i, j, k;

	for (i = 0; i < ARRAY_SIZE(baud); i++) {
		for (j = 0; j < ARRAY_SIZE(clk); j++) {
			for (k = 4; k <= 6; k++) {
				check(baud[i], clk[j], k);
			}
		}
	}

	return 0;
}
