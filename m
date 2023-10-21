Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F370C001E0
	for <linux-serial@archiver.kernel.org>; Sat, 21 Oct 2023 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjJUQQk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Oct 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQQj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Oct 2023 12:16:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0090C1A4
        for <linux-serial@vger.kernel.org>; Sat, 21 Oct 2023 09:16:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40660C433C7;
        Sat, 21 Oct 2023 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697904994;
        bh=y4JFskdrUwYNiP1nwcKVRAOGFpDPCC07UojewYpv2LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PckH0S4EPdrTxuwrkbrEsB0ddV8JC6noeyRjJvyIXa69iv1+p1d8gqVP+H8PFgmLX
         0ieYjQAXUHlZ/8XVk8YO93lRzqEC1rlv7pQcn/PzyGM02jLdBWzk8SjazvVkdOw/FX
         9WEIbbPqeXmbmnmYTGRRVtEeXZoKIoN87CSPkqqE=
Date:   Sat, 21 Oct 2023 18:16:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     jirislaby@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: atmel: Check return value of platform_get_irq()
 in atmel_init_port()
Message-ID: <2023102151-mobster-reappoint-99da@gregkh>
References: <20231018091521.314706-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018091521.314706-1-yiyang13@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 18, 2023 at 09:15:21AM +0000, Yi Yang wrote:
> The platform_get_irq() might be failed and return a negative result, there
> should be return an error code when platform_get_irq() failed.
> Fix it by add check return value of platform_get_irq().
> 
> Fixes: 5bb221b0ad65 ("serial: atmel: Use platform_get_irq() to get the interrupt")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1946fafc3f3e..4984bec88445 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2540,13 +2540,17 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>  	atmel_init_property(atmel_port, pdev);
>  	atmel_set_ops(port);
>  
> +	ret = platform_get_irq(mpdev, 0);
> +	if (ret < 0)
> +		return 0;
> +
>  	port->iotype		= UPIO_MEM;
>  	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
>  	port->ops		= &atmel_pops;
>  	port->fifosize		= 1;
>  	port->dev		= &pdev->dev;
>  	port->mapbase		= mpdev->resource[0].start;
> -	port->irq		= platform_get_irq(mpdev, 0);
> +	port->irq		= ret;

Sorry, no, this makes things much more complex and error-prone in the
long term, for a function that in reality, never fails (obviously
otherwise this would have been reported.)

How did you test this?

thanks,

greg k-h
