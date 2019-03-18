From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 2/2] tty/serial: atmel: RS485 HD w/DMA: enable RX after TX
 is stopped
Date: Mon, 18 Mar 2019 15:30:45 +0100
Message-ID: <cb09f654-1c42-4f0c-25d3-5cb1708d6080@sorico.fr>
References: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
 <20190315092334.13246-3-razvan.stefanescu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315092334.13246-3-razvan.stefanescu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Razvan Stefanescu <razvan.stefanescu@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Gil Weber <webergil@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[ adding Gil Weber in Cc: ]
Le 15/03/2019 à 10:23, Razvan Stefanescu a écrit :
> In half-duplex operation, RX should be started after TX completes.
> 
> If DMA is used, there is a case when the DMA transfer completes but the
> TX FIFO is not emptied, so the RX cannot be restarted just yet.
> 
> Use a boolean variable to store this state and rearm TX interrupt mask
> to be signaled again that the transfer finished. In interrupt transmit
> handler this variable is used to start RX.

I was sure I've already seen something like that.
Gil, could you give it a test ?

you can add :
Cc: stable@vger.kernel.org
Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable RX after TX is done")

Since patch 1/2 is needed for this one, I think you should add also
Cc:stable / Fixes: to the previous patch.

> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a6577b1c4461..b0141dcbbb61 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -166,6 +166,8 @@ struct atmel_uart_port {
>  	unsigned int		pending_status;
>  	spinlock_t		lock_suspended;
>  
> +	bool			hd_start_rx;	/* can start RX during half-duplex operation */
> +
>  	/* ISO7816 */
>  	unsigned int		fidi_min;
>  	unsigned int		fidi_max;
> @@ -934,8 +936,13 @@ static void atmel_complete_tx_dma(void *arg)
>  	if (!uart_circ_empty(xmit))
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
>  	else if (atmel_uart_is_half_duplex(port)) {
> -		/* DMA done, stop TX, start RX for RS485 */
> -		atmel_start_rx(port);
> +		/*
> +		 * DMA done, re-enable TXEMPTY and signal that we can stop
> +		 * TX and start RX for RS485
> +		 */
> +		atmel_port->hd_start_rx = true;
> +		atmel_uart_writel(port, ATMEL_US_IER,
> +				  atmel_port->tx_done_mask);
>  	}
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
> @@ -1379,9 +1386,21 @@ atmel_handle_transmit(struct uart_port *port, unsigned int pending)
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  
>  	if (pending & atmel_port->tx_done_mask) {
> -		/* Either PDC or interrupt transmission */
>  		atmel_uart_writel(port, ATMEL_US_IDR,
>  				  atmel_port->tx_done_mask);
> +
> +		/* Start RX if flag was set and FIFO is empty */
> +		if (atmel_port->hd_start_rx) {
> +			if (atmel_uart_readl(port, ATMEL_US_CSR)
> +					& ATMEL_US_TXEMPTY) {
> +				atmel_port->hd_start_rx = false;
> +				atmel_start_rx(port);
> +			} else {
> +				dev_warn(port->dev, "Should start RX, but TX fifo is not empty\n");
What will happen in this case ?

> +			}
> +			return;
> +		}
> +
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
>  	}
>  }
> 

Thanks !
