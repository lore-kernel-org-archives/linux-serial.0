Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66DC38A2D
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 00:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJYAXa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJYAW4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Oct 2022 20:22:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BB52FEE
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 15:46:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so33763312edj.3
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIHl2iCS5umkUQOttHMwOxT4DU4dTXsnDaz+mZRAMKc=;
        b=oZyDNuZZ8bs6Dd/+bmcm0ORHJLVHkh6oX/lOWkQd7odI9UAqCD7O/wCA/hDvorihH3
         N9+QLewwBtMtqshKTjtsp9e5sf8Q8V9IMkMUcxglNK13SVPGIcxHiUROeBAQPe//FtdZ
         MC3KWgqs6B/AegdXOlxhnQfyBH4y0fiqdEFFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIHl2iCS5umkUQOttHMwOxT4DU4dTXsnDaz+mZRAMKc=;
        b=cpqViZA3gG3UmVzFpdNVu9x2HHEJp8Q1g4OsOfoLZV3K9rOHuenD4bzUfFZv1kFBcW
         E6ByuJK7zbxqJ0TQ10PsGKpf0nCM9qga45Q5gXDKW8qvr1GfyXIwDOo4zYZrBrNj301X
         bfphqlkxr3yrzfg6/Vl8PYkv+Y82vNNPCD/17kYRDZzsfiQ0A+qug3EMokiRtzvagCym
         fRQb6hDZ98ks3Rf1GoFUM2A8vLdVf4it65auSg0pQqkWCYcPv/irwnmfkhZtVQVRrUlR
         kH338qMAvvukDsG9IXjlKlZuG0K6r0eKcalJrdfrTvm4AcFTbYucuMXSLrPQzaLA3Go1
         2M0g==
X-Gm-Message-State: ACrzQf2yV1i7za5+Fuq2rv+m+0RxUY0JtLBVXHcowJHxqpE9d032BASG
        MqOeqn1mXTRe5KLuYQ0Zf7khF6UI37VuW6h3
X-Google-Smtp-Source: AMsMyM63zfx0aHnYhiAGrDMn8zZqBSWrAoJ1Yb7YegPwrmHsZNTqVbJQkkdP0A/RB5FWJmOisp9AIg==
X-Received: by 2002:a05:6402:371b:b0:460:ff7d:f511 with SMTP id ek27-20020a056402371b00b00460ff7df511mr22620267edb.148.1666651597415;
        Mon, 24 Oct 2022 15:46:37 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id w20-20020aa7dcd4000000b004611f5efea8sm531618edu.17.2022.10.24.15.46.35
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 15:46:36 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id g12so5448316wrs.10
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 15:46:35 -0700 (PDT)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr23635683wri.138.1666651584545; Mon, 24
 Oct 2022 15:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-13-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-13-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 15:46:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
Message-ID: <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
Subject: Re: [PATCH printk v2 12/38] tty: serial: kgdboc: use console_is_enabled()
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

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index e76f0186c335..b17aa7e49894 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -533,7 +533,7 @@ static int __init kgdboc_earlycon_init(char *opt)
>         console_lock();
>         for_each_console(con) {
>                 if (con->write && con->read &&
> -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> +                   (console_is_enabled(con) || (con->flags & CON_BOOT)) &&

<shrug>. I guess this is OK, but it feels a little pointless. If we're
still directly looking at the CON_BOOT bit in con->flags it seems
weird to be accessing CON_ENABLED through a special wrapper that's
marked as a `data_race`. In our case it's _not_ a data race, right,
since this function continues to hold the console_lock() even at the
end of the series? I personally would drop this patch but if you
really want it I won't object.

-Doug
