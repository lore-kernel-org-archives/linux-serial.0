Return-Path: <SRS0=/4l0=YA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9307AC47404
	for <linux-serial@archiver.kernel.org>; Mon,  7 Oct 2019 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8821871
	for <linux-serial@archiver.kernel.org>; Mon,  7 Oct 2019 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570459465;
	bh=VtWId5vYYsclunErfb5u6anv5q7krptmTQWAa+3fm0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RiTmFVponCdqTHtL7atSbO+c9x31T3PmyumrcL2UqM9JIbMHu/GhE6xo7RQz8x7SF
	 y1De4ndcNglP6WkLNCnV7qMEl5C6NxQE6YcWRzd0ty6O6+COQaQWU9hjdxnE/xDF5D
	 EVk2rk/k/8f/1tweD8uvkjweVlUZvP6RI7VnMths=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfJGOoZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGOoY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Oct 2019 10:44:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD9D21721;
        Mon,  7 Oct 2019 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570459464;
        bh=VtWId5vYYsclunErfb5u6anv5q7krptmTQWAa+3fm0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y/zA5wDpgBSS11fa0DPaotgCqyxAoUoP9sjoIkwDWeErZuOUvC9zQ1cht0PlgJCz7
         oDOWEFjt3bzZFMMkF97mKTsU/ISIiQrBAPj2O+qpMWGY2JRAVAA9w6qLmhdCbLR5Qq
         c2q9JMvQKLIEaZvl2XAwY0aDEx/POtvwuHZgOkxc=
Date:   Mon, 7 Oct 2019 16:44:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 0/2] drivers: make early_platform code SuperH-specific
Message-ID: <20191007144421.GA966763@kroah.com>
References: <20191003092913.10731-1-brgl@bgdev.pl>
 <20191004130031.GA596158@kroah.com>
 <20191004132025.GQ16318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191004132025.GQ16318@brightrain.aerifal.cx>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20191007144421.qVrOfW2cAm9UMEJvB1DIbvjMrPkxeKfoKT7QvUGofUg@z>

On Fri, Oct 04, 2019 at 09:20:25AM -0400, Rich Felker wrote:
> On Fri, Oct 04, 2019 at 03:00:31PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 03, 2019 at 11:29:11AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > Some time ago I started a discussion about the need for a proper early device
> > > probing mechanism[1]. One that would be based on real platform drivers and
> > > support both platform data and device tree.
> > > 
> > > While we're far from reaching any consensus on the implementation, Arnd
> > > suggested that I start off by moving the SuperH-specific early platform
> > > drivers implementation to arch/sh[2].
> > > 
> > > This series is the first attempt at making way for a new, less hacky
> > > implementation.
> > > 
> > > The first patch moves all the early_platform code to arch/sh.
> > > 
> > > The second patch prefixes all early_platform symbols with 'sh_'.
> > > 
> > > [1] https://lkml.org/lkml/2018/4/26/657
> > > [2] https://lkml.org/lkml/2018/4/27/239
> > > 
> > > v1 -> v2:
> > > - certain drivers are compiled for arm/mach-shmobile too - we need to
> > >   add ifdefs for CONFIG_SUPERH around early_platform calls
> > > 
> > > v2 -> v3:
> > > - added a stub for is_early_platform_device() which always returns false
> > >   on non-SuperH architectures
> > > 
> > > v3 -> v4:
> > > - rebased on top of v5.4-rc1
> > > - removed patches that are already upstream from the series
> > > 
> > > Bartosz Golaszewski (2):
> > >   drivers: move the early platform device support to arch/sh
> > >   sh: add the sh_ prefix to early platform symbols
> > 
> > I like this, any objection from anyone if I take this in my driver-core
> > tree for 5.5-rc1?
> 
> I don't think I have any objection. It will probably make gratuitous
> merge conflicts with Sato-san's old device tree sh4 work when we get
> back to finishing that, but that's not really a big deal.

Ok, I've queued it up in my tree now, thanks,

greg k-h
