From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v4 3/5] tty/serial: at91: remove bunch of macros to access
 UART registers
Date: Mon, 20 Jul 2015 14:24:38 +0200
Message-ID: <55ACE886.1060206@atmel.com>
References: <cover.1435842688.git.cyrille.pitchen@atmel.com> <89084496e1f1f189335d945167aa5327ee36a4a0.1435842688.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89084496e1f1f189335d945167aa5327ee36a4a0.1435842688.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, alexandre.belloni@free-electrons.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: linux-serial@vger.kernel.org

Le 02/07/2015 15:18, Cyrille Pitchen a =E9crit :
> This patch replaces the UART_PUT_*, resp. UART_GET_*, macros by
> atmel_uart_writel(), resp. atmel_uart_readl(), inline function calls.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Ok with this move:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  drivers/tty/serial/atmel_serial.c | 313 +++++++++++++++++++---------=
----------
>  1 file changed, 159 insertions(+), 154 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 2a8f528153e7..e7c337de31d1 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -88,37 +88,6 @@ static void atmel_stop_rx(struct uart_port *port);
> =20
>  #define ATMEL_ISR_PASS_LIMIT	256
> =20
> -/* UART registers. CR is write-only, hence no GET macro */
> -#define UART_PUT_CR(port,v)	__raw_writel(v, (port)->membase + ATMEL_=
US_CR)
> -#define UART_GET_MR(port)	__raw_readl((port)->membase + ATMEL_US_MR)
> -#define UART_PUT_MR(port,v)	__raw_writel(v, (port)->membase + ATMEL_=
US_MR)
> -#define UART_PUT_IER(port,v)	__raw_writel(v, (port)->membase + ATMEL=
_US_IER)
> -#define UART_PUT_IDR(port,v)	__raw_writel(v, (port)->membase + ATMEL=
_US_IDR)
> -#define UART_GET_IMR(port)	__raw_readl((port)->membase + ATMEL_US_IM=
R)
> -#define UART_GET_CSR(port)	__raw_readl((port)->membase + ATMEL_US_CS=
R)
> -#define UART_GET_CHAR(port)	__raw_readl((port)->membase + ATMEL_US_R=
HR)
> -#define UART_PUT_CHAR(port,v)	__raw_writel(v, (port)->membase + ATME=
L_US_THR)
> -#define UART_GET_BRGR(port)	__raw_readl((port)->membase + ATMEL_US_B=
RGR)
> -#define UART_PUT_BRGR(port,v)	__raw_writel(v, (port)->membase + ATME=
L_US_BRGR)
> -#define UART_PUT_RTOR(port,v)	__raw_writel(v, (port)->membase + ATME=
L_US_RTOR)
> -#define UART_PUT_TTGR(port, v)	__raw_writel(v, (port)->membase + ATM=
EL_US_TTGR)
> -#define UART_GET_IP_NAME(port)	__raw_readl((port)->membase + ATMEL_U=
S_NAME)
> -#define UART_GET_IP_VERSION(port) __raw_readl((port)->membase + ATME=
L_US_VERSION)
> -
> - /* PDC registers */
> -#define UART_PUT_PTCR(port,v)	__raw_writel(v, (port)->membase + ATME=
L_PDC_PTCR)
> -#define UART_GET_PTSR(port)	__raw_readl((port)->membase + ATMEL_PDC_=
PTSR)
> -
> -#define UART_PUT_RPR(port,v)	__raw_writel(v, (port)->membase + ATMEL=
_PDC_RPR)
> -#define UART_GET_RPR(port)	__raw_readl((port)->membase + ATMEL_PDC_R=
PR)
> -#define UART_PUT_RCR(port,v)	__raw_writel(v, (port)->membase + ATMEL=
_PDC_RCR)
> -#define UART_PUT_RNPR(port,v)	__raw_writel(v, (port)->membase + ATME=
L_PDC_RNPR)
> -#define UART_PUT_RNCR(port,v)	__raw_writel(v, (port)->membase + ATME=
L_PDC_RNCR)
> -
> -#define UART_PUT_TPR(port,v)	__raw_writel(v, (port)->membase + ATMEL=
_PDC_TPR)
> -#define UART_PUT_TCR(port,v)	__raw_writel(v, (port)->membase + ATMEL=
_PDC_TCR)
> -#define UART_GET_TCR(port)	__raw_readl((port)->membase + ATMEL_PDC_T=
CR)
> -
>  struct atmel_dma_buffer {
>  	unsigned char	*buf;
>  	dma_addr_t	dma_addr;
> @@ -212,6 +181,16 @@ to_atmel_uart_port(struct uart_port *uart)
>  	return container_of(uart, struct atmel_uart_port, uart);
>  }
> =20
> +static inline u32 atmel_uart_readl(struct uart_port *port, u32 reg)
> +{
> +	return __raw_readl(port->membase + reg);
> +}
> +
> +static inline void atmel_uart_writel(struct uart_port *port, u32 reg=
, u32 value)
> +{
> +	__raw_writel(value, port->membase + reg);
> +}
> +
>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>  static bool atmel_use_pdc_rx(struct uart_port *port)
>  {
> @@ -257,7 +236,7 @@ static unsigned int atmel_get_lines_status(struct=
 uart_port *port)
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
>  	unsigned int status, ret =3D 0;
> =20
> -	status =3D UART_GET_CSR(port);
> +	status =3D atmel_uart_readl(port, ATMEL_US_CSR);
> =20
>  	mctrl_gpio_get(atmel_port->gpios, &ret);
> =20
> @@ -304,9 +283,9 @@ static int atmel_config_rs485(struct uart_port *p=
ort,
>  	unsigned int mode;
> =20
>  	/* Disable interrupts */
> -	UART_PUT_IDR(port, atmel_port->tx_done_mask);
> +	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
> =20
> -	mode =3D UART_GET_MR(port);
> +	mode =3D atmel_uart_readl(port, ATMEL_US_MR);
> =20
>  	/* Resetting serial mode to RS232 (0x0) */
>  	mode &=3D ~ATMEL_US_USMODE;
> @@ -316,7 +295,8 @@ static int atmel_config_rs485(struct uart_port *p=
ort,
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>  		dev_dbg(port->dev, "Setting UART to RS485\n");
>  		atmel_port->tx_done_mask =3D ATMEL_US_TXEMPTY;
> -		UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
> +		atmel_uart_writel(port, ATMEL_US_TTGR,
> +				  rs485conf->delay_rts_after_send);
>  		mode |=3D ATMEL_US_USMODE_RS485;
>  	} else {
>  		dev_dbg(port->dev, "Setting UART to RS232\n");
> @@ -326,10 +306,10 @@ static int atmel_config_rs485(struct uart_port =
*port,
>  		else
>  			atmel_port->tx_done_mask =3D ATMEL_US_TXRDY;
>  	}
> -	UART_PUT_MR(port, mode);
> +	atmel_uart_writel(port, ATMEL_US_MR, mode);
> =20
>  	/* Enable interrupts */
> -	UART_PUT_IER(port, atmel_port->tx_done_mask);
> +	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
> =20
>  	return 0;
>  }
> @@ -339,7 +319,9 @@ static int atmel_config_rs485(struct uart_port *p=
ort,
>   */
>  static u_int atmel_tx_empty(struct uart_port *port)
>  {
> -	return (UART_GET_CSR(port) & ATMEL_US_TXEMPTY) ? TIOCSER_TEMT : 0;
> +	return (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXEMPTY) ?
> +		TIOCSER_TEMT :
> +		0;
>  }
> =20
>  /*
> @@ -348,13 +330,14 @@ static u_int atmel_tx_empty(struct uart_port *p=
ort)
>  static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
>  {
>  	unsigned int control =3D 0;
> -	unsigned int mode =3D UART_GET_MR(port);
> +	unsigned int mode =3D atmel_uart_readl(port, ATMEL_US_MR);
>  	unsigned int rts_paused, rts_ready;
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> =20
>  	/* override mode to RS485 if needed, otherwise keep the current mod=
e */
>  	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
> +		atmel_uart_writel(port, ATMEL_US_TTGR,
> +				  port->rs485.delay_rts_after_send);
>  		mode &=3D ~ATMEL_US_USMODE;
>  		mode |=3D ATMEL_US_USMODE_RS485;
>  	}
> @@ -384,7 +367,7 @@ static void atmel_set_mctrl(struct uart_port *por=
t, u_int mctrl)
>  	else
>  		control |=3D ATMEL_US_DTRDIS;
> =20
> -	UART_PUT_CR(port, control);
> +	atmel_uart_writel(port, ATMEL_US_CR, control);
> =20
>  	mctrl_gpio_set(atmel_port->gpios, mctrl);
> =20
> @@ -395,7 +378,7 @@ static void atmel_set_mctrl(struct uart_port *por=
t, u_int mctrl)
>  	else
>  		mode |=3D ATMEL_US_CHMODE_NORMAL;
> =20
> -	UART_PUT_MR(port, mode);
> +	atmel_uart_writel(port, ATMEL_US_MR, mode);
>  }
> =20
>  /*
> @@ -406,7 +389,7 @@ static u_int atmel_get_mctrl(struct uart_port *po=
rt)
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
>  	unsigned int ret =3D 0, status;
> =20
> -	status =3D UART_GET_CSR(port);
> +	status =3D atmel_uart_readl(port, ATMEL_US_CSR);
> =20
>  	/*
>  	 * The control signals are active low.
> @@ -432,10 +415,10 @@ static void atmel_stop_tx(struct uart_port *por=
t)
> =20
>  	if (atmel_use_pdc_tx(port)) {
>  		/* disable PDC transmit */
> -		UART_PUT_PTCR(port, ATMEL_PDC_TXTDIS);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
>  	}
>  	/* Disable interrupts */
> -	UART_PUT_IDR(port, atmel_port->tx_done_mask);
> +	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
> =20
>  	if ((port->rs485.flags & SER_RS485_ENABLED) &&
>  	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
> @@ -450,7 +433,7 @@ static void atmel_start_tx(struct uart_port *port=
)
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> =20
>  	if (atmel_use_pdc_tx(port)) {
> -		if (UART_GET_PTSR(port) & ATMEL_PDC_TXTEN)
> +		if (atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN)
>  			/* The transmitter is already running.  Yes, we
>  			   really need this.*/
>  			return;
> @@ -460,10 +443,10 @@ static void atmel_start_tx(struct uart_port *po=
rt)
>  			atmel_stop_rx(port);
> =20
>  		/* re-enable PDC transmit */
> -		UART_PUT_PTCR(port, ATMEL_PDC_TXTEN);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
>  	}
>  	/* Enable interrupts */
> -	UART_PUT_IER(port, atmel_port->tx_done_mask);
> +	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
>  }
> =20
>  /*
> @@ -471,17 +454,19 @@ static void atmel_start_tx(struct uart_port *po=
rt)
>   */
>  static void atmel_start_rx(struct uart_port *port)
>  {
> -	UART_PUT_CR(port, ATMEL_US_RSTSTA);  /* reset status and receiver *=
/
> +	/* reset status and receiver */
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA);
> =20
> -	UART_PUT_CR(port, ATMEL_US_RXEN);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RXEN);
> =20
>  	if (atmel_use_pdc_rx(port)) {
>  		/* enable PDC controller */
> -		UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> -			port->read_status_mask);
> -		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
> +		atmel_uart_writel(port, ATMEL_US_IER,
> +				  ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> +				  port->read_status_mask);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_RXTEN);
>  	} else {
> -		UART_PUT_IER(port, ATMEL_US_RXRDY);
> +		atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_RXRDY);
>  	}
>  }
> =20
> @@ -490,15 +475,16 @@ static void atmel_start_rx(struct uart_port *po=
rt)
>   */
>  static void atmel_stop_rx(struct uart_port *port)
>  {
> -	UART_PUT_CR(port, ATMEL_US_RXDIS);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RXDIS);
> =20
>  	if (atmel_use_pdc_rx(port)) {
>  		/* disable PDC receive */
> -		UART_PUT_PTCR(port, ATMEL_PDC_RXTDIS);
> -		UART_PUT_IDR(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> -			port->read_status_mask);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_RXTDIS);
> +		atmel_uart_writel(port, ATMEL_US_IDR,
> +				  ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
> +				  port->read_status_mask);
>  	} else {
> -		UART_PUT_IDR(port, ATMEL_US_RXRDY);
> +		atmel_uart_writel(port, ATMEL_US_IDR, ATMEL_US_RXRDY);
>  	}
>  }
> =20
> @@ -538,7 +524,7 @@ static void atmel_enable_ms(struct uart_port *por=
t)
>  	else
>  		ier |=3D ATMEL_US_DCDIC;
> =20
> -	UART_PUT_IER(port, ier);
> +	atmel_uart_writel(port, ATMEL_US_IER, ier);
>  }
> =20
>  /*
> @@ -577,7 +563,7 @@ static void atmel_disable_ms(struct uart_port *po=
rt)
>  	else
>  		idr |=3D ATMEL_US_DCDIC;
> =20
> -	UART_PUT_IDR(port, idr);
> +	atmel_uart_writel(port, ATMEL_US_IDR, idr);
>  }
> =20
>  /*
> @@ -586,9 +572,11 @@ static void atmel_disable_ms(struct uart_port *p=
ort)
>  static void atmel_break_ctl(struct uart_port *port, int break_state)
>  {
>  	if (break_state !=3D 0)
> -		UART_PUT_CR(port, ATMEL_US_STTBRK);	/* start break */
> +		/* start break */
> +		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTBRK);
>  	else
> -		UART_PUT_CR(port, ATMEL_US_STPBRK);	/* stop break */
> +		/* stop break */
> +		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STPBRK);
>  }
> =20
>  /*
> @@ -622,7 +610,7 @@ atmel_buffer_rx_char(struct uart_port *port, unsi=
gned int status,
>  static void atmel_pdc_rxerr(struct uart_port *port, unsigned int sta=
tus)
>  {
>  	/* clear error */
> -	UART_PUT_CR(port, ATMEL_US_RSTSTA);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA);
> =20
>  	if (status & ATMEL_US_RXBRK) {
>  		/* ignore side-effect */
> @@ -645,9 +633,9 @@ static void atmel_rx_chars(struct uart_port *port=
)
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
>  	unsigned int status, ch;
> =20
> -	status =3D UART_GET_CSR(port);
> +	status =3D atmel_uart_readl(port, ATMEL_US_CSR);
>  	while (status & ATMEL_US_RXRDY) {
> -		ch =3D UART_GET_CHAR(port);
> +		ch =3D atmel_uart_readl(port, ATMEL_US_RHR);
> =20
>  		/*
>  		 * note that the error handling code is
> @@ -658,12 +646,13 @@ static void atmel_rx_chars(struct uart_port *po=
rt)
>  			     || atmel_port->break_active)) {
> =20
>  			/* clear error */
> -			UART_PUT_CR(port, ATMEL_US_RSTSTA);
> +			atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA);
> =20
>  			if (status & ATMEL_US_RXBRK
>  			    && !atmel_port->break_active) {
>  				atmel_port->break_active =3D 1;
> -				UART_PUT_IER(port, ATMEL_US_RXBRK);
> +				atmel_uart_writel(port, ATMEL_US_IER,
> +						  ATMEL_US_RXBRK);
>  			} else {
>  				/*
>  				 * This is either the end-of-break
> @@ -672,14 +661,15 @@ static void atmel_rx_chars(struct uart_port *po=
rt)
>  				 * being set. In both cases, the next
>  				 * RXBRK will indicate start-of-break.
>  				 */
> -				UART_PUT_IDR(port, ATMEL_US_RXBRK);
> +				atmel_uart_writel(port, ATMEL_US_IDR,
> +						  ATMEL_US_RXBRK);
>  				status &=3D ~ATMEL_US_RXBRK;
>  				atmel_port->break_active =3D 0;
>  			}
>  		}
> =20
>  		atmel_buffer_rx_char(port, status, ch);
> -		status =3D UART_GET_CSR(port);
> +		status =3D atmel_uart_readl(port, ATMEL_US_CSR);
>  	}
> =20
>  	tasklet_schedule(&atmel_port->tasklet);
> @@ -694,16 +684,18 @@ static void atmel_tx_chars(struct uart_port *po=
rt)
>  	struct circ_buf *xmit =3D &port->state->xmit;
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> =20
> -	if (port->x_char && UART_GET_CSR(port) & atmel_port->tx_done_mask) =
{
> -		UART_PUT_CHAR(port, port->x_char);
> +	if (port->x_char &&
> +	    (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_done_mas=
k)) {
> +		atmel_uart_writel(port, ATMEL_US_THR, port->x_char);
>  		port->icount.tx++;
>  		port->x_char =3D 0;
>  	}
>  	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
>  		return;
> =20
> -	while (UART_GET_CSR(port) & atmel_port->tx_done_mask) {
> -		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
> +	while (atmel_uart_readl(port, ATMEL_US_CSR) &
> +	       atmel_port->tx_done_mask) {
> +		atmel_uart_writel(port, ATMEL_US_THR, xmit->buf[xmit->tail]);
>  		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>  		port->icount.tx++;
>  		if (uart_circ_empty(xmit))
> @@ -715,7 +707,8 @@ static void atmel_tx_chars(struct uart_port *port=
)
> =20
>  	if (!uart_circ_empty(xmit))
>  		/* Enable interrupts */
> -		UART_PUT_IER(port, atmel_port->tx_done_mask);
> +		atmel_uart_writel(port, ATMEL_US_IER,
> +				  atmel_port->tx_done_mask);
>  }
> =20
>  static void atmel_complete_tx_dma(void *arg)
> @@ -935,14 +928,14 @@ static void atmel_rx_from_dma(struct uart_port =
*port)
> =20
> =20
>  	/* Reset the UART timeout early so that we don't miss one */
> -	UART_PUT_CR(port, ATMEL_US_STTTO);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTTO);
>  	dmastat =3D dmaengine_tx_status(chan,
>  				atmel_port->cookie_rx,
>  				&state);
>  	/* Restart a new tasklet if DMA status is error */
>  	if (dmastat =3D=3D DMA_ERROR) {
>  		dev_dbg(port->dev, "Get residue error, restart tasklet\n");
> -		UART_PUT_IER(port, ATMEL_US_TIMEOUT);
> +		atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
>  		tasklet_schedule(&atmel_port->tasklet);
>  		return;
>  	}
> @@ -1008,7 +1001,7 @@ static void atmel_rx_from_dma(struct uart_port =
*port)
>  	tty_flip_buffer_push(tport);
>  	spin_lock(&port->lock);
> =20
> -	UART_PUT_IER(port, ATMEL_US_TIMEOUT);
> +	atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_TIMEOUT);
>  }
> =20
>  static int atmel_prepare_rx_dma(struct uart_port *port)
> @@ -1118,8 +1111,8 @@ atmel_handle_receive(struct uart_port *port, un=
signed int pending)
>  		 * the moment.
>  		 */
>  		if (pending & (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT)) {
> -			UART_PUT_IDR(port, (ATMEL_US_ENDRX
> -						| ATMEL_US_TIMEOUT));
> +			atmel_uart_writel(port, ATMEL_US_IDR,
> +					  (ATMEL_US_ENDRX | ATMEL_US_TIMEOUT));
>  			tasklet_schedule(&atmel_port->tasklet);
>  		}
> =20
> @@ -1130,7 +1123,8 @@ atmel_handle_receive(struct uart_port *port, un=
signed int pending)
> =20
>  	if (atmel_use_dma_rx(port)) {
>  		if (pending & ATMEL_US_TIMEOUT) {
> -			UART_PUT_IDR(port, ATMEL_US_TIMEOUT);
> +			atmel_uart_writel(port, ATMEL_US_IDR,
> +					  ATMEL_US_TIMEOUT);
>  			tasklet_schedule(&atmel_port->tasklet);
>  		}
>  	}
> @@ -1143,8 +1137,8 @@ atmel_handle_receive(struct uart_port *port, un=
signed int pending)
>  		 * End of break detected. If it came along with a
>  		 * character, atmel_rx_chars will handle it.
>  		 */
> -		UART_PUT_CR(port, ATMEL_US_RSTSTA);
> -		UART_PUT_IDR(port, ATMEL_US_RXBRK);
> +		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA);
> +		atmel_uart_writel(port, ATMEL_US_IDR, ATMEL_US_RXBRK);
>  		atmel_port->break_active =3D 0;
>  	}
>  }
> @@ -1159,7 +1153,8 @@ atmel_handle_transmit(struct uart_port *port, u=
nsigned int pending)
> =20
>  	if (pending & atmel_port->tx_done_mask) {
>  		/* Either PDC or interrupt transmission */
> -		UART_PUT_IDR(port, atmel_port->tx_done_mask);
> +		atmel_uart_writel(port, ATMEL_US_IDR,
> +				  atmel_port->tx_done_mask);
>  		tasklet_schedule(&atmel_port->tasklet);
>  	}
>  }
> @@ -1197,7 +1192,7 @@ static irqreturn_t atmel_interrupt(int irq, voi=
d *dev_id)
> =20
>  	do {
>  		status =3D atmel_get_lines_status(port);
> -		mask =3D UART_GET_IMR(port);
> +		mask =3D atmel_uart_readl(port, ATMEL_US_IMR);
>  		pending =3D status & mask;
>  		if (!gpio_handled) {
>  			/*
> @@ -1223,7 +1218,7 @@ static irqreturn_t atmel_interrupt(int irq, voi=
d *dev_id)
>  		if (atmel_port->suspended) {
>  			atmel_port->pending |=3D pending;
>  			atmel_port->pending_status =3D status;
> -			UART_PUT_IDR(port, mask);
> +			atmel_uart_writel(port, ATMEL_US_IDR, mask);
>  			pm_system_wakeup();
>  			break;
>  		}
> @@ -1260,7 +1255,7 @@ static void atmel_tx_pdc(struct uart_port *port=
)
>  	int count;
> =20
>  	/* nothing left to transmit? */
> -	if (UART_GET_TCR(port))
> +	if (atmel_uart_readl(port, ATMEL_PDC_TCR))
>  		return;
> =20
>  	xmit->tail +=3D pdc->ofs;
> @@ -1272,7 +1267,7 @@ static void atmel_tx_pdc(struct uart_port *port=
)
>  	/* more to transmit - setup next transfer */
> =20
>  	/* disable PDC transmit */
> -	UART_PUT_PTCR(port, ATMEL_PDC_TXTDIS);
> +	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
> =20
>  	if (!uart_circ_empty(xmit) && !uart_tx_stopped(port)) {
>  		dma_sync_single_for_device(port->dev,
> @@ -1283,12 +1278,14 @@ static void atmel_tx_pdc(struct uart_port *po=
rt)
>  		count =3D CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  		pdc->ofs =3D count;
> =20
> -		UART_PUT_TPR(port, pdc->dma_addr + xmit->tail);
> -		UART_PUT_TCR(port, count);
> +		atmel_uart_writel(port, ATMEL_PDC_TPR,
> +				  pdc->dma_addr + xmit->tail);
> +		atmel_uart_writel(port, ATMEL_PDC_TCR, count);
>  		/* re-enable PDC transmit */
> -		UART_PUT_PTCR(port, ATMEL_PDC_TXTEN);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
>  		/* Enable interrupts */
> -		UART_PUT_IER(port, atmel_port->tx_done_mask);
> +		atmel_uart_writel(port, ATMEL_US_IER,
> +				  atmel_port->tx_done_mask);
>  	} else {
>  		if ((port->rs485.flags & SER_RS485_ENABLED) &&
>  		    !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
> @@ -1414,10 +1411,10 @@ static void atmel_rx_from_pdc(struct uart_por=
t *port)
> =20
>  	do {
>  		/* Reset the UART timeout early so that we don't miss one */
> -		UART_PUT_CR(port, ATMEL_US_STTTO);
> +		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTTO);
> =20
>  		pdc =3D &atmel_port->pdc_rx[rx_idx];
> -		head =3D UART_GET_RPR(port) - pdc->dma_addr;
> +		head =3D atmel_uart_readl(port, ATMEL_PDC_RPR) - pdc->dma_addr;
>  		tail =3D pdc->ofs;
> =20
>  		/* If the PDC has switched buffers, RPR won't contain
> @@ -1460,8 +1457,8 @@ static void atmel_rx_from_pdc(struct uart_port =
*port)
>  		 */
>  		if (head >=3D pdc->dma_size) {
>  			pdc->ofs =3D 0;
> -			UART_PUT_RNPR(port, pdc->dma_addr);
> -			UART_PUT_RNCR(port, pdc->dma_size);
> +			atmel_uart_writel(port, ATMEL_PDC_RNPR, pdc->dma_addr);
> +			atmel_uart_writel(port, ATMEL_PDC_RNCR, pdc->dma_size);
> =20
>  			rx_idx =3D !rx_idx;
>  			atmel_port->pdc_rx_idx =3D rx_idx;
> @@ -1476,7 +1473,8 @@ static void atmel_rx_from_pdc(struct uart_port =
*port)
>  	tty_flip_buffer_push(tport);
>  	spin_lock(&port->lock);
> =20
> -	UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
> +	atmel_uart_writel(port, ATMEL_US_IER,
> +			  ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
>  }
> =20
>  static int atmel_prepare_rx_pdc(struct uart_port *port)
> @@ -1509,11 +1507,12 @@ static int atmel_prepare_rx_pdc(struct uart_p=
ort *port)
> =20
>  	atmel_port->pdc_rx_idx =3D 0;
> =20
> -	UART_PUT_RPR(port, atmel_port->pdc_rx[0].dma_addr);
> -	UART_PUT_RCR(port, PDC_BUFFER_SIZE);
> +	atmel_uart_writel(port, ATMEL_PDC_RPR, atmel_port->pdc_rx[0].dma_ad=
dr);
> +	atmel_uart_writel(port, ATMEL_PDC_RCR, PDC_BUFFER_SIZE);
> =20
> -	UART_PUT_RNPR(port, atmel_port->pdc_rx[1].dma_addr);
> -	UART_PUT_RNCR(port, PDC_BUFFER_SIZE);
> +	atmel_uart_writel(port, ATMEL_PDC_RNPR,
> +			  atmel_port->pdc_rx[1].dma_addr);
> +	atmel_uart_writel(port, ATMEL_PDC_RNCR, PDC_BUFFER_SIZE);
> =20
>  	return 0;
>  }
> @@ -1667,7 +1666,7 @@ static void atmel_set_ops(struct uart_port *por=
t)
>  static void atmel_get_ip_name(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> -	int name =3D UART_GET_IP_NAME(port);
> +	int name =3D atmel_uart_readl(port, ATMEL_US_NAME);
>  	u32 version;
>  	int usart, uart;
>  	/* usart and uart ascii */
> @@ -1684,7 +1683,7 @@ static void atmel_get_ip_name(struct uart_port =
*port)
>  		atmel_port->is_usart =3D false;
>  	} else {
>  		/* fallback for older SoCs: use version field */
> -		version =3D UART_GET_IP_VERSION(port);
> +		version =3D atmel_uart_readl(port, ATMEL_US_VERSION);
>  		switch (version) {
>  		case 0x302:
>  		case 0x10213:
> @@ -1756,7 +1755,7 @@ static int atmel_startup(struct uart_port *port=
)
>  	 * request_irq() is called we could get stuck trying to
>  	 * handle an unexpected interrupt
>  	 */
> -	UART_PUT_IDR(port, -1);
> +	atmel_uart_writel(port, ATMEL_US_IDR, -1);
>  	atmel_port->ms_irq_enabled =3D false;
> =20
>  	/*
> @@ -1804,9 +1803,9 @@ static int atmel_startup(struct uart_port *port=
)
>  	/*
>  	 * Finally, enable the serial port
>  	 */
> -	UART_PUT_CR(port, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RST=
RX);
>  	/* enable xmit & rcvr */
> -	UART_PUT_CR(port, ATMEL_US_TXEN | ATMEL_US_RXEN);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN)=
;
> =20
>  	setup_timer(&atmel_port->uart_timer,
>  			atmel_uart_timer_callback,
> @@ -1819,13 +1818,14 @@ static int atmel_startup(struct uart_port *po=
rt)
>  					jiffies + uart_poll_timeout(port));
>  		/* set USART timeout */
>  		} else {
> -			UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
> -			UART_PUT_CR(port, ATMEL_US_STTTO);
> +			atmel_uart_writel(port, ATMEL_US_RTOR, PDC_RX_TIMEOUT);
> +			atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTTO);
> =20
> -			UART_PUT_IER(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
> +			atmel_uart_writel(port, ATMEL_US_IER,
> +					  ATMEL_US_ENDRX | ATMEL_US_TIMEOUT);
>  		}
>  		/* enable PDC controller */
> -		UART_PUT_PTCR(port, ATMEL_PDC_RXTEN);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_RXTEN);
>  	} else if (atmel_use_dma_rx(port)) {
>  		/* set UART timeout */
>  		if (!atmel_port->is_usart) {
> @@ -1833,14 +1833,15 @@ static int atmel_startup(struct uart_port *po=
rt)
>  					jiffies + uart_poll_timeout(port));
>  		/* set USART timeout */
>  		} else {
> -			UART_PUT_RTOR(port, PDC_RX_TIMEOUT);
> -			UART_PUT_CR(port, ATMEL_US_STTTO);
> +			atmel_uart_writel(port, ATMEL_US_RTOR, PDC_RX_TIMEOUT);
> +			atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_STTTO);
> =20
> -			UART_PUT_IER(port, ATMEL_US_TIMEOUT);
> +			atmel_uart_writel(port, ATMEL_US_IER,
> +					  ATMEL_US_TIMEOUT);
>  		}
>  	} else {
>  		/* enable receive only */
> -		UART_PUT_IER(port, ATMEL_US_RXRDY);
> +		atmel_uart_writel(port, ATMEL_US_IER, ATMEL_US_RXRDY);
>  	}
> =20
>  	return 0;
> @@ -1860,7 +1861,7 @@ static void atmel_flush_buffer(struct uart_port=
 *port)
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> =20
>  	if (atmel_use_pdc_tx(port)) {
> -		UART_PUT_TCR(port, 0);
> +		atmel_uart_writel(port, ATMEL_PDC_TCR, 0);
>  		atmel_port->pdc_tx.ofs =3D 0;
>  	}
>  }
> @@ -1892,8 +1893,8 @@ static void atmel_shutdown(struct uart_port *po=
rt)
>  	atmel_stop_rx(port);
>  	atmel_stop_tx(port);
> =20
> -	UART_PUT_CR(port, ATMEL_US_RSTSTA);
> -	UART_PUT_IDR(port, -1);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA);
> +	atmel_uart_writel(port, ATMEL_US_IDR, -1);
> =20
> =20
>  	/*
> @@ -1938,12 +1939,12 @@ static void atmel_serial_pm(struct uart_port =
*port, unsigned int state,
>  		clk_prepare_enable(atmel_port->clk);
> =20
>  		/* re-enable interrupts if we disabled some on suspend */
> -		UART_PUT_IER(port, atmel_port->backup_imr);
> +		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->backup_imr);
>  		break;
>  	case 3:
>  		/* Back up the interrupt mask and disable all interrupts */
> -		atmel_port->backup_imr =3D UART_GET_IMR(port);
> -		UART_PUT_IDR(port, -1);
> +		atmel_port->backup_imr =3D atmel_uart_readl(port, ATMEL_US_IMR);
> +		atmel_uart_writel(port, ATMEL_US_IDR, -1);
> =20
>  		/*
>  		 * Disable the peripheral clock for this serial port.
> @@ -1966,7 +1967,7 @@ static void atmel_set_termios(struct uart_port =
*port, struct ktermios *termios,
>  	unsigned int old_mode, mode, imr, quot, baud;
> =20
>  	/* save the current mode register */
> -	mode =3D old_mode =3D UART_GET_MR(port);
> +	mode =3D old_mode =3D atmel_uart_readl(port, ATMEL_US_MR);
> =20
>  	/* reset the mode, clock divisor, parity, stop bits and data size *=
/
>  	mode &=3D ~(ATMEL_US_USCLKS | ATMEL_US_CHRL | ATMEL_US_NBSTOP |
> @@ -2025,7 +2026,7 @@ static void atmel_set_termios(struct uart_port =
*port, struct ktermios *termios,
> =20
>  	if (atmel_use_pdc_rx(port))
>  		/* need to enable error interrupts */
> -		UART_PUT_IER(port, port->read_status_mask);
> +		atmel_uart_writel(port, ATMEL_US_IER, port->read_status_mask);
> =20
>  	/*
>  	 * Characters to ignore
> @@ -2052,15 +2053,16 @@ static void atmel_set_termios(struct uart_por=
t *port, struct ktermios *termios,
>  	 * transmitter is empty if requested by the caller, so there's
>  	 * no need to wait for it here.
>  	 */
> -	imr =3D UART_GET_IMR(port);
> -	UART_PUT_IDR(port, -1);
> +	imr =3D atmel_uart_readl(port, ATMEL_US_IMR);
> +	atmel_uart_writel(port, ATMEL_US_IDR, -1);
> =20
>  	/* disable receiver and transmitter */
> -	UART_PUT_CR(port, ATMEL_US_TXDIS | ATMEL_US_RXDIS);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS | ATMEL_US_RXDI=
S);
> =20
>  	/* mode */
>  	if (port->rs485.flags & SER_RS485_ENABLED) {
> -		UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
> +		atmel_uart_writel(port, ATMEL_US_TTGR,
> +				  port->rs485.delay_rts_after_send);
>  		mode |=3D ATMEL_US_USMODE_RS485;
>  	} else if (termios->c_cflag & CRTSCTS) {
>  		/* RS232 with hardware handshake (RTS/CTS) */
> @@ -2071,7 +2073,7 @@ static void atmel_set_termios(struct uart_port =
*port, struct ktermios *termios,
>  	}
> =20
>  	/* set the mode, clock divisor, parity, stop bits and data size */
> -	UART_PUT_MR(port, mode);
> +	atmel_uart_writel(port, ATMEL_US_MR, mode);
> =20
>  	/*
>  	 * when switching the mode, set the RTS line state according to the
> @@ -2088,16 +2090,16 @@ static void atmel_set_termios(struct uart_por=
t *port, struct ktermios *termios,
>  			rts_state =3D ATMEL_US_RTSEN;
>  		}
> =20
> -		UART_PUT_CR(port, rts_state);
> +		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
>  	}
> =20
>  	/* set the baud rate */
> -	UART_PUT_BRGR(port, quot);
> -	UART_PUT_CR(port, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
> -	UART_PUT_CR(port, ATMEL_US_TXEN | ATMEL_US_RXEN);
> +	atmel_uart_writel(port, ATMEL_US_BRGR, quot);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RST=
RX);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN)=
;
> =20
>  	/* restore interrupts */
> -	UART_PUT_IER(port, imr);
> +	atmel_uart_writel(port, ATMEL_US_IER, imr);
> =20
>  	/* CTS flow-control and modem-status interrupts */
>  	if (UART_ENABLE_MS(port, termios->c_cflag))
> @@ -2208,18 +2210,18 @@ static int atmel_verify_port(struct uart_port=
 *port, struct serial_struct *ser)
>  #ifdef CONFIG_CONSOLE_POLL
>  static int atmel_poll_get_char(struct uart_port *port)
>  {
> -	while (!(UART_GET_CSR(port) & ATMEL_US_RXRDY))
> +	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_RXRDY))
>  		cpu_relax();
> =20
> -	return UART_GET_CHAR(port);
> +	return atmel_uart_readl(port, ATMEL_US_RHR);
>  }
> =20
>  static void atmel_poll_put_char(struct uart_port *port, unsigned cha=
r ch)
>  {
> -	while (!(UART_GET_CSR(port) & ATMEL_US_TXRDY))
> +	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
>  		cpu_relax();
> =20
> -	UART_PUT_CHAR(port, ch);
> +	atmel_uart_writel(port, ATMEL_US_THR, ch);
>  }
>  #endif
> =20
> @@ -2324,9 +2326,9 @@ struct platform_device *atmel_default_console_d=
evice;	/* the serial console devi
>  #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
>  static void atmel_console_putchar(struct uart_port *port, int ch)
>  {
> -	while (!(UART_GET_CSR(port) & ATMEL_US_TXRDY))
> +	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
>  		cpu_relax();
> -	UART_PUT_CHAR(port, ch);
> +	atmel_uart_writel(port, ATMEL_US_THR, ch);
>  }
> =20
>  /*
> @@ -2342,12 +2344,13 @@ static void atmel_console_write(struct consol=
e *co, const char *s, u_int count)
>  	/*
>  	 * First, save IMR and then disable interrupts
>  	 */
> -	imr =3D UART_GET_IMR(port);
> -	UART_PUT_IDR(port, ATMEL_US_RXRDY | atmel_port->tx_done_mask);
> +	imr =3D atmel_uart_readl(port, ATMEL_US_IMR);
> +	atmel_uart_writel(port, ATMEL_US_IDR,
> +			  ATMEL_US_RXRDY | atmel_port->tx_done_mask);
> =20
>  	/* Store PDC transmit status and disable it */
> -	pdc_tx =3D UART_GET_PTSR(port) & ATMEL_PDC_TXTEN;
> -	UART_PUT_PTCR(port, ATMEL_PDC_TXTDIS);
> +	pdc_tx =3D atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN=
;
> +	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
> =20
>  	uart_console_write(port, s, count, atmel_console_putchar);
> =20
> @@ -2356,15 +2359,15 @@ static void atmel_console_write(struct consol=
e *co, const char *s, u_int count)
>  	 * and restore IMR
>  	 */
>  	do {
> -		status =3D UART_GET_CSR(port);
> +		status =3D atmel_uart_readl(port, ATMEL_US_CSR);
>  	} while (!(status & ATMEL_US_TXRDY));
> =20
>  	/* Restore PDC transmit status */
>  	if (pdc_tx)
> -		UART_PUT_PTCR(port, ATMEL_PDC_TXTEN);
> +		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
> =20
>  	/* set interrupts back the way they were */
> -	UART_PUT_IER(port, imr);
> +	atmel_uart_writel(port, ATMEL_US_IER, imr);
>  }
> =20
>  /*
> @@ -2380,17 +2383,17 @@ static void __init atmel_console_get_options(=
struct uart_port *port, int *baud,
>  	 * If the baud rate generator isn't running, the port wasn't
>  	 * initialized by the boot loader.
>  	 */
> -	quot =3D UART_GET_BRGR(port) & ATMEL_US_CD;
> +	quot =3D atmel_uart_readl(port, ATMEL_US_BRGR) & ATMEL_US_CD;
>  	if (!quot)
>  		return;
> =20
> -	mr =3D UART_GET_MR(port) & ATMEL_US_CHRL;
> +	mr =3D atmel_uart_readl(port, ATMEL_US_MR) & ATMEL_US_CHRL;
>  	if (mr =3D=3D ATMEL_US_CHRL_8)
>  		*bits =3D 8;
>  	else
>  		*bits =3D 7;
> =20
> -	mr =3D UART_GET_MR(port) & ATMEL_US_PAR;
> +	mr =3D atmel_uart_readl(port, ATMEL_US_MR) & ATMEL_US_PAR;
>  	if (mr =3D=3D ATMEL_US_PAR_EVEN)
>  		*parity =3D 'e';
>  	else if (mr =3D=3D ATMEL_US_PAR_ODD)
> @@ -2423,9 +2426,9 @@ static int __init atmel_console_setup(struct co=
nsole *co, char *options)
>  	if (ret)
>  		return ret;
> =20
> -	UART_PUT_IDR(port, -1);
> -	UART_PUT_CR(port, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
> -	UART_PUT_CR(port, ATMEL_US_TXEN | ATMEL_US_RXEN);
> +	atmel_uart_writel(port, ATMEL_US_IDR, -1);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RST=
RX);
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN)=
;
> =20
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> @@ -2532,7 +2535,8 @@ static int atmel_serial_suspend(struct platform=
_device *pdev,
> =20
>  	if (atmel_is_console_port(port) && console_suspend_enabled) {
>  		/* Drain the TX shifter */
> -		while (!(UART_GET_CSR(port) & ATMEL_US_TXEMPTY))
> +		while (!(atmel_uart_readl(port, ATMEL_US_CSR) &
> +			 ATMEL_US_TXEMPTY))
>  			cpu_relax();
>  	}
> =20
> @@ -2684,8 +2688,9 @@ static int atmel_serial_probe(struct platform_d=
evice *pdev)
>  	clk_prepare_enable(port->clk);
> =20
>  	if (rs485_enabled) {
> -		UART_PUT_MR(&port->uart, ATMEL_US_USMODE_NORMAL);
> -		UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
> +		atmel_uart_writel(&port->uart, ATMEL_US_MR,
> +				  ATMEL_US_USMODE_NORMAL);
> +		atmel_uart_writel(&port->uart, ATMEL_US_CR, ATMEL_US_RTSEN);
>  	}
> =20
>  	/*
>=20


--=20
Nicolas Ferre
