From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH] serial: fix port type conflict between NS16550A &
	U6_16550A
Date: Tue, 31 Aug 2010 19:11:29 +0100
Message-ID: <20100831181129.GA14733@gallifrey>
References: <1283257149-3370-1-git-send-email-philippe.langlais@stericsson.com> <20100831132906.GA2429@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx.treblig.org ([80.68.94.177]:46136 "EHLO mx.treblig.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655Ab0HaSLd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 14:11:33 -0400
Content-Disposition: inline
In-Reply-To: <20100831132906.GA2429@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Philippe Langlais <philippe.langlais@stericsson.com>, linux-serial@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, loic.pallardy@stericsson.com, vincent.guittot@stericsson.com

* Greg KH (gregkh@suse.de) wrote:
> On Tue, Aug 31, 2010 at 02:19:09PM +0200, Philippe Langlais wrote:
> > Bug seen by Dr. David Alan Gilbert with sparse
> 
> sparse found this?  nice.

It spotted it because it ended up causing the same element of the array
to be initialised twice.
A few hours spent playing with sparse has spotted some nice easy-to-fix
thinko type bugs (this one, two parameters being swapped to kzalloc,
a few places where people passed enums in place of bools).   Basically
if you ignore all the address space, static and locking output
whats left is 'odd' stuff that appears to be worthy of a read.
(That's from my first time using it).  They're all the class of problems
that you would hope a type system in the compiler would spot.

> But odds are we should switch this to an enum to try to find it earlier,
> right?

An enum would be nice; but the other problem is that there are two
lists one in serial.h and one in serial_core.h that both start
in the same way - it was just a matter of time until something
got added to the wrong one. IMO the older list needs killing
unless there is a very good reason for it.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
