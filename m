From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 0/5] tty: serial: Updates for altera_jtaguart driver
Date: Fri, 18 Feb 2011 08:23:24 +0100
Message-ID: <20110218072324.GS4076@distanz.ch>
References: <cover.1297974227.git.tklauser@distanz.ch> <20110217221504.GA10686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:47513 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab1BRHX0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 02:23:26 -0500
Content-Disposition: inline
In-Reply-To: <20110217221504.GA10686@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw

On 2011-02-17 at 23:15:04 +0100, Greg KH <greg@kroah.com> wrote:
> On Thu, Feb 17, 2011 at 09:28:23PM +0100, Tobias Klauser wrote:
> > This patchset adds updates taken from the Nios2 Linux port (currently
> > out-of-tree) repository to the altera_jtaguart driver.
> > 
> > And this time with the correct cover letter right away :-)
> > 
> > Tobias Klauser (5):
> >   tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
> >   tty: serial: altera_jtaguart: Remove unused function
> >     early_altera_jtaguart_setup
> >   tty: serial: altera_jtaguart: Support getting mapbase and IRQ from
> >     resources
> >   tty: serial: altera_jtaguart: Fixup type usage of port flags
> >   tty: serial: altera_jtaguart: Add device tree support
> 
> After this series, I get the following build error:
> 	  CC [M]  drivers/tty/serial/altera_jtaguart.o
> 	  drivers/tty/serial/altera_jtaguart.c:485:3: error: unknown field ???of_match_table??? specified in initializer

Strange, I didn't get that one when compile testing against linux-next
on x86_64. Though it seems I didn't correctly test it on nios2 and I got
a compile error about a missing semicolon in the definition of
altera_jtaguart_match there.

So that might be the culprit for the above message too. I'll resend the
last PATCH of the series to fix that (and of course compile-test it
before).

Thanks a lot and sorry
Tobias
