From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] tty: serial core: decouple pm states from ACPI
Date: Thu, 06 Dec 2012 22:02:23 +0100
Message-ID: <4839526.ruQ5QiepBZ@vostro.rjw.lan>
References: <1354823954-6073-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42264 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab2LFU52 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 15:57:28 -0500
In-Reply-To: <1354823954-6073-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Rickard Andersson <rickard.andersson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Thursday, December 06, 2012 08:59:14 PM Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The serial core is using power states lifted from ACPI for no
> good reason. Remove this reference from the documentation and
> alter all users to use an enum specific to the serial core
> instead, and define it in <linux/serial_core.h>.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Alan think that depending on ACPI for PM states is a bad idea,
> so let's instead create our own definition of the PM states for
> the tty/serial subsystem. (Ditch the other two patches.)
> ---
>  Documentation/serial/driver      |  5 ++---
>  drivers/tty/serial/serial_core.c | 30 ++++++++++++++++--------------
>  include/linux/serial_core.h      | 14 +++++++++++++-
>  3 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/serial/driver b/Documentation/serial/driver
> index 0a25a91..a6ef8dc 100644
> --- a/Documentation/serial/driver
> +++ b/Documentation/serial/driver
> @@ -242,9 +242,8 @@ hardware.
>  
>    pm(port,state,oldstate)
>  	Perform any power management related activities on the specified
> -	port.  State indicates the new state (defined by ACPI D0-D3),
> -	oldstate indicates the previous state.  Essentially, D0 means
> -	fully on, D3 means powered down.
> +	port.  State indicates the new state (defined by
> +	enum uart_pm_state), oldstate indicates the previous state.
>  
>  	This function should not be used to grab any resources.
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 2c7230a..11b23e2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -59,7 +59,8 @@ static struct lock_class_key port_lock_key;
>  static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
>  					struct ktermios *old_termios);
>  static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
> -static void uart_change_pm(struct uart_state *state, int pm_state);
> +static void uart_change_pm(struct uart_state *state,
> +			   enum uart_pm_state pm_state);
>  
>  static void uart_port_shutdown(struct tty_port *port);
>  
> @@ -1365,7 +1366,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>  		spin_lock_irqsave(&port->lock, flags);
>  	} else if (!uart_console(uport)) {
>  		spin_unlock_irqrestore(&port->lock, flags);
> -		uart_change_pm(state, 3);
> +		uart_change_pm(state, UART_PM_STATE_SLEEP);
>  		spin_lock_irqsave(&port->lock, flags);
>  	}
>  
> @@ -1579,7 +1580,7 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
>  	 * Make sure the device is in D0 state.
>  	 */
>  	if (port->count == 1)
> -		uart_change_pm(state, 0);
> +		uart_change_pm(state, UART_PM_STATE_DEFAULT);
>  
>  	/*
>  	 * Start up the serial port.
> @@ -1620,7 +1621,7 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
>  {
>  	struct uart_state *state = drv->state + i;
>  	struct tty_port *port = &state->port;
> -	int pm_state;
> +	enum uart_pm_state pm_state;
>  	struct uart_port *uport = state->uart_port;
>  	char stat_buf[32];
>  	unsigned int status;
> @@ -1645,12 +1646,12 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
>  	if (capable(CAP_SYS_ADMIN)) {
>  		mutex_lock(&port->mutex);
>  		pm_state = state->pm_state;
> -		if (pm_state)
> -			uart_change_pm(state, 0);
> +		if (pm_state != UART_PM_STATE_DEFAULT)
> +			uart_change_pm(state, UART_PM_STATE_DEFAULT);
>  		spin_lock_irq(&uport->lock);
>  		status = uport->ops->get_mctrl(uport);
>  		spin_unlock_irq(&uport->lock);
> -		if (pm_state)
> +		if (pm_state != UART_PM_STATE_DEFAULT)
>  			uart_change_pm(state, pm_state);
>  		mutex_unlock(&port->mutex);
>  
> @@ -1897,7 +1898,8 @@ EXPORT_SYMBOL_GPL(uart_set_options);
>   *
>   * Locking: port->mutex has to be held
>   */
> -static void uart_change_pm(struct uart_state *state, int pm_state)
> +static void uart_change_pm(struct uart_state *state,
> +			   enum uart_pm_state pm_state)
>  {
>  	struct uart_port *port = state->uart_port;
>  
> @@ -1982,7 +1984,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>  		console_stop(uport->cons);
>  
>  	if (console_suspend_enabled || !uart_console(uport))
> -		uart_change_pm(state, 3);
> +		uart_change_pm(state, UART_PM_STATE_SLEEP);
>  
>  	mutex_unlock(&port->mutex);
>  
> @@ -2027,7 +2029,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  			termios = port->tty->termios;
>  
>  		if (console_suspend_enabled)
> -			uart_change_pm(state, 0);
> +			uart_change_pm(state, UART_PM_STATE_DEFAULT);
>  		uport->ops->set_termios(uport, &termios, NULL);
>  		if (console_suspend_enabled)
>  			console_start(uport->cons);
> @@ -2037,7 +2039,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>  		const struct uart_ops *ops = uport->ops;
>  		int ret;
>  
> -		uart_change_pm(state, 0);
> +		uart_change_pm(state, UART_PM_STATE_DEFAULT);
>  		spin_lock_irq(&uport->lock);
>  		ops->set_mctrl(uport, 0);
>  		spin_unlock_irq(&uport->lock);
> @@ -2137,7 +2139,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  		uart_report_port(drv, port);
>  
>  		/* Power up port for set_mctrl() */
> -		uart_change_pm(state, 0);
> +		uart_change_pm(state, UART_PM_STATE_DEFAULT);
>  
>  		/*
>  		 * Ensure that the modem control lines are de-activated.
> @@ -2161,7 +2163,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  		 * console if we have one.
>  		 */
>  		if (!uart_console(port))
> -			uart_change_pm(state, 3);
> +			uart_change_pm(state, UART_PM_STATE_SLEEP);
>  	}
>  }
>  
> @@ -2588,7 +2590,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  	}
>  
>  	state->uart_port = uport;
> -	state->pm_state = -1;
> +	state->pm_state = UART_PM_STATE_UNDEFINED;
>  
>  	uport->cons = drv->cons;
>  	uport->state = state;
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index c6690a2..d1fd0af 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -208,13 +208,25 @@ static inline void serial_port_out(struct uart_port *up, int offset, int value)
>  	up->serial_out(up, offset, value);
>  }
>  
> +/**
> + * enum uart_pm_state - power states for UARTs
> + * @UART_PM_STATE_DEFAULT: UART is powered, up and operational
> + * @UART_PM_STATE_SLEEP: UART is powered off
> + * @UART_PM_STATE_UNDEFINED: sentinel
> + */
> +enum uart_pm_state {
> +	UART_PM_STATE_DEFAULT = 0,
> +	UART_PM_STATE_SLEEP = 3,

Might as well call this one UART_PM_STATE_OFF (and the default one _ON).

Otherwise, it looks OK.

> +	UART_PM_STATE_UNDEFINED,
> +};
> +
>  /*
>   * This is the state information which is persistent across opens.
>   */
>  struct uart_state {
>  	struct tty_port		port;
>  
> -	int			pm_state;
> +	enum uart_pm_state	pm_state;
>  	struct circ_buf		xmit;
>  
>  	struct uart_port	*uart_port;
> 

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
