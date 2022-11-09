Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1252CC4332F
	for <linux-serial@archiver.kernel.org>; Wed,  9 Nov 2022 09:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKIJLO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKIJKd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Nov 2022 04:10:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E812A97
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 01:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A696D6194D
        for <linux-serial@vger.kernel.org>; Wed,  9 Nov 2022 09:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA7EC433D7;
        Wed,  9 Nov 2022 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667985011;
        bh=bkYZTtOLzDgwBZKcRK0AMGmXmk8TRCdzpX4SqBFmxg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sccMhsLPzKCOXhaVWdmeWV+UQPoA9cc5mogJUUfiVPhFSOgxEziXny17xCnuI867T
         HrAUk8fm3nM3Vj6XLjyxyf7zSNljdh5J+5cwNyDIrjRzwFPKiZVZHWarHIm+fUpcEo
         sDJkK+QWm63I4Q7hi0lc+qr3hd6qWuqy4acyVgxI=
Date:   Wed, 9 Nov 2022 10:10:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        andre.przywara@arm.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: pl011: Fix error handling in pl011_init()
Message-ID: <Y2tucFPU15TsbRBp@kroah.com>
References: <20221109084626.2032013-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109084626.2032013-1-cuigaosheng1@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 09, 2022 at 04:46:26PM +0800, Gaosheng Cui wrote:
> When amba_driver_register failed, we need to unregister the platform
> driver which have been registered, otherwise there maybe resource leak,
> so we add error handlings in pl011_init() to fix it.
> 
> Fixes: 0dd1e247fd39 ("drivers: PL011: add support for the ARM SBSA generic UART")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 6d8552506091..ef6d9941f972 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2982,11 +2982,23 @@ static struct amba_driver pl011_driver = {
>  
>  static int __init pl011_init(void)
>  {
> +	int ret;
> +
>  	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
>  
> -	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
> +	ret = platform_driver_register(&arm_sbsa_uart_platform_driver);
> +	if (unlikely(ret)) {

Only use likely/unlikely if you can prove with a benchmark that it makes
a measurable change to do so.

Here, on the init error path, it will never happen.

And how are you causing this call to fail?

How was this tested?

>  		pr_warn("could not register SBSA UART platform driver\n");
> -	return amba_driver_register(&pl011_driver);
> +		return ret;
> +	}
> +
> +	ret = amba_driver_register(&pl011_driver);
> +	if (unlikely(ret)) {

Again, never use unlikely() like this.

And again, how did you get this to fail under normal operation?  And how
was this tested?

thanks,

greg k-h
