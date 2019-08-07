From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 3/5] serial: lantiq: Make IRQ & ISR assignment dynamic
Date: Wed, 7 Aug 2019 16:29:57 +0300
Message-ID: <20190807132957.GY30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <6dd57ea99f734bd4e413f6913914c0a93c00f295.1565160764.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6dd57ea99f734bd4e413f6913914c0a93c00f295.1565160764.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:33PM +0800, Rahul Tanwar wrote:
> This driver/IP is reused across multiple SoCs. Older SoCs supported three
> separate IRQs for tx, rx & err interrupts. Newer Lightning Mountain SoC
> supports single IRQ for all of tx/rx/err interrupts. This patch modifies
> the driver design to support dynamic assignment of IRQ resources & ISRs
> based on devicetree node compatible entries.

> +struct ltq_soc_data {
> +	int	(*fetch_irq)(struct platform_device *pdev,
> +				 struct ltq_uart_port *ltq_port);

This can be simple

	int	(*fetch_irq)(struct device *dev, struct ltq_uart_port *ltq_port);

(Note one line and struct device instead of platform_device)

> +	int	(*request_irq)(struct uart_port *port);
> +	void	(*free_irq)(struct uart_port *port);
> +};

> +	retval = ltq_port->soc->request_irq(port);
> +	if(retval)

Space is missed.

>  		return retval;


> +static int fetch_irq_lantiq(struct platform_device *pdev,
> +			    struct ltq_uart_port *ltq_port)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct uart_port *port = &ltq_port->port;
> +	struct resource irqres[3];
> +	int ret;
> +
> +	ret = of_irq_to_resource_table(node, irqres, 3);
> +	if (ret != 3) {
> +		dev_err(&pdev->dev,
> +			"failed to get IRQs for serial port\n");
> +		return -ENODEV;
> +	}
> +	ltq_port->tx_irq = irqres[0].start;
> +	ltq_port->rx_irq = irqres[1].start;
> +	ltq_port->err_irq = irqres[2].start;
> +	port->irq = irqres[0].start;
> +

> +	return ret;

I'm not sure you need to return known value. 0 will be good enough...

> +}

> +	ltq_port->soc = of_device_get_match_data(&pdev->dev);
> +	ret = ltq_port->soc->fetch_irq(pdev, ltq_port);

> +	if (ret < 0)

...and thus simple...

	if (ret)

...may be used.

> +		return ret;

-- 
With Best Regards,
Andy Shevchenko
