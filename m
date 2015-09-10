From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/3] serial: samsung: Fix UART status handling in DMA mode
Date: Thu, 10 Sep 2015 09:47:18 +0900
Message-ID: <55F0D316.6060004@samsung.com>
References: <1441705127-24125-1-git-send-email-r.baldyga@samsung.com>
 <1441705127-24125-4-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441705127-24125-4-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 08.09.2015 18:38, Robert Baldyga wrote:
> This patch fixes UART status handling in DMA mode.

Please describe the issue - what kind of issues are in UART status
handling? I think this fixes a specific bug which can be observed by the
user, so it should be mentioned here. You mention this a little bit
later but I would miss it if I were not aware earlier of the issue.

> For this purpose we
> introduce s3c24xx_serial_rx_drain_fifo() function, which contains common
> RX handling code for both PIO mode and DMA mode (in case of interrupt).
> 
> Thanks to this we have, among others, 'break' condition handling needed
> for Magic SysRq, which was missing in DMA mode so far. Since we can use
> UART in DMA mode as serial console, it's quite important improvement.
> 
> This change additionally simplifies RX handling code, as we no longer
> need uart_rx_drain_fifo() function, so we can remove it.

Maybe it's because I don't know the driver but I have difficulties to
spot the exact fix. There is significant code movement... To spot the
difference I even applied the patch, it helped...

I think it could be split for easier understanding. First introduce
common code (s3c24xx_serial_rx_drain_fifo()) and then fix the issue.
Yeah, I am grumpy but really the fix should be made visible (easier to
spot).

Best regards,
Krzysztof

> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 142 +++++++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 2b05194..007bc5f 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -388,29 +388,6 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
>  static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
>  				     unsigned long ufstat);
>  
> -static void uart_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
> -{
> -	struct uart_port *port = &ourport->port;
> -	struct tty_port *tty = &port->state->port;
> -	unsigned int ch, ufstat;
> -	unsigned int count;
> -
> -	ufstat = rd_regl(port, S3C2410_UFSTAT);
> -	count = s3c24xx_serial_rx_fifocnt(ourport, ufstat);
> -
> -	if (!count)
> -		return;
> -
> -	while (count-- > 0) {
> -		ch = rd_regb(port, S3C2410_URXH);
> -
> -		ourport->port.icount.rx++;
> -		tty_insert_flip_char(tty, ch, TTY_NORMAL);
> -	}
> -
> -	tty_flip_buffer_push(tty);
> -}
> -
>  static void s3c24xx_serial_stop_rx(struct uart_port *port)
>  {
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> @@ -573,64 +550,12 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
>  	ourport->rx_mode = S3C24XX_RX_PIO;
>  }
>  
> -static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
> +static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
>  {
> -	unsigned int utrstat, ufstat, received;
> -	struct s3c24xx_uart_port *ourport = dev_id;
> -	struct uart_port *port = &ourport->port;
> -	struct s3c24xx_uart_dma *dma = ourport->dma;
> -	struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
> -	struct tty_port *t = &port->state->port;
> -	unsigned long flags;
> -	struct dma_tx_state state;
> -
> -	utrstat = rd_regl(port, S3C2410_UTRSTAT);
> -	ufstat = rd_regl(port, S3C2410_UFSTAT);
> -
> -	spin_lock_irqsave(&port->lock, flags);
> -
> -	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
> -		s3c64xx_start_rx_dma(ourport);
> -		if (ourport->rx_mode == S3C24XX_RX_PIO)
> -			enable_rx_dma(ourport);
> -		goto finish;
> -	}
> -
> -	if (ourport->rx_mode == S3C24XX_RX_DMA) {
> -		dmaengine_pause(dma->rx_chan);
> -		dmaengine_tx_status(dma->rx_chan, dma->rx_cookie, &state);
> -		dmaengine_terminate_all(dma->rx_chan);
> -		received = dma->rx_bytes_requested - state.residue;
> -		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);
> -
> -		enable_rx_pio(ourport);
> -	}
> -
> -	uart_rx_drain_fifo(ourport);
> -
> -	if (tty) {
> -		tty_flip_buffer_push(t);
> -		tty_kref_put(tty);
> -	}
> -
> -	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
> -
> -finish:
> -	spin_unlock_irqrestore(&port->lock, flags);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
> -{
> -	struct s3c24xx_uart_port *ourport = dev_id;
>  	struct uart_port *port = &ourport->port;
>  	unsigned int ufcon, ch, flag, ufstat, uerstat;
> -	unsigned long flags;
>  	int max_count = port->fifosize;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> -
>  	while (max_count-- > 0) {
>  		ufcon = rd_regl(port, S3C2410_UFCON);
>  		ufstat = rd_regl(port, S3C2410_UFSTAT);
> @@ -654,9 +579,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  					ufcon |= S3C2410_UFCON_RESETRX;
>  					wr_regl(port, S3C2410_UFCON, ufcon);
>  					rx_enabled(port) = 1;
> -					spin_unlock_irqrestore(&port->lock,
> -							flags);
> -					goto out;
> +					return;
>  				}
>  				continue;
>  			}
> @@ -702,10 +625,67 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  				 ch, flag);
>  	}
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
>  	tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
> +{
> +	unsigned int utrstat, ufstat, received;
> +	struct s3c24xx_uart_port *ourport = dev_id;
> +	struct uart_port *port = &ourport->port;
> +	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
> +	struct tty_port *t = &port->state->port;
> +	unsigned long flags;
> +	struct dma_tx_state state;
> +
> +	utrstat = rd_regl(port, S3C2410_UTRSTAT);
> +	ufstat = rd_regl(port, S3C2410_UFSTAT);
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
> +		s3c64xx_start_rx_dma(ourport);
> +		if (ourport->rx_mode == S3C24XX_RX_PIO)
> +			enable_rx_dma(ourport);
> +		goto finish;
> +	}
> +
> +	if (ourport->rx_mode == S3C24XX_RX_DMA) {
> +		dmaengine_pause(dma->rx_chan);
> +		dmaengine_tx_status(dma->rx_chan, dma->rx_cookie, &state);
> +		dmaengine_terminate_all(dma->rx_chan);
> +		received = dma->rx_bytes_requested - state.residue;
> +		s3c24xx_uart_copy_rx_to_tty(ourport, t, received);
> +
> +		enable_rx_pio(ourport);
> +	}
> +
> +	s3c24xx_serial_rx_drain_fifo(ourport);
> +
> +	if (tty) {
> +		tty_flip_buffer_push(t);
> +		tty_kref_put(tty);
> +	}
> +
> +	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
> +
> +finish:
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
> +{
> +	struct s3c24xx_uart_port *ourport = dev_id;
> +	struct uart_port *port = &ourport->port;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	s3c24xx_serial_rx_drain_fifo(ourport);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  
> -out:
>  	return IRQ_HANDLED;
>  }
>  
> 
