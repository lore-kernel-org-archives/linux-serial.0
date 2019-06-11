From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Date: Tue, 11 Jun 2019 15:44:15 +0300
Message-ID: <20190611124415.GT9224@smile.fi.intel.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611105603.4435-2-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.

>  static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>  {
>  	serial_out(up, UART_MCR, value);
> +
> +	if (up->gpios) {
> +		int mctrl_gpio = 0;
> +
> +		if (value & UART_MCR_RTS)
> +			mctrl_gpio |= TIOCM_RTS;
> +		if (value & UART_MCR_DTR)
> +			mctrl_gpio |= TIOCM_DTR;
> +
> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
> +	}
>  }
>  
>  static inline int serial8250_in_MCR(struct uart_8250_port *up)
>  {
> -	return serial_in(up, UART_MCR);
> +	int mctrl;
> +
> +	mctrl = serial_in(up, UART_MCR);
> +
> +	if (up->gpios) {
> +		int mctrl_gpio = 0;
> +
> +		/* save current MCR values */
> +		if (mctrl & UART_MCR_RTS)
> +			mctrl_gpio |= TIOCM_RTS;
> +		if (mctrl & UART_MCR_DTR)
> +			mctrl_gpio |= TIOCM_DTR;
> +
> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
> +		if (mctrl_gpio & TIOCM_RTS)
> +			mctrl |= UART_MCR_RTS;
> +		else
> +			mctrl &= ~UART_MCR_RTS;
> +
> +		if (mctrl_gpio & TIOCM_DTR)
> +			mctrl |= UART_MCR_DTR;
> +		else
> +			mctrl &= ~UART_MCR_DTR;
> +	}
> +
> +	return mctrl;
>  }

These are using OR logic with potentially volatile data. Shouldn't we mask
unused bits in UART_MCR in case of up->gpios != NULL?

> +	if (up->gpios == 0)

This is type inconsistency with this check as far as I understand.
I guess you have to do either (up->gpios == NULL), or (!up->gpios).

>  	ret = 0;

+ Blank line.

> +	if (up->gpios)
> +		return mctrl_gpio_get(up->gpios, &ret);

-- 
With Best Regards,
Andy Shevchenko
