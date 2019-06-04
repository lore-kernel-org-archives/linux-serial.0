From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2 v4] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Date: Tue, 4 Jun 2019 19:45:58 +0300
Message-ID: <20190604164558.GO9224@smile.fi.intel.com>
References: <20190603083332.12480-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190603083332.12480-1-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Giulio Benetti <giulio.benetti@micronovasrl.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 03, 2019 at 10:33:31AM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.

>  	for (i = 0; i < UART_GPIO_MAX; i++) {
>  		enum gpiod_flags flags;
> +		char *gpio_str;
> +
> +		/* Check if GPIO property exists and continue if not */
> +		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> +				     mctrl_gpios_desc[i].name);
> +		if (!device_property_present(dev, gpio_str)) {
> +			kfree(gpio_str);
> +			continue;
> +		}
> +		kfree(gpio_str);

Can we rather do something like

	bool present;


	... = kasprintf(...);
// (1)
	present = device_property_present(...);
	kfree(...);
	if (!present)
		continue;

?

On top of this, if gpio_str is NULL, we will have KABOOM.

Something like

	if (!gpio_str)
		continue;

in (1).

>  
>  		if (mctrl_gpios_desc[i].dir_out)
>  			flags = GPIOD_OUT_LOW;

-- 
With Best Regards,
Andy Shevchenko
