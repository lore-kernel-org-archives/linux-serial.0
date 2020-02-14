Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B4C3B1BD
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736FB206D7
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710541;
	bh=PwK+Wo7ooAZj5fAWu1B5LKKtNzce2FWfb54wUGr1iog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HAwtkSYhahEZMB8dudRh7czkF7GhfZsAZrREmiS1HvE7dx2a9Cu38vNhraq70rLif
	 D8xoGQnd3B5OKlZ2Kn5mca+3/qL9n+JuDpwB43A8zU50/A2pILiSkB7OKa+y+RoPT5
	 3JUHYQIKjrQ37KDdXJKAVwr3q5Wdz8wgehXZ60iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbgBNUCU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbgBNUCT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:19 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19DA02467C;
        Fri, 14 Feb 2020 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710539;
        bh=PwK+Wo7ooAZj5fAWu1B5LKKtNzce2FWfb54wUGr1iog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFs8z66/kDgiEEvoLMkGPPp9zucNG4MefCG7YSAWDmcbl96Fg4jC99pKA3hrsfatu
         gY6g8LC5VTuyzNAdpC49KxH1bwVBPecHK0Xd2Nu3zdZfgB0fMZd0QpBYTAzeQUS2UQ
         TO3tZWtNGhoicz3a9ZQkhsFk0T4ei5vsE3qlmbcE=
Date:   Fri, 14 Feb 2020 08:30:58 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 6/8] serial: 8250_port: Disable DMA operations for
 kernel console
Message-ID: <20200214163058.GC3987177@kroah.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214114339.53897-7-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 01:43:37PM +0200, Andy Shevchenko wrote:
> It would be too tricky and error prone to allow DMA operations on
> kernel console.
> 
> One of the concern is when DMA is a separate device, for example on
> Intel CherryTrail platforms, and might need special work around to be
> functional, see the commit
> 
>   eebb3e8d8aaf ("ACPI / LPSS: override power state for LPSS DMA device")
> 
> for more information.
> 
> Another one is that kernel console is used in atomic context, e.g.
> when printing crucial information to the user (Oops or crash),
> and DMA may not serve due to power management complications
> including non-atomic ACPI calls but not limited to it (see above).
> 
> Besides that, other concerns are described in the commit
> 
>   84b40e3b57ee ("serial: 8250: omap: Disable DMA for console UART")
> 
> done for OMAP UART and may be repeated here.
> 
> Disable any kind of DMA operations on kernel console due to above concerns.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 6307a04c0cd9..8ed22aa31add 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2294,10 +2294,14 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Request DMA channels for both RX and TX.
>  	 */
>  	if (up->dma) {
> -		retval = serial8250_request_dma(up);
> -		if (retval) {
> -			pr_warn_ratelimited("%s - failed to request DMA\n",
> -					    port->name);
> +		const char *msg = NULL;
> +
> +		if (uart_console(port))
> +			msg = "forbid DMA for kernel console";
> +		else if (serial8250_request_dma(up))
> +			msg = "failed to request DMA";
> +		if (msg) {
> +			pr_warn_ratelimited("%s - %s\n", port->name, msg);

dev_warn_ratelimited()?  You have a port, you should use it.

thanks,

greg k-h
