Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CD2F5307;
	Tue, 30 Sep 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233499; cv=none; b=AQ5ufq2LT6dqlVqtmRovxEgYDXWfkhMg+UtyQD1WPnXxozSxz2Ey9I+rOS2UU39BN16/Ohop50XJo5dXePKcxhK5eiGhhNZ9DklDIJPWRG6Ftx6EbtEfVdikD7yhEM4r1jiTTDHZzzgxIDWMBWJo3/ii3jgCcotqjjj9Vw+zjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233499; c=relaxed/simple;
	bh=7Pw8i8WlzDGlJGVApLRkH81R7XnMWVnLLLP0pk83u4g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JaDIaYHXvI7oMfQpWnR8G0791/wUPU+JPFdFo9Nf3AAINQkQBlhtJmshCsCy10LoU0eI1/Vd/7+ILIsjPNASbqRsJ1eFYnGXNOPsa6KjStSfFSU9p7E9yMqroS0gnzgR+szC9NRReHQtsu2W39X3rJOK+zcoSg4uyStFg7O9umc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZClELRAz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZClELRAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759233496; x=1790769496;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7Pw8i8WlzDGlJGVApLRkH81R7XnMWVnLLLP0pk83u4g=;
  b=ZClELRAzulZdzUbnniDbqzPUG1Sk1iVhExvZY9/+0iwEfUTUojiDBEV1
   X/cIooQCScI61eoUWN6YbkQRzdKuZZ6seQvOxvs4yGVIXJ9/75ArgUXvd
   WC9w8+VY7iTiQEprk3riqYB82zuup9zy7BuPurp1LLZAtj55S4HSr23Dw
   +SWDSyk3omW72yGoihvmcBxwxeaa8rwAwqrphRKsc9e91Qy48PeVN/vrT
   e6z7+YqDwHVNaX5QbsLmMbbIgBRvWs6J9AFQ96XMvb9sGayl3o5/kO9rn
   INekumZQtE81lyvZdppzVYBTwtNxUYBS0IjME6DuivmPH1tLlalzJ/myv
   g==;
X-CSE-ConnectionGUID: pTPY0bsHRQWotSOe+njBkg==
X-CSE-MsgGUID: r+nHa+u3Qp25EzhyeRSNRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72106435"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="72106435"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:58:16 -0700
X-CSE-ConnectionGUID: C3hKdtygTBOrVDhiwx92WQ==
X-CSE-MsgGUID: YJVuSa8wSPu9aUH79OebPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178908971"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:58:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Sep 2025 14:58:07 +0300 (EEST)
To: Binbin Zhou <zhoubinbin@loongson.cn>
cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
    Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
    Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
    loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
In-Reply-To: <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
Message-ID: <9cd368a1-4ba2-3b96-5cfe-0e600e77a3fe@linux.intel.com>
References: <cover.1758676290.git.zhoubinbin@loongson.cn> <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Sep 2025, Binbin Zhou wrote:

> Add the driver for on-chip UART used on Loongson family chips.
> 
> The hardware is similar to 8250, but there are the following
> differences:
>  - Some chips (such as Loongson-2K2000) have added a fractional division
>    register to obtain the required baud rate accurately, so the
>    {get,set}_divisor callback is overridden.
>  - Due to hardware defects, quirk handling is required for
>    UART_MCR/UART_MSR.
> 
> Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/tty/serial/8250/8250_loongson.c | 202 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c     |   8 +
>  drivers/tty/serial/8250/Kconfig         |  10 ++
>  drivers/tty/serial/8250/Makefile        |   1 +
>  include/uapi/linux/serial_core.h        |   1 +
>  5 files changed, 222 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_loongson.c
> 
> diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
> new file mode 100644
> index 000000000000..a114b4e6d5c3
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_loongson.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Serial Port driver for Loongson family chips
> + *
> + * Copyright (C) 2020-2025 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/reset.h>
> +
> +#include "8250.h"
> +
> +/* Divisor Latch Fraction Register */
> +#define LOONGSON_UART_DLF		0x2
> +
> +/* Flags */
> +#define LOONGSON_UART_HAS_FRAC		BIT(0)
> +#define LOONGSON_UART_QUIRK_MCR		BIT(1)
> +#define LOONGSON_UART_QUIRK_MSR		BIT(2)
> +
> +#define LS2K0500_UART_FLAG	(LOONGSON_UART_QUIRK_MCR | LOONGSON_UART_QUIRK_MSR)
> +#define LS2K1500_UART_FLAG	(LOONGSON_UART_HAS_FRAC | LOONGSON_UART_QUIRK_MCR)
> +
> +struct loongson_uart_data {
> +	int line;
> +	int mcr_invert;
> +	int msr_invert;
> +	struct reset_control *rst;
> +};
> +
> +static unsigned int serial_fixup(struct uart_port *p, unsigned int offset, unsigned int val)
> +{
> +	struct loongson_uart_data *ddata = p->private_data;
> +
> +	if (offset == UART_MCR)
> +		val ^= ddata->mcr_invert;
> +
> +	if (offset == UART_MSR)
> +		val ^= ddata->msr_invert;
> +
> +	return val;
> +}
> +
> +static u32 loongson_serial_in(struct uart_port *p, unsigned int offset)
> +{
> +	unsigned int val;
> +
> +	val = readb(p->membase + (offset << p->regshift));
> +
> +	return serial_fixup(p, offset, val);
> +}
> +
> +static void loongson_serial_out(struct uart_port *p, unsigned int offset, unsigned int value)
> +{
> +	offset <<= p->regshift;
> +	writeb(serial_fixup(p, offset, value), p->membase + offset);

This would be cleaner if you do that serial_fixup() on a preceeding line.

Include for writeb()?

> +}
> +
> +static unsigned int loongson_frac_get_divisor(struct uart_port *port, unsigned int baud,
> +					      unsigned int *frac)
> +{
> +	unsigned int quot;
> +
> +	quot = DIV_ROUND_CLOSEST((port->uartclk << 4), baud);

Missing include.

> +	*frac = FIELD_GET(GENMASK(7, 0), quot);
> +
> +	return FIELD_GET(GENMASK(15, 8), quot);

Please name the fields properly with defines.

You're also missing #include for GENMASK().

> +}
> +
> +static void loongson_frac_set_divisor(struct uart_port *port, unsigned int baud,
> +				      unsigned int quot, unsigned int quot_frac)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +
> +	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> +	serial_dl_write(up, quot);
> +	serial_port_out(port, LOONGSON_UART_DLF, quot_frac);
> +}
> +
> +static int loongson_uart_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port uart = {};
> +	struct loongson_uart_data *ddata;
> +	struct resource *res;
> +	unsigned int flags;
> +	int ret;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	uart.port.irq = platform_get_irq(pdev, 0);
> +	if (uart.port.irq < 0)
> +		return -EINVAL;
> +
> +	device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
> +
> +	spin_lock_init(&uart.port.lock);
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_IOREMAP;
> +	uart.port.iotype = UPIO_MEM;
> +	uart.port.regshift = 0;
> +	uart.port.dev = dev;
> +	uart.port.type = PORT_LOONGSON;
> +	uart.port.private_data = ddata;
> +
> +	uart.port.mapbase = res->start;
> +	uart.port.mapsize = resource_size(res);
> +	uart.port.serial_in = loongson_serial_in;
> +	uart.port.serial_out = loongson_serial_out;
> +
> +	flags = (uintptr_t)device_get_match_data(dev);

Perhaps flags should be unsigned long?

> +	if (flags & LOONGSON_UART_HAS_FRAC) {
> +		uart.port.get_divisor = loongson_frac_get_divisor;
> +		uart.port.set_divisor = loongson_frac_set_divisor;
> +	}
> +
> +	if (flags & LOONGSON_UART_QUIRK_MCR)
> +		ddata->mcr_invert |= (UART_MCR_RTS | UART_MCR_DTR);
> +
> +	if (flags & LOONGSON_UART_QUIRK_MSR)
> +		ddata->msr_invert |= (UART_MSR_CTS | UART_MSR_DSR);

I think it would be better to put these invert masks directly into a 
struct which is then put into .data. LOONGSON_UART_HAS_FRAC can be bool 
in that struct.

> +	ddata->rst = devm_reset_control_get_optional_shared(dev, NULL);
> +	if (IS_ERR(ddata->rst))
> +		return PTR_ERR(ddata->rst);
> +
> +	ret = reset_control_deassert(ddata->rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0) {
> +		reset_control_assert(ddata->rst);
> +		return ret;
> +	}
> +
> +	ddata->line = ret;
> +	platform_set_drvdata(pdev, ddata);
> +
> +	return 0;
> +}
> +
> +static void loongson_uart_remove(struct platform_device *pdev)
> +{
> +	struct loongson_uart_data *ddata = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(ddata->line);
> +	reset_control_assert(ddata->rst);
> +}
> +
> +static int loongson_uart_suspend(struct device *dev)
> +{
> +	struct loongson_uart_data *ddata = dev_get_drvdata(dev);
> +
> +	serial8250_suspend_port(ddata->line);
> +
> +	return 0;
> +}
> +
> +static int loongson_uart_resume(struct device *dev)
> +{
> +	struct loongson_uart_data *data = dev_get_drvdata(dev);
> +
> +	serial8250_resume_port(data->line);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(loongson_uart_pm_ops, loongson_uart_suspend,
> +				loongson_uart_resume);

Include? Please check if you miss even more includes beyond those I've 
highlighted here.

> +static const struct of_device_id loongson_uart_of_ids[] = {
> +	{ .compatible = "loongson,ls2k0500-uart", .data = (void *)LS2K0500_UART_FLAG },
> +	{ .compatible = "loongson,ls2k1500-uart", .data = (void *)LS2K1500_UART_FLAG },
> +	{ /* sentinel */ },

Nit, no need for comma in the terminator entry.

> +};
> +MODULE_DEVICE_TABLE(of, loongson_uart_of_ids);
> +
> +static struct platform_driver loongson_uart_driver = {
> +	.probe = loongson_uart_probe,
> +	.remove = loongson_uart_remove,
> +	.driver = {
> +		.name = "loongson-uart",
> +		.pm = pm_ptr(&loongson_uart_pm_ops),
> +		.of_match_table = loongson_uart_of_ids,
> +	},
> +};
> +
> +module_platform_driver(loongson_uart_driver);
> +
> +MODULE_DESCRIPTION("Loongson UART driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited.");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 719faf92aa8a..53efe841656f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 8, 16, 30},
>  		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> +	[PORT_LOONGSON] = {
> +		.name		= "Loongson",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +		.rxtrig_bytes   = {1, 4, 8, 14},
> +		.flags		= UART_CAP_FIFO,
> +	},

This is exactly identical to PORT_16550A. Just use PORT_16550A instead of 
adding a new one unnecessarily.

--
 i.

>  };
>  
>  /* Uart divisor latch read */
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index f64ef0819cd4..98236b3bec10 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -468,6 +468,16 @@ config SERIAL_8250_OMAP_TTYO_FIXUP
>  	  not booting kernel because the serial console remains silent in case
>  	  they forgot to update the command line.
>  
> +config SERIAL_8250_LOONGSON
> +	tristate "Loongson 8250 based serial port"
> +	depends on SERIAL_8250
> +	depends on LOONGARCH || COMPILE_TEST
> +	help
> +	  If you have a machine based on LoongArch CPU you can enable
> +	  its onboard serial ports by enabling this option. The option
> +	  is applicable to both devicetree and ACPI, say Y to this option.
> +	  If unsure, say N.
> +
>  config SERIAL_8250_LPC18XX
>  	tristate "NXP LPC18xx/43xx serial port support"
>  	depends on SERIAL_8250 && OF && (ARCH_LPC18XX || COMPILE_TEST)
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 513a0941c284..e318a3240789 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
>  obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
> +obj-$(CONFIG_SERIAL_8250_LOONGSON)	+= 8250_loongson.o
>  obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
>  obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
>  obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 9c007a106330..607cf060a72a 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -31,6 +31,7 @@
>  #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
>  #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
>  #define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
> +#define PORT_LOONGSON	31	/* Loongson 16550 UART */
>  
>  /*
>   * ARM specific type numbers.  These are not currently guaranteed
> 
