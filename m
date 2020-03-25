Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6026C5518A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37CD20789
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585119704;
	bh=L92V+2bJcj7BoRxTRqi9mP4QmyLglmt1aSc0qiIM0vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VdPp3/3+rk6XdWxUiC/9EfiD7AlhCGJZS1Lb+EGO9H4dDllXJliTNGiIIvvoQIs14
	 y2M3ze+oxMrnWVJOkKS5rOqhfdtze4hMCO7t/83VM81Yiprd2XFKgX6Ou164ZWyr5d
	 FmoaORzcCn7Fd9hcExutw95KKsBJlPtporYtC/qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgCYHBo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgCYHBo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 03:01:44 -0400
Received: from localhost (unknown [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D3920772;
        Wed, 25 Mar 2020 07:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585119698;
        bh=L92V+2bJcj7BoRxTRqi9mP4QmyLglmt1aSc0qiIM0vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2U23NQd7Tw/2M0F0Pxmzmhfk/qGjT8r9kRJtt12VhMpGhmrExPN33itfYwls2taKc
         7Kr+F60rm2qmS5cTvL3NcjNpMQ+nDxDV0MZUi+sQOd7Ywc+K3aWzRiIDXsRGKYvdA0
         HwXl1Tz8/aO7p+egItzX55amJTKa5zb1zC/NN0EY=
Date:   Wed, 25 Mar 2020 08:01:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] tty: serial: make SERIAL_SPRD depends on ARM or ARM64
Message-ID: <20200325070127.GA2960703@kroah.com>
References: <20200324064949.23697-1-zhang.lyra@gmail.com>
 <20200324112115.GA10018@lakrids.cambridge.arm.com>
 <CAAfSe-u7SjWr7VK37OFrFDfm1o-6VwEoUMLctP61us+iQ1emTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfSe-u7SjWr7VK37OFrFDfm1o-6VwEoUMLctP61us+iQ1emTw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 25, 2020 at 09:37:00AM +0800, Chunyan Zhang wrote:
> Hi Mark, Greg,
> 
> Pleas see my answer below.
> 
> On Tue, 24 Mar 2020 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Mar 24, 2020 at 02:49:49PM +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > kbuild-test reported an error:
> > >
> > >   config: mips-randconfig-a001-20200321 ...
> > >   >> drivers/tty/serial/sprd_serial.c:1175: undefined reference
> > >   to `clk_set_parent'
> > >
> > > Because some mips Kconfig-s select CONFIG_HAVE_CLK but not CONFIG_COMMON_CLK,
> > > so it's probably that clk_set_parent is missed for those configs.
> > >
> > > To fix this error, this patch adds dependence on ARM || ARM64
> > > for SERIAL_SPRD.
> >
> > From the above, isn't the real dependency COMMON_CLOCK?
> 
> Some arch can implement its own clock APIs, for example AR7 [1].

That's fine, then they can not select this option.

> The sprd serial driver is used on ARM and ARM64 platforms only for
> now, which uses clock functions provided by COMMON_CLK, but it has the
> possibility of being used on other architecture platforms, that was my
> thought.
> 
> I should revise this commit message to:
> "
> Because some mips Kconfig-s select CONFIG_HAVE_CLK but not define
> clk_set_parent which is used by the sprd serial driver.
> ...
> "
> 
> Does it make sense?

The arch is not the issue here, the clock framework is, so properly
depend on that, not an arbitrary CPU type.

thanks,

greg k-h
