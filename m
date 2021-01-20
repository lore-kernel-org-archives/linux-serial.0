Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1EC433DB
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D0A23358
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 17:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbhATRQG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404143AbhATRPy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jan 2021 12:15:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E3AA22CE3;
        Wed, 20 Jan 2021 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611162910;
        bh=icT6ldp0FVZTNs/72NOyreuoBFHN73VbBxC41uUl4iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1+iWkrHj2DeduiQT4II0hNWE4A2UXg1nQdfTu/u7O3f4tEzJn6+N26uCzqz1QNL5
         dEs8KQGQBQ6KYihWINdXaRZc46J0XM87o8/TVEufwLkVY6jTuYCN+pXpg/EnlX8hHi
         WghRafhypYgnsxnDnU7wfeIloMACTvloNeI8wcGI=
Date:   Wed, 20 Jan 2021 18:15:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YAhlHL67rDmWSWdr@kroah.com>
References: <20210115211543.33563-1-alcooperx@gmail.com>
 <20210115211543.33563-3-alcooperx@gmail.com>
 <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
 <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com>
 <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
 <YAhiw+6UiUplNcLq@kroah.com>
 <CAHp75Vf-ZmPuOjRYwNbURJXP3g_-m1LUDbsWtKHMvP49jseprw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf-ZmPuOjRYwNbURJXP3g_-m1LUDbsWtKHMvP49jseprw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 20, 2021 at 07:09:46PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 20, 2021 at 7:05 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jan 20, 2021 at 06:47:52PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 19, 2021 at 8:16 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > > On 1/19/2021 7:21 AM, Andy Shevchenko wrote:
> > > > > On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:
> 
> ...
> 
> > > > Not sure this makes sense, given that the DMA hardware that was added to
> > > > this UART block is only used by the UART block and no other pieces of HW
> > > > in the system, nor will they ever be. Not sure it makes sense to pay the
> > > > cost of an extra indirection and subsystem unless there are at least two
> > > > consumers of that DMA hardware to warrant modeling it after a dmaengine
> > > > driver. I also remember that Al researched before whether 8250_dma.c
> > > > could work, and came to the conclusion that it would not, but I will let
> > > > him comment on the specifics.
> > >
> > > I see. In any case I still believe that the driver can be shrinked by
> > > a notable amount of lines.
> >
> > Patches always gladly accepted :)
> 
> Or a good review... :-)

Please do so!
