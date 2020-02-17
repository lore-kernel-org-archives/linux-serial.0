Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB91C34022
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 22:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D48C2072C
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 22:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgBQWvh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:51:37 -0500
Received: from muru.com ([72.249.23.125]:55714 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgBQWvh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 17:51:37 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7722D8087;
        Mon, 17 Feb 2020 22:52:21 +0000 (UTC)
Date:   Mon, 17 Feb 2020 14:51:34 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200217225134.GQ16391@atomide.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200217 11:41]:
> This is third version to get rid of problematic DMA and PM calls in
> the serial kernel console code.
> 
> Patches 1, 3 and 4 are preparatory ones.
> 
> After previous discussion Tony suggested to add a possibility to detach
> and attach back kernel console from user space. It's done in the patch 2.
> 
> Kernel console is sensitive to any kind of complex work needed to print
> out anything on it. One such case is emergency print during Oops.
> 
> More details on topic are in the commit messages of the patches 5 and 6.
> 
> The series has been tested on few Intel platforms.
> 
> Note, it depends to recently submitted and applied patches in
> the core console code [2, 3]. Petr, may you confirm that [3] is
> immutable or even send Greg KH a PR?
> 
> Greg, see above note before applying, thanks!
> 
> [1]: https://lore.kernel.org/patchwork/cover/905632/
> [2]: https://lore.kernel.org/lkml/20200203133130.11591-1-andriy.shevchenko@linux.intel.com/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit
> 
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Petr Mladek <pmladek@suse.com>
> 
> Changelog v3:
> - dropped applied patches
> - dropped "cleanup" DMA patches, that they were not tested and actually are regressions
> - added DEVICE_ATTR_RO/_RW conversion patches (Greg)
> - added pr_*() to dev_*() conversion patch (Greg)
> - updated commit message to note OMAP behaviour change (Russell)
> - replace run-time PM callbacks to be _sync() (Tony)

Nice, works for my test cases now! Please feel free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
