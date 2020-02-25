Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F9C35E01
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 20:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAB521744
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582663317;
	bh=YYC4xaOlh2BnEG7cTijsktqQkfUcqWoUPp+Gy0hHL5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JnNwUxzJ1+9qNVfvOuVwKlA6jflebe7kwjUGQBefeXaKpcnHoIJMfqbPABCKoxsMC
	 Se6KGpqAf4CLU+dLGzD8pbUbVbf/Lbv3B623S5vDbuS6gWYS4eRAhzYaj1XH03cA3Z
	 i0ItjRVGwdZlLyZTYayM233xAVPT4A2WOJIpVC+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgBYUl4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgBYUl4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 15:41:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F88F20675;
        Tue, 25 Feb 2020 20:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582663315;
        bh=YYC4xaOlh2BnEG7cTijsktqQkfUcqWoUPp+Gy0hHL5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyQo5IPJ8L0EIKxeaAFS2wAcDllxRfr2eyVyy1hLk8AAcr8z8/gIQPFmVOAcK45//
         0PSaDa7pEC5LX/x8Hl6kxwy8zvjscYilZIkwDkR1kel/bGuxKAII++UJ/QCGZ7bqbi
         CL+pgiEvxS2wgZ9W/4jpN7F68Cg0E7zmzKk678t0=
Date:   Tue, 25 Feb 2020 21:41:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Donghoon Yu <hoony.yu@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Hyunki Koo <kkoos00@naver.com>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: build it for any platform
Message-ID: <20200225204151.GA13254@kroah.com>
References: <CGME20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc@eucas1p2.samsung.com>
 <20200220102628.3371996-1-gregkh@linuxfoundation.org>
 <b04ad319-9986-c357-ad37-937bbb06bc02@samsung.com>
 <CAMuHMdXzPPNqQom82frY1B6LMre+VD9fPAf98BZ3eo2DhgwoYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXzPPNqQom82frY1B6LMre+VD9fPAf98BZ3eo2DhgwoYg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 25, 2020 at 09:52:38AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 20, 2020 at 1:13 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On 2/20/20 11:26 AM, Greg Kroah-Hartman wrote:
> > > There is no need to tie this driver to only a specific SoC, or compile
> > > test, so remove that dependancy from the Kconfig rules.
> >
> > samsung_tty driver is hardware specific driver so why should we
> > build it for any platform?

Why not?

Seriously, this "only this one specific SoC is allowed to build this
driver" is crazy.  It prevents anyone from building a generic kernel
with drivers as a module which are loaded as needed.

That needs to be fixed, and removing this unneeded dependancy on this
driver allows it to be build for any system and then only loaded when
needed.

> > This change seems to defeat the whole purpose behind COMPILE_TEST
> > config option (which allows us to build hardware-specific drivers
> > without needlessly presenting the user with tons of non-relevant
> > config options).
> >
> > Please explain this change some more, are you planing to remove
> > COMPILE_TEST config option?

I want to get rid of this:

> > > -     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST

We should not need PLAT_SAMSUNG or ARCH_EXYNOS at all, we should be able
to build an arm64 kernel for all platforms.

thanks,

greg k-h
