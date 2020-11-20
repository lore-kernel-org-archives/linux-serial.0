Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C60AC5519F
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA01223BE
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 08:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgKTIPZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 03:15:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38666 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTIPZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 03:15:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id r17so9144570ljg.5;
        Fri, 20 Nov 2020 00:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDs6obGTLR1+wdJ6BVB6dndSCVFd0as/yCTkI8gYmPU=;
        b=Y/xPta9rvf7YKf4ZukcFJI5daQExV4qAMp40tpHdLOeUXuDb6YQ0Nxn36UQg1WFNWs
         fkReHJeQ3naoM3VQIjwZ4XVldStY0TJ4BX2LJ8ljlAp9zjrmI/dctR7Sy3LjiuAR0RZf
         n5u3UgKtTb7Wpcows8hreTNurE4CBobwpn9BgT9wsI6TYy+BvPbn5da0v2yMBt/pbPfs
         YxdbVnX9O4VvnKXJ5819YZ+C2ZRHA/VH0B0yhsnXZ7dbMBaozuXOx1HM61V3+wbNAlkL
         +tndx23C+gMd01/d6rBC9swXLkwR/9RZbQ6KsluVbq7OdjbdHmelrz22gCHGCiAZ36dF
         otIg==
X-Gm-Message-State: AOAM533G7gzApWGtyW1HkeXxnghiEHXppCuKQLaVJyKO9P7gEUnk4AIa
        iUwdqeKeA4LttgM9uv9u0d8=
X-Google-Smtp-Source: ABdhPJxmm2fXT+CqTHKLbKnoL9h2nvyj3DpRahFss6PyhtuoOWUmAs/POQ+0B/EFEX06/htv9hKBVw==
X-Received: by 2002:a2e:9005:: with SMTP id h5mr6752085ljg.59.1605860122921;
        Fri, 20 Nov 2020 00:15:22 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id p25sm261261lfc.125.2020.11.20.00.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 00:15:21 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kg1Zl-0006KK-9f; Fri, 20 Nov 2020 09:15:26 +0100
Date:   Fri, 20 Nov 2020 09:15:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: rad-uart: replace spin_lock_irqsave by
 spin_lock in hard IRQ
Message-ID: <X7d7HXBp01JN5It5@localhost>
References: <1605835613-28359-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605835613-28359-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 20, 2020 at 09:26:53AM +0800, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/tty/serial/rda-uart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
> index 85366e0..d6705a0 100644
> --- a/drivers/tty/serial/rda-uart.c
> +++ b/drivers/tty/serial/rda-uart.c
> @@ -406,10 +406,9 @@ static void rda_uart_receive_chars(struct uart_port *port)
>  static irqreturn_t rda_interrupt(int irq, void *dev_id)
>  {
>  	struct uart_port *port = dev_id;
> -	unsigned long flags;
>  	u32 val, irq_mask;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	spin_lock(&port->lock);

This will break with forced irq threading (i.e. "threadirqs") since the
console code can still end up being called from interrupt context (which
can result in a deadlock).

>  
>  	/* Clear IRQ cause */
>  	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
> @@ -426,7 +425,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
>  		rda_uart_send_chars(port);
>  	}
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	spin_unlock(&port->lock);
>  
>  	return IRQ_HANDLED;
>  }

Johan
