From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] tty/serial: atmel: fix RS485 half duplex with DMA
Date: Thu, 2 Jun 2016 12:41:36 +0200
Message-ID: <57500D60.2000900@atmel.com>
References: <1464389648-4820-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464389648-4820-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Le 28/05/2016 00:54, Alexandre Belloni a =E9crit :
> When using DMA, half duplex doesn't work properly because rx is not s=
topped
> before starting tx. Ensure we call atmel_stop_rx() in the DMA case.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

We can also add:
Cc: <stable@vger.kernel.org> # v4.3+


Thanks Alexandre!



> ---
>  drivers/tty/serial/atmel_serial.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 954941dd8124..f9c798cba83f 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -482,19 +482,21 @@ static void atmel_start_tx(struct uart_port *po=
rt)
>  {
>  	struct atmel_uart_port *atmel_port =3D to_atmel_uart_port(port);
> =20
> -	if (atmel_use_pdc_tx(port)) {
> -		if (atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN)
> -			/* The transmitter is already running.  Yes, we
> -			   really need this.*/
> -			return;
> +	if (atmel_use_pdc_tx(port) && (atmel_uart_readl(port, ATMEL_PDC_PTS=
R)
> +				       & ATMEL_PDC_TXTEN))
> +		/* The transmitter is already running.  Yes, we
> +		   really need this.*/
> +		return;
> =20
> +	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
>  		if ((port->rs485.flags & SER_RS485_ENABLED) &&
>  		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
>  			atmel_stop_rx(port);
> =20
> +	if (atmel_use_pdc_tx(port))
>  		/* re-enable PDC transmit */
>  		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
> -	}
> +
>  	/* Enable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
>  }
>=20


--=20
Nicolas Ferre
