Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19674C49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 17:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E223861628
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 17:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYRlo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 13:41:44 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:43832 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRln (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 13:41:43 -0400
Received: by mail-ua1-f46.google.com with SMTP id f1so3841713uaj.10;
        Fri, 25 Jun 2021 10:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMsdHKSeztMKrPHZ8nbG2VqyYL9zlmEgt8jO+8+YC2U=;
        b=nUT56JRIdUCvJchDRgYdezS6g2Mz2vgennpByZqYJ7owEBc+9VM2PnXG79nAkTBfQ2
         p0T1RnMP1ccbTykEwe1EPLyc0/XOdu507SZtCQID7JXToNkGi3+HWj50SL7Ozbo/pD0S
         CFtgxpWFr8hVEJVxd2c0ZiGgrmw3NhvEo1QRbt0sZL6R4PPtyvcCf5+UNxlcUGYB9MJs
         WMD8BrK9Z9poKuObRd4od38nxpQOML7y0efn44yAdiire3uG3Ug2wL2g+zvKIKM43cJY
         4E+FtBRyTMj1dFW+YnCqCFuFmfjipkyhLRhVKStVHmwcl6qIBvF36nTqaCfhzHCfzHGJ
         R00Q==
X-Gm-Message-State: AOAM531AvKHpb6yfsgknp72vai1RZUnaCddcNiMMCLsKddNnVfl4XEly
        1LfprtrRU+ckKRPhjFPaLaGodobHvboAc6C5ZOY=
X-Google-Smtp-Source: ABdhPJxRW0SpvuDwLgk+xlyHuwdQP6YsYhgHSWcPS2hlfsTa42T+RD8pDpSwzmpkvZj5EGbrv9yxCxRv6cquJ3wmzXs=
X-Received: by 2002:ab0:3734:: with SMTP id s20mr13225318uag.106.1624642761311;
 Fri, 25 Jun 2021 10:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210624224909.6350-1-pali@kernel.org> <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org> <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
 <20210625153803.u6uesckcqyvvo7dl@pali> <20210625155008.GB16901@1wt.eu>
In-Reply-To: <20210625155008.GB16901@1wt.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Jun 2021 19:39:10 +0200
Message-ID: <CAMuHMdWfE7UKkp6=MdAVgHywFjDK3SN4m9+d_6AmJTB=qBEqFw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
To:     Willy Tarreau <w@1wt.eu>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Willy,

On Fri, Jun 25, 2021 at 5:50 PM Willy Tarreau <w@1wt.eu> wrote:
> On Fri, Jun 25, 2021 at 05:38:03PM +0200, Pali Rohár wrote:
> > On Friday 25 June 2021 17:22:31 Geert Uytterhoeven wrote:
> > > > +/*
> > > > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> > > > + * @dividend: unsigned 64bit dividend
> > > > + * @divisor: unsigned 32bit divisor
> > > > + *
> > > > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > > > + * and round to closest integer.
> > > > + *
> > > > + * Return: dividend / divisor rounded to nearest integer
> > > > + */
> > > > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> > > > +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
> > >
> > > Given "dividend" should already be an unsigned 64-bit value, I don't
> > > think the cast to "u64" is needed. Similar macros in this file also
> > > don't have the cast.
> >
> > It is just to ensure that plus operation between dividend and _tmp is
> > evaluated in 64-bit context to prevent overflow. Just a case when user
> > calls this macro with 32-bit dividend param. As it is a macro (and not
> > inline function) type is not automatically enforced.
>
> I agree, a large u32 argument added to _tmp/2 could overflow and remain
> 32 bits, yielding an incorrect result. The cast is mandatory here (and
> will either emit no code, or be useful).

Fair enough.
So we want to add a cast to DIV64_U64_ROUND_CLOSEST() above, too?

> The only trap I'm seeing is if a negative signed int is passed in dividend,
> it will be sign-extended and will give a large u64 value. A preliminary
> u32 cast could avoid this but would break valid u64 arguments, and I'd
> claim we never know what the user wants if this happens in the first place.

Yep.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
