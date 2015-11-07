From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 3/3] tty: Add software emulated RS485 support for 8250
Date: Sat, 7 Nov 2015 11:03:42 -0500
Message-ID: <563E20DE.7000209@hurleysoftware.com>
References: <1446890976-1817-1-git-send-email-matwey@sai.msu.ru>
 <1446890976-1817-3-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446890976-1817-3-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, matwey.kornilov@gmail.com
List-Id: linux-serial@vger.kernel.org

Hi Matwey,

On 11/07/2015 05:09 AM, Matwey V. Kornilov wrote:
> Implementation of software emulation of RS485 direction handling is based
> on omap-serial driver.  It is acts as the following. At transmission start,
> RTS is set (if required) and receiver is off (if required). At transmission
> stop, RTS is set (if required) and fifo is flushed.

Comments below.

> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/tty/serial/8250/8250_port.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 52d82d2..a9291f7 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -559,7 +559,37 @@ static void serial8250_rpm_put_tx(struct uart_8250_port *p)
>  	pm_runtime_mark_last_busy(p->port.dev);
>  	pm_runtime_put_autosuspend(p->port.dev);
>  }

Newline req'd here.

> +static void serial8250_stop_rx(struct uart_port *port);

You can eliminate this forward decl by relocating serial8250_stop_rx() to here
(in a separate patch).

> +static void serial8250_rs485_start_tx(struct uart_8250_port *p)
> +{
> +	if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
> +		return;
> +
> +	if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND) {
> +		serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
> +		if (p->port.rs485.delay_rts_before_send > 0)
> +			mdelay(p->port.rs485.delay_rts_before_send);

So irqs are off for x msecs, and this cpu can't be used for anything else now?
I think this needs to be solved differently; maybe with a timer?

> +	}
> +	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +		serial8250_stop_rx(&p->port);
> +}

Newline req'd here.

> +static void serial8250_rs485_stop_tx(struct uart_8250_port *p)
> +{
> +	if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
> +		return;
>  
> +	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND) {
> +		if (p->port.rs485.delay_rts_after_send > 0)
> +			mdelay(p->port.rs485.delay_rts_after_send);

Same issue with irqs off.

> +		serial_port_out(&p->port, UART_MCR, UART_MCR_RTS);
> +	}
> +	/*
> +	* Empty the RX FIFO, we are not interested in anything
> +	* received during the half-duplex transmission.
> +	*/
> +	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
> +		serial8250_clear_fifos(p);
> +}
>  /*
>   * IER sleep support.  UARTs which have EFRs need the "extended
>   * capability" bit enabled.  Note that on XR16C850s, we need to
> @@ -1309,6 +1339,7 @@ static void serial8250_stop_tx(struct uart_port *port)
>  		up->acr |= UART_ACR_TXDIS;
>  		serial_icr_write(up, UART_ACR, up->acr);
>  	}
> +	serial8250_rs485_stop_tx(up);
>  	serial8250_rpm_put(up);
>  }
>  
> @@ -1317,6 +1348,7 @@ static void serial8250_start_tx(struct uart_port *port)
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
>  	serial8250_rpm_get_tx(up);
> +	serial8250_rs485_start_tx(up);
>  
>  	if (up->dma && !up->dma->tx_dma(up))
>  		return;
> 
