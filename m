Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BEBC433B4
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 20:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65CD61453
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhDUUNq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhDUUNo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 16:13:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227DC06174A;
        Wed, 21 Apr 2021 13:13:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w10so31014976pgh.5;
        Wed, 21 Apr 2021 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiKiiT3Cld6lWV7P2leTGQ31SS/h6uTEHNdFIjw/ZCE=;
        b=YQyTOJVDPq5v3DvN/StujVwTtIWYCgEy0Wi2XXgSo40kkt+T50gbcfh5S0ED7TcrOb
         TKfxVzuAcmMbyqy275epjDVlEQ+AjFjA+AlpOPRkcXMYz25OwprYu+WPPdm+EaA8fVJF
         pA8r87gQb/Ak8webo4iGcSxs1yebrtnsGlmGPxdOZm4w6AmrD88kvKuWlJ/3gSMBQgpY
         UMesc8KXc4A2/n2I63Mr7WqK0CzLT8t6tFAYQAJi/X+rGX2yIekMCuKPdajXT2WoeYCa
         ThuViW8X9TZW5cNKCrX65+gpALKFeMs3gyvypdY1RyYqd8uudSV0HmHuhebmjJDfKpMO
         jPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiKiiT3Cld6lWV7P2leTGQ31SS/h6uTEHNdFIjw/ZCE=;
        b=YBXTTSl1PsVmrcRSnQou756i/cQhlFHyJMdaSjdhjEi0jftgNTAqwTtz7ZzPLOoLGU
         PZoKUuThXiyd06FgNWr6CrW2ulgouKIIV+QEA7TGrNLPhLTo4F6wMjCsCY+b26QRxSJV
         JY4roqwPY/t5e5anHjUnYknfEpd4ZUu6A/kHVkuBpwS4c0nNhEhUKothfpChJu3wF2WR
         XhnmW2dGR/pzroTk5ty+8eMIxE3HO4Zc6p4fh8l2H3yiZtxE98jCCXks86ZpjDFFASmE
         o8Fy4HIYqmyMmmc+/DOwntDYLpvN+4dKuC8jQxeGwPXhG5xDJDqdJapE73G8T+CT2sUL
         oscQ==
X-Gm-Message-State: AOAM530gEZRwfK7OTmxuex4PIEAXcNsQhzWzPIk5c2GuyLL1dn3gE9dD
        QX2riXD0TFwgqE9Ji2wEcrDms2jkRUCpf59+ihE=
X-Google-Smtp-Source: ABdhPJzUYVuS67L/AB55nYoiU0WIUpa69KCd6fhPS2hTky/3aCNVvflFuNJA7TdPM5Pls4rlRICngFyoV3GK9ixo88Y=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr30687150pfb.7.1619035990737; Wed, 21
 Apr 2021 13:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210414134539.42332-1-alcooperx@gmail.com> <CAHp75VfQetCJJZ_U70xEduVBQHEx_GkHeKBs2uzNtvcq9H0BqQ@mail.gmail.com>
 <CAOGqxeUiFE0348Y=yEoD7bnMaGnFkbvNy3WZ2oSZZzR4D-xz_w@mail.gmail.com>
 <CAHp75VfD7i9irKDxk0v+j1c1wFrcu9v+OA-X7+edsg6johhJnQ@mail.gmail.com> <072cc4c2-9a63-312a-a4bd-b4aa6d393a7e@gmail.com>
In-Reply-To: <072cc4c2-9a63-312a-a4bd-b4aa6d393a7e@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 23:12:54 +0300
Message-ID: <CAHp75VfTu-MAwrrDscP215=cPXQ7hwWCgMQkbHEEvrJdqwgiEA@mail.gmail.com>
Subject: Re: [-next] serial: 8250: Match legacy NS16550A UARTs
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alan Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 21, 2021 at 11:00 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 4/21/2021 12:57 PM, Andy Shevchenko wrote:
> > On Wed, Apr 21, 2021 at 10:04 PM Alan Cooper <alcooperx@gmail.com> wrote:
> >> On Thu, Apr 15, 2021 at 6:44 AM Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> >>> On Wed, Apr 14, 2021 at 7:13 PM Al Cooper <alcooperx@gmail.com> wrote:
> >
> >> The problem is that when both the 8250_of and 8250_bcm7271 drivers
> >> were running, occasionally the 8250_of driver would be bound to the
> >> enhanced UART instead of the 8250_bcm7271 driver. This was happening
> >> because we use SCMI based clocks which come up late in initialization
> >> and cause probe DEFER's when the two drivers get their clocks.
> >> Occasionally the SCMI clock would become ready between the
> >> 8250_bcm7271 probe and the 8250_of probe and the 8250_of driver would
> >> be bound. To fix this we decided to config only our 8250_bcm7271
> >> driver and added "ns16665a0" to the compatible string so the driver
> >> would work on our older system.
> >
> > Interesting reading.
> >
> > As far as I understand the 8250 approach (*), you blacklist (or
> > whatever naming you prefer, b/c 8250_of seems does not have such) the
> > binding based on the presence of the specific compatible string.
> >
> > I.o.w. in 8250_of you need to check if you are trying to probe the
> > device which has both compatible strings. In that case you simply
> > return -ENODEV.
>
> Yes we had a downstream patch not submitted that did exactly that:
>
> +       if (IS_ENABLED(CONFIG_SERIAL_8250_BCM7271) &&
> +           of_device_is_compatible(ofdev->dev.of_node,
> "brcm,bcm7271-uart"))
> +               return -ENODEV;
> +
>
> but thanks to Al's findings it does not appear to be needed anymore, we
> could submit it somehow if you feel like other scenarios like having
> SCMI and the UART drivers as modules.

I suggest to upstream it anyway.It will make the kernel robust.

-- 
With Best Regards,
Andy Shevchenko
