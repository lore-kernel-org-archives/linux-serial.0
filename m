From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND] serial: Remove old SC26XX driver
Date: Thu, 19 Dec 2013 11:42:54 -0800
Message-ID: <20131219194254.GA1443@kroah.com>
References: <1386686824-15291-1-git-send-email-shc_work@mail.ru>
 <1387477678.352581860@f236.i.mail.ru>
 <20131219185813.GA28664@kroah.com>
 <1387481356.914448614@f290.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45241 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab3LSTmw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Dec 2013 14:42:52 -0500
Content-Disposition: inline
In-Reply-To: <1387481356.914448614@f290.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Thu, Dec 19, 2013 at 11:29:16PM +0400, Alexander Shiyan wrote:
> > > > On Tue, Dec 10, 2013 at 06:47:04PM +0400, Alexander Shiyan wrote:
> > > > > New driver for NXP (Philips) UART ICs was introduced in September 2012.
> > > > > Old driver no longer used anywhere, this patch removes it.
> > > > > 
> > > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > > ---
> > > > >  drivers/tty/serial/Kconfig  |  18 --
> > > > >  drivers/tty/serial/Makefile |   1 -
> > > > >  drivers/tty/serial/sc26xx.c | 749 --------------------------------------------
> > > > >  3 files changed, 768 deletions(-)
> > > > >  delete mode 100644 drivers/tty/serial/sc26xx.c
> > > > 
> > > > What kernel are you making this patch against?  This still doesn't
> > > > apply, and no one has touched this driver since 3.12-rc1 in my trees...
> > > > 
> > > > Please redo this patch against the latest kernel version so that it can
> > > > be properly applied.
> > > 
> > > Exact as you asked before:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> > > tty-next branch
> > 
> > Nope, fails to apply there :(
> 
> Can this problem be the result of a option "-D" for "git format-patch"?

I do not know, can you take your email from the mailing list and apply
it properly to the tree using 'git am' or even 'patch -p1'?  Both of
those fail for me.

greg k-h
