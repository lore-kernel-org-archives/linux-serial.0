Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193F2C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 07:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6F96321F
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 07:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhKOHFY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 02:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhKOHEz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 02:04:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA61361C14;
        Mon, 15 Nov 2021 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636959720;
        bh=tDHGMv9QNgNQzOclCW8qU+iwVjxwopfiqTR2s6WQL0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCLe6VkZDOXHcXwDrMhUwMdBOjZsZlpIoZRf7vhOEX5GQRdBqHoTPBL9y8yNokPk4
         dt0zUlEaOwUwT3t14Z3tstZKej58I0UQc/66czvZqFUr3B0vbHrzvDq4aeJuHAHx/+
         7/DRSFC2O97OrBli3fpjfZFTVTu3P5s/gFGU0vqE=
Date:   Mon, 15 Nov 2021 08:01:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilia Sergachev <silia@ethz.ch>
Cc:     linux-serial@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: liteuart: fix missing drvdata
Message-ID: <YZIF48DPkfgBf5H9@kroah.com>
References: <20211115031808.7ab632ef@dtkw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115031808.7ab632ef@dtkw>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 15, 2021 at 03:18:08AM +0100, Ilia Sergachev wrote:
> drvdata has to be set in _probe() - otherwise platform_get_drvdata()
> causes null pointer dereference BUG in _remove()
> 
> Signed-off-by: Ilia Sergachev <silia@ethz.ch>
> ---
>  drivers/tty/serial/liteuart.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index dbc0559a9157..f075f4ff5fcf 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -285,6 +285,8 @@ static int liteuart_probe(struct platform_device *pdev)
>  	port->line = dev_id;
>  	spin_lock_init(&port->lock);
>  
> +	platform_set_drvdata(pdev, port);
> +
>  	return uart_add_one_port(&liteuart_driver, &uart->port);
>  }
>  
> -- 
> 2.25.1

What commit does this fix?

thanks,

greg k-h
