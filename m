Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B8C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 17 Nov 2022 00:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiKQA72 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiKQA70 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 19:59:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC46A693
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s12so392605edd.5
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5z9QLYoOFm95pMVOnKF25qs3Hcqgci3miwbsOY+I7C0=;
        b=aoSgoXP2zY/ZjfphtaJ/kTepLvpy5D+9DdGupsf/12+gXXehkXjkHUg6wn2VSX8VwU
         bPsEpBCjmTno6sKngL1LHpPiYZymT1EQwM8fJ3Qu9ZEn83R3dKrXfbpX1BBzBd4FTO67
         V5zSbzQ7arcbflqVfWpaHTBo8VouN+J2TfYCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5z9QLYoOFm95pMVOnKF25qs3Hcqgci3miwbsOY+I7C0=;
        b=pvvOKKtgcDWMjp3K2HkVXIV4+kIOWlH2+sDau6xhEUCZVjkh9VY1yjsIM1cN+JWFI5
         Aj7QCmPCh2jO/XdMxw/+6wiv8pYs041y4MFeom/El6PFaQxuuHyRr8XrmP5xLmiGuYG0
         Eh3L/Ck4Z9dq2JYLTPpmrFq/rkPgabcG70Lg6W+0Hutch4Dedg2ESB0V3J9dzx46bFoa
         Q2iExA6kVpdbS2c0zIhUuBdDSpAnOsZm0WCqiiL1JrXEeVx6xteNUEGshEeytuuXfIBW
         B7Ut4SFhMxcw1JGBLlB3IWrIeLMxX5Pan52+SAYp1u19w8FnXyf9HRI7uavVVIh6vnls
         ZDIw==
X-Gm-Message-State: ANoB5pkJ4QaaFXu7YF7sa4i+pwnXiGGrjdkkwYaIMmSxXWcky+nloknK
        t/Fw9QwP9+5MfoMvBJDbzhI2w1Rp2pNkzkoX
X-Google-Smtp-Source: AA0mqf6+ccPbkFxXow/EoaX5fLaisB0vMInki10gJv7dkEg1mWExnTplXQkWx99EaJu/pDIfwnzVuA==
X-Received: by 2002:a05:6402:1855:b0:45c:fca7:e094 with SMTP id v21-20020a056402185500b0045cfca7e094mr183446edy.314.1668646763459;
        Wed, 16 Nov 2022 16:59:23 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709064ac100b007081282cbd8sm7433807ejt.76.2022.11.16.16.59.20
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:20 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3280382wme.5
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:20 -0800 (PST)
X-Received: by 2002:a1c:cc04:0:b0:3cf:7716:8954 with SMTP id
 h4-20020a1ccc04000000b003cf77168954mr157185wmb.57.1668646760151; Wed, 16 Nov
 2022 16:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-38-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-38-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWZAAhw7rWjCvtqz6VGh-PzG_zMnugX_KkG7gZ+a9Qpw@mail.gmail.com>
Message-ID: <CAD=FV=WWZAAhw7rWjCvtqz6VGh-PzG_zMnugX_KkG7gZ+a9Qpw@mail.gmail.com>
Subject: Re: [PATCH printk v5 37/40] tty: serial: kgdboc: synchronize
 tty_find_polling_driver() and register_console()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Calling tty_find_polling_driver() can lead to uart_set_options() being
> called (via the poll_init() callback of tty_operations) to configure the
> uart. But uart_set_options() can also be called by register_console()
> (via the setup() callback of console).
>
> Take the console_list_lock to synchronize against register_console() and
> also use it for console list traversal. This also ensures the console list
> cannot change until the polling console has been chosen.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 82b4b4d67823..8c2b7ccdfebf 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -189,12 +189,20 @@ static int configure_kgdboc(void)
>         if (kgdboc_register_kbd(&cptr))
>                 goto do_register;
>
> +       /*
> +        * tty_find_polling_driver() can call uart_set_options()
> +        * (via poll_init) to configure the uart. Take the console_list_lock
> +        * in order to synchronize against register_console(), which can also
> +        * configure the uart via uart_set_options(). This also allows safe
> +        * traversal of the console list.
> +        */
> +       console_list_lock();
> +
>         p = tty_find_polling_driver(cptr, &tty_line);
> -       if (!p)
> +       if (!p) {
> +               console_list_unlock();
>                 goto noconfig;
> -
> -       /* For safe traversal of the console list. */
> -       console_list_lock();
> +       }

Seems OK to me, though I guess I would have moved console_lock() up
too just because this isn't a case we need to optimize and then we can
be extra certain that nobody else is messing with console structures
while we're looking at them.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
