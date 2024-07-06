Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B517FE;
	Sat,  6 Jul 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305210; cv=none; b=DBho0tzatoUxpGCOhwIkl/FUi741UCPivO4z6v39vQLf2+El6OOWQqfnwmHq07cy3j4iqKo7ejUT1yXbUyGMox3tP0fzqbjJvRYNsma8yOTEBOqFtWWmP2M+A/wCjjqXpBvSge2QGz3Zn0ZICqIAt6k7n/3eVIE7i1PORad8y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305210; c=relaxed/simple;
	bh=6ogLfKXpH1oZvu0O+Prwwmg1cXHqXPIOQKwIGiMO49E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnWRISTC8PZaVZOizAxy+VmOtEZY8R4iVvZuzG0apBOM3ESIky74f5oMkU3uASXthxyQ8mOIy1c84X/P9mDYZu59i09/xcC53Num9GKT/20vNM0N+L2UxlZbON0p6e61Ck77JBdnhWsJV+SMhPk08H8/UT70u7V/X6xVEsEJF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sat, 6 Jul 2024 22:33:23 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial: 8250: move mmp|pxa uart earlycon code and add
 xscale earlycon
Message-ID: <20240706223323.GYA367.dlan.gentoo>
References: <20240706101856.3077-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706101856.3077-1-jszhang@kernel.org>

Hi 
On 18:18 Sat 06 Jul     , Jisheng Zhang wrote:
> There are two other drivers that bind to "mrvl,mmp-uart": the 8250_of
> and the 8250_pxa. The previous one is generic and the latter is binded
> to ARCH_PXA || ARCH_MMP. Now we may have pxa programming compatible
> HW to support, making use of the generic 8250_of seems a good idea.
> However, there's no earlycon support if we go with this solution. So
> move the mmp|pxa-uart earlycon code to core 8250_early.c.
> 
> At the same, add xscale earlycon support too, only build test since
> I have no xscale machine any more.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_early.c | 11 +++++++++++
>  drivers/tty/serial/8250/8250_pxa.c   | 16 ----------------
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index e3f482fd3de4..6176083d0341 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -171,6 +171,17 @@ OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
>  
> +static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
> +					     const char *options)
> +{
> +	device->port.regshift = 2;
just wondering if possible to introduce a generic earlycon sub option? so kernel
can parse reg-shift from command line parameter instead of hardcoding here,
which would benefit more drivers (potentially without adding more OF_EARLYCON_DECLAREs..)

I mean something like this:
Documentation/admin-guide/kernel-parameters.txt
uart[8250],mmio32,<addr>[,options[,reg-shift=0,1,2,4 ..]]

> +
> +	return early_serial8250_setup(device, options);
> +}
> +OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_rs2_setup);
> +OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_rs2_setup);
> +OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_rs2_setup);
> +
>  #ifdef CONFIG_SERIAL_8250_OMAP
>  
>  static int __init early_omap8250_setup(struct earlycon_device *device,
> diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
> index ba96fa913e7f..b5d937f6f3f9 100644
> --- a/drivers/tty/serial/8250/8250_pxa.c
> +++ b/drivers/tty/serial/8250/8250_pxa.c
> @@ -165,22 +165,6 @@ static struct platform_driver serial_pxa_driver = {
>  
>  module_platform_driver(serial_pxa_driver);
>  
> -#ifdef CONFIG_SERIAL_8250_CONSOLE
> -static int __init early_serial_pxa_setup(struct earlycon_device *device,
> -				  const char *options)
> -{
> -	struct uart_port *port = &device->port;
> -
> -	if (!(device->port.membase || device->port.iobase))
> -		return -ENODEV;
> -
> -	port->regshift = 2;
> -	return early_serial8250_setup(device, NULL);
> -}
> -OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
> -OF_EARLYCON_DECLARE(mmp, "mrvl,mmp-uart", early_serial_pxa_setup);
> -#endif
> -
>  MODULE_AUTHOR("Sergei Ianovich");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:pxa2xx-uart");
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
