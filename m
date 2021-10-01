Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A2DC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF41611C0
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 13:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJAN6V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 09:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353732AbhJAN6T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 09:58:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB0760F6B;
        Fri,  1 Oct 2021 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633096595;
        bh=zgkrIIeoLye/x4Ym5eyxe7AswPlX/KZQtqinEUcnwGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nexB9SL+cxKcJ7+Pwj8CsmB+Plw6kzSCjBY0QPUi2++4hRdCFesm76i3QH7NIyZm9
         Q5dvsKCvZppj7XotLjQUdHJt/jFjjH3mJIRdpEgfUI5zkmwpowK3v+UVnx1QRsf6gJ
         bk5VAvv72XKHrwWqjs0CnoUmJ+Y+oWYPEZXGw4CSKTcmrs6i1CH27A7+7yVfG96wOZ
         q/pf6b66w2Aqr7Y+v/SzskA1GOTe+cx7L/b6gV8yIEIdvodWyJqFxA1dDETfGmT4eh
         Hk1edinQEWFCCXnrKjbsNIHjJtZ7CBPBY4s/81LYEWWgeARoA/6AeciJGMoWQG7HIK
         +kyH6qhYEldXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mWJ1i-0008Sh-6x; Fri, 01 Oct 2021 15:56:38 +0200
Date:   Fri, 1 Oct 2021 15:56:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3]  serial: imx: Suppress false positive sysrq lockdep
 warning
Message-ID: <YVcTluYb6XOiOXZn@hovoldconsulting.com>
References: <20211001101815.729648-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001101815.729648-1-festevam@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 01, 2021 at 07:18:15AM -0300, Fabio Estevam wrote:
> The following sysrq command causes the following lockdep warning:
> 
>  # echo t > /proc/sysrq-trigger
>  ....
> [   20.325246] ======================================================
> [   20.325252] WARNING: possible circular locking dependency detected
> [   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
> Not tainted
> [   20.325273] ------------------------------------------------------
> [   20.325279] sh/236 is trying to acquire lock:
> [   20.325293] c1618614 (console_owner){-...}-{0:0}, at:
> console_unlock+0x180/0x5bc
> [   20.325361]
> [   20.325361] but task is already holding lock:
> [   20.325368] eefccc90 (&pool->lock){-.-.}-{2:2}, at:
> show_workqueue_state+0x104/0x3c8
> [   20.325432]
> [   20.325432] which lock already depends on the new lock.
> 
> ...
> 
> [   20.325657] -> #2 (&pool->lock/1){-.-.}-{2:2}:
> [   20.325690]        __queue_work+0x114/0x810
> [   20.325710]        queue_work_on+0x54/0x94
> [   20.325727]        __imx_uart_rxint.constprop.0+0x1b4/0x2e0
> [   20.325760]        imx_uart_int+0x270/0x310
> 
> This problem happens because uart_handle_sysrq_char() is called
> with the lock held.
> 
> Fix this by using the same approach done in commit 5697df7322fe ("serial:
> fsl_lpuart: split sysrq handling"), which calls uart_prepare_sysrq_char()
> and uart_unlock_and_check_sysrq() instead.
> 
> Its commit log says:
> 
> "Instead of uart_handle_sysrq_char() use uart_prepare_sysrq_char() and
> uart_unlock_and_check_sysrq(). This will call handle_sysrq() without
> holding the port lock, which in turn let us drop the spin_trylock hack."
> 
> Do the same here to suppress the false positive lockdep warning.
> 
> As __imx_uart_rxint() drops the lock now, remove the spin_unlock()
> inside imx_uart_rxint(), which is only used on i.MX1.
> 
> Tested on a i.MX7D board via 'echo t > /proc/sysrq-trigger' in the
> command line and also by passing the "<break> + t" keys in
> the serial console.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Keep the cast when calling uart_prepare_sysrq_char() - Johan
> - Improve commit log and subject - Johan

You changed more things since v2 as that was the broken version that
just dropped the lock.

>  drivers/tty/serial/imx.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..a0135718c588 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -803,7 +803,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  				continue;
>  		}
>  
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> +		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
>  			continue;
>  
>  		if (unlikely(rx & URXD_ERR)) {
> @@ -844,6 +844,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  	}
>  
>  out:
> +	uart_unlock_and_check_sysrq(&sport->port);
>  	tty_flip_buffer_push(port);
>  
>  	return IRQ_HANDLED;
> @@ -852,15 +853,10 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
>  {
>  	struct imx_port *sport = dev_id;
> -	irqreturn_t ret;
>  
>  	spin_lock(&sport->port.lock);
>  
> -	ret = __imx_uart_rxint(irq, dev_id);
> -
> -	spin_unlock(&sport->port.lock);

No, no, no.

Just replace this unlock with uart_unlock_and_check_sysrq() and do the
corresponding change in imx_uart_int(). The result is an even smaller
diff than what you're currently proposing and without any performance
penalty from dropping and reacquiring the lock.

> -
> -	return ret;
> +	return __imx_uart_rxint(irq, dev_id);
>  }
>  
>  static void imx_uart_clear_rx_errors(struct imx_port *sport);
> @@ -959,6 +955,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
>  		imx_uart_writel(sport, USR1_AGTIM, USR1);
>  
>  		__imx_uart_rxint(irq, dev_id);
> +		spin_lock(&sport->port.lock);
>  		ret = IRQ_HANDLED;
>  	}

Johan
