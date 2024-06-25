Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4F143890;
	Tue, 25 Jun 2024 05:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292334; cv=none; b=UgwwQqtRtOk13QTVGW3jMuJRCrUu4DzPaOT/FgmzZz4jG9Ed7pQtQ6ZpEjv9TCqeJnjkmn32Wl33tQokIEHt2QQE22cjvK5lR9cSasPmz2w8sSm6/PMKiVXcTky9ARI3qbQFTnQZoQgE0WM1fYicRelyTse6YLaNB7YxxFZitUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292334; c=relaxed/simple;
	bh=yN7B03ww6l4oUQ4hgTuqfvuuUwySdOP1eBJ2aUO1pAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyc4AaY/DcFaKI8rCbWOZltggulLpERM+KNT0yg1OJsRQGBp5dmFj0md6Os0VHx7/PiBHn/rQzqjmMjGCQqrmY4gVP5ZMwRC5PoBxr8NILpb8JamHBiKuToz0IBr/40oqBJXrk0rTKVonoa+mDNDbqWUq/Y6qnsVtgpYWYHS+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM37+rzp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM37+rzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719292333; x=1750828333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yN7B03ww6l4oUQ4hgTuqfvuuUwySdOP1eBJ2aUO1pAY=;
  b=fM37+rzpcCJ7YU+PCddhneBddEqlSqTxC5hgn8QUP0rWIAOjJYeqgYJd
   i8n6hlyKOs6tOFRq9+FE26PD2qBJhVwvMZ89ZM5yIhyTq6EQ5eeHM5HZ0
   0EUxRL34pNT9o+5lM8VWM9YcZ2ppKlkzQEPHtu++RDNNcXXQXu2Z1S0FD
   2LmXj5R6JvigOkENBPIwXbPbC83e2CoqyDWOrANJG0PKooQf5i6C0O3X2
   BrCxWEASffH2XHyZwyQrq2MO9+ZXhdZ0nl9CBfg4yljaurDB9bnwu9D7k
   OtVRA6I+og1ymLNlASX91BnyDHrRJ0U4iZbuSym7yn/5QsZ+imG7nwUoA
   w==;
X-CSE-ConnectionGUID: 73pykXluRTG54h+SlXWS4Q==
X-CSE-MsgGUID: 00Gtfzm/T4yk12+1apxleA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16434017"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16434017"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 22:12:12 -0700
X-CSE-ConnectionGUID: iSUXVXohR3eOK6BykvmqsQ==
X-CSE-MsgGUID: RlnSrIcLTe2g6WCYE8S47Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48694455"
Received: from unknown (HELO tlindgre-MOBL1) ([10.245.247.67])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 22:12:08 -0700
Date: Tue, 25 Jun 2024 08:12:03 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Fixes for console command line ordering
Message-ID: <ZnpRozsdw6zbjqze@tlindgre-MOBL1>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <ZnWRup3MvcVQ4MX8@pathway.suse.cz>
 <2024062403-skid-gotten-7585@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062403-skid-gotten-7585@gregkh>

On Mon, Jun 24, 2024 at 03:35:39PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 21, 2024 at 04:44:10PM +0200, Petr Mladek wrote:
> > Added Linus into Cc.
> > 
> > On Thu 2024-06-20 15:45:25, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > Recent changes to add support for DEVNAME:0.0 style consoles caused a
> > > regression with the preferred console order where the last console on
> > > the kernel command line is no longer the preferred console.
> > > 
> > > The following four changes fix the issue using Petr's suggestion that
> > > does not involve calling __add_preferred_console() later on again, and
> > > adds the deferred consoles to the console_cmdline[] directly to be
> > > updated when the console is ready.
> > > 
> > > We revert the earlier printk related changes, and then add back the
> > > DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
> > > reducing the code quite a bit too this way.
> > > 
> > > And we also revert all the unusable serial core console quirk handling,
> > > it does not do anything for the legacy "ttyS" named consoles. And then
> > > we add a minimal serial_base_match_and_update_preferred_console().
> > > 
> > > The reason we want DEVNAME:0.0 style consoles is it helps addressing the
> > > console based on the connected serial port controller device rather than
> > > using the hardcoded ttyS addressing. And that helps with issues related
> > > to the console moving around after togging the HSUART option in the BIOS,
> > > or when new ports are enabled in devicetree and aliases are not updated.
> > > 
> > > Tony Lindgren (4):
> > >   printk: Revert add_preferred_console_match() related commits
> > >   printk: Add match_devname_and_update_preferred_console()
> > >   serial: core: Revert unusable console quirk handling
> > >   serial: core: Add serial_base_match_and_update_preferred_console()
> > > 
> > >  drivers/tty/serial/8250/8250_core.c  |   5 -
> > >  drivers/tty/serial/serial_base.h     |  22 +---
> > >  drivers/tty/serial/serial_base_bus.c | 116 +++------------------
> > >  drivers/tty/serial/serial_core.c     |   2 +-
> > >  include/linux/printk.h               |   5 +-
> > >  kernel/printk/Makefile               |   2 +-
> > >  kernel/printk/conopt.c               | 146 ---------------------------
> > >  kernel/printk/console_cmdline.h      |   7 +-
> > >  kernel/printk/printk.c               | 122 ++++++++++++++++------
> > >  9 files changed, 112 insertions(+), 315 deletions(-)
> > >  delete mode 100644 kernel/printk/conopt.c
> > 
> > The patchset looks ready for linux-next. And I have pushed it
> > into printk/linux.git, branch for-6.10-register-console-devname.
> > 
> > I am not sure about the mainline. We need to fix the regression in 6.10.
> > The change is not trivial and rc5 is knocking on the doors.
> > 
> > Unfortunately, the patchset intermixes reverts and new code.
> > So that it can't be used for simple revert as is.
> > 
> > I am quite confident that the new code works as expected.
> > It changes tricky code but the logic of the change is quite
> > straightforward.
> > 
> > 
> > I see three solutions:
> > 
> > 1. Linus could merge the changes directly into rc5.
> > 
> > 2. I could send a pull request after it survives few days in
> >    linux-next.
> > 
> > 3. Or we rework the patchset. And do pure revert for 6.10 and
> >    add the feature a clean way for-6.11.
> 
> Pure revert for 6.10 might be good, as it's late in the cycle.  Let me
> know the git ids and I can do that.

Here's the list of git ids to revert:

$ git log --abbrev=12 --pretty=format:"%h (\"%s\")" v6.9..v6.10-rc5 \
--author="Tony Lindgren" kernel/printk drivers/tty/ Documentation/admin-guide/
b20172ca6bf4 ("serial: core: Fix ifdef for serial base console functions")
4547cd76f08a ("serial: 8250: Fix add preferred console for serial8250_isa_init_ports()")
5c3a766e9f05 ("Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports")
a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init_ports()")
a0f32e2dd998 ("serial: core: Handle serial console options")
787a1cabac01 ("serial: core: Add support for DEVNAME:0.0 style naming for kernel console")
b73c9cbe4f1f ("printk: Flag register_console() if console is set on command line")
8a831c584e6e ("printk: Don't try to parse DEVNAME:0.0 console options")
f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")

> > I personally prefer the 3rd solution. But I am super conservative.
> > I guess that most other people would go with the other 2 solutions.
> 
> I'll be conservative here as well.

Conservative is good.

Regards,

Tony
