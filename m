From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] tty_ioctl: Fix the baud_table check in encode_baud_rate
Date: Tue, 23 Oct 2007 18:27:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710231823530.8693@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710161857280.22596@blysk.ds.pg.gda.pl>
 <20071017114358.3d2b166f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:43158 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbXJWR17 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Oct 2007 13:27:59 -0400
In-Reply-To: <20071017114358.3d2b166f@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 17 Oct 2007, Alan Cox wrote:

> >  The tty_termios_encode_baud_rate() function as defined by tty_ioctl.c has 
> > a problem with the baud_table within.  The comparison operators are 
> > reversed and as a result this table's entries never match and BOTHER is 
> > always used.
> 
> Oops. I thought I'd fixed that one. Bit bothersome its been in -mm that
> long before anyone noticed. 

 -ENOTENOUGHUSERS?

> >  Additionally this function's prototype is not exported unlike the 
> > function itself.
> 
> That bit seems out of date and a prototype was added later in -mm

 Given the function has survived for quite a while without a prototype 
exported (how to use it otherwise? -- I guess set_sgttyb() does not count 
as hardly anybody should be calling it), I suppose it is no surprise it 
was not adequately tested. ;-)

  Maciej
