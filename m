Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CFC433E6
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 11:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0101B64E58
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhBWLYm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhBWLYk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 06:24:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA6E64E58;
        Tue, 23 Feb 2021 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614079439;
        bh=7dt3WFcKWgMb17C1fabScSgpfGbLICDn6coc0lLO/Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y/IR/5jEBIqIMCL6h+smpsP71zMAAcNMreRaGQbwiQCsDmPtjxIgwzUCQ27Uk1TGh
         iV79xVfcA3nUiHJwMY5D9DnQk79pmyn7MiuE8/KxpE/7rTC12Kz3dphj/uYD5qGCTG
         xInK+LQa/ed6GdbFmjUP+aw70PNWmLApzWQ5UUOA=
Date:   Tue, 23 Feb 2021 12:23:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dingsenjie@163.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] tty/serial:Remove superfluous "breaks"
Message-ID: <YDTly/pUCjsgVpDG@kroah.com>
References: <20210223080630.44644-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223080630.44644-1-dingsenjie@163.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 23, 2021 at 04:06:30PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> Remove superfluous "breaks", as there is a "return" before them.
> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>
> ---
>  drivers/tty/serial/imx.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 425624d..6c1c31a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -300,7 +300,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
>  	switch (offset) {
>  	case UCR1:
>  		return sport->ucr1;
> -		break;
>  	case UCR2:
>  		/*
>  		 * UCR2_SRST is the only bit in the cached registers that might
> @@ -311,16 +310,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
>  		if (!(sport->ucr2 & UCR2_SRST))
>  			sport->ucr2 = readl(sport->port.membase + offset);
>  		return sport->ucr2;
> -		break;
>  	case UCR3:
>  		return sport->ucr3;
> -		break;
>  	case UCR4:
>  		return sport->ucr4;
> -		break;
>  	case UFCR:
>  		return sport->ufcr;
> -		break;
>  	default:
>  		return readl(sport->port.membase + offset);
>  	}
> -- 
> 1.9.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
