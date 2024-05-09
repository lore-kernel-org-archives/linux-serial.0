Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9F158D6D
	for <linux-serial@vger.kernel.org>; Thu,  9 May 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262597; cv=none; b=CAyzDKG17e3awk43Fg2M3Ff3/YxDmPNkBP9lIwOoAP8CftIUiC4YZML0xXtTdaxzxy080Cu+q3nEK+tkBR1pCczy+WFSWPc3J/RY5f8eHdjfRWuTrMJd/cd4EkfqwjjCuApvLzoIxWhNOWHGJSXNQdc3Ndejo7522LCZJRyLDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262597; c=relaxed/simple;
	bh=BmcvuQ8My17Fs9sOOwtPlAMsWQHncARfP0NuiXWIsZ4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMrg7YGcgelVd9G+t6Pc27GY0xmVWXSiUZ2Y4VSYVISvhr1jYP5dgO3oWohNBOg+X+WmnDKxOMQYg44cnS/d6GCKuTi06NrTe/xxJmBwPR6tBP1yDnj94H/Y5jFlgGPrCjh5jvytHGbbWjj8SugziGHLPs9ZEucrLgc2nDRtaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0214a224-0e0b-11ef-b972-005056bdfda7;
	Thu, 09 May 2024 16:49:52 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 9 May 2024 16:49:51 +0300
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 2/2] serial: 8250: Extract platform driver
Message-ID: <ZjzUfznxVkyWGPAx@surfacebook.localdomain>
References: <20240506140308.4040735-1-andriy.shevchenko@linux.intel.com>
 <20240506140308.4040735-3-andriy.shevchenko@linux.intel.com>
 <ZjxdR1UvNlB6ctDZ@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjxdR1UvNlB6ctDZ@sunil-laptop>

Thu, May 09, 2024 at 10:51:11AM +0530, Sunil V L kirjoitti:

> Many thanks for helping with this!. Just few questions below for my
> understanding.

You are welcome! Meanwhile, can you test these changes?

> On Mon, May 06, 2024 at 05:00:59PM +0300, Andy Shevchenko wrote:

...

> > +void __init serial8250_isa_init_ports(void)
> > +{
> > +	static int first = 1;
> > +	int i, irqflag = 0;
> > +
> > +	if (!first)
> > +		return;
> > +	first = 0;
> > +
> > +	if (nr_uarts > UART_NR)
> > +		nr_uarts = UART_NR;
> > +
> > +	/*
> > +	 * Set up initial isa ports based on nr_uart module param, or else
> > +	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
> > +	 * need to increase nr_uarts when setting up the initial isa ports.
> > +	 */
> > +	for (i = 0; i < nr_uarts; i++)
> > +		serial8250_setup_port(i);
> > +
> > +	/* chain base port ops to support Remote Supervisor Adapter */
> > +	univ8250_port_ops = *univ8250_port_base_ops;
> > +	univ8250_rsa_support(&univ8250_port_ops);
> > +
> > +	if (share_irqs)
> > +		irqflag = IRQF_SHARED;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(old_serial_port) && i < nr_uarts; i++) {
> > +		struct uart_8250_port *up = serial8250_get_port(i);
> > +		struct uart_port *port = &up->port;
> > +
> > +		port->iobase   = old_serial_port[i].port;
> > +		port->irq      = irq_canonicalize(old_serial_port[i].irq);
> > +		port->irqflags = 0;
> > +		port->uartclk  = old_serial_port[i].baud_base * 16;
> > +		port->flags    = old_serial_port[i].flags;
> > +		port->hub6     = 0;
> > +		port->membase  = old_serial_port[i].iomem_base;
> > +		port->iotype   = old_serial_port[i].io_type;
> > +		port->regshift = old_serial_port[i].iomem_reg_shift;
> > +
> > +		port->irqflags |= irqflag;
> > +		if (serial8250_isa_config != NULL)
> > +			serial8250_isa_config(i, &up->port, &up->capabilities);
> > +
> > +		serial_base_add_isa_preferred_console(serial8250_reg.dev_name, i);
> > +	}
> > +}
> > +
> > +/*
> > + * Register a set of serial devices attached to a platform device.  The
> > + * list is terminated with a zero flags entry, which means we expect
> > + * all entries to have at least UPF_BOOT_AUTOCONF set.
> > + */
> > +static int serial8250_probe(struct platform_device *dev)
> > +{
> > +	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);

> Not related to the change. But..
> How is this supposed to work? When serial8250_init creates this ISA
> platform device,
> it doesn't add any platdata. In that case, entire loop
> below appears dead code to me. Am I missing something?

Yes, you are. Here is the answer:
https://elixir.bootlin.com/linux/latest/C/ident/plat_serial8250_port

I.o.w. it depends on the platform and actual drivers that instantiate the
serial8250 platform device. You found only one case for which it's a dead
code, but not for many others.

> > +	struct uart_8250_port uart;
> > +	int ret, i, irqflag = 0;
> > +
> > +	memset(&uart, 0, sizeof(uart));
> > +
> > +	if (share_irqs)
> > +		irqflag = IRQF_SHARED;
> > +
> > +	for (i = 0; p && p->flags != 0; p++, i++) {
> > +		uart.port.iobase	= p->iobase;
> > +		uart.port.membase	= p->membase;
> > +		uart.port.irq		= p->irq;
> > +		uart.port.irqflags	= p->irqflags;
> > +		uart.port.uartclk	= p->uartclk;
> > +		uart.port.regshift	= p->regshift;
> > +		uart.port.iotype	= p->iotype;
> > +		uart.port.flags		= p->flags;
> > +		uart.port.mapbase	= p->mapbase;
> > +		uart.port.mapsize	= p->mapsize;
> > +		uart.port.hub6		= p->hub6;
> > +		uart.port.has_sysrq	= p->has_sysrq;
> > +		uart.port.private_data	= p->private_data;
> > +		uart.port.type		= p->type;
> > +		uart.bugs		= p->bugs;
> > +		uart.port.serial_in	= p->serial_in;
> > +		uart.port.serial_out	= p->serial_out;
> > +		uart.dl_read		= p->dl_read;
> > +		uart.dl_write		= p->dl_write;
> > +		uart.port.handle_irq	= p->handle_irq;
> > +		uart.port.handle_break	= p->handle_break;
> > +		uart.port.set_termios	= p->set_termios;
> > +		uart.port.set_ldisc	= p->set_ldisc;
> > +		uart.port.get_mctrl	= p->get_mctrl;
> > +		uart.port.pm		= p->pm;
> > +		uart.port.dev		= &dev->dev;
> > +		uart.port.irqflags	|= irqflag;
> > +		ret = serial8250_register_8250_port(&uart);
> > +		if (ret < 0) {
> > +			dev_err(&dev->dev, "unable to register port at index %d "
> > +				"(IO%lx MEM%llx IRQ%d): %d\n", i,
> > +				p->iobase, (unsigned long long)p->mapbase,
> > +				p->irq, ret);
> > +		}
> > +	}
> > +	return 0;
> > +}

> > +static struct platform_driver serial8250_isa_driver = {
> > +	.probe		= serial8250_probe,
> > +	.remove_new	= serial8250_remove,
> > +	.suspend	= serial8250_suspend,
> > +	.resume		= serial8250_resume,
> > +	.driver		= {
> > +		.name	= "serial8250",
> > +	},
> > +};
> > +
> > +/*
> > + * This "device" covers _all_ ISA 8250-compatible serial devices listed
> > + * in the table in include/asm/serial.h
> > + */
> > +struct platform_device *serial8250_isa_devs;
> > +
> > +static int __init serial8250_init(void)
> > +{
> > +	int ret;
> > +
> > +	if (nr_uarts == 0)
> > +		return -ENODEV;
> > +
> > +	serial8250_isa_init_ports();
> > +
> > +	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %s\n",
> > +		nr_uarts, str_enabled_disabled(share_irqs));
> > +
> > +#ifdef CONFIG_SPARC
> > +	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
> > +#else
> > +	serial8250_reg.nr = UART_NR;
> > +	ret = uart_register_driver(&serial8250_reg);
> > +#endif
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = serial8250_pnp_init();
> > +	if (ret)
> > +		goto unreg_uart_drv;
> > +
> > +	serial8250_isa_devs = platform_device_alloc("serial8250",
> > +						    PLAT8250_DEV_LEGACY);
> > +	if (!serial8250_isa_devs) {
> > +		ret = -ENOMEM;
> > +		goto unreg_pnp;
> > +	}
> > +
> > +	ret = platform_device_add(serial8250_isa_devs);
> > +	if (ret)
> > +		goto put_dev;
> > +
> > +	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
> > +
> > +	ret = platform_driver_register(&serial8250_isa_driver);
> > +	if (ret == 0)
> > +		goto out;
> > +
> > +	platform_device_del(serial8250_isa_devs);
> > +put_dev:
> > +	platform_device_put(serial8250_isa_devs);
> > +unreg_pnp:
> > +	serial8250_pnp_exit();
> > +unreg_uart_drv:
> > +#ifdef CONFIG_SPARC
> > +	sunserial_unregister_minors(&serial8250_reg, UART_NR);
> > +#else
> > +	uart_unregister_driver(&serial8250_reg);
> > +#endif
> > +out:
> > +	return ret;
> > +}
> > +module_init(serial8250_init);

...

> > +#ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
> > +#ifndef MODULE
> > +/* This module was renamed to 8250_core in 3.7.  Keep the old "8250" name
> > + * working as well for the module options so we don't break people.  We
> > + * need to keep the names identical and the convenient macros will happily
> > + * refuse to let us do that by failing the build with redefinition errors
> > + * of global variables.  So we stick them inside a dummy function to avoid
> > + * those conflicts.  The options still get parsed, and the redefined
> > + * MODULE_PARAM_PREFIX lets us keep the "8250." syntax alive.
> > + *
> > + * This is hacky.  I'm sorry.
> 
> Should this comment be updated?

Why? There is no change in this approach. It stays as it was.

> > + */
> > +static void __used s8250_options(void)
> > +{
> > +#undef MODULE_PARAM_PREFIX
> > +#define MODULE_PARAM_PREFIX "8250_core."
> > +
> > +	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
> > +	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
> > +	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
> > +}
> > +#else
> > +MODULE_ALIAS("8250_core");
> 
> Should this be 8250_platform or keeping it same for compatibility reason?

No. The module name is still 8250_core if you carefully check the Makefile.

> > +#endif
> > +#endif

...

> > -obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
> > +obj-$(CONFIG_SERIAL_8250)		+= 8250.o
> >  8250-y					:= 8250_core.o
> > +8250-y					+= 8250_platform.o
> >  8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
> >  8250-$(CONFIG_SERIAL_8250_RSA)		+= 8250_rsa.o
> > +
> > +obj-$(CONFIG_SERIAL_8250)		+= 8250_base.o
> 
> Curious to know why this is split?

The line

obj-$(X) += foo.o bar.o

means that if X=m, the foo and bar will be separate modules. Since we have a
few object files per each of them it's better to split them in Makefile in
order to have better readability and maintenance. It's pure done for these
purposes.

> Acked-by: Sunil V L <sunilvl@ventanamicro.com> 

Thank you, but I would prefer Tested-by as it is kinda intrusive change.
I tested it on Intel hardware but it might have (hidden) issues on other
setups.

> >  8250_base-y				:= 8250_port.o
> >  8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
> >  8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o

-- 
With Best Regards,
Andy Shevchenko


