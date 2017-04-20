From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] RFC: serial: core: Dynamic minor support
Date: Thu, 20 Apr 2017 14:15:44 +0200
Message-ID: <20170420121544.GA1131@kroah.com>
References: <20170420120357.18317-1-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170420120357.18317-1-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 20, 2017 at 02:03:57PM +0200, Sjoerd Simons wrote:
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 3fe56894974a..37014c70dd69 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -44,6 +44,32 @@
>   */
>  static DEFINE_MUTEX(port_mutex);
>  
> +#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
> +/* List of uarts to allow for allocation of dynamic minor ranges*/
> +LIST_HEAD(dynamic_uarts);
> +DEFINE_MUTEX(dynamic_uarts_mutex);

Both of these should be static.

> +
> +static void
> +uart_setup_major_minor(struct uart_driver *drv)
> +{
> +	int start = 0;
> +	struct uart_driver *d;
> +

Why not init the list head in here too?

> +	drv->major = LOW_DENSITY_UART_MAJOR;
> +	mutex_lock(&dynamic_uarts_mutex);
> +
> +	list_for_each_entry(d, &dynamic_uarts, dynamic_uarts) {
> +		if (start + drv->nr < d->minor)
> +			break;
> +		start = d->minor + d->nr;
> +	}
> +	list_add_tail(&drv->dynamic_uarts, &d->dynamic_uarts);
> +	drv->minor = start;
> +
> +	mutex_unlock(&dynamic_uarts_mutex);
> +}
> +#endif
> +
>  /*
>   * lockdep: port->lock is initialized in two places, but we
>   *          want only one lock-class:
> @@ -2458,6 +2484,11 @@ int uart_register_driver(struct uart_driver *drv)
>  
>  	BUG_ON(drv->state);
>  
> +#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
> +	INIT_LIST_HEAD(&drv->dynamic_uarts);

That line should be in the function:

> +	uart_setup_major_minor(drv);
> +#endif

And then provide a "empty" function for this if the option is not
enabled, to keep the #ifdef out of the main flow of the code.

> +
>  	/*
>  	 * Maybe we should be using a slab cache for this, especially if
>  	 * we have a large number of ports to handle.
> @@ -2527,6 +2558,13 @@ void uart_unregister_driver(struct uart_driver *drv)
>  	put_tty_driver(p);
>  	for (i = 0; i < drv->nr; i++)
>  		tty_port_destroy(&drv->state[i].port);
> +
> +#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
> +	mutex_lock(&dynamic_uarts_mutex);
> +	list_del(&drv->dynamic_uarts);
> +	mutex_unlock(&dynamic_uarts_mutex);
> +#endif

Make this a function, like above, and do the same thing to keep #ifdef
out of here.

> +
>  	kfree(drv->state);
>  	drv->state = NULL;
>  	drv->tty_driver = NULL;
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 58484fb35cc8..890bbefb3f90 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -31,6 +31,8 @@
>  #include <linux/sysrq.h>
>  #include <uapi/linux/serial_core.h>
>  
> +#define LOW_DENSITY_UART_MAJOR 204

Where are you stealing this from?



> +
>  #ifdef CONFIG_SERIAL_CORE_CONSOLE
>  #define uart_console(port) \
>  	((port)->cons && (port)->cons->index == (port)->line)
> @@ -313,6 +315,10 @@ struct uart_driver {
>  	 */
>  	struct uart_state	*state;
>  	struct tty_driver	*tty_driver;
> +
> +#ifdef CONFIG_SERIAL_DYNAMIC_MINORS
> +	struct list_head	dynamic_uarts;
> +#endif

Why not just always have this?

Nice first try though!

thanks,

greg k-h
