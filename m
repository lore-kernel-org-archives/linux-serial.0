Return-Path: <SRS0=wW49=3Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF44C2D0B1
	for <linux-serial@archiver.kernel.org>; Tue,  4 Feb 2020 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23F92082E
	for <linux-serial@archiver.kernel.org>; Tue,  4 Feb 2020 14:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VghFQN5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgBDOjz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:39:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40579 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgBDOjz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Feb 2020 09:39:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so970833pgk.7;
        Tue, 04 Feb 2020 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qa7V4WeINwfXimSzmyAs2b+JZ6CbLBjZJ3A0tfgUH/c=;
        b=VghFQN5t9pt1ay7zA3/kToQO8ogGxmq0sF+aJ9o4SZALTTJSjh4XqASHkqbh/bqBhc
         pLb6lnOKRq8r4Vm9tZvE5VJUvGDzkHQIQs1jkSN02YPp31Dcrg0uijoAEHHT2VhBeDb2
         6Gd4zRgtep3rygzbaEGZ4xsE/QR1e569+l8Yg67Gl0X9Z4O+/0jfotyaCVClt5F3V0kb
         BF3u72iTl9nzmvhnMgQV4g8xEKxBNGlYlEb+Bbv2jpjZ4Zlb6wWyeWnTEgwFomEOvvas
         FlzDvUMkqhz/HUMck62M5xyqsZaWUqTvfFCTf73ekO524JegaE3AfLeprYXxxP4K5YRI
         WaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qa7V4WeINwfXimSzmyAs2b+JZ6CbLBjZJ3A0tfgUH/c=;
        b=YdnUuJXxCtOhe7kV62op3+3DOmrss5RF1vnINKgDm6g/Bs+u5IVEHiyMLKJmSEcUZf
         TMA+u7ZoHr+1FJZSnB65zs0b/s0rVoXLzGCXs9OTzR26FH83nIPfn4FtU/h+I99hHSnn
         Elf2C5rJJy7/lXSK403U45AiO4nDKzUCQKBcK3R6Dp3IXbu2/0aWjnKGGoYMX6k0tm84
         qWf7dANNewX2Z+u9zksEYSDqHvCwisQ5to5JVEf1impO1rCSXwPDi0382SMzxLM/P+jo
         czTI+9IKj02qOnBlHngyjUl1Detqdty/Vh3JHgEKDEOnoWSN/LZu7d42+GVywGMvtr+W
         n68Q==
X-Gm-Message-State: APjAAAUZmVEJs1vsaUtuREFKkkGSOkGrPQIRbQ1Q+vVbuDja4qrZpWe7
        JNnanCMS+cRy1Oy6Z+MvyCCACRmD0bpkswJgMi4=
X-Google-Smtp-Source: APXvYqxEKtpAOKfDM6HdgNcYObin2NhIphHNUktLTD1h0rK0K4goZvhX6hU282ObhITboaTgU0paE8xAOIDbLXxNEtQ=
X-Received: by 2002:a62:1944:: with SMTP id 65mr32174637pfz.151.1580827193984;
 Tue, 04 Feb 2020 06:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20200204113912.14048-1-tbogendoerfer@suse.de>
In-Reply-To: <20200204113912.14048-1-tbogendoerfer@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Feb 2020 16:39:45 +0200
Message-ID: <CAHp75Ve2_cH7M4nLQ-KynPWRt6NvCGk3LGafOEAjigfNyprcZw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_ioc3: Fix ioremap call
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Paul Burton <paulburton@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 4, 2020 at 1:40 PM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> Commit 4bdc0d676a64 ("remove ioremap_nocache and devm_ioremap_nocache")
> removed devm_ioremap_nocache, but 8250_ioc3 wasn't upstream at that
> time. So fix 8250_ioc3 by using devm_ioremap.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip")

Basically it happened due to ioremap_nocache() removal, but it really
doesn't matter because in this case no functional change is expected.

> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/tty/serial/8250/8250_ioc3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
> index 4c405f1b9c67..d5a39e105a76 100644
> --- a/drivers/tty/serial/8250/8250_ioc3.c
> +++ b/drivers/tty/serial/8250/8250_ioc3.c
> @@ -47,7 +47,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
>         if (!data)
>                 return -ENOMEM;
>
> -       membase = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
> +       membase = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>         if (!membase)
>                 return -ENOMEM;
>
> --
> 2.24.1
>


-- 
With Best Regards,
Andy Shevchenko
