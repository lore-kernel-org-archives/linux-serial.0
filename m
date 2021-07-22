Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A2C4320A
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B2460EBA
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhGVVRM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVRL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 17:17:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C3FE60EB4;
        Thu, 22 Jul 2021 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626991066;
        bh=jxHLi9bM6Hq+3vf5t//DlAv09jjPbBHB2nQxogyaotI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuiSFsbPNO4Ffxt3+mAvxMTMoqe8AB3wjCAbc8L9bjtP/7VLqTomE1tbVss2cTk9C
         gCKzDk9iIErDPnc6i8+BAaA3ELCWYEYO7EsrsUn24BbteMEygIYJL4noaUsJY4wYkn
         qf8NO1SxTmEEh1Pq6PoxFm3DI5Q+y1nj0llY3dEfkWcWNB1BCWnIndCKy4eG3Dv2Ad
         W48MtT5N/QT03aPxC/Ds/vMsAoHLr+EhDrOJV7iB83XdqdumbmS4rMOAcquJBxyimh
         7wRId4g7kklBZqE4VFXI1G24pBNqE4EdqZbD9zScKK/egZ2HwtuMep9WPFAyTD+yS8
         9bCVvQp2ul+yA==
Received: by pali.im (Postfix)
        id 9ECB3805; Thu, 22 Jul 2021 23:57:43 +0200 (CEST)
Date:   Thu, 22 Jul 2021 23:57:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v3 1/5] math64: New DIV_U64_ROUND_CLOSEST helper
Message-ID: <20210722215743.gtwccvokecvoocmm@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-2-pali@kernel.org>
 <CAHp75VeCC3cYu3RZPxuRN4iaM+vxp2rX+E4z+ZxzRGM8oHaMkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeCC3cYu3RZPxuRN4iaM+vxp2rX+E4z+ZxzRGM8oHaMkw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Monday 19 July 2021 15:47:07 Andy Shevchenko wrote:
> On Sat, Jul 17, 2021 at 3:39 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
> > division rounded to the closest integer using unsigned 64bit
> > dividend and unsigned 32bit divisor.
> 
> ...
> 
> > +/*
> > + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
> 
> > + * @dividend: unsigned 64bit dividend
> 
> Here you insist users to provide a u64 (or compatible) type.
> 
> > + * @divisor: unsigned 32bit divisor
> > + *
> > + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> > + * and round to closest integer.
> > + *
> > + * Return: dividend / divisor rounded to nearest integer
> > + */
> > +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \
> 
> > +       ({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
> 
> Here is the casting to u64. Why? (Yes, I have read v1 discussion and I
> just want to continue it here).

See also Willy's response: https://lore.kernel.org/lkml/20210625155008.GB16901@1wt.eu/

Macro does not enforce type as opposite to function.

There is no compile time check for correct type and neither compile time
warning if smaller typed value is passed.

And e.g. passing constant with explicit ULL suffix or casting external
constant to 64bit type is impractical.
