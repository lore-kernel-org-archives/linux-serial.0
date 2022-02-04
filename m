Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39758C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  4 Feb 2022 14:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359279AbiBDO3d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiBDO3d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Feb 2022 09:29:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8DC061714;
        Fri,  4 Feb 2022 06:29:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB32DB82199;
        Fri,  4 Feb 2022 14:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC4C004E1;
        Fri,  4 Feb 2022 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643984970;
        bh=D/EuuGXSzxm5jQmG0yfAnA0DseWHmX4BbSRslKR0zts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeifHCnWRVPB5F5K5vbw2uhzB7sVXNnidcHEf9PKyWXKA5TZbH6thLNgQFX9pOnhN
         cjWsGoU5jaxoORERW54DFIT6svmFoanX8e8k/WKts27re+NhmqxTiA9w2YDAlUsm7t
         vBPyfUAkkE4BWiZrM/VZI/0PpNoMPqJoQffeu4wg=
Date:   Fri, 4 Feb 2022 15:29:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Drop duplicate NULL check in
 uart_*shutdown()
Message-ID: <Yf04R+REP6WahIIr@kroah.com>
References: <20220202165648.5610-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202165648.5610-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 02, 2022 at 06:56:48PM +0200, Andy Shevchenko wrote:
> The free_page(addr), which becomes free_pages(addr, 0) checks addr
> against 0. No need to repeat this check in the callers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57f472268b6d..59f93040d807 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -328,8 +328,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	state->xmit.buf = NULL;
>  	spin_unlock_irqrestore(&uport->lock, flags);
>  
> -	if (xmit_buf)
> -		free_page((unsigned long)xmit_buf);
> +	free_page((unsigned long)xmit_buf);
>  }
>  
>  /**
> @@ -1621,8 +1620,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
>  	state->xmit.buf = NULL;
>  	spin_unlock_irq(&uport->lock);
>  
> -	if (buf)
> -		free_page((unsigned long)buf);
> +	free_page((unsigned long)buf);
>  }
>  
>  static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
> -- 
> 2.34.1
> 

What branch is this against?  It fails to apply to my tty-next branch :(
