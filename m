Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA7EE4993
	for <linux-serial@archiver.kernel.org>; Tue, 22 Aug 2023 09:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjHVJlv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Aug 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjHVJlt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Aug 2023 05:41:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8AA1A5
        for <linux-serial@vger.kernel.org>; Tue, 22 Aug 2023 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692697308; x=1724233308;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8uyPppIMIHlMQgyS1kUHp8H79rilrm+W1DODR+b8Bi4=;
  b=YgGND+YQUP3y1VDFf1gXWRNZqPIBy8hOR7lBCoVhFiJTbHvPJt9omkFn
   Z7i2Ope0r2y+wbu4gi6t7yKNiApy6xl35rCdxKqVkJYWJapoPUNzuotzS
   Eafa0wlSG+C0pP4MF4K53peRK/5tQvA4sf87xuhI5vyRi66lWu7Fb760H
   B1z/TD/vrQ1u4/yMPh+ldfGZW+UXPS7a4Jlp5YZs5m7FVjpGTZdWW+oZl
   nHOV0PtsXT+dqJNf7EMD6m7/XyO0D8tcakZqhagZcF6fSnq8B2ky1Nleg
   q/VSCwA7gQqaubvcc6BlpGBP/OAzTX5jSO7NdaNUfnb+Z5dM6djI/kOrl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404836803"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="404836803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879872371"
Received: from refaase-mobl.ger.corp.intel.com ([10.252.53.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:41:49 -0700
Date:   Tue, 22 Aug 2023 12:41:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com
Subject: Re: [PATCH 2/2] serial: exar: Add RS-485 Support for Sealevel XR17V35X
 based cards
In-Reply-To: <766dab31-6982-67d9-ead9-30f61648d7a2@sealevel.com>
Message-ID: <bd7f9d51-7cf4-d3f5-d2d7-3c822656f67d@linux.intel.com>
References: <766dab31-6982-67d9-ead9-30f61648d7a2@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 21 Aug 2023, Matthew Howell wrote:

Thanks for the patch.

> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the 
> current implementation of 8250_exar uses RTS for the auto-RS485-Enable 
> mode of the XR17V35X UARTs.
> 
> sealevel_rs485_config(): Configures XR17V35X registers for Auto-RS485 
> Enable using DTR.
> pci_sealevel_startup(): Calls pci_xr17v35x_setup(), then sets 
> rs485_config to sealevel_rs485_config().

The changelog doesn't read well as is. The logical flow breaks when you 
jump to describe functions.

> signed-off-by: Matthew Howell <matthew.howell@sealevel.com>

Start with capital S.

> ---
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 018cbaaf238c..246cfb3cc3f8 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -390,6 +390,8 @@ static void __xr17v35x_unregister_gpio(struct platform_device *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> +
> +

Please remove this extra change.

>  static const struct property_entry exar_gpio_properties[] = {
>  	PROPERTY_ENTRY_U32("exar,first-pin", 0),
>  	PROPERTY_ENTRY_U32("ngpios", 16),
> @@ -439,6 +441,35 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
>  	return 0;
>  }
>  
> +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);

No need for !!() if assigning to bool.

> +	u8 __iomem *p = port->membase;
> +	u8 old_lcr;
> +    generic_rs485_config(port, termios, rs485);

Use tab to indent. Leave one empty line after declarations.

> +
> +	if (is_rs485) {
> +		// Set EFR[4]=1 to enable enhanced feature registers
> +		writeb(readb(p + UART_XR_EFR) | 0x10, p + 0x09);
> +
> +		// Set MCR to use DTR as Auto-RS485 Enable signal
> +		writeb(0x04, p + UART_MCR);
> +
> +		// Store original LCR and set LCR[7]=1 to enable access to DLD register
> +		old_lcr = readb(p + UART_LCR);
> +		writeb(old_lcr | 0x80, p + UART_LCR);
> +
> +		// Set DLD[7]=1 for inverted RS485 Enable logic
> +		writeb(readb(p + 0x02) | 0x80, p + 0x02);

Please don't use numeric literals. You should add defines (or use existing 
ones) with proper names in all these cases.

If the names for the defines are good enough, the comments become 
redundant and can be removed so please check that too after naming things 
properly.

> +
> +		// Reset LCR to orginal value

Unnecessary (very obvious) comment, please drop it.

> +		writeb(old_lcr, p + UART_LCR);
> +    }
> +
> +	return 0;
> + }
> +
>  static const struct serial_rs485 generic_rs485_supported = {
>  	.flags = SER_RS485_ENABLED,
>  };
> @@ -744,6 +775,19 @@ static int __maybe_unused exar_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +							  struct uart_8250_port *port, int idx)
> +{
> +	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> +
> +	if (ret)
> +		return ret;
> +
> +	port->port.rs485_config = sealevel_rs485_config;

Do you need to setup .rs485_supported too? (I'm not sure how the init 
works with this driver whether the default one gets used by some logic 
or not).

-- 
 i.


> +	return ret;
> +}
> +
>  static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
>  
>  static const struct exar8250_board pbn_fastcom335_2 = {
> @@ -809,6 +853,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
>  	.exit		= pci_xr17v35x_exit,
>  };
>  
> +static const struct exar8250_board pbn_sealevel = {
> +	.setup		= pci_sealevel_setup,
> +	.exit		= pci_xr17v35x_exit,
> +};
> +
> +static const struct exar8250_board pbn_sealevel_16 = {
> +	.num_ports  = 16,
> +    .setup		= pci_sealevel_setup,
> +	.exit		= pci_xr17v35x_exit,
> +};
> +
>  #define CONNECT_DEVICE(devid, sdevid, bd) {				\
>  	PCI_DEVICE_SUB(							\
>  		PCI_VENDOR_ID_EXAR,					\
> @@ -838,6 +893,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
>  		(kernel_ulong_t)&bd			\
>  	}
>  
> +#define SEALEVEL_DEVICE(devid, bd) {			\
> +	PCI_DEVICE_SUB(					\
> +		PCI_VENDOR_ID_EXAR,			\
> +		PCI_DEVICE_ID_EXAR_##devid,		\
> +		PCI_VENDOR_ID_SEALEVEL,			\
> +		PCI_ANY_ID), 0, 0,	\
> +		(kernel_ulong_t)&bd			\
> +	}
> +
>  static const struct pci_device_id exar_pci_tbl[] = {
>  	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
>  	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
> @@ -886,6 +950,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
>  	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
>  
> +	SEALEVEL_DEVICE(XR17V352, pbn_sealevel),
> +	SEALEVEL_DEVICE(XR17V354, pbn_sealevel),
> +	SEALEVEL_DEVICE(XR17V358, pbn_sealevel),
> +	SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
> +	SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
> +
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
> 
