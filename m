From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] tty: implement led triggers
Date: Mon, 7 May 2018 10:02:52 +0200
Message-ID: <20180507080252.GO2285@localhost>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 03, 2018 at 10:19:52PM +0200, Uwe Kleine-König wrote:
> The rx trigger fires when data is pushed to the ldisc. This is a bit later
> than the actual receiving of data but has the nice benefit that it
> doesn't need adaption for each driver and isn't in the hot path.
> 
> Similarily the tx trigger fires when data taken from the ldisc.

You meant copied from user space, or written to the ldisc, here.

Note that the rx-path is shared with serdev, but the write path is not.
So with this series, serdev devices would only trigger the rx-led.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v1, sent with Message-Id: 
> 20180503100448.1350-1-u.kleine-koenig@pengutronix.de:
> 
>  - implement tx trigger;
>  - introduce Kconfig symbol for conditional compilation;
>  - set trigger to NULL if allocating the name failed to not free random
>    pointers in case the port struct wasn't zeroed;
>  - use if/else instead of goto

> @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
>  		struct tty_buffer *head = buf->head;
>  		struct tty_buffer *next;
>  		int count;
> +		unsigned long delay = 50 /* ms */;

Comment after the semicolon?

>  
>  		/* Ldisc or user is trying to gain exclusive access */
>  		if (atomic_read(&buf->priority))

> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 25d736880013..f042879a597c 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/serdev.h>
>  
> @@ -157,6 +158,30 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>  
>  	tty_port_link_device(port, driver, index);
>  
> +#ifdef CONFIG_TTY_LEDS_TRIGGER
> +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (port->led_trigger_rx_name) {
> +		led_trigger_register_simple(port->led_trigger_rx_name,
> +					    &port->led_trigger_rx);
> +	} else {
> +		port->led_trigger_rx = NULL;
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +	}
> +
> +	port->led_trigger_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
> +					      driver->name, index);
> +	if (port->led_trigger_tx_name) {
> +		led_trigger_register_simple(port->led_trigger_tx_name,
> +					    &port->led_trigger_tx);
> +	} else {
> +		port->led_trigger_tx = NULL;
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +	}
> +#endif

Besides the ugly ifdefs here, you're leaking the above LED resources in
the error paths below (e.g. on probe deferrals).

>  	dev = serdev_tty_port_register(port, device, driver, index);
>  	if (PTR_ERR(dev) != -ENODEV) {
>  		/* Skip creating cdev if we registered a serdev device */

> @@ -249,6 +249,13 @@ struct tty_port {
>  						   set to size of fifo */
>  	struct kref		kref;		/* Ref counter */
>  	void 			*client_data;
> +
> +#ifdef CONFIG_TTY_LEDS_TRIGGER
> +	struct led_trigger	*led_trigger_rx;
> +	char			*led_trigger_rx_name;

const?

> +	struct led_trigger	*led_trigger_tx;
> +	char			*led_trigger_tx_name;

ditto.

> +#endif

Johan
