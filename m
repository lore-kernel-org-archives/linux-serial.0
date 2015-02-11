From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 1/2] serial: imx: Add rs485 support to imx thanks to rs485 functions in serial_core
Date: Wed, 11 Feb 2015 16:55:08 +0100
Message-ID: <1751665.Y0gNN9yM78@ws-stein>
References: <1423668635-30838-1-git-send-email-a.bouin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423668635-30838-1-git-send-email-a.bouin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aurelien BOUIN <a.bouin@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, sascha@saschahauer.de, festevam@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Wednesday 11 February 2015 16:30:34, Aurelien BOUIN wrote:
> This is a patch to add rs485 support with imx freescale processor
> It allows to set the transmit pin used in the structure padding (rs485.padding[0])

Nice idea to use the padding for GPIO configuration. I've done an implementation using board-specific call-backs which doesn't work with DT.

> Signed-off-by: Aurelien BOUIN <a.bouin@gmail.com>
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 4c5e909..a086eef 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -53,6 +53,8 @@
>  #include <asm/irq.h>
>  #include <linux/platform_data/serial-imx.h>
>  #include <linux/platform_data/dma-imx.h>
> +#include <linux/uaccess.h>
> +#include <linux/gpio.h>
>  
>  /* Register definitions */
>  #define URXD0 0x0  /* Receiver Register */
> @@ -280,6 +282,56 @@ static struct of_device_id imx_uart_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
>  
> +static inline struct imx_port *to_imx_port(struct uart_port *uart)
> +{
> +	return container_of(uart, struct imx_port, port);
> +}
> +
> +static void imx_rs485_stop_tx(struct imx_port *imx_uart_port)
> +{
> +	/*
> +	 * Deactivate transmit pin configured in the structure padding
> +	 */
> +	gpio_set_value(imx_uart_port->port.rs485.padding[0], 0);
> +}
> +
> +static void imx_rs485_start_tx(struct imx_port *imx_uart_port)
> +{
> +	/*
> +	 * Activate transmit pin configured in the structure padding
> +	 */
> +	gpio_set_value(imx_uart_port->port.rs485.padding[0], 1);
> +}

Please add the feature to support active-low GPIOs, e.g. using rs485.padding[1].

> +/* Enable or disable the rs485 support */
> +static int imx_config_rs485(struct uart_port *port,
> +		struct serial_rs485 *rs485conf)
> +{
> +	port->rs485 = *rs485conf;
> +	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		int ret;
> +
> +		dev_dbg(port->dev, "Setting UART /dev/ttymxc%d with the pin 0x%x to RS485\n",
> +				port->line, port->rs485.padding[0]);
> +		/*
> +		 * Set the transmit pin configured in the structure padding
> +		 * in GPIO output
> +		 */
> +		ret = gpio_request(port->rs485.padding[0], "RS485 transmit");
> +		if (ret)
> +			dev_err(port->dev, "Unable to request the RS485 transmit %d\n",
> +					port->rs485.padding[0]);
> +		gpio_direction_output(port->rs485.padding[0], 0);
> +
> +	} else {
> +		dev_dbg(port->dev, "Setting UART /dev/ttymxc%d to RS232\n",
> +				port->line);
> +		if (port->rs485.padding[0])
> +			gpio_free(port->rs485.padding[0]);
> +	}
> +	return 0;
> +}
> +
>  static inline unsigned uts_reg(struct imx_port *sport)
>  {
>  	return sport->devdata->uts_reg;
> @@ -580,6 +632,15 @@ static void imx_start_tx(struct uart_port *port)
>  	struct imx_port *sport = (struct imx_port *)port;
>  	unsigned long temp;
>  
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		imx_rs485_start_tx(sport);
> +		/*
> +		 * Transmit complete interrupt change to receiver mode
> +		 */
> +		temp = readl(sport->port.membase + UCR4);
> +		writel(temp | UCR4_TCEN, sport->port.membase + UCR4);
> +	}
> +

If you run a RT-PREEMPT kernel, interrupts aren't actually disabled here. So when you enable the TXDC interrupt here, it will fire up immediately.
Move that after calling imx_transmit_buffer so you are sure there are actually characters inserted.

>  	if (USE_IRDA(sport)) {
>  		/* half duplex in IrDA mode; have to disable receive mode */
>  		temp = readl(sport->port.membase + UCR4);
> @@ -693,8 +754,10 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
>  					goto out;
>  				continue;
>  			}
> -
> -			rx &= sport->port.read_status_mask;
> +			/*
> +			 * Preserve characters with parity or framing errors
> +			 */
> +			rx &= sport->port.read_status_mask | 0xFF;
>  
>  			if (rx & URXD_BRK)
>  				flg = TTY_BREAK;
> @@ -747,8 +810,30 @@ static irqreturn_t imx_int(int irq, void *dev_id)
>  	struct imx_port *sport = dev_id;
>  	unsigned int sts;
>  	unsigned int sts2;
> +	unsigned int cr1, cr2, cr3, cr4;
>  
>  	sts = readl(sport->port.membase + USR1);
> +	sts2 = readl(sport->port.membase + USR2);
> +	cr1 = readl(sport->port.membase + UCR1);
> +	cr2 = readl(sport->port.membase + UCR2);
> +	cr3 = readl(sport->port.membase + UCR3);
> +	cr4 = readl(sport->port.membase + UCR4);
> +
> +	if (sport->port.rs485.flags & SER_RS485_ENABLED)	{
> +		/*
> +		 * Check if the transmit is complete
> +		 */
> +		if ((cr4 & UCR4_TCEN) && (sts2 & USR2_TXDC)) {

Can this actually happen that UCR4_TCEN is unset when in S485 mode?

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
