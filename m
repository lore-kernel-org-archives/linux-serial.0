Return-Path: <SRS0=FrDw=4M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7822AC35679
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEFE20836
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBXJNP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:28061 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgBXJJw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 01:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; 
   d="scan'208";a="229788200"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 01:09:47 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j69kL-004Lj1-NO; Mon, 24 Feb 2020 11:09:49 +0200
Date:   Mon, 24 Feb 2020 11:09:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200224090949.GU10400@smile.fi.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 18, 2020 at 09:58:44AM +0100, Petr Mladek wrote:
> On Mon 2020-02-17 13:40:10, Andy Shevchenko wrote:
> > This is third version to get rid of problematic DMA and PM calls in
> > the serial kernel console code.
> > 
> > Patches 1, 3 and 4 are preparatory ones.
> > 
> > After previous discussion Tony suggested to add a possibility to detach
> > and attach back kernel console from user space. It's done in the patch 2.
> > 
> > Note, it depends to recently submitted and applied patches in
> > the core console code [2, 3]. Petr, may you confirm that [3] is
> > immutable or even send Greg KH a PR?
> 
> Yes, the branch for-5.7-console-exit in printk.git is basically
> immutable. I do my best to prevent rebasing.

Thanks for confirming this!

Greg, thanks for applying patches 1, 3, and 4. How can we proceed from this point?

> > Greg, see above note before applying, thanks!
> > 
> > [1]: https://lore.kernel.org/patchwork/cover/905632/
> > [2]: https://lore.kernel.org/lkml/20200203133130.11591-1-andriy.shevchenko@linux.intel.com/
> > [3]: https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit

-- 
With Best Regards,
Andy Shevchenko


