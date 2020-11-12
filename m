Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8426C2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 08:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDEF221FE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zuZKZ8HG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKLIjP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Nov 2020 03:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgKLIjO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Nov 2020 03:39:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4413720825;
        Thu, 12 Nov 2020 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605170353;
        bh=PCpzkYtNiX/wqGEaW7OrM0P5FLIoDYCVNCAdNEqwluY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zuZKZ8HGaPEDZPaKalWedXqQgGySuwo6cTXBr0e3MQhS+HTRmP90wi/2BtE1gQSkm
         OcdVRMpR7BFer90GdUBlKxNTtF+7DrYR8mqLXLZUsS/vOQR6chAjsOY+zKSW6cxTeZ
         prT0yc0gLYapBLAxilJ2Xl/cXuQME6mXXHVaMGak=
Date:   Thu, 12 Nov 2020 09:40:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fugang Duan <fugang.duan@nxp.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        lukas@wunner.de
Subject: Re: [PATCH v2 tty/serial 1/1] tty: serial: imx: keep console clocks
 always on
Message-ID: <X6z07OYQW9yUUFPE@kroah.com>
References: <20201111025136.29818-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111025136.29818-1-fugang.duan@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 11, 2020 at 10:51:36AM +0800, Fugang Duan wrote:
> For below code, there has chance to cause deadlock in SMP system:
> Thread 1:
> clk_enable_lock();
> pr_info("debug message");
> clk_enable_unlock();
> 
> Thread 2:
> imx_uart_console_write()
> 	clk_enable()
> 		clk_enable_lock();
> 
> Thread 1:
> Acuired clk enable_lock -> printk -> console_trylock_spinning
> Thread 2:
> console_unlock() -> imx_uart_console_write -> clk_disable -> Acquite clk enable_lock
> 
> So the patch is to keep console port clocks always on like
> other console drivers.
> 
> Fixes: 1cf93e0d5488 ("serial: imx: remove the uart_console() check")
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
> v2: Add fixes tag in commit message.
> ---
>  drivers/tty/serial/imx.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1731d9728865..4d6c009ddc31 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2004,15 +2004,6 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>  	int locked = 1;
>  	int retval;
>  
> -	retval = clk_enable(sport->clk_per);
> -	if (retval)
> -		return;
> -	retval = clk_enable(sport->clk_ipg);
> -	if (retval) {
> -		clk_disable(sport->clk_per);
> -		return;
> -	}
> -
>  	if (sport->port.sysrq)
>  		locked = 0;
>  	else if (oops_in_progress)
> @@ -2047,9 +2038,6 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>  
>  	if (locked)
>  		spin_unlock_irqrestore(&sport->port.lock, flags);
> -
> -	clk_disable(sport->clk_ipg);
> -	clk_disable(sport->clk_per);
>  }
>  
>  /*
> @@ -2150,15 +2138,14 @@ imx_uart_console_setup(struct console *co, char *options)
>  
>  	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
>  
> -	clk_disable(sport->clk_ipg);
>  	if (retval) {
> -		clk_unprepare(sport->clk_ipg);
> +		clk_disable_unprepare(sport->clk_ipg);
>  		goto error_console;
>  	}
>  
> -	retval = clk_prepare(sport->clk_per);
> +	retval = clk_prepare_enable(sport->clk_per);
>  	if (retval)
> -		clk_unprepare(sport->clk_ipg);
> +		clk_disable_unprepare(sport->clk_ipg);
>  
>  error_console:
>  	return retval;
> -- 
> 2.17.1
> 

Did you test build this change and totally ignore the build warning you
now get:

drivers/tty/serial/imx.c: In function ‘imx_uart_console_write’:
drivers/tty/serial/imx.c:2011:6: warning: unused variable ‘retval’ [-Wunused-variable]
 2011 |  int retval;
      |      ^~~~~~

Not good...

I'll go fix it.

greg k-h
