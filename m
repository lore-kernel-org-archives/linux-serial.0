Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC0C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCAC206CC
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 17:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbgBNRNx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:13:53 -0500
Received: from muru.com ([72.249.23.125]:55290 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390150AbgBNRNw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 12:13:52 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E04578160;
        Fri, 14 Feb 2020 17:14:35 +0000 (UTC)
Date:   Fri, 14 Feb 2020 09:13:48 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214171348.GP16391@atomide.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
 <20200214133918.GP25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214133918.GP25745@shell.armlinux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Russell King - ARM Linux admin <linux@armlinux.org.uk> [200214 13:40]:
> On Fri, Feb 14, 2020 at 01:43:36PM +0200, Andy Shevchenko wrote:
> > Doing any kind of power management for kernel console is really bad idea.
> > 
> > First of all, it runs in poll and atomic mode. This fact attaches a limitation
> > on the functions that might be called. For example, pm_runtime_get_sync() might
> > sleep and thus can't be used. This call needs, for example, to bring the device
> > to powered on state on the system, where the power on sequence may require
> > on-atomic operations, such as Intel Cherrytrail with ACPI enumerated UARTs.
> > That said, on ACPI enabled platforms it might even call firmware for a job.
> > 
> > On the other hand pm_runtime_get() doesn't guarantee that device will become
> > powered on fast enough.
> > 
> > Besides that, imagine the case when console is about to print a kernel Oops and
> > it's powered off. In such an emergency case calling the complex functions is
> > not the best what we can do, taking into consideration that user wants to see
> > at least something of the last kernel word before it passes away.
> > 
> > Here we modify the 8250 console code to prevent runtime power management.
> 
> It's probably also worth noting (and documenting) that this will likely
> cause a PM regression for OMAP platforms since the serial port will no
> longer be idled, and therefore the power domains will not hit retention
> state.  Please wait for Tony to confirm.

Well with patch 4 in this series we can now attach and detach the serial
console as we've discussed earlier.

This should remove the need for PM during serial console use hopefully :)

I'll try to test this series ASAP.

Regards,

Tony


