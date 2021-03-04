Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88285C433DB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DD164F21
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhCDPzA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:55:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:60774 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236048AbhCDPyz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 10:54:55 -0500
IronPort-SDR: vsWyL/RPHsZz3yniHrCC1qK22jJ7FvKRb7quTwDf2lFmcHj2hu024W6qI0gaIqamw3YFy5iV5U
 /DQp565AczHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251478103"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="251478103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:53:09 -0800
IronPort-SDR: OeNOojzMZdRE1RyFSjkIZFW9mZbb18tZOhV+eV3+qFblq56aODHEm8A5hPtPRAEVbZG/mrhcKC
 5kD4ijsbWsNQ==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507434044"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 07:53:08 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHqHi-009uZE-0v; Thu, 04 Mar 2021 17:53:06 +0200
Date:   Thu, 4 Mar 2021 17:53:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: Constify the software nodes
Message-ID: <YEECYl4MZMpIwBAN@smile.fi.intel.com>
References: <20210304081311.17340-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304081311.17340-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 04, 2021 at 11:13:11AM +0300, Heikki Krogerus wrote:
> Software node is always created for additional device
> properties. If the properties are constant, the software
> node can also be constant.

Independently on the below nit-picks
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 2d0e7c7e408dc..2f49c580139b8 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -354,7 +354,7 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
>  
>  static void *
>  __xr17v35x_register_gpio(struct pci_dev *pcidev,
> -			 const struct property_entry *properties)
> +			 const struct software_node *node)
>  {
>  	struct platform_device *pdev;
>  
> @@ -365,7 +365,7 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev,
>  	pdev->dev.parent = &pcidev->dev;
>  	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
>  
> -	if (platform_device_add_properties(pdev, properties) < 0 ||
> +	if (device_add_software_node(&pdev->dev, node) < 0 ||
>  	    platform_device_add(pdev) < 0) {
>  		platform_device_put(pdev);
>  		return NULL;
> @@ -380,12 +380,16 @@ static const struct property_entry exar_gpio_properties[] = {
>  	{ }
>  };
>  
> +static const struct software_node exar_gpio_node = {
> +	.properties = exar_gpio_properties,
> +};
> +
>  static int xr17v35x_register_gpio(struct pci_dev *pcidev,
>  				  struct uart_8250_port *port)
>  {
>  	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)

>  		port->port.private_data =
> -			__xr17v35x_register_gpio(pcidev, exar_gpio_properties);
> +			__xr17v35x_register_gpio(pcidev, &exar_gpio_node);

I would do one line.

>  	return 0;
>  }
> @@ -457,6 +461,10 @@ static const struct property_entry iot2040_gpio_properties[] = {
>  	{ }
>  };
>  
> +static const struct software_node iot2040_gpio_node = {
> +	.properties = iot2040_gpio_properties,
> +};
> +
>  static int iot2040_register_gpio(struct pci_dev *pcidev,
>  			      struct uart_8250_port *port)
>  {
> @@ -468,7 +476,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
>  	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);

>  	port->port.private_data =
> -		__xr17v35x_register_gpio(pcidev, iot2040_gpio_properties);
> +		__xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);

Ditto.

>  	return 0;
>  }
> @@ -547,6 +555,7 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
>  	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
>  	struct platform_device *pdev = port->port.private_data;
>  
> +	device_remove_software_node(&pdev->dev);
>  	platform_device_unregister(pdev);
>  	port->port.private_data = NULL;
>  }
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


