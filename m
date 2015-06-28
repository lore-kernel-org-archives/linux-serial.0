From: Sergei Zviagintsev <sergei@s15v.net>
Subject: Re: [PATCH RFC v2 2/3] tty: serial_core: Add hooks for uart slave
 drivers
Date: Mon, 29 Jun 2015 00:51:00 +0300
Message-ID: <20150628215100.GC21426@localhost.localdomain>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com>
 <1435520786-31867-3-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435520786-31867-3-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: jslaby@suse.cz, gregkh@linuxfoundation.org, arnd@arndb.de, peter@hurleysoftware.com, mark.rutland@arm.com, gnomes@lxorguk.ukuu.org.uk, sre@kernel.org, neil@brown.name, grant.likely@linaro.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, hns@goldelico.com
List-Id: linux-serial@vger.kernel.org

Hi,

Some minor comments below.

On Sun, Jun 28, 2015 at 09:46:25PM +0200, Marek Belisko wrote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> 1. allow drivers to get notified in mctrl changes
> 2. allow drivers to get notified on rx data (indicating to the driver that
>    the connected chip is active)
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  drivers/tty/serial/serial_core.c | 102 +++++++++++++++++++++++++++++++++++++--
>  include/linux/serial_core.h      |  11 ++++-
>  2 files changed, 107 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index ad61441..c8910c4 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -163,6 +163,84 @@ err0:
>  }
>  EXPORT_SYMBOL_GPL(devm_serial_get_uart_by_phandle);
>  
> +void uart_register_slave(struct uart_port *uport, void *slave)
> +{
> +	if (!slave) {
> +		uart_register_mctrl_notification(uport, NULL);
> +		uart_register_rx_notification(uport, NULL, NULL);
> +	}
> +	uport->slave = slave;
> +}
> +
> +void uart_register_mctrl_notification(struct uart_port *uport, int (*function)(void *slave, int state))
> +{
> +	uport->mctrl_notification = function;
> +}
> +
> +static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> +		int init_hw);
> +
> +static void uart_port_shutdown(struct tty_port *port);
> +
> +void uart_register_rx_notification(struct uart_port *uport, int (*function)(void *slave, unsigned int *c), struct ktermios *termios)
> +{
> +	struct uart_state *state = uport->state;
> +	struct tty_port *tty_port = &state->port;
> +
> +	if (!uport->slave)
> +		return;	/* slave must be registered first */
> +
> +	uport->rx_notification = function;
> +
> +	if (tty_port->count == 0) {

if (tty_port->count)
	return;

> +		if (function) {
> +			int retval = 0;

Useless initialization.

> +
> +			uart_change_pm(state, UART_PM_STATE_ON);
> +			retval = uport->ops->startup(uport);
> +			if (retval == 0 && termios) {

Indentation is evil in this rather simple function :)

> +				int hw_stopped;
> +				/*
> +				 * Initialise the hardware port settings.
> +				 */
> +				uport->ops->set_termios(uport, termios, NULL);
> +
> +				/*
> +				 * Set modem status enables based on termios cflag
> +				 */
> +				spin_lock_irq(&uport->lock);
> +				if (termios->c_cflag & CRTSCTS)
> +					uport->status |= UPSTAT_CTS_ENABLE;
> +				else
> +					uport->status &= ~UPSTAT_CTS_ENABLE;
> +
> +				if (termios->c_cflag & CLOCAL)
> +					uport->status &= ~UPSTAT_DCD_ENABLE;
> +				else
> +					uport->status |= UPSTAT_DCD_ENABLE;
> +
> +				/* reset sw-assisted CTS flow control based on (possibly) new mode */

checkpatch.pl will complain about long line :)

> +				hw_stopped = uport->hw_stopped;
> +				uport->hw_stopped = uart_softcts_mode(uport) &&
> +					!(uport->ops->get_mctrl(uport) & TIOCM_CTS);
> +				if (uport->hw_stopped) {
> +					if (!hw_stopped)
> +						uport->ops->stop_tx(uport);
> +				} else {
> +					if (hw_stopped)
> +						uport->ops->start_tx(uport);
> +				}
> +				spin_unlock_irq(&uport->lock);
> +			}
> +		} else

Usage of braces is against CodingStyle.

> +			uart_port_shutdown(tty_port);
> +	}
> +}
> +
> +EXPORT_SYMBOL_GPL(uart_register_slave);
> +EXPORT_SYMBOL_GPL(uart_register_mctrl_notification);
> +EXPORT_SYMBOL_GPL(uart_register_rx_notification);
> +
>  /*
>   * This routine is used by the interrupt handler to schedule processing in
>   * the software interrupt portion of the driver.
> @@ -220,6 +298,10 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
>  	port->mctrl = (old & ~clear) | set;
>  	if (old != port->mctrl)
>  		port->ops->set_mctrl(port, port->mctrl);
> +
> +	if (port->mctrl_notification)
> +		(*port->mctrl_notification)(port->slave, port->mctrl);
> +
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -259,7 +341,8 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>  		uart_circ_clear(&state->xmit);
>  	}
>  
> -	retval = uport->ops->startup(uport);
> +	if (!state->uart_port->rx_notification)
> +		retval = uport->ops->startup(uport);
>  	if (retval == 0) {
>  		if (uart_console(uport) && uport->cons->cflag) {
>  			tty->termios.c_cflag = uport->cons->cflag;
> @@ -295,7 +378,7 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
>  		int init_hw)
>  {
>  	struct tty_port *port = &state->port;
> -	int retval;
> +	int retval = 0;

What is the point to initialize `retval'?

>  
>  	if (port->flags & ASYNC_INITIALIZED)
>  		return 0;
> @@ -341,8 +424,12 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  
>  		if (!tty || (tty->termios.c_cflag & HUPCL))
>  			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
> -
> -		uart_port_shutdown(port);
> +		/*
> +		 * if we have a slave that has registered for rx_notifications
> +		 * we do not shut down the uart port to be able to monitor the device
> +		 */
> +		if (!uport->rx_notification)
> +			uart_port_shutdown(port);
>  	}
>  
>  	/*
> @@ -1489,8 +1576,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>  	/*
>  	 * At this point, we stop accepting input.  To do this, we
>  	 * disable the receive line status interrupts.
> +	 * Unless a slave driver wants to keep input running
>  	 */
> -	if (port->flags & ASYNC_INITIALIZED) {
> +	if (!uport->rx_notification && (port->flags & ASYNC_INITIALIZED)) {
>  		unsigned long flags;
>  		spin_lock_irqsave(&uport->lock, flags);
>  		uport->ops->stop_rx(uport);
> @@ -3018,6 +3106,10 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
>  {
>  	struct tty_port *tport = &port->state->port;
>  
> +	if (port->rx_notification)
> +		if ((*port->rx_notification)(port->slave, &ch))
> +			return;	/* slave told us to ignore character */
> +
>  	if ((status & port->ignore_status_mask & ~overrun) == 0)
>  		if (tty_insert_flip_char(tport, ch, flag) == 0)
>  			++port->icount.buf_overrun;
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index ba23718..77029781 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -35,7 +35,7 @@
>  #define uart_console(port) \
>  	((port)->cons && (port)->cons->index == (port)->line)
>  #else
> -#define uart_console(port)      ({ (void)port; 0; })
> +#define uart_console(port)      (0)
>  #endif
>  
>  struct uart_port;
> @@ -247,7 +247,11 @@ struct uart_port {
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
>  	struct serial_rs485     rs485;
>  	void			*private_data;		/* generic platform data pointer */
> +	/* UART slave support */
>  	struct list_head	head;			/* list of uarts e.g. to look up by phandle */
> +	void			*slave;			/* optional slave (there can be only one) */
> +	int			(*mctrl_notification)(void *slave, int state);
> +	int			(*rx_notification)(void *slave, unsigned int *c);
>  };
>  
>  static inline int serial_port_in(struct uart_port *up, int offset)
> @@ -485,4 +489,9 @@ static inline int uart_handle_break(struct uart_port *port)
>   */
>  extern struct uart_port *devm_serial_get_uart_by_phandle(struct device *dev,
>  		const char *phandle, u8 index);
> +/* register to receive notifications */
> +extern void uart_register_slave(struct uart_port *uart, void *slave);
> +extern void uart_register_mctrl_notification(struct uart_port *uart, int (*function)(void *slave, int state));
> +extern void uart_register_rx_notification(struct uart_port *uart, int (*function)(void *slave, unsigned int *c), struct ktermios *termios);
> +
>  #endif /* LINUX_SERIAL_CORE_H */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
