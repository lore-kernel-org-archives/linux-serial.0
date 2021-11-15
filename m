Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C5C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EC360FD7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhKONww (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhKONwv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 08:52:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03C6361C4F;
        Mon, 15 Nov 2021 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636984196;
        bh=9B2oJRJxG0SJ+JZ2MNk1YlpKJQB4Zx9ha0guFFwe9WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVebcUbGdcpMKpdjGnRNy/CNjGzIMTt1/m42tywHEMJujyn+13a21Fx/TUCBqbRtn
         0a6p2ylxy9ft6kl7eEyAsWpt91JgbEjV4p6JuNlvBoDplgkwUpvibBdIi+6UHgVGmh
         cNXEohgmP4iSwDIlrkChM8MfAPJODGyImuWaclW387mGyqSdAiGCWYmoleJHAuiedd
         VyuDz0kaPISaLCeyZCc+eKRT7EfGa92039+94O1euo9dvw5MpgkZKsqx1beSPI8YzN
         0hweZDz6jjlSbA0wy/A4GBDLEmqL05AlYDFHLGE0ZbHkur2eBhV4yB24PbjpvFbzdF
         HrG1dZQfc0Dfw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mmcMg-00033B-4O; Mon, 15 Nov 2021 14:49:42 +0100
Date:   Mon, 15 Nov 2021 14:49:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ilia Sergachev <silia@ethz.ch>
Cc:     linux-serial@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: liteuart: fix missing drvdata
Message-ID: <YZJldkD/yxZtoANS@hovoldconsulting.com>
References: <20211115105458.6407e1aa@dtkw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115105458.6407e1aa@dtkw>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 15, 2021 at 10:54:58AM +0100, Ilia Sergachev wrote:
> drvdata has to be set in _probe() - otherwise platform_get_drvdata()
> causes null pointer dereference BUG in _remove()
> 
> Fixes: 1da81e5562fa ("drivers/tty/serial: add LiteUART driver")
> Signed-off-by: Ilia Sergachev <silia@ethz.ch>
> ---
> v1 -> v2: add Fixes:
> 
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

Looks good:

Reviewed-by: Johan Hovold <johan@kernel.org>

There are more issues with driver unbind than this though as the port is
never deregistered. I've fixed it up on top of this patch:

	https://lore.kernel.org/r/20211115133745.11445-1-johan@kernel.org

Johan
