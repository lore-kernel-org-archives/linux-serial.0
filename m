From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 4/5] tty/serial: at91: fix RTS line management when hardware
 handshake is enabled
Date: Fri, 9 Jan 2015 16:40:51 +0100
Message-ID: <54AFF683.2000808@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com> <242df21d70a04c1da8630a356341cbdf00781fda.1418131298.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <242df21d70a04c1da8630a356341cbdf00781fda.1418131298.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, voice.shen@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Le 09/12/2014 14:31, Cyrille Pitchen a =E9crit :
> This patch fixes many bugs in the code dealing with the hardware hand=
shake.
>=20
> As an example, in atmel_set_termios(), we used to test whether the CR=
TSCTS
> c_cflag was set. If so, we selected the "Hardware Handshake" mode thr=
ough the
> Mode Register. However, few lines below the mode was reset to "Normal=
" (0).
> So there was no way to select the "Hardware Handshake" mode. To fix t=
his issue,
> we moved the CRTSCRTS c_cflag test AFTER the mode has been reset to "=
Normal".
>=20
> Also setting the RTSEN and RTSDIS bits in the Control Register has di=
fferent
> results whether the USART is set in "Normal" or "Hardware Handshake" =
mode:
>=20
> 1) "Normal" mode
> - the RTSEN bit forces the RTS line to low level, which tells the rem=
ote peer
>   that we are ready to received new data.
> - the RTSDIS bit forces the RTS line to high level, which tells the r=
emote peer
>   to stop sending new data.
>=20
> 2) "Hardware Handshake" mode
> - the RTSEN bit forces the RTS line to high level.
> - the RTSDIS bit lets the hardware control the RTS line.
>=20
> WARNING:
> when FIFOs are not available or not enabled, the RTS line is controll=
ed by the
> PDC. This is why using the Hardware Handshake mode requires using the=
 PDC
> channel for reception. However the Hardware Handshake mode DOES NOT w=
ork with
> DMA controller since it cannot control the RTS line.
> Future designs with FIFOs will introduce a new feature: the RTS line =
will be
> controlled by the RX FIFO using thresholds. This patch was tested wit=
h this new
> design.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Indeed. It fixes a pretty important misbehavior.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
>  drivers/tty/serial/atmel_serial.c | 91 ++++++++++++++++++++++++++---=
----------
>  1 file changed, 61 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 92a8b26..9e0c636 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -341,13 +341,37 @@ static u_int atmel_tx_empty(struct uart_port *p=
ort)
>  static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
>  {
>  	unsigned int control =3D 0;
> -	unsigned int mode;
> +	unsigned int mode =3D UART_GET_MR(port);
> +	unsigned int rts_paused, rts_ready;
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> =20
> +	/* override mode to RS485 if needed, otherwise keep the current mod=
e */
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		if ((port->rs485.delay_rts_after_send) > 0)
> +			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
> +		mode &=3D ~ATMEL_US_USMODE;
> +		mode |=3D ATMEL_US_USMODE_RS485;
> +	}
> +
> +	/* set the RTS line state according to the mode */
> +	if ((mode & ATMEL_US_USMODE) =3D=3D ATMEL_US_USMODE_HWHS) {
> +		/* force RTS line to high level */
> +		rts_paused =3D ATMEL_US_RTSEN;
> +
> +		/* give the control of the RTS line back to the hardware */
> +		rts_ready =3D ATMEL_US_RTSDIS;
> +	} else {
> +		/* force RTS line to high level */
> +		rts_paused =3D ATMEL_US_RTSDIS;
> +
> +		/* force RTS line to low level */
> +		rts_ready =3D ATMEL_US_RTSEN;
> +	}
> +
>  	if (mctrl & TIOCM_RTS)
> -		control |=3D ATMEL_US_RTSEN;
> +		control |=3D rts_ready;
>  	else
> -		control |=3D ATMEL_US_RTSDIS;
> +		control |=3D rts_paused;
> =20
>  	if (mctrl & TIOCM_DTR)
>  		control |=3D ATMEL_US_DTREN;
> @@ -359,23 +383,12 @@ static void atmel_set_mctrl(struct uart_port *p=
ort, u_int mctrl)
>  	mctrl_gpio_set(atmel_port->gpios, mctrl);
> =20
>  	/* Local loopback mode? */
> -	mode =3D UART_GET_MR(port) & ~ATMEL_US_CHMODE;
> +	mode &=3D ~ATMEL_US_CHMODE;
>  	if (mctrl & TIOCM_LOOP)
>  		mode |=3D ATMEL_US_CHMODE_LOC_LOOP;
>  	else
>  		mode |=3D ATMEL_US_CHMODE_NORMAL;
> =20
> -	/* Resetting serial mode to RS232 (0x0) */
> -	mode &=3D ~ATMEL_US_USMODE;
> -
> -	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		dev_dbg(port->dev, "Setting UART to RS485\n");
> -		if ((port->rs485.delay_rts_after_send) > 0)
> -			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
> -		mode |=3D ATMEL_US_USMODE_RS485;
> -	} else {
> -		dev_dbg(port->dev, "Setting UART to RS232\n");
> -	}
>  	UART_PUT_MR(port, mode);
>  }
> =20
> @@ -1921,12 +1934,14 @@ static void atmel_set_termios(struct uart_por=
t *port, struct ktermios *termios,
>  			      struct ktermios *old)
>  {
>  	unsigned long flags;
> -	unsigned int mode, imr, quot, baud;
> +	unsigned int old_mode, mode, imr, quot, baud;
> +
> +	/* save the current mode register */
> +	mode =3D old_mode =3D UART_GET_MR(port);
> =20
> -	/* Get current mode register */
> -	mode =3D UART_GET_MR(port) & ~(ATMEL_US_USCLKS | ATMEL_US_CHRL
> -					| ATMEL_US_NBSTOP | ATMEL_US_PAR
> -					| ATMEL_US_USMODE);
> +	/* reset the mode, clock divisor, parity, stop bits and data size *=
/
> +	mode &=3D ~(ATMEL_US_USCLKS | ATMEL_US_CHRL | ATMEL_US_NBSTOP |
> +		  ATMEL_US_PAR | ATMEL_US_USMODE);
> =20
>  	baud =3D uart_get_baud_rate(port, termios, old, 0, port->uartclk / =
16);
>  	quot =3D uart_get_divisor(port, baud);
> @@ -1971,12 +1986,6 @@ static void atmel_set_termios(struct uart_port=
 *port, struct ktermios *termios,
>  	} else
>  		mode |=3D ATMEL_US_PAR_NONE;
> =20
> -	/* hardware handshake (RTS/CTS) */
> -	if (termios->c_cflag & CRTSCTS)
> -		mode |=3D ATMEL_US_USMODE_HWHS;
> -	else
> -		mode |=3D ATMEL_US_USMODE_NORMAL;
> -
>  	spin_lock_irqsave(&port->lock, flags);
> =20
>  	port->read_status_mask =3D ATMEL_US_OVRE;
> @@ -2020,18 +2029,40 @@ static void atmel_set_termios(struct uart_por=
t *port, struct ktermios *termios,
>  	/* disable receiver and transmitter */
>  	UART_PUT_CR(port, ATMEL_US_TXDIS | ATMEL_US_RXDIS);
> =20
> -	/* Resetting serial mode to RS232 (0x0) */
> -	mode &=3D ~ATMEL_US_USMODE;
> -
> +	/* mode */
>  	if (port->rs485.flags & SER_RS485_ENABLED) {
>  		if ((port->rs485.delay_rts_after_send) > 0)
>  			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
>  		mode |=3D ATMEL_US_USMODE_RS485;
> +	} else if (termios->c_cflag & CRTSCTS) {
> +		/* RS232 with hardware handshake (RTS/CTS) */
> +		mode |=3D ATMEL_US_USMODE_HWHS;
> +	} else {
> +		/* RS232 without hadware handshake */
> +		mode |=3D ATMEL_US_USMODE_NORMAL;
>  	}
> =20
> -	/* set the parity, stop bits and data size */
> +	/* set the mode, clock divisor, parity, stop bits and data size */
>  	UART_PUT_MR(port, mode);
> =20
> +	/*
> +	 * when switching the mode, set the RTS line state according to the
> +	 * new mode, otherwise keep the former state
> +	 */
> +	if ((old_mode & ATMEL_US_USMODE) !=3D (mode & ATMEL_US_USMODE)) {
> +		unsigned int rts_state;
> +
> +		if ((mode & ATMEL_US_USMODE) =3D=3D ATMEL_US_USMODE_HWHS) {
> +			/* let the hardware control the RTS line */
> +			rts_state =3D ATMEL_US_RTSDIS;
> +		} else {
> +			/* force RTS line to low level */
> +			rts_state =3D ATMEL_US_RTSEN;
> +		}
> +
> +		UART_PUT_CR(port, rts_state);
> +	}
> +
>  	/* set the baud rate */
>  	UART_PUT_BRGR(port, quot);
>  	UART_PUT_CR(port, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>=20


--=20
Nicolas Ferre
