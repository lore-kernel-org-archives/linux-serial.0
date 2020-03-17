Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB3EC2BB1D
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 18:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2E20735
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584471042;
	bh=uUdSH4gCaGeUmZ55v6fuJQXnwyKeqcNjFsT+iCxBMNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bSjkwxS6eyy6mguVqhSWwT3toPiGTMR9MjGZF+JxLA3fwupBMjB4Peybb3nQ9YNpU
	 ELkO7YhKO8E8p9KKKKSJ2E6HEeEikV5msw2PMcPWRXSpcEl5idyV9Zcaiby1t9lXLo
	 G27vEdPVh+CJGqazu2qdWTMl9ZvrCKI9j2PTdaNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCQSum (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgCQSul (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 14:50:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2DB320724;
        Tue, 17 Mar 2020 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584471041;
        bh=uUdSH4gCaGeUmZ55v6fuJQXnwyKeqcNjFsT+iCxBMNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmFW7qPj8sgSlPE2iB2IanZ+PDyzuYZ9tBGMiVJPRTHndP+BJTKM0dl6Q1nfj9rGz
         fkGkHJMAcoyT8pajPh5Uwkp3/mXwcM/nZKHFbb6TpVE2hOYjJCOxzFFUolWmIWusEJ
         iEE4JxmctqGnYkwudGDnHuYhIarVvD9/xEXFSMaI=
Date:   Tue, 17 Mar 2020 19:50:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200317185038.GA1479924@kroah.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
 <20200224090949.GU10400@smile.fi.intel.com>
 <20200224122346.nba6jgkgfpbqjpzw@pathway.suse.cz>
 <20200310134445.GI1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310134445.GI1922688@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 10, 2020 at 03:44:45PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2020 at 01:23:46PM +0100, Petr Mladek wrote:
> > On Mon 2020-02-24 11:09:49, Andy Shevchenko wrote:
> > > On Tue, Feb 18, 2020 at 09:58:44AM +0100, Petr Mladek wrote:
> > > > On Mon 2020-02-17 13:40:10, Andy Shevchenko wrote:
> > > > > This is third version to get rid of problematic DMA and PM calls in
> > > > > the serial kernel console code.
> > > > > 
> > > > > Patches 1, 3 and 4 are preparatory ones.
> > > > > 
> > > > > After previous discussion Tony suggested to add a possibility to detach
> > > > > and attach back kernel console from user space. It's done in the patch 2.
> > > > > 
> > > > > Note, it depends to recently submitted and applied patches in
> > > > > the core console code [2, 3]. Petr, may you confirm that [3] is
> > > > > immutable or even send Greg KH a PR?
> > > > 
> > > > Yes, the branch for-5.7-console-exit in printk.git is basically
> > > > immutable. I do my best to prevent rebasing.
> > > 
> > > Thanks for confirming this!
> > > 
> > > Greg, thanks for applying patches 1, 3, and 4. How can we proceed from this point?
> > > 
> > > > > Greg, see above note before applying, thanks!
> > 
> > The easiest solution would be when all patches go via one tree.
> > 
> > Greg, would you want to take the 7 patches from
> > https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit
> > via your tree?
> 
> I think it would be nice to send formal PR to Greg.
> 
> > I have never done such shuffles between two maintainer trees.
> > Are there any preferred steps how to do so smoothly, please?
> 
> Usually it's done via immutable branch / tag that all stakeholders
> (including the initiator) can pull into their -next branches.
> 
> In any case, if Greg is considering next cycle, don't forget to apply this to
> your -next :-) (I think it's already there)

I've queued all of these up now.  I hope :)

If I have missed anything, please let me know.

thanks,

greg k-h
