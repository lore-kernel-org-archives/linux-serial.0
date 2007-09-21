From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] kernel/printk.c: Concerns about the console handover
Date: Fri, 21 Sep 2007 15:22:18 +0200
Message-ID: <46F3C58A.7000200@redhat.com>
References: <Pine.LNX.4.64N.0709201749240.30788@blysk.ds.pg.gda.pl> <20070921010349.2caee558.akpm@linux-foundation.org> <46F3BC3A.8060703@redhat.com> <20070921130600.GB20277@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758660AbXIUNW4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2007 09:22:56 -0400
In-Reply-To: <20070921130600.GB20277@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Gerd Hoffmann <kraxel@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Yinghai.Lu@Sun.COM, bryan.wu@analog.com, dilinger@queued.net, lethal@linux-sh.org, rgetz@blackfin.uclinux.org, vapier.adi@gmail.com

Russell King wrote:
> I had an issue with the console initialisation on serial ports, which I
> discovered during my PXA work.  My reason for asking about the kernel
> versions (which Andrew forwarded to LKML) is to determine whether the
> report is as a result of those changes, or lack of those changes.
> 
> Those -mm versions with git-arm in probably have that change.  Ergo
> the importance to answer this question about kernel versions.

The problem description sounds like it could have been introduced by
that patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=69331af79cf29e26d1231152a172a1a10c2df511

cheers,
  Gerd
