Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6CCC49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA80B61954
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 17:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYRrM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 13:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYRrM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 13:47:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A0BC6157E;
        Fri, 25 Jun 2021 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643091;
        bh=OtC2yHps4Gx+4TrmMrLMl5zOxwe81NfKarp7uzkjwAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYYpRXzLYtG50IJPZ9h6GR6iiH9qLv/987IdlIdK5dKrh21BIZ+L9nZMW5wmsXkCj
         bkUCxO6poe0/XjIdqzeMhQUJ02SikvRfoluA2b6j3zcVhcWy8WQkESoMv1CEmoTmRf
         zvSm7MgsEl7hsV4kfl2c2VGwTLvBWFcABJdyNLzV5PmWWc5O80dWaq8zbdkSs05jhx
         GpL/nHSdwHT5MVeB5wCK9WIUjmSBtYNzh3geb6VS8EMzDIVIWVzQNv8kPueBPLv9q2
         9SCT6wbXxcTWntCFYGb3TwaibrE+PetCqMeofXd+cAlAs+iRV4eyCSarQKU8lYJfyq
         Jz4kJvGKRbPiA==
Received: by pali.im (Postfix)
        id 97367A7D; Fri, 25 Jun 2021 19:44:48 +0200 (CEST)
Date:   Fri, 25 Jun 2021 19:44:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <20210625174448.kje4pvg5ixpu3vaw@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org>
 <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
 <20210625153803.u6uesckcqyvvo7dl@pali>
 <20210625155008.GB16901@1wt.eu>
 <CAMuHMdWfE7UKkp6=MdAVgHywFjDK3SN4m9+d_6AmJTB=qBEqFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWfE7UKkp6=MdAVgHywFjDK3SN4m9+d_6AmJTB=qBEqFw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Friday 25 June 2021 19:39:10 Geert Uytterhoeven wrote:
> Hi Willy,
> 
> On Fri, Jun 25, 2021 at 5:50 PM Willy Tarreau <w@1wt.eu> wrote:
> > On Fri, Jun 25, 2021 at 05:38:03PM +0200, Pali Rohár wrote:
> > > On Friday 25 June 2021 17:22:31 Geert Uytterhoeven wrote:
> > > > > +/*
> > > > > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> > > > > + * @dividend: unsigned 64bit dividend
> > > > > + * @divisor: unsigned 32bit divisor
> > > > > + *
> > > > > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > > > > + * and round to closest integer.
> > > > > + *
> > > > > + * Return: dividend / divisor rounded to nearest integer
> > > > > + */
> > > > > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> > > > > +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
> > > >
> > > > Given "dividend" should already be an unsigned 64-bit value, I don't
> > > > think the cast to "u64" is needed. Similar macros in this file also
> > > > don't have the cast.
> > >
> > > It is just to ensure that plus operation between dividend and _tmp is
> > > evaluated in 64-bit context to prevent overflow. Just a case when user
> > > calls this macro with 32-bit dividend param. As it is a macro (and not
> > > inline function) type is not automatically enforced.
> >
> > I agree, a large u32 argument added to _tmp/2 could overflow and remain
> > 32 bits, yielding an incorrect result. The cast is mandatory here (and
> > will either emit no code, or be useful).
> 
> Fair enough.
> So we want to add a cast to DIV64_U64_ROUND_CLOSEST() above, too?

For DIV64_U64_ROUND_CLOSEST() it is not needed. divisor is copied into
u64 _tmp variable and therefore "(dividend) + _tmp / 2" is already
evaluated in 64-bit context even when dividend is only 32-bit.

The only trap is that negative value as written below.

> > The only trap I'm seeing is if a negative signed int is passed in dividend,
> > it will be sign-extended and will give a large u64 value. A preliminary
> > u32 cast could avoid this but would break valid u64 arguments, and I'd
> > claim we never know what the user wants if this happens in the first place.
> 
> Yep.
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
