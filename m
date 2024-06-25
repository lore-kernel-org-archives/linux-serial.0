Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2D13A416;
	Tue, 25 Jun 2024 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296420; cv=none; b=IVINpC9qxmoYwpiDB2OmAtNJZXX5MyrxjPoXOpD8Ug82QXUJ6qT/6JaTjpTFA65Sepaa8knfb7kGDiF1PGEc/5K1EEzwNQAyr3+rmmCgBdEb6wspIKVuVcyNBWNN+c6r4uHRQJY1u0/yp6LvrjC20ux4hA4tenTPzdy6qVKBiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296420; c=relaxed/simple;
	bh=V1K4/G+lu8I5KlDy4hOS2Sn0j0A0MQzyQoBb5221FTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCALIOn967nx4XpTQLWZTPDe5JgcwGi0zs1KgTXvzzn9WWlU/Obxt8xrWVrQlwE7sIDvA72MImFrc0HFAeXG4gl0k5VkcsFDLyEUHLW08+uXnaaLxo4yDNYKOXGPmT5LErR8fJHRAsI/8OGpN6Z0Cj20LhE0ZvsZOnvFGkDam5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtxiYSjQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtxiYSjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AE5C32781;
	Tue, 25 Jun 2024 06:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719296419;
	bh=V1K4/G+lu8I5KlDy4hOS2Sn0j0A0MQzyQoBb5221FTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtxiYSjQv8K6uwhULeWsR7uduFWLTbw9AZUCh644aC01WXB2ETu54Eb8BpjjPk0gh
	 RvcM/LT0u06IcsRLmzKpE/Z57nT1PLvKC9QEyOxDdixwU6MCBWm1Wy8bUCTVX+isVV
	 yRrqQSItP8Poq9B9f9nv+991vjIEJglTrlp6EW0o=
Date: Tue, 25 Jun 2024 08:20:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
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
Message-ID: <2024062551-hubcap-bauble-fae5@gregkh>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <ZnWRup3MvcVQ4MX8@pathway.suse.cz>
 <2024062403-skid-gotten-7585@gregkh>
 <ZnpRozsdw6zbjqze@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnpRozsdw6zbjqze@tlindgre-MOBL1>

On Tue, Jun 25, 2024 at 08:12:03AM +0300, Tony Lindgren wrote:
> On Mon, Jun 24, 2024 at 03:35:39PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 21, 2024 at 04:44:10PM +0200, Petr Mladek wrote:
> > > Added Linus into Cc.
> > > 
> > > On Thu 2024-06-20 15:45:25, Tony Lindgren wrote:
> > > > Hi,
> > > > 
> > > > Recent changes to add support for DEVNAME:0.0 style consoles caused a
> > > > regression with the preferred console order where the last console on
> > > > the kernel command line is no longer the preferred console.
> > > > 
> > > > The following four changes fix the issue using Petr's suggestion that
> > > > does not involve calling __add_preferred_console() later on again, and
> > > > adds the deferred consoles to the console_cmdline[] directly to be
> > > > updated when the console is ready.
> > > > 
> > > > We revert the earlier printk related changes, and then add back the
> > > > DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
> > > > reducing the code quite a bit too this way.
> > > > 
> > > > And we also revert all the unusable serial core console quirk handling,
> > > > it does not do anything for the legacy "ttyS" named consoles. And then
> > > > we add a minimal serial_base_match_and_update_preferred_console().
> > > > 
> > > > The reason we want DEVNAME:0.0 style consoles is it helps addressing the
> > > > console based on the connected serial port controller device rather than
> > > > using the hardcoded ttyS addressing. And that helps with issues related
> > > > to the console moving around after togging the HSUART option in the BIOS,
> > > > or when new ports are enabled in devicetree and aliases are not updated.
> > > > 
> > > > Tony Lindgren (4):
> > > >   printk: Revert add_preferred_console_match() related commits
> > > >   printk: Add match_devname_and_update_preferred_console()
> > > >   serial: core: Revert unusable console quirk handling
> > > >   serial: core: Add serial_base_match_and_update_preferred_console()
> > > > 
> > > >  drivers/tty/serial/8250/8250_core.c  |   5 -
> > > >  drivers/tty/serial/serial_base.h     |  22 +---
> > > >  drivers/tty/serial/serial_base_bus.c | 116 +++------------------
> > > >  drivers/tty/serial/serial_core.c     |   2 +-
> > > >  include/linux/printk.h               |   5 +-
> > > >  kernel/printk/Makefile               |   2 +-
> > > >  kernel/printk/conopt.c               | 146 ---------------------------
> > > >  kernel/printk/console_cmdline.h      |   7 +-
> > > >  kernel/printk/printk.c               | 122 ++++++++++++++++------
> > > >  9 files changed, 112 insertions(+), 315 deletions(-)
> > > >  delete mode 100644 kernel/printk/conopt.c
> > > 
> > > The patchset looks ready for linux-next. And I have pushed it
> > > into printk/linux.git, branch for-6.10-register-console-devname.
> > > 
> > > I am not sure about the mainline. We need to fix the regression in 6.10.
> > > The change is not trivial and rc5 is knocking on the doors.
> > > 
> > > Unfortunately, the patchset intermixes reverts and new code.
> > > So that it can't be used for simple revert as is.
> > > 
> > > I am quite confident that the new code works as expected.
> > > It changes tricky code but the logic of the change is quite
> > > straightforward.
> > > 
> > > 
> > > I see three solutions:
> > > 
> > > 1. Linus could merge the changes directly into rc5.
> > > 
> > > 2. I could send a pull request after it survives few days in
> > >    linux-next.
> > > 
> > > 3. Or we rework the patchset. And do pure revert for 6.10 and
> > >    add the feature a clean way for-6.11.
> > 
> > Pure revert for 6.10 might be good, as it's late in the cycle.  Let me
> > know the git ids and I can do that.
> 
> Here's the list of git ids to revert:
> 
> $ git log --abbrev=12 --pretty=format:"%h (\"%s\")" v6.9..v6.10-rc5 \
> --author="Tony Lindgren" kernel/printk drivers/tty/ Documentation/admin-guide/
> b20172ca6bf4 ("serial: core: Fix ifdef for serial base console functions")
> 4547cd76f08a ("serial: 8250: Fix add preferred console for serial8250_isa_init_ports()")
> 5c3a766e9f05 ("Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports")
> a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init_ports()")
> a0f32e2dd998 ("serial: core: Handle serial console options")
> 787a1cabac01 ("serial: core: Add support for DEVNAME:0.0 style naming for kernel console")
> b73c9cbe4f1f ("printk: Flag register_console() if console is set on command line")
> 8a831c584e6e ("printk: Don't try to parse DEVNAME:0.0 console options")
> f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")

All now reverted, thanks!

greg k-h
