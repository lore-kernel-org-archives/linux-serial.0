From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 5/5] serial: lantiq: Add support for Lightning Mountain
 SoC
Date: Wed, 7 Aug 2019 16:31:23 +0300
Message-ID: <20190807133123.GZ30120@smile.fi.intel.com>
References: <cover.1565160764.git.rahul.tanwar@linux.intel.com>
 <a947355d6cf0ab71205e81779e1549f42f3f945a.1565160764.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a947355d6cf0ab71205e81779e1549f42f3f945a.1565160764.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, robh+dt@kernel.org, mark.rutland@arm.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 07, 2019 at 05:21:35PM +0800, Rahul Tanwar wrote:
> This patch adds IRQ & ISR support in the driver for Lightning Mountain SoC.

> +#define ASC_IRNCR_MASK		0x7

GENMASK() ?

> +static irqreturn_t lqasc_irq(int irq, void *p)
> +{
> +	unsigned long flags;
> +	u32 stat;
> +	struct uart_port *port = p;
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +
> +	spin_lock_irqsave(&ltq_port->lock, flags);
> +	stat = readl(port->membase + LTQ_ASC_IRNCR);
> +	if (!(stat & ASC_IRNCR_MASK)) {
> +		spin_unlock_irqrestore(&ltq_port->lock, flags);
> +		return IRQ_NONE;
> +	}

> +	spin_unlock_irqrestore(&ltq_port->lock, flags);

Are you sure the below does not need a serialization?

If it's not the case, you may unlock the lock immediately after readl().

> +
> +	if (stat & ASC_IRNCR_TIR)
> +		lqasc_tx_int(irq, p);
> +
> +	if (stat & ASC_IRNCR_RIR)
> +		lqasc_rx_int(irq, p);
> +
> +	if (stat & ASC_IRNCR_EIR)
> +		lqasc_err_int(irq, p);
> +
> +	return IRQ_HANDLED;
> +}

> +static int fetch_irq_intel(struct platform_device *pdev,
> +			   struct ltq_uart_port *ltq_port)
> +{
> +	struct uart_port *port = &ltq_port->port;
> +	int ret;
> +
> +	ret = of_irq_get(pdev->dev.of_node, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"failed to fetch IRQ for serial port\n");

> +		return -ENODEV;

	return ret;

> +	}
> +	ltq_port->common_irq = ret;
> +	port->irq = ret;
> +

> +	return ret;

Same as per patch 3, i.e.

	return 0;

> +}

> +static int request_irq_intel(struct uart_port *port)
> +{
> +	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
> +	int retval;
> +
> +	retval = request_irq(ltq_port->common_irq, lqasc_irq, 0,
> +			     "asc_irq", port);

> +	if (retval) {
> +		dev_err(port->dev, "failed to request asc_irq\n");
> +		return retval;
> +	}
> +
> +	return 0;

	if (retval)
		dev_err();

	return retval;

> +}

> +
> +

One blank line is enough.

-- 
With Best Regards,
Andy Shevchenko
