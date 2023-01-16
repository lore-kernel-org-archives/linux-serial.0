Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12591C46467
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 15:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjAPP3V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 10:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjAPP23 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 10:28:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6109223111
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 07:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0536E61007
        for <linux-serial@vger.kernel.org>; Mon, 16 Jan 2023 15:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC22C433EF;
        Mon, 16 Jan 2023 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673882629;
        bh=it0pkYXTAx8Hru0WRIy1t0XiKdnjq1cBLA/oVDeMr6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZo95OzBRc3B3DFMD3O5YJ4yCk+3KYzMFsqM/183sQJQivshyvwvjGhSHPFmRg9ih
         vH7gyHcpcaomycD85hAF71k9H+M/E66kwyu9uiNjxGlhE9SLud3z7MN9+UakREP/3m
         6y7K9OlFYxfrWVN7w4xdqjT6s71+7/T8ewQnCuGoGSl9SK45X6mrkDnUwiaWxTQZs3
         wkiu52oDUxosVHQsospWezOEUneJrH14XBN4SV73w4MnKiMbNSipmpzvWe68vRuPxi
         W/WFn5izak04CGqB6aR8BpBmLGUUb8g6uQBvjGDyOiuI5stKePyWI62xDhdvu6XCDj
         +haBh/U/a/8tQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHRLD-0005Tk-O1; Mon, 16 Jan 2023 16:24:08 +0100
Date:   Mon, 16 Jan 2023 16:24:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Tomasz =?utf-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 3/8] serial: imx: do not sysrq broken chars
Message-ID: <Y8VsFx3p+viCp1It@hovoldconsulting.com>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230113184334.287130-1-sorganov@gmail.com>
 <20230113184334.287130-4-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113184334.287130-4-sorganov@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 13, 2023 at 09:43:29PM +0300, Sergey Organov wrote:
> Do not call uart_handle_sysrq_char() if we got any receive error along with
> the character, as we don't want random junk to be considered a sysrq.
> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e7fce31e460d..1c950112a598 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -911,9 +911,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  				continue;
>  		}
>  
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> -			continue;
> -
>  		if (unlikely(rx & URXD_ERR)) {
>  			if (rx & URXD_BRK)
>  				sport->port.icount.brk++;
> @@ -942,7 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>  				flg = TTY_OVERRUN;
>  
>  			sport->port.sysrq = 0;
> -		}
> +		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> +			continue;

Nit: missing braces {}

Note that you could also place just place this after the block due to
the reset of the sysrq time stamp.

>  
>  		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
>  			goto out;

Johan
