Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B87C07E9B
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F50F6113E
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhGSMFI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbhGSMFI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jul 2021 08:05:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3CC061574;
        Mon, 19 Jul 2021 05:03:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s18so18849807pgg.8;
        Mon, 19 Jul 2021 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tto4OVvjuCgq4lBBMOSB4qS7FSxO1fllKtx/pkaH/aM=;
        b=LuQ/kJePBiQ2sZZAE0U5rHZDK1pdMQwE9VZ/S1Ngpg6VDNtB2XUn3nHKtrus/jXsFL
         i1lw2oX51zCuDbuZUa4I1oUHkZLWAHBLZbqo2+4AP94xWDDpwz2RAMITYgt3Z2NYrbsJ
         OmzY7hYqC/SQz0xg4Ih0X55QSOi7Pk6pdKCt+E67doyzAo3xVWu8+mYajawkR49UeerC
         ZZ6Lycm/hFybFuKM2+4qybHbosPe5tR++hIoIrWSoIeSf6R+xn37t0WDEALhJyku01EC
         pG1O5vPG10586FZ7rWFMqvGuxgj+mJj+CS31+3sGJL4lFmIVLPAkvLoFJQFUY6kjtok9
         DlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tto4OVvjuCgq4lBBMOSB4qS7FSxO1fllKtx/pkaH/aM=;
        b=hz4cQqpFW+i7zmx/Le2W/npqr1OhU+n93YzfHev/h1XodIQp2+PJJcEUuYFm++1yqK
         FS0+U3Zph2HH3F7nq+5GeCzcs0rDKFiGtwJkJkXHnvkpjRtsKTwnALw7trf326InDem4
         XhKHRbfDCjDWhoLB7RUJO6KdR2Taxw84Jl9/piYqJKUaTVkiGV+0yDHp6JrU2phxBKF6
         3L/Na1AmbPFCiWNxymmNdWLXBOmJG0zn1E90JOtD455AURYxjTRThUz7P0cwupjE+gMi
         qOIyG41TaeSIK4ko0h2cwP+Pg5CiItoL05gUWp2uyebDLiZl9dJAw/A3mDEzbkVANkzs
         Wh0A==
X-Gm-Message-State: AOAM531uPY5pMPgfA//0rXQ106mViL3asyfPAMU/3mxKLZFOQYivXUER
        fxIpxzyhm/4CLHd28FD8YE8LzGJ2JQW36qWlLZo=
X-Google-Smtp-Source: ABdhPJwpKyQgs0rJ1djIB80LNagdLFagxsrcE0J+H7ot1s1STaLkL2e1Q8aLp4hs86aGu8FTDeXY8TYxDB9kCjSh568=
X-Received: by 2002:a65:434a:: with SMTP id k10mr25333382pgq.4.1626698747965;
 Mon, 19 Jul 2021 05:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210624224909.6350-1-pali@kernel.org> <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org> <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
 <20210625153803.u6uesckcqyvvo7dl@pali>
In-Reply-To: <20210625153803.u6uesckcqyvvo7dl@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 15:45:08 +0300
Message-ID: <CAHp75Vdzb9yhm490vAhL7O0S+5FPR=sM1Tohqi70xYV+bXVr8g@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 25, 2021 at 6:39 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Friday 25 June 2021 17:22:31 Geert Uytterhoeven wrote:
> > On Fri, Jun 25, 2021 at 4:37 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:

...

> > > +/*
> > > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor =
rounded to nearest integer

> > > + * @dividend: unsigned 64bit dividend

(1)

> > > + * @divisor: unsigned 32bit divisor
> > > + *
> > > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > > + * and round to closest integer.
> > > + *
> > > + * Return: dividend / divisor rounded to nearest integer
> > > + */
> > > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> > > +       ({ u32 _tmp =3D (divisor); div_u64((u64)(dividend) + _tmp / 2=
, _tmp); })
> >
> > Given "dividend" should already be an unsigned 64-bit value, I don't
> > think the cast to "u64" is needed. Similar macros in this file also
> > don't have the cast.
>
> It is just to ensure that plus operation between dividend and _tmp is
> evaluated in 64-bit context to prevent overflow. Just a case when user
> calls this macro with 32-bit dividend param.

This contradicts (1).

> As it is a macro (and not
> inline function) type is not automatically enforced.
>
> DIV_S64_ROUND_CLOSEST macro assigns its argument into temporary 64-bit
> variable which then ensures usage of 64-bit arithmetic operations. Same
> applies for DIV64_U64_ROUND_CLOSEST and DIV64_U64_ROUND_UP macros.
>
> So this is reason why I added explicit cast to u64.

I don't see the reason for casting in the current code. Probably you
need to rephrase documentation to explain why it's there.

--=20
With Best Regards,
Andy Shevchenko
