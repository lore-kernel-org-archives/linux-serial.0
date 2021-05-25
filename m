Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4807C4707F
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4CF61400
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhEYIR3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 May 2021 04:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhEYIR2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 May 2021 04:17:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 460B6613F9;
        Tue, 25 May 2021 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621930558;
        bh=OI2gXiU9RTu0knVsus/2FhWQayb9rozz7U4IUjC7ymw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gs6E9wxsK2STh99Y40NKU1Zc7XoXXSStI4OyrUhaHpT3FEaHa2MIpCUZUcg/XbIpd
         PHkvfVY6QRGof5UPb1iaGwLMqXGCrZkakrEJJF06DvnrXO5tXYLZExbe9I9mVNpih6
         aY4RkghhfuqrCxfP9cn6hK8xLYDx9riogWYbwgUo=
Date:   Tue, 25 May 2021 10:15:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, jacmet@sunsite.dk, git@xilinx.com
Subject: Re: [PATCH 1/2] tty: serial: uartlite: Disable clocks in case of
 errors
Message-ID: <YKyyPB7JjPd25uiL@kroah.com>
References: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1621929844-19727-2-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621929844-19727-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 25, 2021 at 01:34:03PM +0530, Shubhrajyoti Datta wrote:
> In case the uart registration fails the clocks are left enabled.
> Disable the clock in case of errors.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/tty/serial/uartlite.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index f42ccc4..39ea495 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -799,7 +799,7 @@ static int ulite_probe(struct platform_device *pdev)
>  		ret = uart_register_driver(&ulite_uart_driver);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Failed to register driver\n");
> -			return ret;
> +			goto err_out_clk_disable;
>  		}
>  	}
>  
> @@ -808,6 +808,10 @@ static int ulite_probe(struct platform_device *pdev)
>  	clk_disable(pdata->clk);
>  
>  	return ret;
> +
> +err_out_clk_disable:
> +	clk_disable_unprepare(pdata->clk);

Why not put this above in your error code?

Also, are you sure that you are calling uart_register_driver() in the
correct place?  Shouldn't everything be set up before it is called?  You
have more logic after it is called, what happens if your device is
opened before the uart_register_driver() call returns?

thanks,

greg k-h
