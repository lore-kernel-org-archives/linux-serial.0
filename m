Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B41FC07E95
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D230361C60
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jul 2021 10:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhGGKkw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGGKkw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jul 2021 06:40:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A4C061574;
        Wed,  7 Jul 2021 03:38:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w127so2808154oig.12;
        Wed, 07 Jul 2021 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRDVd3phHldoWTQmSimMtW/ZkB5i7EmON+ZcljUt8y0=;
        b=Ie0NKg5A3KosypF4mGzEcZQd6tmBl2xXmoJP96pGlZB0Dh45eJmnZj1KJLPvlzZYVI
         ZDW7ibU3WKCVGqXxw8AGEGNYki0iMNPqb17LrmGeHCnuCVZAEWZ4Vg+KJAoGZgO5bpDV
         ugbXG2L6A8UZh8Nj5meSb9lBwzWo1Vcpdj1TaB9DRD1kZ15YF9CrmdI+pCutdcXFgJUE
         WLysgahZ3bh5jPV4dfCUSbzpsUrUum6o7TvmrdcxCqTHRzu2oYX3Th0kHqlHWqZEqZ+0
         siRrDSmdhxszLcGKe3w22tu4AWp+8Sk8qLacy/WXbEtPimjxw3Iop8ujb44l1bYo5/Od
         7veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRDVd3phHldoWTQmSimMtW/ZkB5i7EmON+ZcljUt8y0=;
        b=AeZBDiIr8/GQSn4XqTN+RyZhX7unUOji+jtbmv9IdIfSGfhf//G2f+GfIsqJKgHkkr
         8g1UA3nbYMPgXoif7H/CuWYD/mF92hQ9hYANAZr6QbmNjKQ9RFVNFf+oUlJuX2JetbYJ
         w+g4Fi0l4xAYzQvtQBKs7ItE5BRAT0GfnB+xXHpsgjRUv0ZU/zSeayPfaKCrg1OiRKpY
         +U15xi6W1vKp7l2Fsak08a5hEDuN2E5xJR3kqt70Bxlnf7pSYO8KcB0msDkp4Tp/o0zA
         D+2h/uCM3Q2uEB/4+WjEO+RtKI6mznZ+hgFeKDEfiU8wpHIRNO3IQASCsqGBvgF+1fsC
         Coxw==
X-Gm-Message-State: AOAM531G0c9BJ/RfTxzC0k+KhMzarCjTPy6vzRWQCbZeYzSwX2hD0HhZ
        3eQtRwxNdRTULiyaMmrPiDSWTGJ7dyJt7FaXXw==
X-Google-Smtp-Source: ABdhPJz+fa1+dCRl3mFwYsST0Ps6DUBEoahlnScTMpNnl/FsDdKBG1rc59wOJSWRcTWXWm+CSTTWmp7hdofNxP/Hor4=
X-Received: by 2002:a05:6808:2105:: with SMTP id r5mr4321672oiw.57.1625654290533;
 Wed, 07 Jul 2021 03:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com> <CAHp75Vdne2fVAdmMYPn71T8LnSNMxVhBVK8dbmMASTSTUnOjBA@mail.gmail.com>
In-Reply-To: <CAHp75Vdne2fVAdmMYPn71T8LnSNMxVhBVK8dbmMASTSTUnOjBA@mail.gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 7 Jul 2021 18:37:52 +0800
Message-ID: <CAMhUBjmsoB5zzqdqs5OKwqNa_twFwxu16pb+OTmUpTwW59sDfQ@mail.gmail.com>
Subject: Re: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 7, 2021 at 4:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Monday, July 5, 2021, Zheyu Ma <zheyuma97@gmail.com> wrote:
>>
>> In function 'neo_intr', the driver uses 'ch->ch_equeue' and
>> 'ch->ch_reuque'. These two pointers are initialized in 'jsm_tty_open',
>> but the interrupt handler 'neo_intr' has been registered in the probe
>> progress. If 'jsm_tty_open' has not been called at this time, it will
>> cause null pointer dereference.
>>
>> Once the driver registers the interrupt handler, the driver should be
>> ready to handle it.
>>
>> Fix this by allocating the memory at probe time and not at open time.
>>
>> This log reveals it:
>
>
>
> When doing commit messages try to avoid tons of noise in them, I.e. here is _a lot of useless lines_ from the log, has to be addressed.

Thanks for your advice, I will learn from other commits.

Regards,
Zheyu Ma
