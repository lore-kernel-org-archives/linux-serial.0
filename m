From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] modify pl011 driver to let it work as wakeup source
Date: Thu, 17 Sep 2015 11:31:26 +0100
Message-ID: <20150917103126.GM21084@n2100.arm.linux.org.uk>
References: <1442478716-7377-1-git-send-email-zhaoyang.huang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442478716-7377-1-git-send-email-zhaoyang.huang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 17, 2015 at 04:31:56PM +0800, Zhaoyang Huang wrote:
> +struct uart_match {
> +	struct uart_port *port;
> +	struct uart_driver *driver;
> +};
> +
> +static int match_uart_port(struct device *dev, void *data)
> +{
> +	struct uart_match *match = data;
> +
> +	dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
> +		match->port->line;
> +
> +	pr_info("the match data of ttyAMA0 is %d %d\n",
> +			(int)devt, (int)dev->devt);
> +
> +	return dev->devt == devt; /* Actually, only one tty per port */
> +}
...
> +	ret = pl011_register_port(uap);
> +
> +	if (!of_find_property(dev->dev.of_node, "linux,wakeup", NULL)) {
> +		uart_dev = NULL;
> +		return ret;
> +	}
> +
> +	match.port = &uap->port;
> +	match.driver = &amba_reg;
> +
> +	uart_dev = device_find_child(&dev->dev, &match, match_uart_port);
> +
> +	if (uart_dev) {
> +		device_init_wakeup(uart_dev, true);
> +		dev_pm_set_wake_irq(uart_dev, uap->port.irq);
> +	}
> +
> +	return ret;

I can only describe this code as a hack.  This looks like something
which should be handled by generic infrastructure at an appropriate
point (somewhere inside uart_add_one_port()), not by hacky code in
each driver.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
