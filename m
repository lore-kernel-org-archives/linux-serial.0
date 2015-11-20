From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter in
 start_tx
Date: Fri, 20 Nov 2015 07:13:41 -0500
Message-ID: <564F0E75.5020100@hurleysoftware.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 11/19/2015 03:02 PM, Soren Brinkmann wrote:
> start_tx must start transmitting characters. Regardless of the state of
> the circular buffer, always enable the transmitter hardware.

Why?

Does cdns_uart_stop_tx() actually stop the transmitter so that
data remains in the transmitter?

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 2c98c357d9a0..df6778d17949 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -512,9 +512,6 @@ static void cdns_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int status, numbytes = port->fifosize;
>  
> -	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
> -		return;

The test for tx stopped needs to remain; otherwise, transmission will
restart even if the tty has been stopped (for example by userspace
or IXON software flow control).

Regards,
Peter Hurley

> -
>  	/*
>  	 * Set the TX enable bit and clear the TX disable bit to enable the
>  	 * transmitter.
> @@ -524,6 +521,9 @@ static void cdns_uart_start_tx(struct uart_port *port)
>  	status |= CDNS_UART_CR_TX_EN;
>  	writel(status, port->membase + CDNS_UART_CR_OFFSET);
>  
> +	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
> +		return;
> +
>  	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR_OFFSET) &
>  				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
>  		/* Break if no more data available in the UART buffer */
> 
