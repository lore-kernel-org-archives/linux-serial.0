Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ECFC48BC2
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49A961946
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 18:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFYSOR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 14:14:17 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:33708 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFYSOQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 14:14:16 -0400
Received: by mail-vs1-f43.google.com with SMTP id j8so5966312vsd.0;
        Fri, 25 Jun 2021 11:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UGCjOlRMxleh7mNgzuADGgNle/wDqmHHRKvIHdKcwLI=;
        b=jpTpeP6zT58bEt7MvbfkpJ8IUJtlVT7BT4i8BDyE+1sZbt8w3Rqd1iNCk+wSj7cA1z
         XB8wE4KhK1v5kBPrmQ44LvjAaY/LAUk50CQg47jL6hI+dz2QaNtQppeLcqRcqIcJfO81
         iDCuWNJpWAoO6euHKjuwwismkYWb433UZlN9B1sZpj35h00WKyP6P+LJZq6rN5sbHA3M
         UTpoG+CxzvoHcWjjLFtYjcK2PpVetKdDaQYrv8vaUXjJFaGKxwWKbwB733oRuBY3LYQU
         afgRBNnGbRcfjErvraM67W58o6DAl8HCO8AkrW3j37ryxmH8BMXmRVNS1GHH5JgjXcp1
         DYwQ==
X-Gm-Message-State: AOAM5336877mfT1EgMW5PD346B5qmIsxeZq0WyxaKjasj5MhcEOL/xAT
        HZf9HjlHO4X0JxYKYlju2J8TIcrug0r1o+r+opA=
X-Google-Smtp-Source: ABdhPJxL0voD6OURz4cp/fmkQKvGuot8ADooEYP7MmZj/8kbo2Udiga87FuIglb2ROpcwkxvqA7qBF8c2PE52dNe8Xc=
X-Received: by 2002:a05:6102:301c:: with SMTP id s28mr9984120vsa.18.1624644714273;
 Fri, 25 Jun 2021 11:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210624224909.6350-1-pali@kernel.org> <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org> <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
 <20210625153803.u6uesckcqyvvo7dl@pali> <20210625155008.GB16901@1wt.eu>
 <CAMuHMdWfE7UKkp6=MdAVgHywFjDK3SN4m9+d_6AmJTB=qBEqFw@mail.gmail.com> <20210625174448.kje4pvg5ixpu3vaw@pali>
In-Reply-To: <20210625174448.kje4pvg5ixpu3vaw@pali>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Jun 2021 20:11:43 +0200
Message-ID: <CAMuHMdXSXZXQiDupPqqmH-o_pDnn9EF=SLP4Oc5zwK=EFxF3Ew@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
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

Hi Pali,

On Fri, Jun 25, 2021 at 7:44 PM Pali Rohár <pali@kernel.org> wrote:
> On Friday 25 June 2021 19:39:10 Geert Uytterhoeven wrote:
> > On Fri, Jun 25, 2021 at 5:50 PM Willy Tarreau <w@1wt.eu> wrote:
> > > On Fri, Jun 25, 2021 at 05:38:03PM +0200, Pali Rohár wrote:
> > > > On Friday 25 June 2021 17:22:31 Geert Uytterhoeven wrote:
> > > > > > +/*
> > > > > > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> > > > > > + * @dividend: unsigned 64bit dividend
> > > > > > + * @divisor: unsigned 32bit divisor
> > > > > > + *
> > > > > > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > > > > > + * and round to closest integer.
> > > > > > + *
> > > > > > + * Return: dividend / divisor rounded to nearest integer
> > > > > > + */
> > > > > > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> > > > > > +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
> > > > >
> > > > > Given "dividend" should already be an unsigned 64-bit value, I don't
> > > > > think the cast to "u64" is needed. Similar macros in this file also
> > > > > don't have the cast.
> > > >
> > > > It is just to ensure that plus operation between dividend and _tmp is
> > > > evaluated in 64-bit context to prevent overflow. Just a case when user
> > > > calls this macro with 32-bit dividend param. As it is a macro (and not
> > > > inline function) type is not automatically enforced.
> > >
> > > I agree, a large u32 argument added to _tmp/2 could overflow and remain
> > > 32 bits, yielding an incorrect result. The cast is mandatory here (and
> > > will either emit no code, or be useful).
> >
> > Fair enough.
> > So we want to add a cast to DIV64_U64_ROUND_CLOSEST() above, too?
>
> For DIV64_U64_ROUND_CLOSEST() it is not needed. divisor is copied into
> u64 _tmp variable and therefore "(dividend) + _tmp / 2" is already
> evaluated in 64-bit context even when dividend is only 32-bit.

Thanks, I stand corrected.  Time to enter weekend mode...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
