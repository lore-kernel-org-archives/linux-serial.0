Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FF7C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4802168B
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 13:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ut7kZlgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBNNjb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:39:31 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44198 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgBNNjb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 08:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BW+EE+1Fkc8PjPK9WHMdALla3YeElZUWZwO/xMeGQfo=; b=ut7kZlgTdAPc/xIJyfvLY1dis
        fh9EFBLIhtBTRpFyeKMOScJhKm1iUeS8N1DB87GIP/A9DsDiAX6UqG5WOUpQzL1zbOiNDp6XI/Q4y
        nP+3pTM2JR5PSGQF2WSjODyk1IPTfWVANBqoTA3qch2v82cWnNA8qXJVHo7mgwcGS127lklIinXap
        7k7IS4+Ocbu0q9XaFnxi6UbylFxQXVeJbhdVxZBRHjrorrGFwUP3VmZRSwT9MA2fSYAptwLFaNYwP
        9/06PQCYN3VRfEe+dLQWDX4YT4n6GusuNZcu+KCRn81BKO4B8eBPvWbNdFd6HhpSLEZ1zTaOfjwTL
        3N9oe8FNg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51892)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j2bBj-0007DH-8A; Fri, 14 Feb 2020 13:39:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j2bBe-0003Q8-DR; Fri, 14 Feb 2020 13:39:18 +0000
Date:   Fri, 14 Feb 2020 13:39:18 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214133918.GP25745@shell.armlinux.org.uk>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 01:43:36PM +0200, Andy Shevchenko wrote:
> Doing any kind of power management for kernel console is really bad idea.
> 
> First of all, it runs in poll and atomic mode. This fact attaches a limitation
> on the functions that might be called. For example, pm_runtime_get_sync() might
> sleep and thus can't be used. This call needs, for example, to bring the device
> to powered on state on the system, where the power on sequence may require
> on-atomic operations, such as Intel Cherrytrail with ACPI enumerated UARTs.
> That said, on ACPI enabled platforms it might even call firmware for a job.
> 
> On the other hand pm_runtime_get() doesn't guarantee that device will become
> powered on fast enough.
> 
> Besides that, imagine the case when console is about to print a kernel Oops and
> it's powered off. In such an emergency case calling the complex functions is
> not the best what we can do, taking into consideration that user wants to see
> at least something of the last kernel word before it passes away.
> 
> Here we modify the 8250 console code to prevent runtime power management.

It's probably also worth noting (and documenting) that this will likely
cause a PM regression for OMAP platforms since the serial port will no
longer be idled, and therefore the power domains will not hit retention
state.  Please wait for Tony to confirm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
