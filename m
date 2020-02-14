Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD35C47409
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451B42465D
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710543;
	bh=NDlZpEFzQFI5oTbPtjB57GN93k87n94Y6gYiKbZfEFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qjxVirBQ8LXsPvDK9vZcGjHWspILd0ol0BbgQ4974CVaqSp99w9E41bf73f6Ym/X9
	 BBnBlUMYsBy++P90EpZlKMcoBlWxoO4I4CT4hiRx44KWaed+/ad9hZ7fGzIap7E74q
	 wxav2Zul3YwtuAYjfuUNsLlTy7vFZxEz4BCqlLEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgBNUCW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389437AbgBNUCR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:17 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DB124673;
        Fri, 14 Feb 2020 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710536;
        bh=NDlZpEFzQFI5oTbPtjB57GN93k87n94Y6gYiKbZfEFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUOB4vdBEvvN7QFve5totDd+oZ9uSVQAIZztoPgap2sgYViUKAedsGEfNfZ2fyOEQ
         ELqNYkpZ86ANMrOqj/GP/9pSXeFoZ51/kpFYjb1ELVyiM4fluri5xCTIa25C8J1PZF
         pqoX2IcjhIm9X8nLqTRIVivAPC2rerLCKtCAssFQ=
Date:   Fri, 14 Feb 2020 08:27:19 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/8] serial: core: use octal permissions on module
 param
Message-ID: <20200214162719.GA3987177@kroah.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214114339.53897-4-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 01:43:34PM +0200, Andy Shevchenko wrote:
> Symbolic permissions 'S_IRUSR | S_IRGRP' are not preferred.
> Use octal permissions '0440'. This also makes code shorter.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index bb2287048108..7564bbd3061c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2749,19 +2749,19 @@ static ssize_t uart_get_attr_iomem_reg_shift(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE, "%d\n", tmp.iomem_reg_shift);
>  }
>  
> -static DEVICE_ATTR(type, S_IRUSR | S_IRGRP, uart_get_attr_type, NULL);
> -static DEVICE_ATTR(line, S_IRUSR | S_IRGRP, uart_get_attr_line, NULL);
> -static DEVICE_ATTR(port, S_IRUSR | S_IRGRP, uart_get_attr_port, NULL);
> -static DEVICE_ATTR(irq, S_IRUSR | S_IRGRP, uart_get_attr_irq, NULL);
> -static DEVICE_ATTR(flags, S_IRUSR | S_IRGRP, uart_get_attr_flags, NULL);
> -static DEVICE_ATTR(xmit_fifo_size, S_IRUSR | S_IRGRP, uart_get_attr_xmit_fifo_size, NULL);
> -static DEVICE_ATTR(uartclk, S_IRUSR | S_IRGRP, uart_get_attr_uartclk, NULL);
> -static DEVICE_ATTR(close_delay, S_IRUSR | S_IRGRP, uart_get_attr_close_delay, NULL);
> -static DEVICE_ATTR(closing_wait, S_IRUSR | S_IRGRP, uart_get_attr_closing_wait, NULL);
> -static DEVICE_ATTR(custom_divisor, S_IRUSR | S_IRGRP, uart_get_attr_custom_divisor, NULL);
> -static DEVICE_ATTR(io_type, S_IRUSR | S_IRGRP, uart_get_attr_io_type, NULL);
> -static DEVICE_ATTR(iomem_base, S_IRUSR | S_IRGRP, uart_get_attr_iomem_base, NULL);
> -static DEVICE_ATTR(iomem_reg_shift, S_IRUSR | S_IRGRP, uart_get_attr_iomem_reg_shift, NULL);
> +static DEVICE_ATTR(type, 0440, uart_get_attr_type, NULL);
> +static DEVICE_ATTR(line, 0440, uart_get_attr_line, NULL);
> +static DEVICE_ATTR(port, 0440, uart_get_attr_port, NULL);
> +static DEVICE_ATTR(irq, 0440, uart_get_attr_irq, NULL);
> +static DEVICE_ATTR(flags, 0440, uart_get_attr_flags, NULL);
> +static DEVICE_ATTR(xmit_fifo_size, 0440, uart_get_attr_xmit_fifo_size, NULL);
> +static DEVICE_ATTR(uartclk, 0440, uart_get_attr_uartclk, NULL);
> +static DEVICE_ATTR(close_delay, 0440, uart_get_attr_close_delay, NULL);
> +static DEVICE_ATTR(closing_wait, 0440, uart_get_attr_closing_wait, NULL);
> +static DEVICE_ATTR(custom_divisor, 0440, uart_get_attr_custom_divisor, NULL);
> +static DEVICE_ATTR(io_type, 0440, uart_get_attr_io_type, NULL);
> +static DEVICE_ATTR(iomem_base, 0440, uart_get_attr_iomem_base, NULL);
> +static DEVICE_ATTR(iomem_reg_shift, 0440, uart_get_attr_iomem_reg_shift, NULL);

I'll take these, but we should move them all to DEVICE_ATTR_RO() as that
would make things a lot more "obvious" what is happening here.

thanks,

greg k-h
