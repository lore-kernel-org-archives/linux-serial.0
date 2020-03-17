Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09853C10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D5D20738
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584455028;
	bh=0KEgAPXq9iYiYZLfx3KHeje8IN95rTEDMJs8iZS/Y0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jJ/XaEC6F5rNYbgeM7+aMJMVF3nEN7CJZ9cyqjTgQRVj99Kf9zHZvjTfK4ZgsCL0r
	 E35d0/dURo/vLAdTUO2whrH+SeBi7TGEK8sjtKh4NLVpSG5o8+xlgxh8ISx/kS7EIu
	 3vveKtcE1dkaEL6qY3jWbkcWRtPV2ZyFoMkF5JaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQOXs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgCQOXs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 10:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EEB20663;
        Tue, 17 Mar 2020 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584455027;
        bh=0KEgAPXq9iYiYZLfx3KHeje8IN95rTEDMJs8iZS/Y0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwnwjQib5FRvF1pY8Acp2Xal1NZtJI7hKgPPw1XZBwJNOtZ/Hmir4sbeUmhg0Fqwo
         QXXyIMPN+NBtUvqrM7O+16YYHJrG/Z17lea+bfzbTGGvUfdbptZGtuVS9ByTLQBQ74
         TjPLvu0a44ao4g4BT6qTmFDwY3UKMvvVk4pArTuU=
Date:   Tue, 17 Mar 2020 15:23:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Message-ID: <20200317142343.GB1391636@kroah.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
 <20200218085844.hdsnba5o53fca2g2@pathway.suse.cz>
 <20200224090949.GU10400@smile.fi.intel.com>
 <20200224122346.nba6jgkgfpbqjpzw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224122346.nba6jgkgfpbqjpzw@pathway.suse.cz>
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

I will pull this from your tree so please do not rebase :)

thanks,

greg k-h
