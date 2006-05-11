From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Thu, 11 May 2006 23:20:01 +0100
Message-ID: <20060511222001.GC28693@flint.arm.linux.org.uk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33289 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750826AbWEKWm1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 May 2006 18:42:27 -0400
Content-Disposition: inline
In-Reply-To: <87ac9o3ak3.fsf@sleipner.barco.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org

On Thu, May 11, 2006 at 04:23:08PM +0200, Peter Korsgaard wrote:
> The hardware is very simple (baudrate/start/stopbits fixed and
> no break support). See the datasheet for details:
> 
> http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
> 
> Comments and suggestions are welcome. I'm especially wondering about
> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
> driver ..

That's for the mpc52xx folk to comment about.  I personally don't like
it.

> +static inline unsigned int serial_in(struct uart_port *port, int offset)
> +{
> +	return readb(port->membase + offset);
> +}
> +
> +static inline void serial_out(struct uart_port *port, int offset, int value)
> +{
> +	writeb(value, port->membase + offset);
> +}

Since there's no additional complication here, do you need separate
serial_in/serial_out inline functions?

> +static void ulite_stop_rx(struct uart_port *port)
> +{
> +	/* N/A */

It would probably be a good idea to set a flag so that your interrupt
handler can discard any input received after this function is called,
rather than adding it into the ldisc queue regardless.

> +}
> +
> +static void ulite_enable_ms(struct uart_port *port)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_break_ctl(struct uart_port *port, int ctl)
> +{
> +	/* N/A */
> +}
> +
> +static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = (struct uart_port *)dev_id;
> +	struct tty_struct *tty = port->info->tty;
> +	struct circ_buf *xmit  = &port->info->xmit;
> +	int busy;
> +
> +	do {
> +		int stat = serial_in(port, ULITE_STATUS);
> +
> +		busy = 0;
> +
> +		if (stat & (ULITE_STATUS_OVERRUN | ULITE_STATUS_FRAME
> +			    | ULITE_STATUS_RXVALID)) {
> +			busy = 1;
> +
> +			if (stat & ULITE_STATUS_OVERRUN) {
> +				tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +				port->icount.overrun++;
> +			}
> +
> +			if (stat & ULITE_STATUS_FRAME) {
> +				tty_insert_flip_char(tty, 0, TTY_FRAME);
> +				port->icount.frame++;
> +			}

No proper handling of these special conditions - drivers are expected
to take note of the termios settings and do the expected thing.  You
can't rely on the tty layer to discard overrun, parity or frame
conditions if they're not required.

> +static void ulite_console_write(struct console *co, const char *s,
> +				unsigned int count)
> +{
> +	struct uart_port *port = &ports[co->index];
> +	int i;
> +
> +	/* disable interrupts */
> +	serial_out(port, ULITE_CONTROL, 0);
> +
> +	for (i = 0; i < count; i++) {
> +		/* line return handling */
> +		if (*s == '\n')
> +			serial_out(port, ULITE_TX, '\r');
> +
> +		serial_out(port, ULITE_TX, *s++);
> +
> +		/* wait until it's sent */
> +		while (!(serial_in(port, ULITE_STATUS)
> +			 & ULITE_STATUS_TXEMPTY)) ;
> +	}

Should be using uart_console_write().

> +static int __devinit ulite_probe(struct platform_device *pdev)
> +{
> +	struct resource *res, *res2;
> +	struct uart_port *port;
> +	int ret;
> +
> +	if (pdev->id < 0 || pdev->id >= CONFIG_SERIAL_UARTLITE_NR_UARTS)
> +		return -EINVAL;
> +
> +	if (ports[pdev->id].iobase)
> +		return -EBUSY;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res2)
> +		return -ENODEV;
> +
> +	port = &ports[pdev->id];
> +
> +	port->fifosize	= 16;
> +	port->regshift	= 2;
> +	port->iotype	= UPIO_MEM;
> +	port->iobase	= 1; /* mark port in use */

No.  If iobase isn't used, set it to zero.

> +	port->mapbase	= res->start;
> +	port->ops	= &ulite_ops;
> +	port->irq	= res2->start;
> +	port->flags	= UPF_BOOT_AUTOCONF;
> +	port->dev	= &pdev->dev;
> +
> +	if (!request_mem_region(res->start, res->end - res->start + 1,
> +				pdev->name)) {
> +		dev_err(&pdev->dev, "Memory region busy\n");
> +		ret = -EBUSY;
> +		goto request_mem_failed;
> +	}
> +
> +	port->membase = ioremap(res->start, res->end - res->start + 1);
> +	if (!port->membase) {
> +		dev_err(&pdev->dev, "Unable to map registers\n");
> +		ret = -EIO;
> +		goto map_failed;
> +	}
> +
> +	uart_add_one_port(&ulite_uart_driver, port);
> +	platform_set_drvdata(pdev, port);
> +	return 0;
> +
> + map_failed:
> +	release_mem_region(res->start, res->end - res->start + 1);
> + request_mem_failed:
> +
> +	return ret;
> +}
> +
> +static int ulite_remove(struct platform_device *pdev)
> +{
> +	struct uart_port *port = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	if (port)
> +		uart_remove_one_port(&ulite_uart_driver, port);
> +
> +	port->iobase = 0;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ulite_platform_driver = {
> +	.probe	= ulite_probe,
> +	.remove	= ulite_remove,
> +	.driver	= {
> +		   .owner = THIS_MODULE,
> +		   .name  = "uartlite",
> +		   },
> +};
> +
> +int __init ulite_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&ulite_uart_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&ulite_platform_driver);
> +	if (ret)
> +		uart_unregister_driver(&ulite_uart_driver);
> +
> +	return ret;
> +}
> +
> +void __exit ulite_exit(void)
> +{
> +	platform_driver_unregister(&ulite_platform_driver);
> +	uart_unregister_driver(&ulite_uart_driver);
> +}
> +
> +module_init(ulite_init);
> +module_exit(ulite_exit);
> +
> +MODULE_AUTHOR("Peter Korsgaard <jacmet@sunsite.dk>");
> +MODULE_DESCRIPTION("Xilinx uartlite serial driver");
> +MODULE_LICENSE("GPL");
> Index: linux/drivers/serial/Kconfig
> ===================================================================
> --- linux.orig/drivers/serial/Kconfig	2006-05-09 16:55:27.000000000 +0200
> +++ linux/drivers/serial/Kconfig	2006-05-10 18:02:09.000000000 +0200
> @@ -507,6 +507,33 @@
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>  
> +config SERIAL_UARTLITE
> +	tristate "Xilinx uartlite serial port support"
> +	depends on PPC32
> +	select SERIAL_CORE
> +	help
> +	  Say Y here if you want to use the Xilinx uartlite serial controller.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called uartlite.ko.
> +
> +config SERIAL_UARTLITE_NR_UARTS
> +	int "Maximum number of Xilinx uartlite serial ports"
> +	depends on SERIAL_UARTLITE
> +	default "4"
> +	help
> +	  Set this to the number of serial ports you want the driver
> +	  to support.
> +
> +config SERIAL_UARTLITE_CONSOLE
> +	bool "Support for console on Xilinx uartlite serial port"
> +	depends on SERIAL_UARTLITE=y
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  Say Y here if you wish to use a Xilinx uartlite as the system
> +	  console (the system console is the device which receives all kernel
> +	  messages and warnings and which allows logins in single user mode).
> +
>  config SERIAL_SUNCORE
>  	bool
>  	depends on SPARC
> Index: linux/drivers/serial/Makefile
> ===================================================================
> --- linux.orig/drivers/serial/Makefile	2006-05-09 16:55:27.000000000 +0200
> +++ linux/drivers/serial/Makefile	2006-05-09 16:56:02.000000000 +0200
> @@ -55,3 +55,4 @@
>  obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
>  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
>  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
> +obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
> Index: linux/include/linux/serial.h
> ===================================================================
> --- linux.orig/include/linux/serial.h	2006-05-09 16:55:27.000000000 +0200
> +++ linux/include/linux/serial.h	2006-05-09 16:56:02.000000000 +0200
> @@ -76,7 +76,8 @@
>  #define PORT_16654	11
>  #define PORT_16850	12
>  #define PORT_RSA	13	/* RSA-DV II/S card */
> -#define PORT_MAX	13
> +#define PORT_UARTLITE	14
> +#define PORT_MAX	14

The first set of numbers are reserved for the 8250 driver.  Please add
to the _end_ of the port number list.  Also, use serial_core.h rather
than serial.h please.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
