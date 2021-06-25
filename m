Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C3C49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5566195F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFYPxH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:53:07 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:57120 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhFYPxH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 11:53:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 15PFo8Qb017261;
        Fri, 25 Jun 2021 17:50:08 +0200
Date:   Fri, 25 Jun 2021 17:50:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
Message-ID: <20210625155008.GB16901@1wt.eu>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
 <20210625143617.12826-8-pali@kernel.org>
 <CAMuHMdUCEHtqNk-nGJhPK_=NrgSoRhmC99J9pdGqQxcWpoFqGg@mail.gmail.com>
 <20210625153803.u6uesckcqyvvo7dl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625153803.u6uesckcqyvvo7dl@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 25, 2021 at 05:38:03PM +0200, Pali Rohár wrote:
> On Friday 25 June 2021 17:22:31 Geert Uytterhoeven wrote:
> > > +/*
> > > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> > > + * @dividend: unsigned 64bit dividend
> > > + * @divisor: unsigned 32bit divisor
> > > + *
> > > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > > + * and round to closest integer.
> > > + *
> > > + * Return: dividend / divisor rounded to nearest integer
> > > + */
> > > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> > > +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
> > 
> > Given "dividend" should already be an unsigned 64-bit value, I don't
> > think the cast to "u64" is needed. Similar macros in this file also
> > don't have the cast.
> 
> It is just to ensure that plus operation between dividend and _tmp is
> evaluated in 64-bit context to prevent overflow. Just a case when user
> calls this macro with 32-bit dividend param. As it is a macro (and not
> inline function) type is not automatically enforced.

I agree, a large u32 argument added to _tmp/2 could overflow and remain
32 bits, yielding an incorrect result. The cast is mandatory here (and
will either emit no code, or be useful).

The only trap I'm seeing is if a negative signed int is passed in dividend,
it will be sign-extended and will give a large u64 value. A preliminary
u32 cast could avoid this but would break valid u64 arguments, and I'd
claim we never know what the user wants if this happens in the first place.

Willy
