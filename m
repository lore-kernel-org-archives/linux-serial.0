Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC792C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 12:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDA6610FC
	for <linux-serial@archiver.kernel.org>; Tue,  5 Oct 2021 12:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhJEMnh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhJEMnf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Oct 2021 08:43:35 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D4C06174E
        for <linux-serial@vger.kernel.org>; Tue,  5 Oct 2021 05:41:44 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id y3so9347001uar.5
        for <linux-serial@vger.kernel.org>; Tue, 05 Oct 2021 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXDISnOh7ZckzDfw/rbcZvXrMiBYqKScksuW8yTohwo=;
        b=Id6GY7R7KVW4uvhaDGqG/LWrQ6RRdE1WY7dKbzLj7Ytnar8nAL98hjwk25jwOwdofa
         Q3p8KNC0hBivELcvg9UIHnpq1LPqrMc0WJKGt3BEx3jHkBLz9ZqJX2SYqT0Sxc3st3hJ
         8KRWyAE9Hj3qmrXrXDrLVL8wgFVdiQq6C+nTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXDISnOh7ZckzDfw/rbcZvXrMiBYqKScksuW8yTohwo=;
        b=xE7r8mxpA1NbOy/Or/V1Tjg08rsaLixmK7gF6k3KNWhvUeD5Gjo4D0cnfwchUPb2ev
         0NcfhRn6W/W4qK1xWvJwcqUkFVtz0IRtFVtS+ZBICf5aiHDeeVxFTw8XA7jFHNaFl6y9
         wRJc9+8FkYFpvgii36T2zNUmwX2ynF5dDTPXBNmvDcbXCJ4PJz/TDugm1XEOKZ+idNPa
         dPJQnyD0Po09qcSQd1hXvhkBtRXGkwkRmFypceMH1jr35N6z0iYz6BD8s3g8M/Kx0Nyy
         0Smpll39Vqo+r+2nMrAD94+xM5Q1K385EyTy3ItCbemZO1Pq5ulo8klDH9BuibGtTk+R
         /n/g==
X-Gm-Message-State: AOAM530WvqVybPgoJ+6hsiDY+3Dv+h4TTkNOPQ9wAd4Eemo+qiBvgd02
        Pjpg14/tHlWg7Hl10FQO1BCk/fvIKkS3DPoJV5GtaQ==
X-Google-Smtp-Source: ABdhPJycar/1wBuMyd28y5qD07f3f9Qc3yBwJUToU1jHeLCtYVBM75fhfQEWYkGKlFKgB5ZSWIo29TnnTykxW5XfrIo=
X-Received: by 2002:ab0:494a:: with SMTP id a10mr11929782uad.90.1633437703878;
 Tue, 05 Oct 2021 05:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210930124950.3069638-1-daniel@0x0f.com> <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
 <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com>
 <YVYmTL8WsgYnxPwc@smile.fi.intel.com> <CAFr9PXmVQFDdMiMUgg4v7DAcFkdaUtFeaXOyW4_NrVd5oYKSSA@mail.gmail.com>
 <YVxBphzSDG2VmM4I@smile.fi.intel.com>
In-Reply-To: <YVxBphzSDG2VmM4I@smile.fi.intel.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 5 Oct 2021 21:41:33 +0900
Message-ID: <CAFr9PXkN-6MAExF-P8-Biej2yoQYB6eQDezwfPRX4bcXaayZfA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

On Tue, 5 Oct 2021 at 21:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > Ok, is there a reason it's not for the ID tables? Does it break something?
>
> It will look ugly. Why we define a table that may or may not be used?
> Sounds fishy.

I guess it's a toss up between is the attribute more ugly than #ifdefs
and is the ugliness of either worth it..
Not going to say I have an answer here. :)

> On top of that why you should tell linker to waste resources on something
> that you may well know beforehand will be thrown away?

That's true but the linker on my machine with 64GB of RAM compiling
for a single core machine with 64MB of RAM doesn't mind too much.

> > For what it's worth I think the OF ids are a bit wasteful.
>
> Exactly my point, but fixing one driver of zillions does not solve the issue
> in general.

I looked into making OF ids smaller globally. There seems to be 64
bytes wasted from the start for the name and type fields as nothing
uses them as far as I can tell.
Then you have the array for the compatible string which is currently
128 bytes but the longest compatible string in the kernel is less than
64 from what I can tell.
I understand that it's for future proofing etc. Adding a few hacks to
my kernel to remove the unused fields and reduce the size of the
compatible string saved a few tens of K.
Which isn't a lot but might be the difference between the kernel
fitting in a tiny SPI NOR partition or not.

> > For some
> > drivers where there are tons of broken variations they add a few K of
> > unneeded data. But since everyone now has gigabytes of memory I doubt
> > they care...
> Some actually cares.
>

Ok.. I might consider pushing my changes to remove unused ids all over
the place then.
drivers/cpufreq/cpufreq-dt-platdev.c is a really good example of
adding ~10K to kernels for no reason.

> > I'm working with 64MB. :)
>
> Then I would imagine that you already using as less kernel configuration as
> possible and have as many modules as you want for the hardware that might
> appear to be connected to that board, right?

I have a minimal config but compiling in macb for the ethernet
compiles in code and ids for stuff like zynq that I could do without.

>Then again one driver with 100+
> bytes doesn't affect really your case. Disabling, for example PRINTK, will
> win much more for you.

It's not *that* bad just yet. :)

Anyhow, thankyou for the interesting discussion. I'll just leave this
in my tree for now so I don't have to see the warning.

Cheers,

Daniel
