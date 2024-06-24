Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF713DDB9;
	Mon, 24 Jun 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236142; cv=none; b=DhXrf6IOzS3V0154k8vZqRxX0o/mb5ozqVPz68rV1pBOt0/zZbDLEghS+STd4D7mKndK87Zk4J1FSHmHALTJEpXGaLVYpXEzhZeTYySrmwxUAAt5aCLl5iZq4O+KqOvd1wCUUGGauYd6lb3Bkia5WqForfYHeynktIN7yE/b8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236142; c=relaxed/simple;
	bh=subTJ+uFPM8731pDflhaGFrtqZT3OTFd30D7fdddPJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyYkqf77gUP+Ju+jNGH+WLs7QYORNFxfhbFRTYw8qiiW3P1UC1phLY46bKVb9CqnmjPWdM2bHN8YGkXj+8Q+Pt+11eIg0RtJ61I0XNy6qmaclGhpRVbIwOUDpSEczaVb4FlRdWnzTSu1rmRnOg16ORmJVTsg7VW0zscLm3qxmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvn/ylbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvn/ylbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB81C2BBFC;
	Mon, 24 Jun 2024 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719236142;
	bh=subTJ+uFPM8731pDflhaGFrtqZT3OTFd30D7fdddPJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvn/ylbkUFXDxqcgmC+9F4MIKKR0knniIH2AnrjTgLfSW17bJwxVecCJBKRO9V+Sz
	 uCUCTslFmWdc8st1vT6i/fH52uVqq6YcddxezdArTbglz9C422cqRLcotnBtPyvnMh
	 XhE+iU1T6dFndbGOk+3WW1tbL2wABkdLCEkMR8RQ=
Date: Mon, 24 Jun 2024 15:35:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>,
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
Message-ID: <2024062403-skid-gotten-7585@gregkh>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <ZnWRup3MvcVQ4MX8@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnWRup3MvcVQ4MX8@pathway.suse.cz>

On Fri, Jun 21, 2024 at 04:44:10PM +0200, Petr Mladek wrote:
> Added Linus into Cc.
> 
> On Thu 2024-06-20 15:45:25, Tony Lindgren wrote:
> > Hi,
> > 
> > Recent changes to add support for DEVNAME:0.0 style consoles caused a
> > regression with the preferred console order where the last console on
> > the kernel command line is no longer the preferred console.
> > 
> > The following four changes fix the issue using Petr's suggestion that
> > does not involve calling __add_preferred_console() later on again, and
> > adds the deferred consoles to the console_cmdline[] directly to be
> > updated when the console is ready.
> > 
> > We revert the earlier printk related changes, and then add back the
> > DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
> > reducing the code quite a bit too this way.
> > 
> > And we also revert all the unusable serial core console quirk handling,
> > it does not do anything for the legacy "ttyS" named consoles. And then
> > we add a minimal serial_base_match_and_update_preferred_console().
> > 
> > The reason we want DEVNAME:0.0 style consoles is it helps addressing the
> > console based on the connected serial port controller device rather than
> > using the hardcoded ttyS addressing. And that helps with issues related
> > to the console moving around after togging the HSUART option in the BIOS,
> > or when new ports are enabled in devicetree and aliases are not updated.
> > 
> > Tony Lindgren (4):
> >   printk: Revert add_preferred_console_match() related commits
> >   printk: Add match_devname_and_update_preferred_console()
> >   serial: core: Revert unusable console quirk handling
> >   serial: core: Add serial_base_match_and_update_preferred_console()
> > 
> >  drivers/tty/serial/8250/8250_core.c  |   5 -
> >  drivers/tty/serial/serial_base.h     |  22 +---
> >  drivers/tty/serial/serial_base_bus.c | 116 +++------------------
> >  drivers/tty/serial/serial_core.c     |   2 +-
> >  include/linux/printk.h               |   5 +-
> >  kernel/printk/Makefile               |   2 +-
> >  kernel/printk/conopt.c               | 146 ---------------------------
> >  kernel/printk/console_cmdline.h      |   7 +-
> >  kernel/printk/printk.c               | 122 ++++++++++++++++------
> >  9 files changed, 112 insertions(+), 315 deletions(-)
> >  delete mode 100644 kernel/printk/conopt.c
> 
> The patchset looks ready for linux-next. And I have pushed it
> into printk/linux.git, branch for-6.10-register-console-devname.
> 
> I am not sure about the mainline. We need to fix the regression in 6.10.
> The change is not trivial and rc5 is knocking on the doors.
> 
> Unfortunately, the patchset intermixes reverts and new code.
> So that it can't be used for simple revert as is.
> 
> I am quite confident that the new code works as expected.
> It changes tricky code but the logic of the change is quite
> straightforward.
> 
> 
> I see three solutions:
> 
> 1. Linus could merge the changes directly into rc5.
> 
> 2. I could send a pull request after it survives few days in
>    linux-next.
> 
> 3. Or we rework the patchset. And do pure revert for 6.10 and
>    add the feature a clean way for-6.11.

Pure revert for 6.10 might be good, as it's late in the cycle.  Let me
know the git ids and I can do that.

> I personally prefer the 3rd solution. But I am super conservative.
> I guess that most other people would go with the other 2 solutions.

I'll be conservative here as well.

thanks,

greg k-h
