From: Ted Ts'o <tytso@mit.edu>
Subject: Re: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 20:25:23 -0500
Message-ID: <20101119012523.GT3290@thunk.org>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com>
 <E1PJAfx-0000gW-8e@palantir.moria.de>
 <ic40v4$ghm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:47621 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760172Ab0KSBZ2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 20:25:28 -0500
Content-Disposition: inline
In-Reply-To: <ic40v4$ghm$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, Michael Haardt <michael@moria.de>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 18, 2010 at 08:05:56PM +0000, Grant Edwards wrote:
> On 2010-11-18, Michael Haardt <michael@moria.de> wrote:
> >> > I miss a way to disable the transmit FIFO.
> >>
> >> From userspace or from within a kernel driver?
> >
> > From userspace.
> 
> $ man setserial

Specifically, if you use setserial to configure a serial port so that
its UART is a 16450, it will force the transmit FIFO to be unused.

    	      	     	     	   - Ted
