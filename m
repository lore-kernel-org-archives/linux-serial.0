Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD79C83F2F
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 18:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbjHaSHI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbjHaSHF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 14:07:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387FCE5F
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693505223; x=1725041223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gs1EJ+EojXPg4Qai9oAnz0JAwOTf/RHq8ZQ47lSegow=;
  b=VbVgqeZguk46VS2KJZeYPOaI0yslEK/9pGAIJinWkT9F04fWLqJD3dco
   CxJ/blLAVmJTsJqoTEIJwId7Ut2d0Cb4UbZw6EqDKSXKYEeFGfIjPessd
   Knew0fMGVpp3RcMhcIPWjlap7nKgVBd3Kh5K778KNrAiSLqopBsXlXRtW
   DOsbeN1CHm10QdGa+jfkoiQBbhse6GJWEbPSJzVuGhIbkKOOPwDP7VMLV
   7rf0RvTAMOsXr9KUvPJO9rWv3ISq3fkupTehM+qWs+O+vpfxhuJc+fotK
   EPjacMDVXwqdUOtBEAfGI3TjgcNe1ugBxE75Ml9Esd4C5YX/yXww7J7wH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378759422"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="378759422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="768887007"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="768887007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:05:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbm2L-005T4O-2u;
        Thu, 31 Aug 2023 21:04:57 +0300
Date:   Thu, 31 Aug 2023 21:04:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V2 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZPDWSegiy+NGT5b6@smile.fi.intel.com>
References: <b2a721-227-14ef-75eb-36244ba2942@sealevel.com>
 <9fcbbcb5-5e54-d3b7-3d28-7b50215a580@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcbbcb5-5e54-d3b7-3d28-7b50215a580@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 30, 2023 at 11:08:28AM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the 
> current implementation of 8250_exar uses RTS for the auto-RS485-Enable 
> mode of the XR17V35X UARTs. This patch applies a new sealevel_rs485_config 

s/This patch applies/Apply/

> function to configure the XR17V35X of Sealevel cards for DTR control of 
> RS485 Enable.
> 
> Based on feedback from the first submission I replaced the hex values with 
> defines and fixed up various format issues. I couldn't find an existing 
> define for the DLD register or its RS485 Polarity bit so I created a new 
> define. I tried to follow the format of the other defines in serial_reg.h.

...

> +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);

!!() is redundant.

> +	u8 __iomem *p = port->membase;
> +	u8 old_lcr;
> +
> +	generic_rs485_config(port, termios, rs485);

> +	if (is_rs485) {

	if (!is_rs485)
		return 0;

...

> +		// Set EFR[4]=1 to enable enhanced feature registers

> +		// Set MCR to use DTR as Auto-RS485 Enable signal

> +		// Store original LCR and set LCR[7]=1 to enable access to DLD register

> +		// Set DLD[7]=1 for inverted RS485 Enable logic

I believe the comment style in this file is /* */.

> +    }
> +
> +	return 0;
> + }

...

> +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +							  struct uart_8250_port *port, int idx)

Wrong indentation.

> +{
> +	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> +
> +	if (ret)
> +		return ret;

Use more robust style

	int ret;

	ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
	if (ret)
		return ret;

> +	port->port.rs485_config = sealevel_rs485_config;
> +
> +	return ret;

	return 0;

> +}

...

> +static const struct exar8250_board pbn_sealevel_16 = {
> +	.num_ports  = 16,

> +    .setup		= pci_sealevel_setup,

TABs vs. spaces, please fix.

> +	.exit		= pci_xr17v35x_exit,
> +};

...

> @@ -885,6 +953,7 @@ static const struct pci_device_id exar_pci_tbl[] = {
>  	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
> +
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, exar_pci_tbl);

Stray change.

...

> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h

Really?
Please, localize this to the driver.

It may be the same reason to do so as in 7e12357ed64a ("serial: exar:
Move register defines from uapi header to consumer site")

>  #define UART_DLL	0	/* Out: Divisor Latch Low */
>  #define UART_DLM	1	/* Out: Divisor Latch High */
> +#define UART_DLD	2	/* Divisor Fractional */
> +#define UART_DLD_485_POLARITY 0x80 /* RS-485 Enable Signal Polarity */
>  #define UART_DIV_MAX	0xFFFF	/* Max divisor value */

-- 
With Best Regards,
Andy Shevchenko


