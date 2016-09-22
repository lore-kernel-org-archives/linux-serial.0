From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv2 1/3] serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
Date: Thu, 22 Sep 2016 15:14:05 +0200
Message-ID: <20160922131405.y4wvgd3n534jbdv5@pengutronix.de>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-2-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160912094733.21501-2-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 12, 2016 at 11:47:31AM +0200, Richard Genoud wrote:
> This function returns true if CTS and RTS are used as GPIOs.
> Some drivers (like atmel_serial) needs to know if the flow control is
> handled by the controller or by GPIOs.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>  drivers/tty/serial/serial_mctrl_gpio.c |  8 ++++++++
>  drivers/tty/serial/serial_mctrl_gpio.h | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index d2da6aa7f27d..93bed8c99796 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/irq.h>
> +#include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/termios.h>
>  #include <linux/serial_core.h>
> @@ -72,6 +73,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
>  
> +bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios)
> +{
> +	return !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)) &&
> +		!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_RTS));

mctrl_gpio_to_gpiod cannot return an error pointer. So this is
(surprise!) a wrong usage of IS_ERR_OR_NULL.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
