From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] serial: 8250_of: Add reset support
Date: Wed, 24 May 2017 10:18:36 +0200
Message-ID: <1495613916.3840.16.camel@pengutronix.de>
References: <20170524045319.29926-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170524045319.29926-1-joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Joel,

On Wed, 2017-05-24 at 14:53 +1000, Joel Stanley wrote:
> This adds the hooks for an optional reset controller in the 8250 device
> tree node.
> 
> Signed-off-by: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt |  1 +
>  drivers/tty/serial/8250/8250_of.c                 | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index 10276a46ecef..63e32393f82b 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -45,6 +45,7 @@ Optional properties:
>    property.
>  - tx-threshold: Specify the TX FIFO low water indication for parts with
>    programmable TX FIFO thresholds.
> +- resets : phandle + reset specifier pairs
>  
>  Note:
>  * fsl,ns16550:
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 1cbadafc6889..f34dd23376f4 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -19,11 +19,13 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  
>  #include "8250.h"
>  
>  struct of_serial_info {
>  	struct clk *clk;
> +	struct reset_control *rst;
>  	int type;
>  	int line;
>  };
> @@ -132,6 +134,18 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		}
>  	}
>  
> +	info->rst = devm_reset_control_get_optional(&ofdev->dev, NULL);

Please use devm_reset_control_get_optional_shared instead.

This looks like shared (clock-like) reset use, where you just have to
make sure that the reset is deasserted while the module is in use, but
you don't care whether it is actually asserted all the time otherwise.

> +	if (IS_ERR(info->rst)) {
> +		ret = PTR_ERR(info->rst);
> +		if (ret == -EPROBE_DEFER)
> +			goto out;
> +		info->rst = NULL;

devm_reset_control_get_optional returns NULL if no reset is specified in
the device tree specifically so we don't have to do this in all the
drivers. If an error is returned, just goto out unconditionally, ...

> +	} else {
> +		ret = reset_control_deassert(info->rst);
> +		if (ret)
> +			goto out;
> +	}

... then reset_control_deassert can be called unconditionally, too.

> +
>  	port->type = type;
>  	port->uartclk = clk;
>  	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
> @@ -231,6 +245,8 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
>  
>  	if (info->clk)
>  		clk_disable_unprepare(info->clk);
> +	if (info->rst)

Not necessary, reset_control_assert checks this, too.

> +		reset_control_assert(info->rst);
>  	kfree(info);
>  	return 0;
>  }

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
