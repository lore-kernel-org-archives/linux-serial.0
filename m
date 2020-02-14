Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249CC35242
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EE8206CC
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 21:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgBNVlc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:41:32 -0500
Received: from muru.com ([72.249.23.125]:55410 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387782AbgBNVlc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 16:41:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9E58B80E7;
        Fri, 14 Feb 2020 21:42:15 +0000 (UTC)
Date:   Fri, 14 Feb 2020 13:41:28 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 0/8] serial: Disable DMA and PM on kernel console
Message-ID: <20200214214128.GW16391@atomide.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214163325.GA3992427@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214163325.GA3992427@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [200214 20:03]:
> On Fri, Feb 14, 2020 at 01:43:31PM +0200, Andy Shevchenko wrote:
> > This is second attempt [1] to get rid of problematic DMA and PM calls
> > in the serial kernel console code.
> > 
> > Kernel console is sensitive to any kind of complex work needed to print
> > out anything on it. One such case is emergency print during Oops.
> > 
> > Patches 1-3 are preparatory ones.
> 
> I've applied these first 3, as they are "obvious" :)
> 
> I'll let others weigh in on the other patches here, as I'd like to see
> if Tony and others feel it solves their issues or not.

Yes with the pm_runtime_get_sync/pm_runtime_put_sync change for
patch 5/8 things work nicely for me. But as it looks like there will
be another revision of the patches so I'll wait for that before
acking.

Regards,

Tony
