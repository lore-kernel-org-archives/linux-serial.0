Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CBDC433E4
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 17:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A63220657
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 17:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh1hzjpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbgHQR0R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390039AbgHQRZd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 13:25:33 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C57C061389;
        Mon, 17 Aug 2020 10:25:33 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so15174824ilc.11;
        Mon, 17 Aug 2020 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKtlLroQpL/sWAJgH4qxybWU48/NnHnKlgQrlvvNczw=;
        b=Zh1hzjplnO00QpCm/On/zjcaMBwW9TTlmZ3xHT74iBDu8raplF54GVXb0JGtIgCZus
         owaf1p2obJm9WFiiMARI3u+MFRo5MmOf9c7bohL5PGxygj+7g4S84OYpeJZjl8nqciz5
         oyQMYuBWu0tVZk8SjeAIf5qw9l1gCM8140nr9wB94lJ2DPlnh+lfMGsMkRB7HLHqGTCp
         XAlCYEsYhJxcGSMUwpYpUfW5QY2vIyb2c/KexMWq0kiIvnJ5d7X+eKomPKtiL4AE4mEn
         66gUW7Gam9grdox6zUK0Zc+8vW/kn7wePWxt1b0rVRqi4TUPmBD54TmRiuO7RVRPmNZ9
         h9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKtlLroQpL/sWAJgH4qxybWU48/NnHnKlgQrlvvNczw=;
        b=SXyWyjuCYocXFNWET8nJpmJI3nZrRzJ47hbpF8mdYsdvC8IFsYNO5H5+nUez8Y/sD6
         B2Zd+I8ZfEu5BZuy49s6QI3oJT+FgWK13z8MfzPzEojB0cLKIFb4k4o//JvoruRePsK7
         rmSlYK8yRmC7DCoGX3jr+E1Z+weF+v6qZZgkFnllMCVpcw+WktV/zLw4HOL+4VzMfSS5
         RbLQNEtO9XqFzy6a2pbmzo1P++SA5c6WpzxOe1aTBjaYUmIapsDLHhb/P5NIpp36iNsR
         c0lRhWY9Jc1R5uZmAZWQR30iEQy1hW/ikvm/F0g2Zenaqmpu1Nx++AlmUVTXuFJZ88RH
         quMQ==
X-Gm-Message-State: AOAM530snq+ugm27TwAszEj7PpEkbxeRFlTiaLNtanTsM7d8h2sIlzNc
        QTBdi6dbvZErnIVfFb0gGKMcCx9ZBdMesh0OxHeYG0EYgw81gQ==
X-Google-Smtp-Source: ABdhPJxKJV7ZDUifvV2jxONW1h9vnjrTDiPV21b4WSI1cQ36QytJWfdjPUr/+UXcj5suUkTUs5Ql6OXn0KmK/xxxrB0=
X-Received: by 2002:a92:2901:: with SMTP id l1mr9877131ilg.306.1597685132897;
 Mon, 17 Aug 2020 10:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200817165059.957748-1-ztong0001@gmail.com> <20200817170038.GA725471@kroah.com>
In-Reply-To: <20200817170038.GA725471@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 17 Aug 2020 13:25:22 -0400
Message-ID: <CAA5qM4AH7rLCve8YjZ50No02BY524nPbSOJVa+8_e3dXKmpuJw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: fix earlycon dependency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 17, 2020 at 1:00 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> We can handle lines 72 characters long :)
OK, thanks, I was not aware of that, I will reformat the text in the
next version

> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>
> What broke to cause this to be needed?

newbie here, please don't laugh at me,
I just followed what people were doing after read some articles from
the internet

> Can you provide a "Fixes:" tag for this?
sure, thanks for the suggestion

>
> > ---
> >  drivers/tty/serial/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 8a0352eb337c..42e844314cbb 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -8,6 +8,7 @@ menu "Serial drivers"
> >
> >  config SERIAL_EARLYCON
> >       bool
> > +     select SERIAL_CORE
>
> Are you _sure_ about this?  This feels odd...

Yeah.. that also seems odd to me -- this bug can be triggered under
some corner cases
which I haven't figured out why --
I can encounter this problem when doing allmodconfig followed by some random
select/deselect in menuconfig. -- It seems that menuconfig is not
doing some dependency
check correctly, i.e. when SERIAL_CORE is not builtin, SERIAL_EARLYCON
should not
be selected either.
What do you suggest?

> thanks,
Thank you.

> greg k-h
