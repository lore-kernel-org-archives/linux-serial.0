From: Greg KH <gregkh@suse.de>
Subject: Re: [Nios2-dev] [PATCH 0/5] tty: serial: Updates for
 altera_jtaguart driver
Date: Fri, 18 Feb 2011 07:26:51 -0800
Message-ID: <20110218152651.GB10414@suse.de>
References: <cover.1297974227.git.tklauser@distanz.ch>
 <20110217221504.GA10686@kroah.com>
 <20110218072324.GS4076@distanz.ch>
 <4D5E1FF6.20805@wytron.com.tw>
 <20110218074542.GA759@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43530 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab1BRP0x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 10:26:53 -0500
Content-Disposition: inline
In-Reply-To: <20110218074542.GA759@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Thomas Chou <thomas@wytron.com.tw>, Grant Likely <grant.likely@secretlab.ca>, nios2-dev@sopc.et.ntust.edu.tw, Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org

On Fri, Feb 18, 2011 at 08:45:42AM +0100, Tobias Klauser wrote:
> On 2011-02-18 at 08:29:58 +0100, Thomas Chou <thomas@wytron.com.tw> wrote:
> > On 02/18/2011 03:23 PM, Tobias Klauser wrote:
> >> On 2011-02-17 at 23:15:04 +0100, Greg KH<greg@kroah.com>  wrote:
> >>> On Thu, Feb 17, 2011 at 09:28:23PM +0100, Tobias Klauser wrote:
> >>>> This patchset adds updates taken from the Nios2 Linux port (currently
> >>>> out-of-tree) repository to the altera_jtaguart driver.
> >>>>
> >>>> And this time with the correct cover letter right away :-)
> >>>>
> >>>> Tobias Klauser (5):
> >>>>    tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
> >>>>    tty: serial: altera_jtaguart: Remove unused function
> >>>>      early_altera_jtaguart_setup
> >>>>    tty: serial: altera_jtaguart: Support getting mapbase and IRQ from
> >>>>      resources
> >>>>    tty: serial: altera_jtaguart: Fixup type usage of port flags
> >>>>    tty: serial: altera_jtaguart: Add device tree support
> >>>
> >>> After this series, I get the following build error:
> >>> 	  CC [M]  drivers/tty/serial/altera_jtaguart.o
> >>> 	  drivers/tty/serial/altera_jtaguart.c:485:3: error: unknown field ???of_match_table??? specified in initializer
> >>
> >> Strange, I didn't get that one when compile testing against linux-next
> >> on x86_64. Though it seems I didn't correctly test it on nios2 and I got
> >> a compile error about a missing semicolon in the definition of
> >> altera_jtaguart_match there.
> >
> > It might be that the of_match_table patch is available in Grant's branch  
> > only, which is for v3.6.39. Maybe you can ask Grant to take this patch 
> > 5/5.
> 
> That explains it, thanks Thomas.
> 
> Greg, care to take only patches 1/5 to 4/5 for now? I'll resubmit 5/5
> for the 2.6.39 merge window, unless Grant already wants to take this to
> his tree.

Please resend the 1-4 patches to me and I will be glad to apply them.

thanks,

greg k-h
