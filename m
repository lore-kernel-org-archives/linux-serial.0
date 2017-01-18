From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 8/9] serdev: add a tty port controller driver
Date: Wed, 18 Jan 2017 14:42:57 +0200
Message-ID: <1484743377.2133.204.camel@linux.intel.com>
References: <20170116225436.17505-1-robh@kernel.org>
         <20170116225436.17505-9-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-9-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2017-01-16 at 16:54 -0600, Rob Herring wrote:
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


> +	depends on SERIAL_DEV_BUS != m

Since you have this line the
 if SERIAL_DEV_BUS
is redundant for it.

So, leave either one or another (as an example you can look at
DMADEVICES).

> +
> +#define SERPORT_BUSY	1
> +#define SERPORT_ACTIVE	2
> +#define SERPORT_DEAD	3
> +
> +struct serport {
> +	struct tty_port *port;
> +	struct tty_struct *tty;

> +	struct tty_driver *tty_drv;
> +	int tty_idx;

Do you need tty_ prefix for them?

> +	struct mutex lock;
> +	unsigned long flags;
> +};
> +
> +/*
> + * Callback functions from the tty port.
> + */
> +
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

So, if you are going to use serport->flags always under lock, you don't
need to use atomic bit operations.

Either
 __test_bit() and Co
Or
 flags & BIT(x)

> +		goto out_unlock;
> +
> +	serdev_controller_receive_buf(ctrl, cp, count);
> +
> +out_unlock:
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
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))

Hmm...

> +		serdev_controller_write_wakeup(ctrl);
> +}
> 

> +	return tty_write_room(tty);
> +}

> +
> +

One extra line.

> +static int ttyport_open(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty;
> +	struct ktermios ktermios;
> +
> +	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
> +	serport->tty = tty;
> +
> +	serport->port->client_ops = &client_ops;
> +	serport->port->client_data = ctrl;
> +
> 

> +	tty->receive_room = 65536;

Magic?

> +
> +	if (tty->ops->open)
> +		tty->ops->open(serport->tty, NULL);
> +	else
> +		tty_port_open(serport->port, tty, NULL);
> +
> +	/* Bring the UART into a known 8 bits no parity hw fc state
> */
> +	ktermios = tty->termios;
> +	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
> +			      INLCR | IGNCR | ICRNL | IXON);
> +	ktermios.c_oflag &= ~OPOST;
> +	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG |
> IEXTEN);
> +	ktermios.c_cflag &= ~(CSIZE | PARENB);
> +	ktermios.c_cflag |= CS8;
> +	ktermios.c_cflag |= CRTSCTS;
> +	tty_set_termios(tty, &ktermios);
> +
> +	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> +
> 

> +	mutex_lock(&serport->lock);
> +	set_bit(SERPORT_ACTIVE, &serport->flags);
> +	mutex_unlock(&serport->lock);

So, some clarification would be good to have to understand why you need
mutex _and_ atomic operation together.

What does mutex protect?

> +
> +	tty_unlock(serport->tty);
> +	return 0;
> +}

> +void serdev_tty_port_unregister(struct tty_port *port)
> +{
> +	struct serdev_controller *ctrl = port->client_data;
> +	struct serport *serport =
> serdev_controller_get_drvdata(ctrl);
> +

> +	if (!serport)
> +		return;

What this check prevents from?

> +
> +	serdev_controller_remove(ctrl);
> +	port->client_ops = NULL;
> +	port->client_data = NULL;
> +	serdev_controller_put(ctrl);
> +}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
