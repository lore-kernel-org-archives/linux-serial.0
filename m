From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v3 09/10] tty: xuartps: Only handle RX IRQs when RX
 is enabled
Date: Sat, 5 Dec 2015 12:43:13 -0500
Message-ID: <56632231.6000000@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-10-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-10-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Ignore RX-related interrupts if RX is not enabled.

This doesn't look like a safe approach; fast-forward a couple of years and
some is trying to add some feature but can't figure out why no data is
arriving...

What is this trying to solve?

Regards,
Peter Hurley

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index db9e23eaf300..3a1e508926c1 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -161,6 +161,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>   * @pclk:		APB clock
>   * @baud:		Current baud rate
>   * @clk_rate_change_nb:	Notifier block for clock changes
> + * @flags:		Driver flags
>   */
>  struct cdns_uart {
>  	struct uart_port	*port;
> @@ -168,7 +169,11 @@ struct cdns_uart {
>  	struct clk		*pclk;
>  	unsigned int		baud;
>  	struct notifier_block	clk_rate_change_nb;
> +	u32			flags;
>  };
> +
> +#define CDNS_FLAG_RX_ENABLED	BIT(0)
> +
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
>  		clk_rate_change_nb);
>  
> @@ -262,6 +267,7 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
>  static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
>  {
>  	struct uart_port *port = (struct uart_port *)dev_id;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  	unsigned long flags;
>  	unsigned int isrstatus, numbytes;
>  
> @@ -272,7 +278,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
>  	 */
>  	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
>  
> -	cdns_uart_handle_rx(port, isrstatus);
> +	if (cdns_uart->flags & CDNS_FLAG_RX_ENABLED)
> +		cdns_uart_handle_rx(port, isrstatus);
>  
>  	/* Dispatch an appropriate handler */
>  	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
> @@ -579,11 +586,13 @@ static void cdns_uart_stop_tx(struct uart_port *port)
>  static void cdns_uart_stop_rx(struct uart_port *port)
>  {
>  	unsigned int regval;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  
>  	regval = readl(port->membase + CDNS_UART_CR_OFFSET);
>  	regval |= CDNS_UART_CR_RX_DIS;
>  	/* Disable the receiver */
>  	writel(regval, port->membase + CDNS_UART_CR_OFFSET);
> +	cdns_uart->flags &= ~CDNS_FLAG_RX_ENABLED;
>  }
>  
>  /**
> @@ -764,6 +773,7 @@ static int cdns_uart_startup(struct uart_port *port)
>  {
>  	unsigned long flags;
>  	unsigned int retval = 0, status = 0;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  
>  	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
>  								(void *)port);
> @@ -790,6 +800,7 @@ static int cdns_uart_startup(struct uart_port *port)
>  	status &= CDNS_UART_CR_RX_DIS;
>  	status |= CDNS_UART_CR_RX_EN;
>  	writel(status, port->membase + CDNS_UART_CR_OFFSET);
> +	cdns_uart->flags |= CDNS_FLAG_RX_ENABLED;
>  
>  	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
>  	 * no parity.
> @@ -833,6 +844,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
>  {
>  	int status;
>  	unsigned long flags;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  
> @@ -844,6 +856,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
>  	/* Disable the TX and RX */
>  	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
>  			port->membase + CDNS_UART_CR_OFFSET);
> +	cdns_uart->flags &= ~CDNS_FLAG_RX_ENABLED;
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
> 
