From: Greg KH <greg@kroah.com>
Subject: Re: Mainpine IQ Express Rev3 problems beginning 2.6.36
Date: Sun, 12 Dec 2010 08:52:01 -0800
Message-ID: <20101212165201.GB14184@kroah.com>
References: <4D001AF1.80902@mainpine.com>
 <20101209064259.GA10714@kroah.com>
 <9BEA64D1D71A4BCFA22E0ECE7A4B3A01@callisto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:47569 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500Ab0LLQwE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 12 Dec 2010 11:52:04 -0500
Content-Disposition: inline
In-Reply-To: <9BEA64D1D71A4BCFA22E0ECE7A4B3A01@callisto>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <lee.howard@mainpine.com>
Cc: linux-serial@vger.kernel.org

On Sat, Dec 11, 2010 at 04:36:07PM -0800, Lee Howard wrote:
> > What type of device is this?  A pci card or something else?
> 
> The Mainpine IQ Express cards are multiport PCIe cards with modems attached
> to the serial ports.
> 
> > What driver controls it?
> 
> 8250
> 
> > Also, the best thing to do would be if you could run 'git 
> > bisect' to narrow the problem down to the specific patch that 
> > caused the problem.
> > Any chance you could do that?
> 
> I've been at that for three days now.  It's very tedious and cumbersome
> because, even starting with 'git bisect start -- drivers/serial' which
> narrows-down the anticipated number of runs to 6, it's very difficult to do
> because most of the kernel revisions that are being tested have some bug in
> them (they don't build at all, they have oopses, etc.) and I find myself
> spending a lot of time only to have to do a 'git bisect skip' if I don't
> want to try to work-around those problems.  Eventually I found myself simply
> disabling modules in the build that I don't need to perform the test... And
> that worked better until I started running into other problems in the test
> that were not the same as the one I was having before... So when I'm doing
> 'git bisect' and come across a revision that doesn't work but doesn't have
> the same problems as the target problem, what do I do?  Should I mark it
> "bad" or "skip" it?

Don't limit yourself to changes in drivers/serial as there are lots of
tty fixes in other parts of the kernel that could have caused issues
with this.

As for build issues, try to make a minimal working config for your
system, using 'make localmodconfig'.  That will speed up your build time
immensely as well as reduce your chances of build and runtime problems
with the intermediate kernels.

best of luck,

greg k-h
