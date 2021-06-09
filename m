Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC414C48BD1
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C680F61183
	for <linux-serial@archiver.kernel.org>; Wed,  9 Jun 2021 12:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhFIMof (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234686AbhFIMob (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Jun 2021 08:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD2C46139A;
        Wed,  9 Jun 2021 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623242557;
        bh=8U3g3XJCMqY+IVlfpoB4fbqdxoomDSJLZ81ZiFhomKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJAZVZS2yq0C9N+72aMnEcvWMxjokfENBM0AwzF7BGxerhXbqRTRxjk5hDIOdsITD
         ZUSXdxm7ynJOA4N/BEG2YJsVz26Rr/DAnBVpfH4JUeXXjlKe/3k03DnkRJytOwkMiQ
         sXspSLFlUjflHbOPDBprxS9eO0LBDhTnEVgggUPY=
Date:   Wed, 9 Jun 2021 14:42:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 3/3] serial: 8250_exar: Add ->unregister_gpio()
 callback
Message-ID: <YMC3OknGE+Kzs6u2@kroah.com>
References: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
 <20210608144239.12697-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608144239.12697-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 08, 2021 at 05:42:39PM +0300, Andy Shevchenko wrote:
> For the sake of reducing layering violation add ->unregister_gpio()
> callback and use it in the ->exit() one.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 36 ++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 3ffeedc29c83..d502240bbcf2 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -114,6 +114,7 @@ struct exar8250;
>  struct exar8250_platform {
>  	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
>  	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
> +	void (*unregister_gpio)(struct uart_8250_port *);
>  };
>  
>  /**
> @@ -352,9 +353,8 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
>  	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
>  }
>  
> -static void *
> -__xr17v35x_register_gpio(struct pci_dev *pcidev,
> -			 const struct software_node *node)
> +static struct platform_device *__xr17v35x_register_gpio(struct pci_dev *pcidev,
> +							const struct software_node *node)
>  {
>  	struct platform_device *pdev;
>  
> @@ -374,6 +374,12 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev,
>  	return pdev;
>  }
>  
> +static void __xr17v35x_unregister_gpio(struct platform_device *pdev)
> +{
> +	device_remove_software_node(&pdev->dev);
> +	platform_device_unregister(pdev);
> +}
> +
>  static const struct property_entry exar_gpio_properties[] = {
>  	PROPERTY_ENTRY_U32("exar,first-pin", 0),
>  	PROPERTY_ENTRY_U32("ngpios", 16),
> @@ -384,8 +390,7 @@ static const struct software_node exar_gpio_node = {
>  	.properties = exar_gpio_properties,
>  };
>  
> -static int xr17v35x_register_gpio(struct pci_dev *pcidev,
> -				  struct uart_8250_port *port)
> +static int xr17v35x_register_gpio(struct pci_dev *pcidev, struct uart_8250_port *port)
>  {
>  	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
>  		port->port.private_data =
> @@ -394,6 +399,15 @@ static int xr17v35x_register_gpio(struct pci_dev *pcidev,
>  	return 0;
>  }
>  
> +static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
> +{
> +	if (!port->port.private_data)
> +		return;
> +
> +	__xr17v35x_unregister_gpio(port->port.private_data);
> +	port->port.private_data = NULL;
> +}
> +
>  static int generic_rs485_config(struct uart_port *port,
>  				struct serial_rs485 *rs485)
>  {
> @@ -419,6 +433,7 @@ static int generic_rs485_config(struct uart_port *port,
>  
>  static const struct exar8250_platform exar8250_default_platform = {
>  	.register_gpio = xr17v35x_register_gpio,
> +	.unregister_gpio = xr17v35x_unregister_gpio,
>  	.rs485_config = generic_rs485_config,
>  };
>  
> @@ -484,6 +499,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
>  static const struct exar8250_platform iot2040_platform = {
>  	.rs485_config = iot2040_rs485_config,
>  	.register_gpio = iot2040_register_gpio,
> +	.unregister_gpio = xr17v35x_unregister_gpio,
>  };
>  
>  /*
> @@ -555,17 +571,11 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>  
>  static void pci_xr17v35x_exit(struct pci_dev *pcidev)
>  {
> +	const struct exar8250_platform *platform = exar_get_platform();
>  	struct exar8250 *priv = pci_get_drvdata(pcidev);
>  	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
> -	struct platform_device *pdev;
>  
> -	pdev = port->port.private_data;
> -	if (!pdev)
> -		return;
> -
> -	device_remove_software_node(&pdev->dev);
> -	platform_device_unregister(pdev);
> -	port->port.private_data = NULL;
> +	platform->unregister_gpio(port);
>  }
>  
>  static inline void exar_misc_clear(struct exar8250 *priv)
> -- 
> 2.30.2
> 

This patch doesn't apply to my tty-next branch, so I've dropped it :(

greg k-h
