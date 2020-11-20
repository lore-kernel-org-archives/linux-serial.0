Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571CEC5519F
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3037205CA
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgKTIW7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 03:22:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33231 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTIW7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 03:22:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id l11so12297973lfg.0;
        Fri, 20 Nov 2020 00:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igNyjk3ZPx8gip3TWBwYGkCHE1bwLNjhy25vHgmoofM=;
        b=ntrnyXrNEEaeUfDL8GLWp4xNBCDXlR3btQrEPT2eIsp7Jtxblf+y+XahrsRcywrvHq
         qIoeqiQvZqj4jaL1tgw1hPqCEIfOrsWr3ZAJalr6BRhWU8jXi/hWrRp98ratIE8zgGvg
         b4R3INVaGF9Xx1Sic+oJgeqgqMlq9CTVpMCISFb0Pd+rrQYKkUWS6BdAm3hq75l047He
         WFrywV2JgZM7n28jjXpuNOCqWFq+IerLjaG3vSmobmqdvLxEscfIdlsFUEhTzcXkwzQe
         XDkmrtG89F8whwFWDW3ylokdnJfMLmVpa0waMsvkkBoRLgSkFY4N+/yJOntVuR3sRO0W
         4Vzw==
X-Gm-Message-State: AOAM530VbRBr47c8zoU2pmFqS/jwarfn2BY5BoAtFHyQ+uhwVduTbY/d
        dRBMFErh0myZsdz8n8afzE8mP552sZCVaA==
X-Google-Smtp-Source: ABdhPJzOp+eccDhMRSlMLj+WI/oOOIjtCIyDA73IFZ4z9h1b+/Wws70IvzKvmw3L9gkeUZvmlfMgEw==
X-Received: by 2002:a19:e01b:: with SMTP id x27mr2881996lfg.510.1605860577080;
        Fri, 20 Nov 2020 00:22:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v16sm220722ljj.0.2020.11.20.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 00:22:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kg1h6-0006VH-Ax; Fri, 20 Nov 2020 09:23:00 +0100
Date:   Fri, 20 Nov 2020 09:23:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Message-ID: <X7d85DKvisjA3nYv@localhost>
References: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605776489-16283-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 19, 2020 at 05:01:29PM +0800, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/tty/serial/owl-uart.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index c149f8c3..472fdaf 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -251,10 +251,9 @@ static void owl_uart_receive_chars(struct uart_port *port)
>  static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>  {
>  	struct uart_port *port = dev_id;
> -	unsigned long flags;
>  	u32 stat;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	spin_lock(&port->lock);

Same thing here; this will break with forced irq threading (i.e.
"threadirqs") since the console code can still end up being called from
interrupt context.

>  	stat = owl_uart_read(port, OWL_UART_STAT);
>  
> @@ -268,7 +267,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
>  	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
>  	owl_uart_write(port, stat, OWL_UART_STAT);
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	spin_unlock(&port->lock);
>  
>  	return IRQ_HANDLED;
>  }

Johan
