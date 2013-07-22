From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH] ARM: S3C24XX: Add missing clkdev entries for s3c2440 UART
Date: Mon, 22 Jul 2013 13:39:29 +0900
Message-ID: <0b0201ce8695$7434f5c0$5c9ee140$@org>
References: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11909 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab3GVEjb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Jul 2013 00:39:31 -0400
In-reply-to: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, =?ISO-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, oselas@community.pengutronix.de, 'Chander Kashyap' <chander.kashyap@linaro.org>

Sylwester Nawrocki wrote:
> 
> This patch restores serial port operation which has been broken since
> commit 60e93575476f90a72146b51283f514da655410a7
> serial: samsung: enable clock before clearing pending interrupts during
> init
> 
> That commit only uncovered the real issue which was missing clkdev
> entries for the "uart" clocks on S3C2440. It went unnoticed so far
> because return value of clk API calls were not being checked at all
> in the samsung serial port driver.
> 
> This patch should be backported to at least 3.10 stable kernel, since
> the serial port has not been working on s3c2440 since 3.10-rc5.
> 
OK, will apply into -fixes and let me add 'stable' tree in Cc, thanks for
your suggestion :-)

> Cc: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> [on S3C2440 SoC based Mini2440 board]
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> ---
> 
> There seems to be something wrong with the process, as things are
> getting broken late in the -rc cycle.  It seems author of the above
> mentioned commit didn't test all 6 SoC series that the samsung
> serial driver handles.  While I can understand they might not have
> all required hardware it's a bit irritating that the patch that
> in practice caused regression appeared only on linux-serial mailing
> list. And it's not evident it was even tried to test it on all
> potentially affected platforms. It not clear on what platforms
> the patch has been tested.
> 
> My humble suggestion is, _please_ do send patches that affect multiple
> Samsung SoCs to linux-samsung@vger.kernel.org.  So there is better
> review and test exposure.  And we can reduce mess like this happening
> in the future.
> 
Absolutely!

Thanks,
Kukjin

> Thanks!
> Sylwester
> ---
>  arch/arm/mach-s3c24xx/clock-s3c2410.c      |  161
+++++++++++++++++--------
> ---
>  arch/arm/mach-s3c24xx/clock-s3c2440.c      |    3 +
>  arch/arm/plat-samsung/include/plat/clock.h |    5 +
>  3 files changed, 106 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2410.c b/arch/arm/mach-
> s3c24xx/clock-s3c2410.c
> index afa0267..d39d3c7 100644
> --- a/arch/arm/mach-s3c24xx/clock-s3c2410.c
> +++ b/arch/arm/mach-s3c24xx/clock-s3c2410.c
> @@ -119,66 +119,101 @@ static struct clk init_clocks_off[] = {
>  	}
>  };
> 
> -static struct clk init_clocks[] = {
> -	{
> -		.name		= "lcd",
> -		.parent		= &clk_h,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_LCDC,
> -	}, {
> -		.name		= "gpio",
> -		.parent		= &clk_p,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_GPIO,
> -	}, {
> -		.name		= "usb-host",
> -		.parent		= &clk_h,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_USBH,
> -	}, {
> -		.name		= "usb-device",
> -		.parent		= &clk_h,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_USBD,
> -	}, {
> -		.name		= "timers",
> -		.parent		= &clk_p,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_PWMT,
> -	}, {
> -		.name		= "uart",
> -		.devname	= "s3c2410-uart.0",
> -		.parent		= &clk_p,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_UART0,
> -	}, {
> -		.name		= "uart",
> -		.devname	= "s3c2410-uart.1",
> -		.parent		= &clk_p,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_UART1,
> -	}, {
> -		.name		= "uart",
> -		.devname	= "s3c2410-uart.2",
> -		.parent		= &clk_p,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_UART2,
> -	}, {
> -		.name		= "rtc",
> -		.parent		= &clk_p,
> -		.enable		= s3c2410_clkcon_enable,
> -		.ctrlbit	= S3C2410_CLKCON_RTC,
> -	}, {
> -		.name		= "watchdog",
> -		.parent		= &clk_p,
> -		.ctrlbit	= 0,
> -	}, {
> -		.name		= "usb-bus-host",
> -		.parent		= &clk_usb_bus,
> -	}, {
> -		.name		= "usb-bus-gadget",
> -		.parent		= &clk_usb_bus,
> -	},
> +static struct clk clk_lcd = {
> +	.name		= "lcd",
> +	.parent		= &clk_h,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_LCDC,
> +};
> +
> +static struct clk clk_gpio = {
> +	.name		= "gpio",
> +	.parent		= &clk_p,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_GPIO,
> +};
> +
> +static struct clk clk_usb_host = {
> +	.name		= "usb-host",
> +	.parent		= &clk_h,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_USBH,
> +};
> +
> +static struct clk clk_usb_device = {
> +	.name		= "usb-device",
> +	.parent		= &clk_h,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_USBD,
> +};
> +
> +static struct clk clk_timers = {
> +	.name		= "timers",
> +	.parent		= &clk_p,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_PWMT,
> +};
> +
> +struct clk s3c24xx_clk_uart0 = {
> +	.name		= "uart",
> +	.devname	= "s3c2410-uart.0",
> +	.parent		= &clk_p,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_UART0,
> +};
> +
> +struct clk s3c24xx_clk_uart1 = {
> +	.name		= "uart",
> +	.devname	= "s3c2410-uart.1",
> +	.parent		= &clk_p,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_UART1,
> +};
> +
> +struct clk s3c24xx_clk_uart2 = {
> +	.name		= "uart",
> +	.devname	= "s3c2410-uart.2",
> +	.parent		= &clk_p,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_UART2,
> +};
> +
> +static struct clk clk_rtc = {
> +	.name		= "rtc",
> +	.parent		= &clk_p,
> +	.enable		= s3c2410_clkcon_enable,
> +	.ctrlbit	= S3C2410_CLKCON_RTC,
> +};
> +
> +static struct clk clk_watchdog = {
> +	.name		= "watchdog",
> +	.parent		= &clk_p,
> +	.ctrlbit	= 0,
> +};
> +
> +static struct clk clk_usb_bus_host = {
> +	.name		= "usb-bus-host",
> +	.parent		= &clk_usb_bus,
> +};
> +
> +static struct clk clk_usb_bus_gadget = {
> +	.name		= "usb-bus-gadget",
> +	.parent		= &clk_usb_bus,
> +};
> +
> +static struct clk *init_clocks[] = {
> +	&clk_lcd,
> +	&clk_gpio,
> +	&clk_usb_host,
> +	&clk_usb_device,
> +	&clk_timers,
> +	&s3c24xx_clk_uart0,
> +	&s3c24xx_clk_uart1,
> +	&s3c24xx_clk_uart2,
> +	&clk_rtc,
> +	&clk_watchdog,
> +	&clk_usb_bus_host,
> +	&clk_usb_bus_gadget,
>  };
> 
>  /* s3c2410_baseclk_add()
> @@ -195,7 +230,6 @@ int __init s3c2410_baseclk_add(void)
>  {
>  	unsigned long clkslow = __raw_readl(S3C2410_CLKSLOW);
>  	unsigned long clkcon  = __raw_readl(S3C2410_CLKCON);
> -	struct clk *clkp;
>  	struct clk *xtal;
>  	int ret;
>  	int ptr;
> @@ -207,8 +241,9 @@ int __init s3c2410_baseclk_add(void)
> 
>  	/* register clocks from clock array */
> 
> -	clkp = init_clocks;
> -	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++, clkp++) {
> +	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++) {
> +		struct clk *clkp = init_clocks[ptr];
> +
>  		/* ensure that we note the clock state */
> 
>  		clkp->usage = clkcon & clkp->ctrlbit ? 1 : 0;
> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2440.c b/arch/arm/mach-
> s3c24xx/clock-s3c2440.c
> index 1069b56..aaf006d 100644
> --- a/arch/arm/mach-s3c24xx/clock-s3c2440.c
> +++ b/arch/arm/mach-s3c24xx/clock-s3c2440.c
> @@ -166,6 +166,9 @@ static struct clk_lookup s3c2440_clk_lookup[] = {
>  	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
>  	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
>  	CLKDEV_INIT(NULL, "clk_uart_baud3", &s3c2440_clk_fclk_n),
> +	CLKDEV_INIT("s3c2440-uart.0", "uart", &s3c24xx_clk_uart0),
> +	CLKDEV_INIT("s3c2440-uart.1", "uart", &s3c24xx_clk_uart1),
> +	CLKDEV_INIT("s3c2440-uart.2", "uart", &s3c24xx_clk_uart2),
>  	CLKDEV_INIT("s3c2440-camif", "camera", &s3c2440_clk_cam_upll),
>  };
> 
> diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-
> samsung/include/plat/clock.h
> index 254c3dd..63239f4 100644
> --- a/arch/arm/plat-samsung/include/plat/clock.h
> +++ b/arch/arm/plat-samsung/include/plat/clock.h
> @@ -83,6 +83,11 @@ extern struct clk clk_ext;
>  extern struct clksrc_clk clk_epllref;
>  extern struct clksrc_clk clk_esysclk;
> 
> +/* S3C24XX UART clocks */
> +extern struct clk s3c24xx_clk_uart0;
> +extern struct clk s3c24xx_clk_uart1;
> +extern struct clk s3c24xx_clk_uart2;
> +
>  /* S3C64XX specific clocks */
>  extern struct clk clk_h2;
>  extern struct clk clk_27m;
> --
> 1.7.4.1

