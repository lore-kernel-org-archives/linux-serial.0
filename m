Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5254FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EEC61452
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 07:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348848AbhI3H42 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348701AbhI3H42 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 03:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A88E61527;
        Thu, 30 Sep 2021 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632988486;
        bh=OiXgFJskGnrAjQHW5jvOa+L3VBpqy62OF3JwEaOZj/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cal4QdR9imqTGjSkFSQzdx5rMZ0UpWKEbaefZQiahKYwaMVRRTu8Ff5EqTh43uXo6
         dP3NPQqQLpIexGnzm7mGC2KpliLtUkkTcXCGS+5tjJsZ1sD9k1NbDOgTobQg1m198Y
         igS5b0tqr5apuopYdX5g8Y9H7KyjGc025bQ4ylhi5AFJxChjYY2+WAwrZ8/Rt21NIc
         NVeRc0+YbA5BQ/fm56J0XcSA0+OZCvlWRvZDEwXtgqC1D57guiNafB4MfhDDjcI0CK
         xRDwQLGHdtp1bPK0qLeUB61VRr9C42qL0s1+GCAU3CEA5KwUkjQtEtau/fdVCjWbGm
         kEVry2gxP7Jew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mVqtz-0005mt-2Y; Thu, 30 Sep 2021 09:54:47 +0200
Date:   Thu, 30 Sep 2021 09:54:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     gregkh@linuxfoundation.org, michael@walle.cc,
        linux-serial@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH v2] serial: imx: Fix sysrq deadlock
Message-ID: <YVVtRw/JlUzn4H54@hovoldconsulting.com>
References: <20210929214324.44910-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929214324.44910-1-festevam@denx.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 29, 2021 at 06:43:24PM -0300, Fabio Estevam wrote:
> The following sysrq command causes the following deadlock:
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
> fsl_lpuart: split sysrq handling"), which calls 
> uart_unlock_and_check_sysrq() to drop the lock prior to 
> uart_handle_sysrq_char().
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - I noticed that when sending break + t via the terminal, the characters
> were sometimes lost. Do the minimal changes to fix the deadlock without
> missing the sysrq input.
> 
>  drivers/tty/serial/imx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..1c768dd3896d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -788,6 +788,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  	unsigned int rx, flg, ignored = 0;
>  	struct tty_port *port = &sport->port.state->port;
>  
> +	uart_unlock_and_check_sysrq(&sport->port);

This is just so broken; you can't just drop the lock. And you clearly
haven't even tried to understand how uart_unlock_and_check_sysrq()
works.

Please take a closer look at the commit you're trying to mimic.

>  	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
>  		u32 usr2;
>  
> @@ -846,6 +847,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  out:
>  	tty_flip_buffer_push(port);
>  
> +	spin_lock(&sport->port.lock);
>  	return IRQ_HANDLED;
>  }

Johan
