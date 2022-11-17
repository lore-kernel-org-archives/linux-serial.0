Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741FC43217
	for <linux-serial@archiver.kernel.org>; Thu, 17 Nov 2022 01:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiKQBAQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 20:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiKQA76 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 19:59:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C906AEE9
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n20so1510402ejh.0
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7IItaZa/7I4VBu5cw0wrKUsh/hbQDFMwGlkpESbfAao=;
        b=HAD+QNbZhmm80gWWfMxazQiOdxU/8OoWGwpppi16ividblCxYrow2hz0E0zZ7AhQ0z
         cJqUTprf41aF4MbLXaLFlbvRQJVq6IL9gsK+Kqxa/h2queVIuT30rA6VyDlCgXIBzNyT
         qslBCis6l11GbiAG8lz7dScccivWN8QaYUE08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IItaZa/7I4VBu5cw0wrKUsh/hbQDFMwGlkpESbfAao=;
        b=LeQXgtlMWHkK7pKpyDgVNtHXq5TLRlTXaCGKPjYGppiVEnNPIle1FMOTvFUKSZMScW
         gpHZ/jGfOqupq5B0e/sYgZjRzDE8BE6MjwQWf0OjXGFQsqN4PBeHnLDmOlz5AmEVHArp
         Y0et23+hmMBZRjyuyxP+leVkbIrwOkYFzp59sR6gmPAZaMRRSRrgLekQxBtbmoKVTIov
         8iFlNO9Uk1agfpOMH3ZePPLkUqQSFNcmVYZq5ADBFeveFJJq9nlF8FM0ZVB9fcV8ueiX
         kL6vkmDMfc/d1o+HBW8YMkAY6EVJtezf+ZAkTDvlb43ObqlO8P0NtutIG+bI/WwZkWH4
         gFTQ==
X-Gm-Message-State: ANoB5pmVH5385WWcGCaleEdYm1cyaEmlw3D5nPP8jmnyhev0TGOMVv/K
        Sz2Sz9ajfhJj8B/fJRXoKaTe3X1vRKk84EDO
X-Google-Smtp-Source: AA0mqf4jMVtIyLUBrfkE56kV0cU7uOdqTBwk3z4zMmiqvr55ZRV3K/syauAzjnlUG3py3lJ6Ip9pvg==
X-Received: by 2002:a17:906:1498:b0:73f:40a9:62ff with SMTP id x24-20020a170906149800b0073f40a962ffmr252514ejc.678.1668646789699;
        Wed, 16 Nov 2022 16:59:49 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id dk6-20020a0564021d8600b0046146c730easm8229162edb.75.2022.11.16.16.59.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:48 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id bs21so431447wrb.4
        for <linux-serial@vger.kernel.org>; Wed, 16 Nov 2022 16:59:47 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr35889wrs.659.1668646787360; Wed, 16 Nov
 2022 16:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-36-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-36-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WHEjpL1VYnLRp9Vy300Xd3Tu=u3MOo_rvHCABDTsQFPA@mail.gmail.com>
Message-ID: <CAD=FV=WHEjpL1VYnLRp9Vy300Xd3Tu=u3MOo_rvHCABDTsQFPA@mail.gmail.com>
Subject: Re: [PATCH printk v5 35/40] tty: serial: kgdboc: use srcu console
 list iterator
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
> Use srcu console list iteration for safe console list traversal.
> Note that this is a preparatory change for when console_lock no
> longer provides synchronization for the console list.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 5be381003e58..c6df9ef34099 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -451,6 +451,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  {
>         struct console *con;
>         static bool already_warned;
> +       int cookie;
>
>         if (already_warned)
>                 return;
> @@ -463,9 +464,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>          * serial drivers might be OK with this, print a warning once per
>          * boot if we detect this case.
>          */
> -       for_each_console(con)
> +       cookie = console_srcu_read_lock();
> +       for_each_console_srcu(con) {
>                 if (con == kgdboc_earlycon_io_ops.cons)
> -                       return;
> +                       break;
> +       }
> +       console_srcu_read_unlock(cookie);
> +       if (con)
> +               return;

Is there truly any guarantee that "con" will be NULL if
for_each_console_srcu() finishes naturally (AKA without a "break"
being executed)?

It looks as if currently this will be true but nothing in the comments
of for_each_console_srcu() nor hlist_for_each_entry_srcu() (which it
calls) guarantees this, right? It would be nice if that was
documented, but I guess it's not a huge deal.

 Also: wasn't there just some big issue about people using loop
iteration variables after the loop finished?

https://lwn.net/Articles/885941/

Ah, I guess that's a slightly different problem and probably not relevant here.

So it seems like this is fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
