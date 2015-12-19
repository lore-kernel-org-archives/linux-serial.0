From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] serial: 8250: add gpio support to exar
Date: Sat, 19 Dec 2015 16:43:20 +0000
Message-ID: <20151219164320.287792c1@lxorguk.ukuu.org.uk>
References: <1450538637-9229-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450538637-9229-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, 19 Dec 2015 20:53:57 +0530
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
> Add support to use these pins and select GPIO_SYSFS also so that these
> pins can be used from the userspace through sysfs.

I don't actually see why this is a separate module the way you've done
it. As you've got runtime requirements for it in the serial driver based
on the Kconfig entries it'll either always be needed or never, so having
it as a separate module just wastes memory, better just to build the
extra file into the driver in this case.

>
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1764,12 +1764,29 @@ xr17v35x_has_slave(struct serial_private *priv)
>  	        (dev_id == PCI_DEVICE_ID_EXAR_XR17V8358));
>  }
>  
> +extern void xr17v35x_gpio_exit(struct uart_8250_port *);
> +extern int xr17v35x_gpio_init(struct pci_dev *, struct uart_8250_port *);
> +
> +static void pci_xr17v35x_exit(struct pci_dev *dev)
> +{
> +#if defined(CONFIG_SERIAL_8250_EXAR_GPIO)
> +	struct serial_private *priv = pci_get_drvdata(dev);
> +	struct uart_8250_port *port = NULL;
> +
> +	if (priv)
> +		port = serial8250_get_port(priv->line[0]);
> +
> +	xr17v35x_gpio_exit(port);

This looks odd - how will priv be NULL if the init succeeded ? And if you
can tolerate NULL isn't the whole thing

	xr17v35x_gpio_exit(serial8250_get_port(priv->line[0]));

which conventiently means you can make xr17v35x_gpio_exit a null function
in the header and keep the ifdefs there

> +#endif
> +}
> +
>  static int
>  pci_xr17v35x_setup(struct serial_private *priv,
>  		  const struct pciserial_board *board,
>  		  struct uart_8250_port *port, int idx)
>  {
>  	u8 __iomem *p;
> +	int ret;
>  
>  	p = pci_ioremap_bar(priv->dev, 0);
>  	if (p == NULL)
> @@ -1807,7 +1824,16 @@ pci_xr17v35x_setup(struct serial_private *priv,
>  	writeb(128, p + UART_EXAR_RXTRG);
>  	iounmap(p);
>  
> -	return pci_default_setup(priv, board, port, idx);
> +	ret = pci_default_setup(priv, board, port, idx);
> +	if (ret)
> +		return ret;
> +
> +#if defined(CONFIG_SERIAL_8250_EXAR_GPIO)
> +	if (idx == 0 && priv->dev->vendor == PCI_VENDOR_ID_EXAR)
> +		ret = xr17v35x_gpio_init(priv->dev, port);
> +#endif
> +
> +	return ret;
>  }

I would suggest

1. Put all the checks on idx == 0 and the like into the gpio driver code
so it makes less mess here. It's gpio knowledge not serial knowledge.

2. Can you not just remove the VENDOR_ID_EXAR check ?

3. If you tidy the code up so the gpio call is

	ret = pci_default_setup(blah)
	if (ret == 0)
		ret = xr17v35x_gpio_init(priv->dev, port);
	return ret;

Then you can just ifdef the gpio_init/exit methods to return 0 in the
header and avoid ifdef mess anywhere else


The gpio driver itself I'd suggest fixing

+	exar_gpio = devm_kzalloc(&dev->dev, sizeof(*exar_gpio), GFP_KERNEL);
+	if (!exar_gpio) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	/* assuming we will never have more than 99 boards */
+	buf = devm_kzalloc(&dev->dev, strlen("exar_gpio") + 3, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}


It's not worth making buf a separate allocation. Just declare a 16 byte
buffer or whatever at the end of the struct and stop worrying about the
number of boards. Not only will it actually be smaller than all the code
to handle the case, it'll be more reliable.

The other thing that looks a bit wrong is exar_get(). You've got it
returning negative error codes on a NULL. Firstly as far as I can see the
NULL case can't happen, secondly if it does you take negative values from
it and treat them as valid then use them, which is nonsensical.

If it can't be NULL and the check is just for sanity you don't need it -
the kernel will give you a nice traceback if you reference NULL. If it
can happen then you need to fix all the callers.

Alan
