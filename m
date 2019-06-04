From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2 v4] tty/serial/8250: use mctrl_gpio helpers
Date: Tue, 4 Jun 2019 19:52:24 +0300
Message-ID: <20190604165224.GP9224@smile.fi.intel.com>
References: <20190603083332.12480-1-sr@denx.de>
 <20190603083332.12480-2-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190603083332.12480-2-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 03, 2019 at 10:33:32AM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.

> +	if (up->gpios) {

> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
> +	}

...

> +	if (up->gpios) {

> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);

> +	}

...

> +			gpios = mctrl_gpio_init(&uart->port, 0);
> +			if (IS_ERR(gpios)) {
> +				if (PTR_ERR(gpios) != -ENOSYS)
> +					return PTR_ERR(gpios);
> +			}

...

> +	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
> +						UART_GPIO_RTS))) {

> +	}

...

> -	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
> +	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW
> +		&& IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
> +							UART_GPIO_RTS))) {

> }

...

> +	if (up->gpios)
> +		mctrl_gpio_disable_ms(up->gpios);

...

> +	if (up->gpios)
> +		mctrl_gpio_enable_ms(up->gpios);

...

> +	if (up->gpios)
> +		return mctrl_gpio_get(up->gpios, &ret);


Can we rather make this mimic the gpiod_get_optional() API?

So, if we get an error, it's an error, otherwise with NULL pointer the
operations goes to be no-op.

[IS_ERR_OR_NULL() -> IS_ERR(), if (up->gpios) -> /dev/null, etc]


-- 
With Best Regards,
Andy Shevchenko
