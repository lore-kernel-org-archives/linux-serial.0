Return-Path: <SRS0=FrDw=4M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB434C35671
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6442072D
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 12:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXMXt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:23:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXMXt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Feb 2020 07:23:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 510C5AC1D;
        Mon, 24 Feb 2020 12:23:47 +0000 (UTC)
Date:   Mon, 24 Feb 2020 13:23:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200224122346.nba6jgkgfpbqjpzw@pathway.suse.cz>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
 <20200224090949.GU10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224090949.GU10400@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 2020-02-24 11:09:49, Andy Shevchenko wrote:
> On Tue, Feb 18, 2020 at 09:58:44AM +0100, Petr Mladek wrote:
> > On Mon 2020-02-17 13:40:10, Andy Shevchenko wrote:
> > > This is third version to get rid of problematic DMA and PM calls in
> > > the serial kernel console code.
> > > 
> > > Patches 1, 3 and 4 are preparatory ones.
> > > 
> > > After previous discussion Tony suggested to add a possibility to detach
> > > and attach back kernel console from user space. It's done in the patch 2.
> > > 
> > > Note, it depends to recently submitted and applied patches in
> > > the core console code [2, 3]. Petr, may you confirm that [3] is
> > > immutable or even send Greg KH a PR?
> > 
> > Yes, the branch for-5.7-console-exit in printk.git is basically
> > immutable. I do my best to prevent rebasing.
> 
> Thanks for confirming this!
> 
> Greg, thanks for applying patches 1, 3, and 4. How can we proceed from this point?
> 
> > > Greg, see above note before applying, thanks!

The easiest solution would be when all patches go via one tree.

Greg, would you want to take the 7 patches from
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit
via your tree?

I have never done such shuffles between two maintainer trees.
Are there any preferred steps how to do so smoothly, please?

Best Regards,
Petr
