Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC8C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 09:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D4C610CC
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 09:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhEJKBB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 May 2021 06:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEJKBB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 May 2021 06:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 987BA610CB;
        Mon, 10 May 2021 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620640796;
        bh=1Fqt/lO6W2UB2zlaP0nG7zj/PsW8gJl/kBA6a/ThXiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=si4s5LjHLsd9wxgbTQsIUjfE6g8ovLGQpYuozMGQemIvJZTNrvoD65gSRIm7sTmPM
         LOIrfyeG5aAc+Dbz6vQmXWJKnkT/65NH+Tcrj50mHTFnbJe1kol2E25p7bGVeaxUp5
         WZALA4tn4tCY3hCDQPyrg+eWG9Cnag5gSJ6dcfz7YvVIcGazVFLNk0vJcrH6Kk8UeE
         QOpdMfW5iOy9OKw2VnEVH9f1teISR4Yw5jQNc+7jcM6pss8EOeu4p6ilVUnwIl0foM
         /3WT7lrT3zvBuQCNJCdpbHyUexLIZU3PpZ3HfEnPfSTq58g+2BssX5xB2EV7jOuDoG
         bKjJEC9N62EJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lg2hj-00028v-Iu; Mon, 10 May 2021 11:59:59 +0200
Date:   Mon, 10 May 2021 11:59:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Lin <dtwlin@gmail.com>, Alex Elder <elder@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 35/35] tty: make use of tty_get_byte_size
Message-ID: <YJkEH+WVukPqne6w@hovoldconsulting.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-36-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505091928.22010-36-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 05, 2021 at 11:19:28AM +0200, Jiri Slaby wrote:
> In the previous patch, we introduced tty_get_byte_size for computing
> byte size. Here, we make use of it in various tty drivers.
> 
> The stats look nice: 16 insertions, 203 deletions.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c           |  8 +-----
>  drivers/staging/greybus/uart.c              | 16 +----------
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 19 +-----------
>  drivers/tty/serial/mxs-auart.c              | 18 +-----------
>  drivers/tty/serial/qcom_geni_serial.c       | 16 +----------
>  drivers/tty/serial/sh-sci.c                 | 20 +------------
>  drivers/tty/serial/stm32-usart.c            | 32 +--------------------
>  drivers/tty/synclink_gt.c                   |  9 +-----
>  drivers/usb/class/cdc-acm.c                 | 17 ++---------
>  drivers/usb/serial/belkin_sa.c              | 21 ++------------
>  drivers/usb/serial/cypress_m8.c             | 19 ++----------
>  drivers/usb/serial/pl2303.c                 | 15 +---------
>  drivers/usb/serial/whiteheat.c              |  9 +-----
>  13 files changed, 16 insertions(+), 203 deletions(-)

> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index f414d6acad69..a5cbd7324268 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -971,23 +971,7 @@ static void mxs_auart_settermios(struct uart_port *u,
>  	ctrl2 = mxs_read(s, REG_CTRL2);
>  
>  	/* byte size */
> -	switch (cflag & CSIZE) {
> -	case CS5:
> -		bm = 0;
> -		break;
> -	case CS6:
> -		bm = 1;
> -		break;
> -	case CS7:
> -		bm = 2;
> -		break;
> -	case CS8:
> -		bm = 3;
> -		break;
> -	default:
> -		return;
> -	}
> -
> +	bm = tty_get_byte_size(cflag, false) - 5;

This looks weird. The 0..3 constants are really "magic constants"
representing the different word sizes. Subtracting an offset obfuscates
this. Perhaps better left unchanged or add an appropriately names define
for the offset to make it clear what is going on here.

> diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
> index 1dca04e1519d..b135ed1ee512 100644
> --- a/drivers/usb/serial/cypress_m8.c
> +++ b/drivers/usb/serial/cypress_m8.c
> @@ -887,23 +887,8 @@ static void cypress_set_termios(struct tty_struct *tty,
>  	} else
>  		parity_enable = parity_type = 0;
>  
> -	switch (cflag & CSIZE) {
> -	case CS5:
> -		data_bits = 0;
> -		break;
> -	case CS6:
> -		data_bits = 1;
> -		break;
> -	case CS7:
> -		data_bits = 2;
> -		break;
> -	case CS8:
> -		data_bits = 3;
> -		break;
> -	default:
> -		dev_err(dev, "%s - CSIZE was set, but not CS5-CS8\n", __func__);
> -		data_bits = 3;
> -	}
> +	data_bits = tty_get_byte_size(cflag, false) - 5;
> +

Same here.

>  	spin_lock_irqsave(&priv->lock, flags);
>  	oldlines = priv->line_control;
>  	if ((cflag & CBAUD) == B0) {
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index fd773d252691..76e4d90a9d43 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -788,20 +788,7 @@ static void pl2303_set_termios(struct tty_struct *tty,
>  
>  	pl2303_get_line_request(port, buf);
>  
> -	switch (C_CSIZE(tty)) {
> -	case CS5:
> -		buf[6] = 5;
> -		break;
> -	case CS6:
> -		buf[6] = 6;
> -		break;
> -	case CS7:
> -		buf[6] = 7;
> -		break;
> -	default:
> -	case CS8:
> -		buf[6] = 8;
> -	}
> +	buf[6] = tty_get_byte_size(C_CSIZE(tty), false);

Passing tty->termios would be better, but either way no need to mask off
the non CSIZE bits here.

Johan
