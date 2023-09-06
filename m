Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BD1EB8FB3
	for <linux-serial@archiver.kernel.org>; Wed,  6 Sep 2023 13:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjIFNos (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbjIFNor (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Sep 2023 09:44:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEFB1994
        for <linux-serial@vger.kernel.org>; Wed,  6 Sep 2023 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694007878; x=1725543878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JxX2XIKXMWLHhUmwfg5JBteSiHxxnJaV7wjgYZ/gtWs=;
  b=AGn7A5cTgX92mSS1QUy2kx86uZ6+BC/dFuxFZJ2hL55YqY0BU7m0CW3i
   hrUkAp3ks3u7uaH2YTcFKbxFnxJ4zzgq61xC/kWorHeUSKSwGOOMDTawq
   1/K7NwxbJHoe33dgyYSIwyzrhZg4e+0K/+FbPqy17BiGbolUr4rJFrp1K
   9l9G1migAzbrESLhHuWDiHuBnXgrpja3qFZzCTB4MCeLNZLcuHAWHbhcs
   RgTsa5lCAkcedPAV3KjJQWH0exkkecJs6CR2E17VKdgS18SKTL/hV/HZD
   i82usg5t/hr3r7OdiDTOZNF5CbMgH1QhN+q9c4MJBGQBXQjcsR28rleAF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362099482"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362099482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 06:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="811652391"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="811652391"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 06:44:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qdspY-006xEx-23;
        Wed, 06 Sep 2023 16:44:28 +0300
Date:   Wed, 6 Sep 2023 16:44:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZPiCPJYfiR9ZfVJC@smile.fi.intel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 05, 2023 at 12:06:20PM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com

Okay, I started reviewing it and it has all the same issues that I pointed
out previously. Are you sure you sent a _new_ version?

For your convenience I left all comments here.

> 
> Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the 
> current implementation of 8250_exar uses RTS for the auto-RS485-Enable 
> mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on 

All four above and two below (Link: and supposed to be a blank line)
have a trailing space. Which editor do you use? You probably need to configure
it to avoid this.

> Sealevel cards.

> Link: 
> https://lore.kernel.org/all/b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com/

Should be a single line.

> 

No blank lines in the tag block.

...

> +	generic_rs485_config(port, termios, rs485);

> +	if (rs485->flags & SER_RS485_ENABLED) {

What I meant is to have

	if (!)rs485->flags & SER_RS485_ENABLED))
		return 0;

here, which allows you to reduce indentation level in the below block.

> +		/* Set EFR[4]=1 to enable enhanced feature registers */
> +		writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> +
> +		/* Set MCR to use DTR as Auto-RS485 Enable signal */
> +		writeb(UART_MCR_OUT1, p + UART_MCR);
> +
> +		/* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> +		old_lcr = readb(p + UART_LCR);
> +		writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> +
> +		/* Set DLD[7]=1 for inverted RS485 Enable logic */
> +		writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> +
> +		writeb(old_lcr, p + UART_LCR);
> +    }
> +
> +	return 0;

...

> +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +		   struct uart_8250_port *port, int idx)
> +{
> +	int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);

> +	port->port.rs485_config = sealevel_rs485_config;

This is incorrect in a way that we do not assign return values in case it is
an error path. This will be prone to mistakes on the caller side.

	int ret;

	ret = ...
	if (ret)
		return ret;

	...

	return 0;

> +	return ret;
> +}

...

> +static const struct exar8250_board pbn_sealevel_16 = {
> +	.num_ports	= 16,

> +    .setup		= pci_sealevel_setup,

Here is the indentation issue. Use leading TABs.

> +	.exit		= pci_xr17v35x_exit,
> +};

...

> +#define SEALEVEL_DEVICE(devid, bd) {			\
> +	PCI_DEVICE_SUB(					\
> +		PCI_VENDOR_ID_EXAR,			\
> +		PCI_DEVICE_ID_EXAR_##devid,		\
> +		PCI_VENDOR_ID_SEALEVEL,			\

> +		PCI_ANY_ID), 0, 0,	\

Seems trailing \ is indented wrongly, missing TAB?

> +		(kernel_ulong_t)&bd			\
> +	}

-- 
With Best Regards,
Andy Shevchenko


