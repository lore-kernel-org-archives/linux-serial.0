Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059BFC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9D461A55
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 07:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352547AbhJAHyd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 03:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhJAHyd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 03:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF5D619F7;
        Fri,  1 Oct 2021 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633074769;
        bh=F7vCTf8aUkS3mIGbaMfgFBtWgfqMgiQGONP77SM/h+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVdb5bYJSDOFaT6eZ9iS3vtdnfR3WC27BDdiu8LyIaMF4x6P0DctBdV9ubtMX/TFg
         T8h+Qp+bC5jDF0hd91Wvssdevl8vcVGryVSw1aCEh0Bu3aqQtlS7zZiis6s1s2GyBb
         E128iMtV+x0i0W1WK5zIjpThRrHpMS5o5Bj6mpOrObWCr93m5YS6L76APmDsFKI1/E
         ZxvuIVQZCICrtUxy9fKjt7JzGCX8iVH+jIDvFkp71/1r2nkS+wRT9117Lx2qXBTaHM
         qHcrsPndHrxelzUoyR6l0t8DmL8gbJ2niOeOC+LDz2tEpvSqzVvE4lgpRe8UMJbo9h
         nMYQRkEYmCxhQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mWDLg-0007eo-6i; Fri, 01 Oct 2021 09:52:52 +0200
Date:   Fri, 1 Oct 2021 09:52:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2] serial: imx: Fix sysrq deadlock
Message-ID: <YVa+VL5W+Gnp7TUa@hovoldconsulting.com>
References: <20210929214324.44910-1-festevam@denx.de>
 <YVVtRw/JlUzn4H54@hovoldconsulting.com>
 <bae11ec74a0515841ad36403b9f5a47b@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae11ec74a0515841ad36403b9f5a47b@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 30, 2021 at 10:45:31AM -0300, Fabio Estevam wrote:
> Hi Johan,
> 
> On 30/09/2021 04:54, Johan Hovold wrote:
> 
> > This is just so broken; you can't just drop the lock. And you clearly
> > haven't even tried to understand how uart_unlock_and_check_sysrq()
> > works.
> > 
> > Please take a closer look at the commit you're trying to mimic.
> 
> Thanks for the feedback.
> 
> I have changed it to:
> 
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..b7cda50602d5 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -803,7 +803,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
> *dev_id)
>   				continue;
>   		}
> 
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> +		if (uart_prepare_sysrq_char(&sport->port, rx))

Why did you drop the cast? If there's anything in the high bits you'd
see the help text printed as you report below (even if it seems
unlikely).

>   			continue;
> 
>   		if (unlikely(rx & URXD_ERR)) {
> @@ -844,6 +844,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
> *dev_id)
>   	}
> 
>   out:
> +	uart_unlock_and_check_sysrq(&sport->port);
>   	tty_flip_buffer_push(port);
> 
>   	return IRQ_HANDLED;
> @@ -959,6 +960,7 @@ static irqreturn_t imx_uart_int(int irq, void 
> *dev_id)
>   		imx_uart_writel(sport, USR1_AGTIM, USR1);
> 
>   		__imx_uart_rxint(irq, dev_id);
> +		spin_lock(&sport->port.lock);
>   		ret = IRQ_HANDLED;
>   	}

It's a step in the right direction, but you need to restructure the code
so that you don't need to drop and reacquire the lock.

> @@ -1977,9 +1979,7 @@ imx_uart_console_write(struct console *co, const 
> char *s, unsigned int count)
>   	unsigned int ucr1;
>   	int locked = 1;
> 
> -	if (sport->port.sysrq)
> -		locked = 0;
> -	else if (oops_in_progress)
> +	if (oops_in_progress)
>   		locked = spin_trylock_irqsave(&sport->port.lock, flags);
>   	else
>   		spin_lock_irqsave(&sport->port.lock, flags);

And you need to fix the commit summary and commit message since you're
actually fixing any deadlock. You're just suppressing a false positive
lockdep warning due to the above sysrq hack.

> This makes the deadlock not happen after running:
> echo t > /proc/sysrq-trigger
> 
> , but entering <break> + t via the console does not work anymore.
> 
> 
> It returns the sysrq help instead:
> 
> sysrq: HELP : loglevel(0-9) reboot(b) crash(c) show-all-locks(d) 
> terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) 
> thaw-filesystems(j) sak(k) show-backtrace-all-active-cpu
> s(l) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) 
> show-registers(p) show-all-timers(q) unraw(r) sync(s) 
> show-task-states(t) unmount(u) show-blocked-tasks(w) 
> dump-ftrace-buffer(z)

So either you're just pushing garbage to the sysrq handler due to the
dropped cast above or you may, for example, have a NUL char in the
receiver due to the break that you don't discard.

I'd start with logging the key that gets passed to the sysrq handler.

Johan
