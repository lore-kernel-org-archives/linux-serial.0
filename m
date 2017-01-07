From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
Date: Sat, 07 Jan 2017 16:11:54 +0200
Message-ID: <1483798314.26691.3.camel@linux.intel.com>
References: <20170106162635.19677-1-robh@kernel.org>
         <20170106162635.19677-9-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106162635.19677-9-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
> Add a serdev controller driver for tty ports.
> 
> The controller is registered with serdev when tty ports are registered
> with the TTY core. As the TTY core is built-in only, this has the side
> effect of making serdev built-in as well.
> 
> 

> +if SERIAL_DEV_BUS
> +
> +config SERIAL_DEV_CTRL_TTYPORT
> +	bool "Serial device TTY port controller"
> +	depends on TTY

> +	depends on SERIAL_DEV_BUS=y

Do you need one?


> +static int ttyport_receive_buf(struct tty_port *port, const unsigned
> char *cp,
> +				const unsigned char *fp, size_t
> count)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +
> +	mutex_lock(&serport->lock);
> +
> +	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
> +		goto out;
> +
> +	serdev_controller_receive_buf(ctrl, cp, count);
> +
> +out:

out_unlock: ?

> +	mutex_unlock(&serport->lock);
> +	return count;
> +}
> +
> +static void ttyport_write_wakeup(struct tty_port *port)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +
> +	clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags);

This doesn't prevent to be called this function in parallel. Is it okay?

> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		serdev_controller_write_wakeup(ctrl);
> +}

> +
> +static int ttyport_write_buf(struct serdev_controller *ctrl, const
> unsigned char *data, size_t len)
> +{
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty = serport->tty;
> +
> +	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> +	return serport->tty->ops->write(serport->tty, data, len);

Just tty->ops->...(); ?

> +}



> +int serdev_tty_port_register(struct tty_port *port, struct device
> *parent,
> +			    struct tty_driver *drv, int idx)
> +{
> +	struct serdev_controller *ctrl;
> +	struct serport *serport;
> +	int ret;
> +
> +	if (!port || !drv || !parent || !parent->of_node)

And if it's ACPI? Perhaps last is redundant.

> +		return -ENODEV;
> +
> +	ctrl = serdev_controller_alloc(parent, sizeof(struct
> serport));
> +	if (!ctrl)
> +		return -ENOMEM;
> +	serport = serdev_controller_get_drvdata(ctrl);
> +
> +	mutex_init(&serport->lock);
> +	serport->port = port;
> +	serport->tty_idx = idx;
> +	serport->tty_drv = drv;
> +
> +	ctrl->ops = &ctrl_ops;
> +
> +	ret = serdev_controller_add(ctrl);
> +	if (ret)
> +		goto err;
> +
> +	printk(KERN_INFO "serdev: Serial port %s\n", drv->name);

Hmm... It's not a debug message, why not use pr_info()?

> +	return 0;
> +
> +err:

err_controller_put: ?

> +	serdev_controller_put(ctrl);
> +	return ret;
> +}
> +
> +void serdev_tty_port_unregister(struct tty_port *port)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +
> 

> +	if (!serport)
> +		return;

Same question, whose responsibility to do this?


+
> +#ifdef CONFIG_SERIAL_DEV_CTRL_TTYPORT
> +int serdev_tty_port_register(struct tty_port *port, struct device
> *parent,
> +			    struct tty_driver *drv, int idx);
> +void serdev_tty_port_unregister(struct tty_port *port);
> +#else
> +static inline int serdev_tty_port_register(struct tty_port *port,
> +					   struct device *parent,
> +					   struct tty_driver *drv,
> int idx)
> +{
> +	return -ENODEV;
> +}
> +static inline void serdev_tty_port_unregister(struct tty_port *port)
> {}

> +#endif

Perhaps comment to see from which if this one.

> +
>  #endif

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
