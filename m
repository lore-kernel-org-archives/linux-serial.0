From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH RFC v2 2/3] tty: serial_core: Add hooks for uart slave drivers
Date: Mon, 29 Jun 2015 18:47:22 +0200
Message-ID: <3E4DBCB0-EA87-4DF2-A6B9-6ED0FBA3BD69@goldelico.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com> <1435520786-31867-3-git-send-email-marek@goldelico.com> <20150628215100.GC21426@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150628215100.GC21426@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Zviagintsev <sergei@s15v.net>
Cc: Marek Belisko <marek@goldelico.com>, jslaby@suse.cz, gregkh@linuxfoundation.org, arnd@arndb.de, peter@hurleysoftware.com, mark.rutland@arm.com, gnomes@lxorguk.ukuu.org.uk, sre@kernel.org, neil@brown.name, grant.likely@linaro.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com
List-Id: linux-serial@vger.kernel.org

Hi,
thanks again.

Am 28.06.2015 um 23:51 schrieb Sergei Zviagintsev <sergei@s15v.net>:

> Hi,
>=20
> Some minor comments below.
>=20
> On Sun, Jun 28, 2015 at 09:46:25PM +0200, Marek Belisko wrote:
>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>>=20
>> 1. allow drivers to get notified in mctrl changes
>> 2. allow drivers to get notified on rx data (indicating to the drive=
r that
>>   the connected chip is active)
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> drivers/tty/serial/serial_core.c | 102 +++++++++++++++++++++++++++++=
++++++++--
>> include/linux/serial_core.h      |  11 ++++-
>> 2 files changed, 107 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/s=
erial_core.c
>> index ad61441..c8910c4 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -163,6 +163,84 @@ err0:
>> }
>> EXPORT_SYMBOL_GPL(devm_serial_get_uart_by_phandle);
>>=20
>> +void uart_register_slave(struct uart_port *uport, void *slave)
>> +{
>> +	if (!slave) {
>> +		uart_register_mctrl_notification(uport, NULL);
>> +		uart_register_rx_notification(uport, NULL, NULL);
>> +	}
>> +	uport->slave =3D slave;
>> +}
>> +
>> +void uart_register_mctrl_notification(struct uart_port *uport, int =
(*function)(void *slave, int state))
>> +{
>> +	uport->mctrl_notification =3D function;
>> +}
>> +
>> +static int uart_port_startup(struct tty_struct *tty, struct uart_st=
ate *state,
>> +		int init_hw);
>> +
>> +static void uart_port_shutdown(struct tty_port *port);
>> +
>> +void uart_register_rx_notification(struct uart_port *uport, int (*f=
unction)(void *slave, unsigned int *c), struct ktermios *termios)
>> +{
>> +	struct uart_state *state =3D uport->state;
>> +	struct tty_port *tty_port =3D &state->port;
>> +
>> +	if (!uport->slave)
>> +		return;	/* slave must be registered first */
>> +
>> +	uport->rx_notification =3D function;
>> +
>> +	if (tty_port->count =3D=3D 0) {
>=20
> if (tty_port->count)
> 	return;
>=20
>> +		if (function) {
>> +			int retval =3D 0;
>=20
> Useless initialization.

Indeed.

>=20
>> +
>> +			uart_change_pm(state, UART_PM_STATE_ON);
>> +			retval =3D uport->ops->startup(uport);
>> +			if (retval =3D=3D 0 && termios) {
>=20
> Indentation is evil in this rather simple function :)
>=20
>> +				int hw_stopped;
>> +				/*
>> +				 * Initialise the hardware port settings.
>> +				 */
>> +				uport->ops->set_termios(uport, termios, NULL);
>> +
>> +				/*
>> +				 * Set modem status enables based on termios cflag
>> +				 */
>> +				spin_lock_irq(&uport->lock);
>> +				if (termios->c_cflag & CRTSCTS)
>> +					uport->status |=3D UPSTAT_CTS_ENABLE;
>> +				else
>> +					uport->status &=3D ~UPSTAT_CTS_ENABLE;
>> +
>> +				if (termios->c_cflag & CLOCAL)
>> +					uport->status &=3D ~UPSTAT_DCD_ENABLE;
>> +				else
>> +					uport->status |=3D UPSTAT_DCD_ENABLE;
>> +
>> +				/* reset sw-assisted CTS flow control based on (possibly) new m=
ode */
>=20
> checkpatch.pl will complain about long line :)

Ok.

>=20
>> +				hw_stopped =3D uport->hw_stopped;
>> +				uport->hw_stopped =3D uart_softcts_mode(uport) &&
>> +					!(uport->ops->get_mctrl(uport) & TIOCM_CTS);
>> +				if (uport->hw_stopped) {
>> +					if (!hw_stopped)
>> +						uport->ops->stop_tx(uport);
>> +				} else {
>> +					if (hw_stopped)
>> +						uport->ops->start_tx(uport);
>> +				}
>> +				spin_unlock_irq(&uport->lock);
>> +			}
>> +		} else
>=20
> Usage of braces is against CodingStyle.

Ok.

>=20
>> +			uart_port_shutdown(tty_port);
>> +	}
>> +}
>> +
>> +EXPORT_SYMBOL_GPL(uart_register_slave);
>> +EXPORT_SYMBOL_GPL(uart_register_mctrl_notification);
>> +EXPORT_SYMBOL_GPL(uart_register_rx_notification);
>> +
>> /*
>>  * This routine is used by the interrupt handler to schedule process=
ing in
>>  * the software interrupt portion of the driver.
>> @@ -220,6 +298,10 @@ uart_update_mctrl(struct uart_port *port, unsig=
ned int set, unsigned int clear)
>> 	port->mctrl =3D (old & ~clear) | set;
>> 	if (old !=3D port->mctrl)
>> 		port->ops->set_mctrl(port, port->mctrl);
>> +
>> +	if (port->mctrl_notification)
>> +		(*port->mctrl_notification)(port->slave, port->mctrl);
>> +
>> 	spin_unlock_irqrestore(&port->lock, flags);
>> }
>>=20
>> @@ -259,7 +341,8 @@ static int uart_port_startup(struct tty_struct *=
tty, struct uart_state *state,
>> 		uart_circ_clear(&state->xmit);
>> 	}
>>=20
>> -	retval =3D uport->ops->startup(uport);
>> +	if (!state->uart_port->rx_notification)
>> +		retval =3D uport->ops->startup(uport);
>> 	if (retval =3D=3D 0) {
>> 		if (uart_console(uport) && uport->cons->cflag) {
>> 			tty->termios.c_cflag =3D uport->cons->cflag;
>> @@ -295,7 +378,7 @@ static int uart_startup(struct tty_struct *tty, =
struct uart_state *state,
>> 		int init_hw)
>> {
>> 	struct tty_port *port =3D &state->port;
>> -	int retval;
>> +	int retval =3D 0;
>=20
> What is the point to initialize `retval=92?

Probably remains from an intermediate version where we had needed it.
Will be removed.

>=20
>>=20
>> 	if (port->flags & ASYNC_INITIALIZED)
>> 		return 0;
>> @@ -341,8 +424,12 @@ static void uart_shutdown(struct tty_struct *tt=
y, struct uart_state *state)
>>=20
>> 		if (!tty || (tty->termios.c_cflag & HUPCL))
>> 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
>> -
>> -		uart_port_shutdown(port);
>> +		/*
>> +		 * if we have a slave that has registered for rx_notifications
>> +		 * we do not shut down the uart port to be able to monitor the de=
vice
>> +		 */
>> +		if (!uport->rx_notification)
>> +			uart_port_shutdown(port);
>> 	}
>>=20
>> 	/*
>> @@ -1489,8 +1576,9 @@ static void uart_close(struct tty_struct *tty,=
 struct file *filp)
>> 	/*
>> 	 * At this point, we stop accepting input.  To do this, we
>> 	 * disable the receive line status interrupts.
>> +	 * Unless a slave driver wants to keep input running
>> 	 */
>> -	if (port->flags & ASYNC_INITIALIZED) {
>> +	if (!uport->rx_notification && (port->flags & ASYNC_INITIALIZED)) =
{
>> 		unsigned long flags;
>> 		spin_lock_irqsave(&uport->lock, flags);
>> 		uport->ops->stop_rx(uport);
>> @@ -3018,6 +3106,10 @@ void uart_insert_char(struct uart_port *port,=
 unsigned int status,
>> {
>> 	struct tty_port *tport =3D &port->state->port;
>>=20
>> +	if (port->rx_notification)
>> +		if ((*port->rx_notification)(port->slave, &ch))
>> +			return;	/* slave told us to ignore character */
>> +
>> 	if ((status & port->ignore_status_mask & ~overrun) =3D=3D 0)
>> 		if (tty_insert_flip_char(tport, ch, flag) =3D=3D 0)
>> 			++port->icount.buf_overrun;
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core=
=2Eh
>> index ba23718..77029781 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -35,7 +35,7 @@
>> #define uart_console(port) \
>> 	((port)->cons && (port)->cons->index =3D=3D (port)->line)
>> #else
>> -#define uart_console(port)      ({ (void)port; 0; })
>> +#define uart_console(port)      (0)
>> #endif
>>=20
>> struct uart_port;
>> @@ -247,7 +247,11 @@ struct uart_port {
>> 	const struct attribute_group **tty_groups;	/* all attributes (seria=
l core use only) */
>> 	struct serial_rs485     rs485;
>> 	void			*private_data;		/* generic platform data pointer */
>> +	/* UART slave support */
>> 	struct list_head	head;			/* list of uarts e.g. to look up by phandl=
e */
>> +	void			*slave;			/* optional slave (there can be only one) */
>> +	int			(*mctrl_notification)(void *slave, int state);
>> +	int			(*rx_notification)(void *slave, unsigned int *c);
>> };
>>=20
>> static inline int serial_port_in(struct uart_port *up, int offset)
>> @@ -485,4 +489,9 @@ static inline int uart_handle_break(struct uart_=
port *port)
>>  */
>> extern struct uart_port *devm_serial_get_uart_by_phandle(struct devi=
ce *dev,
>> 		const char *phandle, u8 index);
>> +/* register to receive notifications */
>> +extern void uart_register_slave(struct uart_port *uart, void *slave=
);
>> +extern void uart_register_mctrl_notification(struct uart_port *uart=
, int (*function)(void *slave, int state));
>> +extern void uart_register_rx_notification(struct uart_port *uart, i=
nt (*function)(void *slave, unsigned int *c), struct ktermios *termios)=
;
>> +
>> #endif /* LINUX_SERIAL_CORE_H */
>> --=20
>> 1.9.1
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
