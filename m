Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90FC07E9E
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 12:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5EA61C7C
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 12:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGGMbF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhGGMbF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 08:31:05 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CEAC061574;
        Wed,  7 Jul 2021 05:28:24 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id j4-20020a4ac5440000b029025992521cf0so448690ooq.7;
        Wed, 07 Jul 2021 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KxYIpsb7bwxmvSeqwXuD9MRNzq1sLHfCjQSXhrPmEQ=;
        b=CcFlw+MYK78NZDMKT09gEZsyvrUubHnD+fE4uA3T4sWTb1yNiOTS6CSkCX6HxubaC+
         kX7JJFC/xjshXNIkHvGFHweLWaJuLpWHzSQGE3rvq0mthVFLhQCz7rhCqkrPxoeSLNCr
         3negsyJQJtUbEcKFsDNlA3pReLDACt40vWDPHJkPrBDD5s56Aph88OcifrSSZ2+jifEO
         vpP5PkCQLco4dER6nSwY22ipHsLEpwz+RXIE5ptdwqkmszxUV/MbmsArDIez2aQMc7k4
         FsdyYVqw18NbGdDwRpUmBoE90u7n69q1am3u7ftKTIYregQv95SqLNVyP1EOls1MiMYX
         8okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KxYIpsb7bwxmvSeqwXuD9MRNzq1sLHfCjQSXhrPmEQ=;
        b=UDOSdp/+qqEZGwt0rS8pofORE57AEKgdoNcdywfDVRg97MXbqSYef7czItSZUMBSpR
         J15YD0Pbp1ckz32/h/C0awYnkiWjxlFVf04csDkuDotbVb4RiMLKDbm8OCXM11g6xCim
         6Sy906xuGUVBs7H8NlPgBZJAGDFwFjrxYzwup9ueS2ctVUsPeJTe9jYJnuzxho1Sq0+v
         PgPEh+ZQQ3SY/l+ay1bS03u2mRhzkT7JTz8MMTWHqXzvZEWy+tpGdZLEkySvgHBkaXyo
         gZK5idtrjWwof7vUiH4/wMYFaEsEyVgDQi1X5ECibZrG0VRjgUQI0Kx9tofAeu7J70T4
         SSOg==
X-Gm-Message-State: AOAM531UA4iyR3pnrx4s1qq6zGgFrqb1Hg+M4ClTuuMMmRU90u4vHoTh
        ZK1EyButWMhyz5dLWrIhWsLbNbkBtE9UVX1E8A==
X-Google-Smtp-Source: ABdhPJxBUXRvVpyV3QW1D3tUwFGxHqGx3anYaJrUZxZ0iv+UL939lTnqPmUwQ3nVReQTlFIF/ahE+/LaZrU/9ikDcds=
X-Received: by 2002:a4a:e6c8:: with SMTP id v8mr10182864oot.41.1625660903976;
 Wed, 07 Jul 2021 05:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com> <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
In-Reply-To: <fde46fee-fad9-8f3b-79b0-ad426fd379dd@kernel.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 7 Jul 2021 20:28:12 +0800
Message-ID: <CAMhUBj=Vrwd__fmTmegqU22Hn3zGE_iitF0+zAAkQFHssy3gaA@mail.gmail.com>
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 7, 2021 at 3:49 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 05. 07. 21, 14:53, Zheyu Ma wrote:
> > In function 'neo_intr', the driver uses 'ch->ch_equeue' and
> > 'ch->ch_reuque'. These two pointers are initialized in 'jsm_tty_open',
> > but the interrupt handler 'neo_intr' has been registered in the probe
> > progress. If 'jsm_tty_open' has not been called at this time, it will
> > cause null pointer dereference.
> >
> > Once the driver registers the interrupt handler, the driver should be
> > ready to handle it.
> >
> > Fix this by allocating the memory at probe time and not at open time.
>
> You are allocating the buffer in jsm_tty_init now. But that is still
> called after request_irq() in probe. So care to explain how this helps
> exactly? As I understand it, you only made the window much smaller.

You are right, this may indeed still cause problems, I did not
consider this before. So maybe we should put request_irq() at the end
of the probe function.

> Anyway, I'm no expert on jsm, but AFAICS jsm_tty_open first allocates
> the buffers, brd->bd_ops->uart_init() / neo_uart_init() clears ier and
> only brd->bd_ops->param() / neo_param() enables interrupts on the device
> (by ier update and write). So how it comes an interrupt came before
> neo_param() in jsm_tty_open was called?

I considered the threat from a malicious device, which means that a
harmful peripheral may not comply with the driver's convention,
arbitrary send interrupt signals, or send malicious data. I think the
driver should also handle this situation, at least to prevent the
kernel from crashing.

Thanks,

Zheyu Ma
