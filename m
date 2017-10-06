From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 10/16] serial: mvebu-uart: dissociate RX and TX interrupts
Date: Fri, 06 Oct 2017 15:11:43 +0200
Message-ID: <87bmlke7zk.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-11-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171006101344.15590-11-miquel.raynal@free-electrons.com>
        (Miquel Raynal's message of "Fri, 6 Oct 2017 12:13:38 +0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jiri Slaby <jslaby@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Wilson Ding <dingwei@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Miquel,
 
 On ven., oct. 06 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> While the standard UART port can use a single IRQ that 'sums' both RX
> and TX interrupts, the extended port cannot and has to use two different
> ISR, one for each direction. The standard port also has the hability
                                                              ability
> to use two separate interrupts (one for each direction).
>
> The logic is then: either there is only one unnamed interrupt on the
> standard port and this interrupt must be used for both directions
> (this is legacy bindings); or all the interrupts must be described and
> named 'uart-sum' (if available), 'uart-rx', 'uart-tx' and two separate
> handlers for each direction will be used.
>
> Suggested-by: Allen Yan <yanwei@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/tty/serial/mvebu-uart.c | 129 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 118 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 46d10209637a..b52cbe8c0558 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -79,7 +79,16 @@
>  #define MVEBU_UART_TYPE		"mvebu-uart"
>  #define DRIVER_NAME		"mvebu_serial"
>  
> -/* Register offsets, different depending on the UART */
> +enum {
> +	/* Either there is only one summed IRQ... */
> +	UART_IRQ_SUM = 0,
> +	/* ...or there are two separate IRQ for RX and TX */
> +	UART_RX_IRQ = 0,
> +	UART_TX_IRQ,
> +	UART_IRQ_COUNT
> +};
> +
> +/* Diverging register offsets */
>  struct uart_regs_layout {
>  	unsigned int rbr;
>  	unsigned int tsh;
> @@ -106,6 +115,8 @@ struct mvebu_uart_driver_data {
>  struct mvebu_uart {
>  	struct uart_port *port;
>  	struct clk *clk;
> +	int irq[UART_IRQ_COUNT];
> +	unsigned char __iomem *nb;
>  	struct mvebu_uart_driver_data *data;
>  };
>  
> @@ -313,9 +324,32 @@ static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
>  	unsigned int st = readl(port->membase + UART_STAT);
>  
>  	if (st & (STAT_RX_RDY(port) | STAT_OVR_ERR | STAT_FRM_ERR |
> +		  STAT_BRK_DET))
> +		mvebu_uart_rx_chars(port, st);
> +
> +	if (st & STAT_TX_RDY(port))
> +		mvebu_uart_tx_chars(port, st);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mvebu_uart_rx_isr(int irq, void *dev_id)
> +{
> +	struct uart_port *port = (struct uart_port *)dev_id;
> +	unsigned int st = readl(port->membase + UART_STAT);
> +
> +	if (st & (STAT_RX_RDY(port) | STAT_OVR_ERR | STAT_FRM_ERR |
>  			STAT_BRK_DET))
>  		mvebu_uart_rx_chars(port, st);
>  
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mvebu_uart_tx_isr(int irq, void *dev_id)
> +{
> +	struct uart_port *port = (struct uart_port *)dev_id;
> +	unsigned int st = readl(port->membase + UART_STAT);
> +
>  	if (st & STAT_TX_RDY(port))
>  		mvebu_uart_tx_chars(port, st);
>  
> @@ -324,6 +358,7 @@ static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
>  
>  static int mvebu_uart_startup(struct uart_port *port)
>  {
> +	struct mvebu_uart *mvuart = to_mvuart(port);
>  	unsigned int ctl;
>  	int ret;
>  
> @@ -342,11 +377,37 @@ static int mvebu_uart_startup(struct uart_port *port)
>  	ctl |= CTRL_RX_RDY_INT(port);
>  	writel(ctl, port->membase + UART_INTR(port));
>  
> -	ret = request_irq(port->irq, mvebu_uart_isr, port->irqflags,
> -			  DRIVER_NAME, port);
> -	if (ret) {
> -		dev_err(port->dev, "failed to request irq\n");
> -		return ret;
> +	if (!mvuart->irq[UART_TX_IRQ]) {
> +		/* Old bindings with just one interrupt (UART0 only) */
> +		ret = devm_request_irq(port->dev, mvuart->irq[UART_IRQ_SUM],
> +				       mvebu_uart_isr, port->irqflags,
> +				       dev_name(port->dev), port);
> +		if (ret) {
> +			dev_err(port->dev, "unable to request IRQ %d\n",
> +				mvuart->irq[UART_IRQ_SUM]);
> +			return ret;
> +		}
> +	} else {
> +		/* New bindings with an IRQ for RX and TX (both UART) */
> +		ret = devm_request_irq(port->dev, mvuart->irq[UART_RX_IRQ],
> +				       mvebu_uart_rx_isr, port->irqflags,
> +				       dev_name(port->dev), port);
> +		if (ret) {
> +			dev_err(port->dev, "unable to request IRQ %d\n",
> +				mvuart->irq[UART_RX_IRQ]);
> +			return ret;
> +		}
> +
> +		ret = devm_request_irq(port->dev, mvuart->irq[UART_TX_IRQ],
> +				       mvebu_uart_tx_isr, port->irqflags,
> +				       dev_name(port->dev),
> +				       port);
> +		if (ret) {
> +			dev_err(port->dev, "unable to request IRQ %d\n",
> +				mvuart->irq[UART_TX_IRQ]);
> +			free_irq(mvuart->irq[UART_RX_IRQ], port);

If you register with devm_request_irq then you have to free with
devm_free_irq().

> +			return ret;
> +		}
>  	}
>  
>  	return 0;
> @@ -354,9 +415,16 @@ static int mvebu_uart_startup(struct uart_port *port)
>  
>  static void mvebu_uart_shutdown(struct uart_port *port)
>  {
> +	struct mvebu_uart *mvuart = to_mvuart(port);
> +
>  	writel(0, port->membase + UART_INTR(port));
>  
> -	free_irq(port->irq, port);
> +	if (!mvuart->irq[UART_TX_IRQ]) {
> +		free_irq(mvuart->irq[UART_IRQ_SUM], port);

same here use devm_free_irq().

> +	} else {
> +		free_irq(mvuart->irq[UART_RX_IRQ], port);
> +		free_irq(mvuart->irq[UART_TX_IRQ], port);

And here again.

Gregory

> +	}
>  }
>  
>  static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> @@ -658,15 +726,15 @@ static const struct of_device_id mvebu_uart_of_match[];
>  static int mvebu_uart_probe(struct platform_device *pdev)
>  {
>  	struct resource *reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	const struct of_device_id *match = of_match_device(mvebu_uart_of_match,
>  							   &pdev->dev);
>  	struct uart_port *port;
>  	struct mvebu_uart *mvuart;
> +	int irq;
>  	int ret;
>  
> -	if (!reg || !irq) {
> -		dev_err(&pdev->dev, "no registers/irq defined\n");
> +	if (!reg) {
> +		dev_err(&pdev->dev, "no registers defined\n");
>  		return -EINVAL;
>  	}
>  
> @@ -693,7 +761,12 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  	port->flags      = UPF_FIXED_PORT;
>  	port->line       = pdev->id;
>  
> -	port->irq        = irq->start;
> +	/*
> +	 * IRQ number is not stored in this structure because we may have two of
> +	 * them per port (RX and TX). Instead, use the driver UART structure
> +	 * array so called ->irq[].
> +	 */
> +	port->irq        = 0;
>  	port->irqflags   = 0;
>  	port->mapbase    = reg->start;
>  
> @@ -728,6 +801,40 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  			port->uartclk = clk_get_rate(mvuart->clk);
>  	}
>  
> +	/* Manage interrupts */
> +	memset(mvuart->irq, 0, UART_IRQ_COUNT);
> +	if (platform_irq_count(pdev) == 1) {
> +		/* Old bindings: no name on the single unamed UART0 IRQ */
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "unable to get UART IRQ\n");
> +			return irq;
> +		}
> +
> +		mvuart->irq[UART_IRQ_SUM] = irq;
> +	} else {
> +		/*
> +		 * New bindings: named interrupts (RX, TX) for both UARTS,
> +		 * only make use of uart-rx and uart-tx interrupts, do not use
> +		 * uart-sum of UART0 port.
> +		 */
> +		irq = platform_get_irq_byname(pdev, "uart-rx");
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "unable to get 'uart-rx' IRQ\n");
> +			return irq;
> +		}
> +
> +		mvuart->irq[UART_RX_IRQ] = irq;
> +
> +		irq = platform_get_irq_byname(pdev, "uart-tx");
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "unable to get 'uart-tx' IRQ\n");
> +			return irq;
> +		}
> +
> +		mvuart->irq[UART_TX_IRQ] = irq;
> +	}
> +
>  	/* UART Soft Reset*/
>  	writel(CTRL_SOFT_RST, port->membase + UART_CTRL(port));
>  	udelay(1);
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
