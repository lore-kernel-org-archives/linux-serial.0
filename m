From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] serial/efm32: parse location property
Date: Mon, 04 Mar 2013 22:38:54 +0800
Message-ID: <20130304143854.395EF3E206B@localhost>
References: <1358774576-13275-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1478199060444048331=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1358774576-13275-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--===============1478199060444048331==
Content-Type: text/plain

On Mon, 21 Jan 2013 14:22:56 +0100, Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> The non-dt probing allowed passing the location via platform data from
> the beginning. So make up leeway for device tree probing.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Linus, does this look like some thing that should be done using pinctrl?

g.

> ---
> Hello,
> 
> I wonder if the location property should be mandatory. Do you have an
> opinion? 
> 
> BTW, I was surprised that I had to use of_property_read_u32 but not
> of_property_read_u8. I would have expected that the only difference
> between those two is the returned type, but actually the format to
> specify an u8 is different. Is this intended? (Probably it is. If so, is
> it maybe sensible to accentuate the difference by using a different
> function name for the u32 case?)
> 
> Best regards
> Uwe
> 
>  .../devicetree/bindings/tty/serial/efm32-uart.txt  |    6 ++++
>  drivers/tty/serial/efm32-uart.c                    |   31 +++++++++++++++-----
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt b/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt
> index 6588b69..8e080b8 100644
> --- a/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/efm32-uart.txt
> @@ -5,10 +5,16 @@ Required properties:
>  - reg : Address and length of the register set
>  - interrupts : Should contain uart interrupt
>  
> +Optional properties:
> +- location : Decides the location of the USART I/O pins.
> +  Allowed range : [0 .. 5]
> +  Default: 0
> +
>  Example:
>  
>  uart@0x4000c400 {
>  	compatible = "efm32,uart";
>  	reg = <0x4000c400 0x400>;
>  	interrupts = <15>;
> +	location = <0>;
>  };
> diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
> index a8cbb26..67ff23b 100644
> --- a/drivers/tty/serial/efm32-uart.c
> +++ b/drivers/tty/serial/efm32-uart.c
> @@ -81,6 +81,7 @@ struct efm32_uart_port {
>  	struct uart_port port;
>  	unsigned int txirq;
>  	struct clk *clk;
> +	struct efm32_uart_pdata pdata;
>  };
>  #define to_efm_port(_port) container_of(_port, struct efm32_uart_port, port)
>  #define efm_debug(efm_port, format, arg...)			\
> @@ -300,13 +301,8 @@ static irqreturn_t efm32_uart_txirq(int irq, void *data)
>  static int efm32_uart_startup(struct uart_port *port)
>  {
>  	struct efm32_uart_port *efm_port = to_efm_port(port);
> -	u32 location = 0;
> -	struct efm32_uart_pdata *pdata = dev_get_platdata(port->dev);
>  	int ret;
>  
> -	if (pdata)
> -		location = UARTn_ROUTE_LOCATION(pdata->location);
> -
>  	ret = clk_enable(efm_port->clk);
>  	if (ret) {
>  		efm_debug(efm_port, "failed to enable clk\n");
> @@ -315,7 +311,9 @@ static int efm32_uart_startup(struct uart_port *port)
>  	port->uartclk = clk_get_rate(efm_port->clk);
>  
>  	/* Enable pins at configured location */
> -	efm32_uart_write32(efm_port, location | UARTn_ROUTE_RXPEN | UARTn_ROUTE_TXPEN,
> +	efm32_uart_write32(efm_port,
> +			UARTn_ROUTE_LOCATION(efm_port->pdata.location) |
> +			UARTn_ROUTE_RXPEN | UARTn_ROUTE_TXPEN,
>  			UARTn_ROUTE);
>  
>  	ret = request_irq(port->irq, efm32_uart_rxirq, 0,
> @@ -674,11 +672,24 @@ static int efm32_uart_probe_dt(struct platform_device *pdev,
>  		struct efm32_uart_port *efm_port)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	u32 location;
>  	int ret;
>  
>  	if (!np)
>  		return 1;
>  
> +	ret = of_property_read_u32(np, "location", &location);
> +	if (!ret) {
> +		if (location > 5) {
> +			dev_err(&pdev->dev, "invalid location\n");
> +			return -EINVAL;
> +		}
> +		efm_debug(efm_port, "using location %u\n", location);
> +		efm_port->pdata.location = location;
> +	} else {
> +		efm_debug(efm_port, "fall back to location 0\n");
> +	}
> +
>  	ret = of_alias_get_id(np, "serial");
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
> @@ -738,10 +749,16 @@ static int efm32_uart_probe(struct platform_device *pdev)
>  	efm_port->port.flags = UPF_BOOT_AUTOCONF;
>  
>  	ret = efm32_uart_probe_dt(pdev, efm_port);
> -	if (ret > 0)
> +	if (ret > 0) {
>  		/* not created by device tree */
> +		const struct efm32_uart_pdata *pdata = dev_get_platdata(&pdev->dev);
> +
>  		efm_port->port.line = pdev->id;
>  
> +		if (pdata)
> +			efm_port->pdata = *pdata;
> +	}
> +
>  	if (efm_port->port.line >= 0 &&
>  			efm_port->port.line < ARRAY_SIZE(efm32_uart_ports))
>  		efm32_uart_ports[efm_port->port.line] = efm_port;
> -- 
> 1.7.10.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

--===============1478199060444048331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1478199060444048331==--
