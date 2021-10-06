Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C13C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B042161019
	for <linux-serial@archiver.kernel.org>; Wed,  6 Oct 2021 08:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhJFIMQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237592AbhJFIMQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Oct 2021 04:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9DE61139;
        Wed,  6 Oct 2021 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633507824;
        bh=8/7SOE9B9Ak3yZeHX9X6qT9a3p3qkgUqsXF5o0zJgvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+Kfq08JWg8j0OrEp75yQUApWZDovWTMoLDdLbuRh0EocV/2JKOWokkZClOWBwocm
         bYHiAg4x8jGX+RCKO/bCen7NOwL7y6+79jq2wtLQ2z3mYTCCzg+IkE/5DDOrIR4GJ/
         wg5L2wDPpeA/dTR5XWKwFJNP2W3DQBZL7XLU0EIJao2fP4vI9YDy9C6HuNkZw3DO9X
         Z4WG4m7lVfM14vbYHMLehCRQlXYfV5fX7IA8zx1xq+osfPACEN3mjKl48FWanA6SK/
         fVD6vmFAy+HR458HndBNA/FqCRwuscSXF965uHxh2snw/otLuRv341smk8roUx1L6m
         3rjOKUPbyEMLQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mY20O-0005Ii-Qs; Wed, 06 Oct 2021 10:10:24 +0200
Date:   Wed, 6 Oct 2021 10:10:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de,
        u.kleine-koenig@pengutronix.de, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]  serial: imx: Suppress false positive sysrq lockdep
 warning
Message-ID: <YV1Z8JslFiBSFGJF@hovoldconsulting.com>
References: <20211001101815.729648-1-festevam@denx.de>
 <YVcTluYb6XOiOXZn@hovoldconsulting.com>
 <0bbe2832eb2dc3a7c32f3d484ab42208@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bbe2832eb2dc3a7c32f3d484ab42208@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 01, 2021 at 11:15:33PM -0300, Fabio Estevam wrote:
> On 01/10/2021 10:56, Johan Hovold wrote:
> 
> > No, no, no.
> > 
> > Just replace this unlock with uart_unlock_and_check_sysrq() and do the
> > corresponding change in imx_uart_int(). The result is an even smaller
> > diff than what you're currently proposing and without any performance
> > penalty from dropping and reacquiring the lock.
> 
> Just to be clear, this is something that I have also tried:
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..b652908f0bf1 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -803,7 +803,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
> *dev_id)
>   				continue;
>   		}
> 
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> +		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
>   			continue;
> 
>   		if (unlikely(rx & URXD_ERR)) {
> @@ -858,7 +858,7 @@ static irqreturn_t imx_uart_rxint(int irq, void 
> *dev_id)
> 
>   	ret = __imx_uart_rxint(irq, dev_id);
> 
> -	spin_unlock(&sport->port.lock);
> +	uart_unlock_and_check_sysrq(&sport->port);
> 
>   	return ret;
>   }
> @@ -991,7 +991,7 @@ static irqreturn_t imx_uart_int(int irq, void 
> *dev_id)
>   		ret = IRQ_HANDLED;
>   	}
> 
> -	spin_unlock(&sport->port.lock);
> +	uart_unlock_and_check_sysrq(&sport->port);
> 
>   	return ret;
>   }

> , but still get the lockdep warning in this case.

Ok, thanks for testing. The above is what I meant and it does fix the
false-positive lockdep splat which motivated
uart_unlock_and_check_sysrq() to be added in the first place.

Looking closer at the splat you reported (which you've edited quite
heavily), it becomes apparent that you are now hitting a different
locking issue. And it's not a false positive this time.

There a problem with the workqueue debugging code, which unless fixed at
the source, would prevent any console driver from queueing work while
holding a lock also taken in their write paths. And
tty_flip_buffer_push() is just one example of many.

I can easily reproduce the splat with another serial driver, and I've
also been able to trigger the actual deadlock.

I've prepared a patch that takes care of the workqueue state dumping,
which I'll send as a reply to this mail. Would you mind giving it a spin
with the imx driver as well?

Note that you may hit the other, false-positive, lockdep splat when
running with the workqueue fix, but the above diff should then address
that.

Johan
