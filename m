Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23528C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B2E61969
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFYPk1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhFYPk1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 11:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E66BB61945;
        Fri, 25 Jun 2021 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624635486;
        bh=RYnSHZKNvSMtaXCYfBQEZdqzo1AD3QHCRl1A89atjBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2ybPRZbslkAS7uLPBBDADPnPhHIJrVs4dHt4SAbTBqdmxLYZVdRWbk7VzBwoq8Km
         NlsiyTLWPCAOoBS1c1N/+1ASckrW0oh0G62ug73y20HmFYA/AMGk+NJL9guEymxKfp
         Utidpf3VE7K9kAbinLNaZ/3RNm3S8jmLKTP8KS1NviDRbF5H789WPxzKdV2hlOUVbc
         +nDx3OnI2K2D+8iLnIlhCNgoKgItuizlIGpE3MA9UkzofK6kqpnrAWhbZFjRxvg1pb
         QYnH80UAmNo9HWTZMEvJvW5rZq0ehTaN23qkgbPt9j54k7BHA3EOlt6B763FNYVwBq
         6ONyOM8UC3KkQ==
Received: by pali.im (Postfix)
        id 87B88A7D; Fri, 25 Jun 2021 17:38:03 +0200 (CEST)
Date:   Fri, 25 Jun 2021 17:38:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
Message-ID: <20210625153803.u6uesckcqyvvo7dl@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org>
 <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Friday 25 June 2021 17:22:31 Geert Uytterhoeven wrote:
> Hi Pali,
> 
> On Fri, Jun 25, 2021 at 4:37 PM Pali Rohár <pali@kernel.org> wrote:
> > Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
> > division rounded to the closest integer using unsigned 64bit
> > dividend and unsigned 32bit divisor.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/include/linux/math64.h
> > +++ b/include/linux/math64.h
> > @@ -281,6 +281,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
> >  #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)     \
> >         ({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
> >
> > +/*
> > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> > + * @dividend: unsigned 64bit dividend
> > + * @divisor: unsigned 32bit divisor
> > + *
> > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > + * and round to closest integer.
> > + *
> > + * Return: dividend / divisor rounded to nearest integer
> > + */
> > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> > +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
> 
> Given "dividend" should already be an unsigned 64-bit value, I don't
> think the cast to "u64" is needed. Similar macros in this file also
> don't have the cast.

It is just to ensure that plus operation between dividend and _tmp is
evaluated in 64-bit context to prevent overflow. Just a case when user
calls this macro with 32-bit dividend param. As it is a macro (and not
inline function) type is not automatically enforced.

DIV_S64_ROUND_CLOSEST macro assigns its argument into temporary 64-bit
variable which then ensures usage of 64-bit arithmetic operations. Same
applies for DIV64_U64_ROUND_CLOSEST and DIV64_U64_ROUND_UP macros.

So this is reason why I added explicit cast to u64.

> 
> > +
> >  /*
> >   * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
> >   * @dividend: signed 64bit dividend
> 
> With the above nit fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
