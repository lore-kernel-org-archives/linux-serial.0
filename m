Return-Path: <SRS0=X3gT=4G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F60C34026
	for <linux-serial@archiver.kernel.org>; Tue, 18 Feb 2020 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C85206E2
	for <linux-serial@archiver.kernel.org>; Tue, 18 Feb 2020 08:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgBRI6r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:58:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:53754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgBRI6r (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Feb 2020 03:58:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B70FACCE;
        Tue, 18 Feb 2020 08:58:45 +0000 (UTC)
Date:   Tue, 18 Feb 2020 09:58:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 2020-02-17 13:40:10, Andy Shevchenko wrote:
> This is third version to get rid of problematic DMA and PM calls in
> the serial kernel console code.
> 
> Patches 1, 3 and 4 are preparatory ones.
> 
> After previous discussion Tony suggested to add a possibility to detach
> and attach back kernel console from user space. It's done in the patch 2.
> 
> Note, it depends to recently submitted and applied patches in
> the core console code [2, 3]. Petr, may you confirm that [3] is
> immutable or even send Greg KH a PR?

Yes, the branch for-5.7-console-exit in printk.git is basically
immutable. I do my best to prevent rebasing.

> Greg, see above note before applying, thanks!
> 
> [1]: https://lore.kernel.org/patchwork/cover/905632/
> [2]: https://lore.kernel.org/lkml/20200203133130.11591-1-andriy.shevchenko@linux.intel.com/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit

Best Regards,
Petr
