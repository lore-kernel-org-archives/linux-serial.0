Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF78C4361B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FF32343F
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 11:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgLILX3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:23:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36653 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgLILX1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 06:23:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so2599919lfb.3
        for <linux-serial@vger.kernel.org>; Wed, 09 Dec 2020 03:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5e2aSFjarWQkLVbbkT+U1TSmzSIUt4+5IUsX9H9cmb0=;
        b=SAMgBYhx3vK2pyWxeKfGlKLph7mHrqKfpQWNEiSSpu9KpQqP7x3eM3yH91To7m6qW9
         0dOxQb2CNvM+V3RLTzee8LWYwLaOk0CZ0EAH4Rzmsf3m2bRYlwgoPi+ILHPefwWE8Xok
         /i844AxU0KoChSkEqNz+2fKVf1A2gEeDdMJtqo/WGGtsGwIiW3yzNeRLRKwZs/XSPXdd
         LQ6qWqYKdrfe4LLrBHV6Mft4UPpasD1YoTUxnT0gpzmk87MZsNbEVWfXdLJoUCReLQFa
         zNpDmgK/fxMg1n3n53dqek32zOpZHivnHRXTpGfip/a5LVlOhdJMxeKpkKwfuHNheFI8
         Lvrg==
X-Gm-Message-State: AOAM532PZFeZPTxRUVbCJmjt8J3/ZeHtrlBYPJjZQXhlMcWVNDD5gykm
        2BgcfqZ1ZBuAKauNE425CKI=
X-Google-Smtp-Source: ABdhPJz4tDG7dKUgK4ityFmg3vSOGhRLJ/zP52TGKw7ZCw4shjkEUgDQXycsjH6d4iUmEOJtvcTqfA==
X-Received: by 2002:ac2:548b:: with SMTP id t11mr839549lfk.181.1607512965721;
        Wed, 09 Dec 2020 03:22:45 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y13sm139426lfg.189.2020.12.09.03.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:22:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmxZ7-0003bm-8G; Wed, 09 Dec 2020 12:23:25 +0100
Date:   Wed, 9 Dec 2020 12:23:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: 8250: always call tx_chars under
 spinlock
Message-ID: <X9CzrUVgyqeuREKK@localhost>
References: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209091728.2357-1-s.trumtrar@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 09, 2020 at 10:17:27AM +0100, Steffen Trumtrar wrote:
> In most cases serial8250_tx_chars is called with spinlock held.
> Fix the remaining location, too.

Please explain where __start_tx() is called without holding the port
lock and consider fixing that up.

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_port.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index b0af13074cd3..3310c2b70138 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1559,6 +1559,7 @@ static void serial8250_stop_tx(struct uart_port *port)
>  static inline void __start_tx(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned long flags;
>  
>  	if (up->dma && !up->dma->tx_dma(up))
>  		return;
> @@ -1569,8 +1570,11 @@ static inline void __start_tx(struct uart_port *port)
>  
>  			lsr = serial_in(up, UART_LSR);
>  			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> -			if (lsr & UART_LSR_THRE)
> +			if (lsr & UART_LSR_THRE) {
> +				spin_lock_irqsave(&port->lock, flags);
>  				serial8250_tx_chars(up);
> +				spin_unlock_irqrestore(&port->lock, flags);
> +			}

Since several callers of __start_tx() do hold the lock, this change will
introduce a deadlock.

>  		}
>  	}

Johan
