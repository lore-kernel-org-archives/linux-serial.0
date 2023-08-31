Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F678CA0FE2
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjHaXRs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXRs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 19:17:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B267CE8
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693523865; x=1725059865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ufaSvDzWcx1IqFT9gJQn85A4B5g669lQwFUZiLgcl/4=;
  b=gKqHlkIkzpiBz0nNxTeHra6GApbW970eFhyI/G4zEpnpGQa3sswY1y2V
   /D2JH7YoHBnRgYh/nZzwH6Ebp+QCE2weYnlp4LlxMj9ckuIHBRM3M5jns
   fpfthiNakgNwFEIu54qRy1Mgq0vI+hB1eQtjxC/Xb90M4vqu9p9uKwnt8
   UHMpAmihMyRe3oH/DQlJYzoXxuhlApL9quO8Zt5Mz+ft6WoTry8Lysi6p
   tFMB0DnzFz45vDu27qArxPY0P/BJ4XXTDGGKUUr8gDARkQf4x46loRbbV
   Pb8lL3OmR9LRkxqc/nlV85fZ8pWnwagNoloL/uwpKAHN+AVr4TvnL4XCy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374993787"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="374993787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070505374"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="1070505374"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:17:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbquy-005WiA-1K;
        Fri, 01 Sep 2023 02:17:40 +0300
Date:   Fri, 1 Sep 2023 02:17:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V3 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
Message-ID: <ZPEflBvmd5R/kImw@smile.fi.intel.com>
References: <b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 31, 2023 at 03:48:08PM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com
> 
> Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but 
> the current implementation in 8250_exar uses RTS for the auto-RS485-Enable 
> mode of the XR17V35X UARTs. This patch implements sealevel_rs485_config to 

Please, read Submitting Patches documentation, in particular find there
the paragraph that matches to "This patch". With that, amend commit message
accordingly.

We refer to the functions as func() (note the parentheses).

> configure the XR17V35X for DTR control of RS485 Enable and assigns it to 

Your lines have trailing whitespaces, please get rid of them.

> Sealevel cards in pci_sealevel_setup.

> Fixed defines and various format issues from previous submissions.

What does this mean? If it's a changelog, use the correct place for it
(see below).

> 
> Link: 
> https://lore.kernel.org/linux-serial/b2a721-227-14ef-75eb-36244ba2942@sealevel.com

Tags must occupy a single line: a single line per each tag.

> 

Tag block must have no blank lines.

Most of these is described in the above mentioned documentation.

> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> ---

Here you add comments and/or changelog.

> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 3886f78ecbbf..6b28f5a3df17 100644

...

> +#define UART_EXAR_DLD				0x02 /* Divisor Fractional */
> +#define UART_EXAR_DLD_485_POLARITY 	0x80 /* RS-485 Enable Signal Polarity */

Mixed TABs and spaces in a wrong order, usually we use only TABs in such cases.

...

> +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	u8 __iomem *p = port->membase;
> +	u8 old_lcr;
> +
> +	generic_rs485_config(port, termios, rs485);

> +	if (rs485->flags & SER_RS485_ENABLED) {

Seems you haven't seen / ignored my comments. Please, read my previous reply.

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
> + }

-- 
With Best Regards,
Andy Shevchenko


