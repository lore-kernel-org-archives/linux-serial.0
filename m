Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1DC38A2D
	for <linux-serial@archiver.kernel.org>; Tue, 25 Oct 2022 01:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJYBWZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiJYBWJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Oct 2022 21:22:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9754CAD
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:49:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r14so34065888edc.7
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/J+E57FepHa+VPoHH/vCuYiisEoXCo25k1eOwk+X83Q=;
        b=LT4xjotEAQR+rhahuuC7tR5xBqJe9l3UB1hAIpYccMggPOooSk4KhuAaRudbslGZ9O
         q+Bi3Z/UsVAZ7vS4NyzfUydTnIt6ntqcgJ9O3pk2xZkcp1u2mriPc4Eb+65LxBjyVP4W
         kbUnb6o6ie3vaTcKX+BW3LO94wVzl2CJ7Z8j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/J+E57FepHa+VPoHH/vCuYiisEoXCo25k1eOwk+X83Q=;
        b=ca8nrm7TyK2eJvQi+ut2caaMa4ywVK2c2V8dfl2C9w6I/CYieJkWjiCMOr48VPbrkM
         kPDkcTcN1DdWci/NNd0RXxf3C9NWSur8NMDzHLTaxkmfnw4+Sd/1kRnvk3syLqNfTLvj
         2LjVjzVGN20PkHVawNH06fd1osVoXgv5lufENsQIUL7+E8+UtxJSOb17ljD78jcOhL21
         /UiHgWB9x7AroZjGB6rAjMMJ7bAK/HawKF45WJWRizi05tj4U2yHq+4slDlwNM6bJqHI
         fFDCuRwggsMYxM1V9aHZ2ZdX8LbGPtSKjlEzMqjeICXLFo//UTwen8e5Z+4KxGmkEbIR
         qCcA==
X-Gm-Message-State: ACrzQf2qc+w8pJbg/267RSCLNRWtEFa7LRMGQdr/XAeM0kkYUDtpbZV0
        bhsHkGd7Nlew4SIALAlhTUpkotXcd5tAxdAt
X-Google-Smtp-Source: AMsMyM5ZSYZt8w/paZgIu0AmOWbnRrzZaj4XnOGlMfAGbc1Fh7LZRD83ZacjbCU2mrfY47x8XWzXmA==
X-Received: by 2002:a05:6402:3594:b0:45d:acf9:c782 with SMTP id y20-20020a056402359400b0045dacf9c782mr34380911edc.63.1666658987166;
        Mon, 24 Oct 2022 17:49:47 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906434a00b0079b9f7509a0sm566524ejm.52.2022.10.24.17.49.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:49:46 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id v1so18491959wrt.11
        for <linux-serial@vger.kernel.org>; Mon, 24 Oct 2022 17:49:46 -0700 (PDT)
X-Received: by 2002:adf:f641:0:b0:236:737f:8e00 with SMTP id
 x1-20020adff641000000b00236737f8e00mr4396527wrp.659.1666658985935; Mon, 24
 Oct 2022 17:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-13-john.ogness@linutronix.de> <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:49:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
Message-ID: <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 3:46 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
> >
> > Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  drivers/tty/serial/kgdboc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index e76f0186c335..b17aa7e49894 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -533,7 +533,7 @@ static int __init kgdboc_earlycon_init(char *opt)
> >         console_lock();
> >         for_each_console(con) {
> >                 if (con->write && con->read &&
> > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > +                   (console_is_enabled(con) || (con->flags & CON_BOOT)) &&
>
> <shrug>. I guess this is OK, but it feels a little pointless. If we're
> still directly looking at the CON_BOOT bit in con->flags it seems
> weird to be accessing CON_ENABLED through a special wrapper that's
> marked as a `data_race`. In our case it's _not_ a data race, right,
> since this function continues to hold the console_lock() even at the
> end of the series? I personally would drop this patch but if you
> really want it I won't object.

I realized that my statement isn't quite true. It actually only holds
console_list_lock() even at the end of the series. Still, it seems
weird that we're declaring the `data_race` on CON_ENABLED but not
CON_BOOT ?
