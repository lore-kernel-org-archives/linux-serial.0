From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] serial: pl011: honour serial aliases in device tree
Date: Tue, 21 Aug 2012 08:26:15 -0500
Message-ID: <50338C77.4060700@gmail.com>
References: <1345544302-12406-1-git-send-email-matthew.leach@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53666 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2HUN0U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 09:26:20 -0400
Received: by obbuo13 with SMTP id uo13so11188365obb.19
        for <linux-serial@vger.kernel.org>; Tue, 21 Aug 2012 06:26:19 -0700 (PDT)
In-Reply-To: <1345544302-12406-1-git-send-email-matthew.leach@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Leach <matthew.leach@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>

On 08/21/2012 05:18 AM, Matthew Leach wrote:
> If the order of UART nodes is changed in the device tree, then tty dev
> devices are attached to different serial ports causing the console to
> be directed to a different physical serial port. The "serial" aliases
> in the device tree should prevent this.
> 
> This patch ensures that the UART driver creates tty devices that
> honour these aliases if a device tree is present.
> 
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>

One comment/question below, but otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/tty/serial/amba-pl011.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index c17923e..5919599 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -52,6 +52,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/delay.h>
>  #include <linux/types.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  
>  #include <asm/io.h>
> @@ -1869,6 +1870,42 @@ static struct uart_driver amba_reg = {
>  	.cons			= AMBA_CONSOLE,
>  };
>  
> +#ifdef CONFIG_OF

Now that we have IS_ENABLED, perhaps we want to put this inside the
function instead?

if (!IS_ENABLED(CONFIG_OF))
	return index;


> +static int pl011_probe_dt_alias(int index, struct device *dev)
> +{
> +	struct device_node *np;
> +	static bool seen_dev_with_alias = false;
> +	static bool seen_dev_without_alias = false;
> +	int ret = index;
> +
> +	np = dev->of_node;
> +	if (!np)
> +		return ret;
> +
> +	ret = of_alias_get_id(np, "serial");
> +	if (IS_ERR_VALUE(ret)) {
> +		seen_dev_without_alias = true;
> +		ret = index;
> +	} else {
> +		seen_dev_with_alias = true;
> +		if (ret >= ARRAY_SIZE(amba_ports) || amba_ports[ret] != NULL) {
> +			dev_warn(dev, "requested serial port %d  not available.\n", ret);
> +			ret = index;
> +		}
> +	}
> +
> +	if (seen_dev_with_alias && seen_dev_without_alias)
> +		dev_warn(dev, "aliased and non-aliased serial devices found in device tree. Serial port enumeration may be unpredictable.\n");
> +
> +	return ret;
> +}
> +#else
> +static int pl011_probe_dt_alias(int index, struct device *dev)
> +{
> +	return index;
> +}
> +#endif
> +
>  static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  {
>  	struct uart_amba_port *uap;
> @@ -1891,6 +1928,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  		goto out;
>  	}
>  
> +	i = pl011_probe_dt_alias(i, &dev->dev);
> +
>  	base = ioremap(dev->res.start, resource_size(&dev->res));
>  	if (!base) {
>  		ret = -ENOMEM;
> 

