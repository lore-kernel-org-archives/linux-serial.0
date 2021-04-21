Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BD6C43462
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529DD61455
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 19:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbhDUTFl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhDUTFc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C308C06174A;
        Wed, 21 Apr 2021 12:04:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b9so13335781iod.13;
        Wed, 21 Apr 2021 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUDW9uB6dtic8LNInMZ5mkp7CSEf9li+7LiP5Nkuys4=;
        b=tUiTit/FVljKgEsl1SuyAGd49Ljk3WdXpHBHBbZPL50McaFpSfIb7MOOFSVpx9aqh8
         tfwK+8f0/ol5Dr8I0hQeO3M5hy3LPtGPnDbn5u9ArjSvN9apWDGr22Z57IIwXQJKY2I9
         UFSSZ32rVU3jxpci/U4hUcW7JKdyFot5ONuaz1tysXN9bVogksgs6do9MeqBSv1GL+Lf
         X+ewhNWvQ8PwxOkr7sEQKtFJX+gtbIX2wxIjMb7WKJnKbXNIhdUFyouA9ut4vo58mwje
         Nz+h3ZUS1QtacvaQDEnwIXuhOd4FSwov+t93bNU0p6tHAQB5JvWk9UyMWTciTIAZpalE
         CQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUDW9uB6dtic8LNInMZ5mkp7CSEf9li+7LiP5Nkuys4=;
        b=mm/1YKeWYbiINYYxZbXuW9v2Mb+BL/b9DNb0/+0NEt/B17XD91xWj+poCZFDysX+8w
         E1oMtl/4ArVy8BMYiA0IsWwWDNRDT/At+kCQHAfxaO6/RJvJn9wQQ2lj4+PySplxCog6
         RF3YRKVU2VNt+8Jf1rTgvcH7Cnlv/65jIIZGnEI3Ud01tyVaqq6jg9wnQxk21+KfoOKC
         WptpG1bHO4603+G17jzsouBHCBcZw6z+yLZ8VMICNscQ0YVIlxEct9gUcB7bJJIr8Kra
         tT1T+NXNU1a2xCAls6/2FgzF5klwpxAxrLL8KSi9uNwU3Fuij9lr3lrU0KiLRvGzuDl8
         i43w==
X-Gm-Message-State: AOAM532h+h9yochcC/NjsXqXd698KDCH/WDVaabiMsTvDkWh4Cc1Oa6A
        Nz2k22N9+jWI5XApzQaLkMHaKvO1F8D7grOHB5g=
X-Google-Smtp-Source: ABdhPJwukcdypfUxDhRhbr18BXxqWW32JazZNeTDAW+6CoBLDuYQjFSpBAww50YeVsfhR7JtQT9Nqzyfhm+1Z0Ji3AM=
X-Received: by 2002:a02:a616:: with SMTP id c22mr26331069jam.129.1619031896345;
 Wed, 21 Apr 2021 12:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210414134539.42332-1-alcooperx@gmail.com> <CAHp75VfQetCJJZ_U70xEduVBQHEx_GkHeKBs2uzNtvcq9H0BqQ@mail.gmail.com>
In-Reply-To: <CAHp75VfQetCJJZ_U70xEduVBQHEx_GkHeKBs2uzNtvcq9H0BqQ@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 21 Apr 2021 15:04:45 -0400
Message-ID: <CAOGqxeUiFE0348Y=yEoD7bnMaGnFkbvNy3WZ2oSZZzR4D-xz_w@mail.gmail.com>
Subject: Re: [-next] serial: 8250: Match legacy NS16550A UARTs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 15, 2021 at 6:44 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 7:13 PM Al Cooper <alcooperx@gmail.com> wrote:
> >
> > From: Florian Fainelli <f.fainelli@gmail.com>
> >
> > Older 32-bit only Broadcom STB chips used a NS16550A compatible UART,
> > the 8250_bcm7271.c driver can drive those UARTs just fine provided that
> > we let it match the appropriate compatible string.
>
> This sounds not correct to me, ns16550a is a national semiconductor product.
>
> Why is it here and not in generic 8250_of?

Andy,

While double checking in preparation for this response I was surprised
to find that the problem that this was meant to solve no longer
exists. The original issue was a result of the two UART drivers
returning probe DEFERs when getting their clocks. This was happening
because we use SCMI based clocks and they were coming up late in the
initialization process. The problem no longer exists because the SCMI
clock driver is now being called by subsys_init instead of module_init
and the drivers don't DEFER on clocks.

Here's a more detailed description of the problem we were trying to solve.

Our SoC's have always had a NS16650A UART core and older SoC's would
have a compatible string of: 'compatible = ""ns16550a"' and use the
8250_of driver. Our newer SoC's have added enhancements to the base
core to add support for DMA and accurate high speed baud rates and use
this newer 8250_bcm7271 driver. The Device Tree node for our enhanced
UARTs has a compatible string of: 'compatible = "brcm,bcm7271-uart",
"ns16550a"''. With both drivers running and the link order setup so
that the 8250_bcm7217 driver is initialized before the 8250_of driver,
we should bind the 8250_bcm7271 driver to the enhanced UART, or for
upstream kernels that don't have the 8250_bcm7271 driver, we bind to
the 8250_of driver.

The problem is that when both the 8250_of and 8250_bcm7271 drivers
were running, occasionally the 8250_of driver would be bound to the
enhanced UART instead of the 8250_bcm7271 driver. This was happening
because we use SCMI based clocks which come up late in initialization
and cause probe DEFER's when the two drivers get their clocks.
Occasionally the SCMI clock would become ready between the
8250_bcm7271 probe and the 8250_of probe and the 8250_of driver would
be bound. To fix this we decided to config only our 8250_bcm7271
driver and added "ns16665a0" to the compatible string so the driver
would work on our older system.

I was surprised by a couple of things while working on this issue.
1. The compatible string left to right order has no effect on which
driver is bound for builtin drivers.
2. I thought that the new "device links" added by the OF framework for
clocks would fix this order issue but it did not because the link was
made to the parent of the SCMI clock protocol which comes up long
before the clock protocol.

Thanks
Al



>
> > +       {
> > +               .compatible = "ns16550a",
> > +               .data = brcmstb_rate_table_16550a,
> > +       },
>
>
> --
> With Best Regards,
> Andy Shevchenko
