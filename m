Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E336DC2BB8C
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E4920675
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCJNot (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:44:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:36261 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgCJNos (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 09:44:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="235940424"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2020 06:44:43 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBfBd-008TY1-9g; Tue, 10 Mar 2020 15:44:45 +0200
Date:   Tue, 10 Mar 2020 15:44:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200310134445.GI1922688@smile.fi.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
 <20200224090949.GU10400@smile.fi.intel.com>
 <20200224122346.nba6jgkgfpbqjpzw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224122346.nba6jgkgfpbqjpzw@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 24, 2020 at 01:23:46PM +0100, Petr Mladek wrote:
> On Mon 2020-02-24 11:09:49, Andy Shevchenko wrote:
> > On Tue, Feb 18, 2020 at 09:58:44AM +0100, Petr Mladek wrote:
> > > On Mon 2020-02-17 13:40:10, Andy Shevchenko wrote:
> > > > This is third version to get rid of problematic DMA and PM calls in
> > > > the serial kernel console code.
> > > > 
> > > > Patches 1, 3 and 4 are preparatory ones.
> > > > 
> > > > After previous discussion Tony suggested to add a possibility to detach
> > > > and attach back kernel console from user space. It's done in the patch 2.
> > > > 
> > > > Note, it depends to recently submitted and applied patches in
> > > > the core console code [2, 3]. Petr, may you confirm that [3] is
> > > > immutable or even send Greg KH a PR?
> > > 
> > > Yes, the branch for-5.7-console-exit in printk.git is basically
> > > immutable. I do my best to prevent rebasing.
> > 
> > Thanks for confirming this!
> > 
> > Greg, thanks for applying patches 1, 3, and 4. How can we proceed from this point?
> > 
> > > > Greg, see above note before applying, thanks!
> 
> The easiest solution would be when all patches go via one tree.
> 
> Greg, would you want to take the 7 patches from
> https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit
> via your tree?

I think it would be nice to send formal PR to Greg.

> I have never done such shuffles between two maintainer trees.
> Are there any preferred steps how to do so smoothly, please?

Usually it's done via immutable branch / tag that all stakeholders
(including the initiator) can pull into their -next branches.

In any case, if Greg is considering next cycle, don't forget to apply this to
your -next :-) (I think it's already there)

-- 
With Best Regards,
Andy Shevchenko


