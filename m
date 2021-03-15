Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990AC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 18:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6357864DF0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 18:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhCOSQY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhCOSQR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 14:16:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164CC06174A;
        Mon, 15 Mar 2021 11:16:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l2so20954250pgb.1;
        Mon, 15 Mar 2021 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7gXh8If5lLSf1WxWeVi7tx6btQcwG11a3RaI0iXEjI=;
        b=uuMxU7VNbmDo+baQMlzi65YLpPhkRIYur8VUqEFbKk4c38qae3zU8Adjiedbj4vCge
         O9o3Q6wa1J/WWEzzUTMjtyhj6CpurGADfhIsGsIvViZVcaSX3NaJuHPu994N0ApsikS/
         cfDtH2xi3cBxubVwunRN7CKxHdY6xx0AkFa4gPYFbzEyC4u5KEU1MHrfRoWOPXLUhb9Z
         Cs158JnD1XS+7HdgeUreI4rfnDcCwOro5oRvLT0V92XthUqUiuDZzL2dxcCTbbUqH5c8
         WH+2ZQqUQaSqCbREVLIhe53TM7J0wRcWwIh60lUfvd8fXfI7qgAOrOhOVKt7eLtLaJoN
         +HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7gXh8If5lLSf1WxWeVi7tx6btQcwG11a3RaI0iXEjI=;
        b=OhvWsbus8kkSCsHDWtkYobrmNTWVgIoH5nS4mwsbjnxEBCv0gtfrKlNuPcL4zid2NW
         tSdVkP+a8hdQD7RMBvyE8/mssEGxUFfCIktVqEdy6BtuFdkWAwaAjpY5Bp5FP3K9S5SM
         QrAp6xsoLf+KUn9pwBDcAWreprQDXvQdtcmwAq8oQWi+OhB/afVOJk5wskYtR72+fu7w
         5I/j5aThJxyjP/nk6bf1IbseRGWQ+lJ7ENuhTnB0fxhTbVfMIUP4KmLhvKn/r5j00RSF
         n3cT3YLGNbJkLX4L/3JFT9lKBG5iaaJYIZOfrKJhZd023ZTKm60Mg32llKNZq5gVtiCI
         1KjA==
X-Gm-Message-State: AOAM532Z7rmGXkGXXVtIo/tIzlb2loasho7PuY+g6s+/9ZjGO3k5WavX
        EzEJ/GONGvjSjVlRUWd+L86MmLhgRnVXa/1ttPDmMezepQt0cw==
X-Google-Smtp-Source: ABdhPJw3alc5qqFKGQJPh1tDzn1eBVQRLupqnrLTL2qF/XOJf5/y8VM1JRrWHY5lq01mpISfsJuuGz2skwQSj2wOYcQ=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr25185217pfb.7.1615832176481; Mon, 15
 Mar 2021 11:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Mar 2021 20:16:00 +0200
Message-ID: <CAHp75VcopwQgUQVF_uGwddzioTJqddwuft11+HBwH25e1kQEyw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 15, 2021 at 8:12 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Since interrupt handler is called with disabled local interrupts, there
> is no need to use the spinlock primitives disabling interrupts as well.

Thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 80df842bf4c7..d9e4b67a12a0 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -715,13 +715,12 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
>         struct s3c24xx_uart_dma *dma = ourport->dma;
>         struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
>         struct tty_port *t = &port->state->port;
> -       unsigned long flags;
>         struct dma_tx_state state;
>
>         utrstat = rd_regl(port, S3C2410_UTRSTAT);
>         rd_regl(port, S3C2410_UFSTAT);
>
> -       spin_lock_irqsave(&port->lock, flags);
> +       spin_lock(&port->lock);
>
>         if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
>                 s3c64xx_start_rx_dma(ourport);
> @@ -750,7 +749,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
>         wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
>
>  finish:
> -       spin_unlock_irqrestore(&port->lock, flags);
> +       spin_unlock(&port->lock);
>
>         return IRQ_HANDLED;
>  }
> @@ -846,11 +845,10 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  {
>         struct s3c24xx_uart_port *ourport = dev_id;
>         struct uart_port *port = &ourport->port;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&port->lock, flags);
> +       spin_lock(&port->lock);
>         s3c24xx_serial_rx_drain_fifo(ourport);
> -       spin_unlock_irqrestore(&port->lock, flags);
> +       spin_unlock(&port->lock);
>
>         return IRQ_HANDLED;
>  }
> @@ -934,13 +932,12 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
>  {
>         struct s3c24xx_uart_port *ourport = id;
>         struct uart_port *port = &ourport->port;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&port->lock, flags);
> +       spin_lock(&port->lock);
>
>         s3c24xx_serial_tx_chars(ourport);
>
> -       spin_unlock_irqrestore(&port->lock, flags);
> +       spin_unlock(&port->lock);
>         return IRQ_HANDLED;
>  }
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
