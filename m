Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BF15AAD6
	for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578628; cv=none; b=fQwxk2u6b1zRe6pAA3VXNvK3OQTXIYkFgbZD3g9/jCt/XZMR7PImMu5ufMwOvjnWkQ33tLjNYeImKEToUdaj4xOF6OVVEx5+DyIAZ5hm3LaiCJqB8qEHdZyNPxox/VWXsyk8/WuwXWESzBVeA9YFRUM8o8v9Ja4crSVs2SBhG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578628; c=relaxed/simple;
	bh=ZH2QndDVxXKun5T0YQ831uYRPaFGatEyken8xicj57c=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=H4BtKm+MbEy5039hjOYZa+pDsh2FVGQoO3Dj3AoT2J5eGNA/cJ7VtQKe9aKB/ZLUQLu1ygYxrn6nrutM+8Y6GIWUeP8WyKSH8uly2baNLrogLX/Q83vvQfu6xBkf/kPnBUo05K7ffHenUWyacUP4AbtH8viAuFYWKazWQVfes8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mz1XAu4B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mz1XAu4B"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-205722ba00cso46522845ad.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Sep 2024 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726578626; x=1727183426; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmpipaU5ffyWBh3m6fh3V3iGFrcojyzndJ3rQy5E5JM=;
        b=mz1XAu4BGRbr6IrTw0Dieok3tAeTzO7FLFn6Px45kSFTZBOQ8t74YZmy5RyqYmLYvV
         fRmj0Z8iXiD2ewC/z8VrFE+kYklw2c/Q1cM1tZB4Z5SdsQj3L/lKopxljjOLVohe7hQV
         mbTdTpel/XYiglljN4CsW7IunqRuQDAY1Onj1607CQr3PeMyTI3BXLPZqThne5KiDSrP
         a7q5KxwGaOse9mP3SCvwqyIJrBeMDKYGTVviEKv8SvfUmtkzNkvlYRy/XELQ1XPcLXnp
         HUQH1K4S2+qEErVVJbAbf2WYkq1bxIqZLOEAl9DmqHP6BvVQcFQRI1F6Jck4OFVQj6jI
         Fw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726578626; x=1727183426;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmpipaU5ffyWBh3m6fh3V3iGFrcojyzndJ3rQy5E5JM=;
        b=NKDDhW0GynS6v1P5/qKAguEjRtF0yD3OiU+GbJf8g41S2j0p+ukHjNl7JpW1YK8vfI
         BHwtrNbgNBNoSGna/ZAI3MmAMdhf4cRLBKkvJ4lyupjX8hNxWtuaN4zAK5daXFoSXDZ5
         k7PJi8wlnwZT0uxzir23q6sU13LQmTReKmlH0uKvqNNdaPoh1c/dC6CArtTgpTqIQNKW
         jPmelo1mJ0e6Xwvx3aetMKJVy6Rq6lu8AZPFIasA2ZN53BUU9Vs3Z+mKe8IWfHm18vsT
         8l5o3e888jGdXdxkQykLFgJAm1vzct7AAVDnT3iGd88aopVCRimUgvPBBDa+PnicbMPx
         dkpg==
X-Forwarded-Encrypted: i=1; AJvYcCUD4NKpqgtg1f/zNg5WDHhm/wtDeYflnT/sRu8fQbt0SCcpy2mq6acXWWwbjjbFMM7DmoP9lk+1mXcmSG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNBFBli2Uc/Y9JxGLfLoRHP0hUO07CM8rkzcSaMAVeSzMmIJJ
	x7Fy5aN+kHaiEMvw/HKdvazhYMGDc/RRXBxpUTTjP7Ll8b3Gw0ez7txv+UKFZKE=
X-Google-Smtp-Source: AGHT+IHr2PTsAEqZCBw/S1zvsTs5J8nFAVPnfPYChOs8eSgK4C2WuQJcW+CGfn1gsM2xolgbVSznbg==
X-Received: by 2002:a17:902:da84:b0:206:c911:9d75 with SMTP id d9443c01a7336-2076e3b2654mr255519565ad.20.1726578626018;
        Tue, 17 Sep 2024 06:10:26 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db10csm50158835ad.53.2024.09.17.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:10:25 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:10:25 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 06:10:18 PDT (-0700)
Subject:     Re: [PATCH] serial: 8250_platform: Enable generic 16550A platform devices
In-Reply-To: <20240730051218.767580-1-sunilvl@ventanamicro.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
  andriy.shevchenko@linux.intel.com, andrei.warkentin@intel.com, apatel@ventanamicro.com, ajones@ventanamicro.com,
  dfustini@tenstorrent.com, Sunil V L <sunilvl@ventanamicro.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <mhng-d52ac6ff-2221-4613-9fce-f73467495389@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

On Mon, 29 Jul 2024 22:12:18 PDT (-0700), Sunil V L wrote:
> Currently, 8250_platform driver is used only for devices with fixed
> serial ports (plat_serial8250_port). Extend this driver for any generic
> 16550A platform devices which can be probed using standard hardware
> discovery mechanisms like ACPI.
>
> This is required in particular for RISC-V which has non-PNP generic
> 16550A compatible UART that needs to be enumerated as ACPI platform
> device.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 77 +++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)


It seems a bit awkward that we need something RISC-V specific here.  I 
guess the idea is that we don't want to depend on PNP because we'd end 
up with a bunch of PCI dependencies as well?  That seems like kind of an 
odd way to do things, but I'm frequently suprised by ACPI stuff so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if someone was waiting for me...

> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index d5c8d851348d..bdfb16bed4f2 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -6,7 +6,9 @@
>   *	      PNP 8250/16550 ports
>   *	      "serial8250" platform devices
>   */
> +#include <linux/acpi.h>
>  #include <linux/array_size.h>
> +#include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/once.h>
> @@ -100,6 +102,65 @@ void __init serial8250_isa_init_ports(void)
>  	DO_ONCE(__serial8250_isa_init_ports);
>  }
>
> +/*
> + * Generic 16550A platform devices
> + */
> +static int serial8250_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port uart = { 0 };
> +	struct resource *regs;
> +	unsigned char iotype;
> +	int ret, line;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (regs) {
> +		uart.port.iobase = regs->start;
> +		iotype = UPIO_PORT;
> +	} else {
> +		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!regs) {
> +			dev_err(dev, "no registers defined\n");
> +			return -EINVAL;
> +		}
> +
> +		uart.port.mapbase = regs->start;
> +		uart.port.mapsize = resource_size(regs);
> +		uart.port.flags = UPF_IOREMAP;
> +		iotype = UPIO_MEM;
> +	}
> +
> +	/* Default clock frequency*/
> +	uart.port.uartclk = 1843200;
> +	uart.port.type = PORT_16550A;
> +	uart.port.dev = &pdev->dev;
> +	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
> +	ret = uart_read_and_validate_port_properties(&uart.port);
> +	/* no interrupt -> fall back to polling */
> +	if (ret == -ENXIO)
> +		ret = 0;
> +	if (ret)
> +		return ret;
> +
> +	if (uart.port.mapbase) {
> +		uart.port.membase = devm_ioremap(dev, uart.port.mapbase, uart.port.mapsize);
> +		if (!uart.port.membase)
> +			return -ENOMEM;
> +	}
> +
> +	/*
> +	 * The previous call may not set iotype correctly when reg-io-width
> +	 * property is absent and it doesn't support IO port resource.
> +	 */
> +	uart.port.iotype = iotype;
> +
> +	line = serial8250_register_8250_port(&uart);
> +	if (line < 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  /*
>   * Register a set of serial devices attached to a platform device.  The
>   * list is terminated with a zero flags entry, which means we expect
> @@ -110,6 +171,15 @@ static int serial8250_probe(struct platform_device *dev)
>  	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
>  	struct uart_8250_port uart;
>  	int ret, i, irqflag = 0;
> +	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
> +
> +	/*
> +	 * Probe platform UART devices defined using standard hardware
> +	 * discovery mechanism like ACPI or DT. Support only ACPI based
> +	 * serial device for now.
> +	 */
> +	if (!p && is_acpi_node(fwnode))
> +		return serial8250_platform_probe(dev);
>
>  	memset(&uart, 0, sizeof(uart));
>
> @@ -198,6 +268,12 @@ static int serial8250_resume(struct platform_device *dev)
>  	return 0;
>  }
>
> +static const struct acpi_device_id acpi_platform_serial_table[] = {
> +	{ "RSCV0003", 0 }, // RISC-V Generic 16550A UART
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
> +
>  static struct platform_driver serial8250_isa_driver = {
>  	.probe		= serial8250_probe,
>  	.remove_new	= serial8250_remove,
> @@ -205,6 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
>  	.resume		= serial8250_resume,
>  	.driver		= {
>  		.name	= "serial8250",
> +		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
>  	},
>  };
