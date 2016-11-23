From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Wed, 23 Nov 2016 11:08:19 +0100
Message-ID: <20161123100819.GA20137@kroah.com>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123100106.15969-2-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 23, 2016 at 11:01:03AM +0100, Sascha Hauer wrote:
> With this patch the serial core provides LED triggers for RX and TX.
> 
> As the serial core layer does not know when the hardware actually sends
> or receives characters, this needs help from the UART drivers. The
> LED triggers are registered in uart_add_led_triggers() called from
> the UART drivers which want to support LED triggers. All the driver
> has to do then is to call uart_led_trigger_[tx|rx] to indicate
> activity.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 73 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h      | 10 ++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f2303f3..3e8afb7 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -34,6 +34,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/leds.h>
>  
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
> @@ -2703,6 +2704,77 @@ static const struct attribute_group tty_dev_attr_group = {
>  	.attrs = tty_dev_attrs,
>  	};
>  
> +void uart_led_trigger_tx(struct uart_port *uport)
> +{
> +	unsigned long delay = 50;
> +
> +	led_trigger_blink_oneshot(uport->led_trigger_tx, &delay, &delay, 0);
> +}
> +
> +void uart_led_trigger_rx(struct uart_port *uport)
> +{
> +	unsigned long delay = 50;
> +
> +	led_trigger_blink_oneshot(uport->led_trigger_rx, &delay, &delay, 0);
> +}

Don't these functions need an EXPORT_SYMBOL_GPL() to work properly with
uart drivers being built as a module?

thanks,

greg k-h
