Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B31482F0
	for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304593; cv=none; b=TOJd34Zhp2Gf/C1amVLEfNBeQESn41r9ROZ70GoriJ/+S3RL726RI0DNanxn+SLkK0T3LHmHbb51l1g4snaHd8s3wH5ZhPjdsZqFFDeAsvKFt9RGW3qGqQMGI3g8D0oPPVPg9nmqOGXmxVzunvUx3Lu+KG4FHclvPWThb1mpgj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304593; c=relaxed/simple;
	bh=dRHpzmSsFYDlsse5ShwVsot0eEz8ENEC+BQ1G/fIUGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8MDvE2EPsNr8wcBRhUSTITDbtqSkpXLF3zxGRtuVje8RPVOgq3PQKe9tMh2RXpaQDYGZ39dZEVGkx8xxz7uamxDu9GMxN2Jzb+rxRqt01x0EUvzw7YVfESI07Ga0jGGre7qYFZDv5BIDfxdA8Bpu4nldq8qDUxwlb7DzqvASfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gieiIzEd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gieiIzEd"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so57780711fa.2
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2024 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719304588; x=1719909388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuS5DPpmOhroPWtajZKPoCKp87zKc8dy5+EvwOudsqM=;
        b=gieiIzEdJhnf3NlEFttCHc7pU32Gk2tZltm1/mD9HYrFdBr+KslMu6UZ0Y4M/3PUVK
         OYESWzM/B78r/6SdcLYueBxdJenM3wirP/aiynfjSRr8N43xacw8Fxe4L+vOIeDz+a1S
         sTcXZnyYwoMpqfb76HHkoWYMpSTyoNFjp9i7xJ1Ouecd0Ys5DVxc2zVhxbkKELzygDZT
         3rRq4cph3NPXi6C6TE7RQ9YQKOPolvCUgzV/Ak0S+lL6jWmu2O7eOCqZU2BcAzKnw5m/
         fIU9GORWAwCjxkhlgnKnuM9jHdE6YHKvGz/u9dooFMz0Qmcg9NuCZqLZfssJRxte2v6l
         9zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304588; x=1719909388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuS5DPpmOhroPWtajZKPoCKp87zKc8dy5+EvwOudsqM=;
        b=fJ4l/35MShRh3n2lCp9XqM/VOa7G5Rdd2Z1bKguoVjdCGCb7mzAsKdG5LrqcgYataf
         wYOuhT4qlnKoc9XvR4A8g7xVxtoO8dOxz2f2PvTFbsaYSPo8/EF6QMPjzQz3M3jqKChm
         bWn6oDGj72QLAq3pSo3yc5FEsE/umgeZ9JpcstPtfM6/9DSgMi0Rb8T5mPHd+1Zyzlo2
         GaFkstcBC5rraZ2JMm7N6XNoaQCp9IwHmsWYl1SHq19H+YTcsDB5+TJRHt9MZXryid0V
         JfvwBBll1yM5VdRamweDIfU94DUW4JWphxJnvIrzGy/Sw7RYQ0OBr+QChkqNAkgQdk7Q
         YMaw==
X-Forwarded-Encrypted: i=1; AJvYcCWgNVGASyUgBWoxJB7hNGlILRXKBEFOTr7yQrjih/QseuUZpXCdjEX/8nYJzjBWcuo6Sc4EG+j9dZtkbxXfrdfotzPBeNFmfG7Jh0oY
X-Gm-Message-State: AOJu0YyX73f6cmIu3Daz//aoOnzfNf2fe88kIXQK8DkbywpxIa14kAPq
	Np2D8NrmE1D0M0+9MexdWFJhTgPXjsCwpT+SfEIQG7EaFeLOjYGX+3QdP4QwWQ8=
X-Google-Smtp-Source: AGHT+IFJSQeKryvBLg7sTeJHjYSYhVOrI7eqMtkBjerN8ltNdjpw3ldSHWOmIRgJjXl3sI6jC2Lb0Q==
X-Received: by 2002:a2e:9bc7:0:b0:2ec:30ee:6972 with SMTP id 38308e7fff4ca-2ec59328425mr50534431fa.24.1719304587672;
        Tue, 25 Jun 2024 01:36:27 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5e2e46sm75625205ad.223.2024.06.25.01.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:36:27 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:36:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <ZnqBYAV7iplmeh1R@pathway.suse.cz>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <ZnWRup3MvcVQ4MX8@pathway.suse.cz>
 <2024062403-skid-gotten-7585@gregkh>
 <ZnpRozsdw6zbjqze@tlindgre-MOBL1>
 <2024062551-hubcap-bauble-fae5@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024062551-hubcap-bauble-fae5@gregkh>

On Tue 2024-06-25 08:20:06, Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2024 at 08:12:03AM +0300, Tony Lindgren wrote:
> > On Mon, Jun 24, 2024 at 03:35:39PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jun 21, 2024 at 04:44:10PM +0200, Petr Mladek wrote:
> > > > Added Linus into Cc.
> > > > 
> > > > On Thu 2024-06-20 15:45:25, Tony Lindgren wrote:
> > > > > Hi,
> > > > > 
> > > > > Recent changes to add support for DEVNAME:0.0 style consoles caused a
> > > > > regression with the preferred console order where the last console on
> > > > > the kernel command line is no longer the preferred console.
> > > > > 
> > > > > The following four changes fix the issue using Petr's suggestion that
> > > > > does not involve calling __add_preferred_console() later on again, and
> > > > > adds the deferred consoles to the console_cmdline[] directly to be
> > > > > updated when the console is ready.
> > > > > 
> > > > > We revert the earlier printk related changes, and then add back the
> > > > > DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
> > > > > reducing the code quite a bit too this way.
> > > > > 
> > > > > And we also revert all the unusable serial core console quirk handling,
> > > > > it does not do anything for the legacy "ttyS" named consoles. And then
> > > > > we add a minimal serial_base_match_and_update_preferred_console().
> > > > > 
> > > > > The reason we want DEVNAME:0.0 style consoles is it helps addressing the
> > > > > console based on the connected serial port controller device rather than
> > > > > using the hardcoded ttyS addressing. And that helps with issues related
> > > > > to the console moving around after togging the HSUART option in the BIOS,
> > > > > or when new ports are enabled in devicetree and aliases are not updated.
> > > > > 
> > > > > Tony Lindgren (4):
> > > > >   printk: Revert add_preferred_console_match() related commits
> > > > >   printk: Add match_devname_and_update_preferred_console()
> > > > >   serial: core: Revert unusable console quirk handling
> > > > >   serial: core: Add serial_base_match_and_update_preferred_console()
> > > > > 
> > > > >  drivers/tty/serial/8250/8250_core.c  |   5 -
> > > > >  drivers/tty/serial/serial_base.h     |  22 +---
> > > > >  drivers/tty/serial/serial_base_bus.c | 116 +++------------------
> > > > >  drivers/tty/serial/serial_core.c     |   2 +-
> > > > >  include/linux/printk.h               |   5 +-
> > > > >  kernel/printk/Makefile               |   2 +-
> > > > >  kernel/printk/conopt.c               | 146 ---------------------------
> > > > >  kernel/printk/console_cmdline.h      |   7 +-
> > > > >  kernel/printk/printk.c               | 122 ++++++++++++++++------
> > > > >  9 files changed, 112 insertions(+), 315 deletions(-)
> > > > >  delete mode 100644 kernel/printk/conopt.c
> > > > 
> > > > The patchset looks ready for linux-next. And I have pushed it
> > > > into printk/linux.git, branch for-6.10-register-console-devname.
> > > > 
> > > > I am not sure about the mainline. We need to fix the regression in 6.10.
> > > > The change is not trivial and rc5 is knocking on the doors.
> > > > 
> > > > Unfortunately, the patchset intermixes reverts and new code.
> > > > So that it can't be used for simple revert as is.
> > > > 
> > > > I am quite confident that the new code works as expected.
> > > > It changes tricky code but the logic of the change is quite
> > > > straightforward.
> > > > 
> > > > 
> > > > I see three solutions:
> > > > 
> > > > 1. Linus could merge the changes directly into rc5.
> > > > 
> > > > 2. I could send a pull request after it survives few days in
> > > >    linux-next.
> > > > 
> > > > 3. Or we rework the patchset. And do pure revert for 6.10 and
> > > >    add the feature a clean way for-6.11.
> > > 
> > > Pure revert for 6.10 might be good, as it's late in the cycle.  Let me
> > > know the git ids and I can do that.
> > 
> > Here's the list of git ids to revert:
> > 
> > $ git log --abbrev=12 --pretty=format:"%h (\"%s\")" v6.9..v6.10-rc5 \
> > --author="Tony Lindgren" kernel/printk drivers/tty/ Documentation/admin-guide/
> > b20172ca6bf4 ("serial: core: Fix ifdef for serial base console functions")
> > 4547cd76f08a ("serial: 8250: Fix add preferred console for serial8250_isa_init_ports()")
> > 5c3a766e9f05 ("Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports")
> > a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init_ports()")
> > a0f32e2dd998 ("serial: core: Handle serial console options")
> > 787a1cabac01 ("serial: core: Add support for DEVNAME:0.0 style naming for kernel console")
> > b73c9cbe4f1f ("printk: Flag register_console() if console is set on command line")
> > 8a831c584e6e ("printk: Don't try to parse DEVNAME:0.0 console options")
> > f03e8c1060f8 ("printk: Save console options for add_preferred_console_match()")
> 
> All now reverted, thanks!

Great, thanks Greg!

Tony, could you please send a new patchset which would provide
the new solution on top of this revert? It might make sense
to wait until the revert reaches mainline.

Best Regards,
Petr
