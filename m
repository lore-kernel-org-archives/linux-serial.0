From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/4] ARM: davinci: uart: move to dev_id based clk_get
Date: Fri, 26 Apr 2013 12:31:53 +0530
Message-ID: <517A2661.3000605@ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com> <1365510664-1394-2-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab3DZHCh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 03:02:37 -0400
In-Reply-To: <1365510664-1394-2-git-send-email-prakash.pm@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org

Hi Prakash,

On 4/9/2013 6:01 PM, Manjunathappa, Prakash wrote:
> For modules having single clock, clk_get should be done with dev_id.
> But current davinci implementation handles multiple instances
> of the UART devices with single platform_device_register. Hence clk_get
> is based on con_id rather than dev_id, this is not correct. Do
> platform_device_register for each instance and clk_get on dev_id.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  arch/arm/mach-davinci/da830.c                  |    8 ++--
>  arch/arm/mach-davinci/da850.c                  |    8 ++--
>  arch/arm/mach-davinci/devices-da8xx.c          |   40 ++++++++++++++++---
>  arch/arm/mach-davinci/devices-tnetv107x.c      |   35 ++++++++++++++---
>  arch/arm/mach-davinci/dm355.c                  |   48 ++++++++++++++++++-----
>  arch/arm/mach-davinci/dm365.c                  |   35 ++++++++++++----
>  arch/arm/mach-davinci/dm644x.c                 |   48 ++++++++++++++++++-----
>  arch/arm/mach-davinci/dm646x.c                 |   49 +++++++++++++++++++-----
>  arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
>  arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +-
>  arch/arm/mach-davinci/serial.c                 |   19 ++++++---
>  arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
>  12 files changed, 230 insertions(+), 72 deletions(-)

[...]

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index fc50243..eec7132 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -67,7 +67,7 @@
>  void __iomem *da8xx_syscfg0_base;
>  void __iomem *da8xx_syscfg1_base;
>  
> -static struct plat_serial8250_port da8xx_serial_pdata[] = {
> +static struct plat_serial8250_port da8xx_serial_pdata0[] = {

da8xx_serial0_pdata is more appropriate. Likewise for other entries below.

>  	{
>  		.mapbase	= DA8XX_UART0_BASE,
>  		.irq		= IRQ_DA8XX_UARTINT0,
> @@ -77,6 +77,11 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
>  		.regshift	= 2,
>  	},
>  	{
> +		.flags	= 0,
> +	},

No need of trailing ',' on sentinel. No need of the zero initialization.
Here and other places below.

> +};
> +static struct plat_serial8250_port da8xx_serial_pdata1[] = {
> +	{
>  		.mapbase	= DA8XX_UART1_BASE,
>  		.irq		= IRQ_DA8XX_UARTINT1,
>  		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
> @@ -85,6 +90,11 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
>  		.regshift	= 2,
>  	},
>  	{
> +		.flags	= 0,
> +	},
> +};
> +static struct plat_serial8250_port da8xx_serial_pdata2[] = {
> +	{
>  		.mapbase	= DA8XX_UART2_BASE,
>  		.irq		= IRQ_DA8XX_UARTINT2,
>  		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
> @@ -97,11 +107,29 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
>  	},
>  };
>  
> -struct platform_device da8xx_serial_device = {
> -	.name	= "serial8250",
> -	.id	= PLAT8250_DEV_PLATFORM,
> -	.dev	= {
> -		.platform_data	= da8xx_serial_pdata,
> +struct platform_device da8xx_serial_device[] = {
> +	{
> +		.name	= "serial8250",
> +		.id	= PLAT8250_DEV_PLATFORM,
> +		.dev	= {
> +			.platform_data	= da8xx_serial_pdata0,
> +		},
> +	},
> +	{
> +		.name	= "serial8250",
> +		.id	= PLAT8250_DEV_PLATFORM1,
> +		.dev	= {
> +			.platform_data	= da8xx_serial_pdata1,
> +		},
> +	},
> +	{
> +		.name	= "serial8250",
> +		.id	= PLAT8250_DEV_PLATFORM2,
> +		.dev	= {
> +			.platform_data	= da8xx_serial_pdata2,
> +		},
> +	},
> +	{
>  	},
>  };

[...]

> diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
> index f262581..57e6150 100644
> --- a/arch/arm/mach-davinci/serial.c
> +++ b/arch/arm/mach-davinci/serial.c
> @@ -76,7 +76,7 @@ int __init davinci_serial_setup_clk(unsigned instance, unsigned int *rate)
>  	char name[16];
>  	struct clk *clk;
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
> -	struct device *dev = &soc_info->serial_dev->dev;
> +	struct device *dev = &soc_info->serial_dev[instance].dev;
>  
>  	sprintf(name, "uart%d", instance);
>  	clk = clk_get(dev, name);

Why not pass con_id = NULL now?

> @@ -96,19 +96,25 @@ int __init davinci_serial_setup_clk(unsigned instance, unsigned int *rate)
>  
>  int __init davinci_serial_init(struct davinci_uart_config *info)
>  {
> -	int i, ret;
> +	int i, ret = 0;
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
> -	struct device *dev = &soc_info->serial_dev->dev;
> -	struct plat_serial8250_port *p = dev->platform_data;
> +	struct device *dev;
> +	struct plat_serial8250_port *p;
>  
>  	/*
>  	 * Make sure the serial ports are muxed on at this point.
>  	 * You have to mux them off in device drivers later on if not needed.
>  	 */
> -	for (i = 0; p->flags; i++, p++) {
> +	for (i = 0; soc_info->serial_dev[i].dev.platform_data != NULL; i++) {
> +		dev = &soc_info->serial_dev[i].dev;
> +		p = dev->platform_data;
>  		if (!(info->enabled_uarts & (1 << i)))
>  			continue;
>  
> +		ret = platform_device_register(&soc_info->serial_dev[i]);
> +		if (ret)
> +			continue;
> +
>  		ret = davinci_serial_setup_clk(i, &p->uartclk);
>  		if (ret)
>  			continue;
> @@ -125,6 +131,5 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
>  		if (p->membase && p->type != PORT_AR7)
>  			davinci_serial_reset(p);
>  	}
> -
> -	return platform_device_register(soc_info->serial_dev);
> +	return ret;
>  }

Now that we are overhauling this part of code, some improvements can be
done. First, get rid of struct davinci_uart_config. None of the board
files use it meaningfully and we know we are not going to have more
board files. Second, make davinci_serial_init() take pointer to serial
platform device directly. This eliminates need for serial_dev in the
soc_info structure (yay!). You might also find that
davinci_serial_setup_clk() can be eliminated as well since there is not
much to do there now.

Thanks,
Sekhar
