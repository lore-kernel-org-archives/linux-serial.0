From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2 v3] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Date: Wed, 29 May 2019 15:44:35 +0200
Message-ID: <20190529134435.GR568@localhost>
References: <20190527111805.876-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190527111805.876-1-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

On Mon, May 27, 2019 at 01:18:04PM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI.

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> v3:
> - No change
> 
> v2:
> - Include the problem description and analysis from Mika into the commit
>   text, as suggested by Greg.
> 
>  drivers/tty/serial/serial_mctrl_gpio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 39ed56214cd3..cac50b20a119 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -116,6 +116,13 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>  
>  	for (i = 0; i < UART_GPIO_MAX; i++) {
>  		enum gpiod_flags flags;
> +		char *gpio_str;
> +
> +		/* Check if GPIO property exists and continue if not */
> +		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
> +				     mctrl_gpios_desc[i].name);

Where's the corresponding kfree?

> +		if (!device_property_present(dev, gpio_str))
> +			continue;
>  
>  		if (mctrl_gpios_desc[i].dir_out)
>  			flags = GPIOD_OUT_LOW;

Johan
