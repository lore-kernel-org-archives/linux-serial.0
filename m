From: "Lee Howard" <lee.howard@mainpine.com>
Subject: RE: Mainpine IQ Express Rev3 problems beginning 2.6.36
Date: Sat, 11 Dec 2010 16:36:07 -0800
Message-ID: <9BEA64D1D71A4BCFA22E0ECE7A4B3A01@callisto>
References: <4D001AF1.80902@mainpine.com> <20101209064259.GA10714@kroah.com>
Reply-To: <lee.howard@mainpine.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pandora.howardsilvan.com ([216.235.106.114]:42595 "EHLO
	mail.mainpine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0LLAf4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 11 Dec 2010 19:35:56 -0500
In-Reply-To: <20101209064259.GA10714@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg KH' <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Wednesday, December 08, 2010 10:43 PM
> 
> On Wed, Dec 08, 2010 at 03:55:29PM -0800, Lee Howard wrote:
> > Hello everyone,
> > 
> > A week ago I had a customer report to me that they were having 
> > problems using the Mainpine IQ Express Rev3 (multiport modem which 
> > uses the Oxsemi OXPCIe95x chipset) after updating their system from 
> > kernel 2.6.22.10 (which they patched because native support 
> for the IQ 
> > Express didn't enter the kernel until 2.6.28) to kernel 2.6.36.
> > 
> > As I had never used any 2.6.36 kernel, myself, I explained 
> that I had 
> > experienced no problem with the 2.6.35.6 kernel (as found in Fedora 
> > 14) at which point they installed kernel 2.6.35.8 and reported back 
> > that this had resolved the problem for them.
> > 
> > Following their report I then tested by installing the 2.6.37-rc4 
> > kernel (using 'make oldconfig', taking .config from the Fedora 14 
> > kernel that was working), and I was quickly able to determine that 
> > there were problems because simple communications with the 
> modems were 
> > not working properly using 'minicom'.  (I also have now tested with 
> > 2.6.37-rc5 with the same result.)  Characters appear to be getting 
> > lost/dropped in the communication... for example, I *expect* the 
> > following on the minicom terminal screen when I start it up as it 
> > initializes the modem:
> > 
> > -------------------
> > AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
> > OK
> > 
> > -------------------
> > 
> > The blinking cursor will be on the line following the OK.  This is 
> > what happens when using kernel 2.6.35.  However, when I use
> > 2.6.37-rc5 this is what I see:
> > 
> > -------------------
> > AT S7=45 S0=0 L1
> > -------------------
> > 
> > Sometimes there is a character or two more on the screen but there 
> > will be no OK and the cursor will be blinking at the end of 
> the line 
> > of commands... which leads me to believe that the modem did not see 
> > the CR+LF from the application.  If I simply press enter on the 
> > terminal, then I'll see the OK as expected.  So it seems to me that 
> > only the first bunch of characters are making it through 
> and that the 
> > rest are getting dropped for some reason.
> > 
> > setserial tells me the following about the port:
> > 
> > # setserial -G /dev/ttyS4
> > /dev/ttyS4 uart 16950/954 port 0x0000 irq 18 baud_base 4000000 
> > spd_normal skip_test
> > 
> > I think I can say with confidence that the problem started 
> with 2.6.36.
> > 
> > What can I do to help solve the problem?
> 
> What type of device is this?  A pci card or something else?

The Mainpine IQ Express cards are multiport PCIe cards with modems attached
to the serial ports.

> What driver controls it?

8250

> Also, the best thing to do would be if you could run 'git 
> bisect' to narrow the problem down to the specific patch that 
> caused the problem.
> Any chance you could do that?

I've been at that for three days now.  It's very tedious and cumbersome
because, even starting with 'git bisect start -- drivers/serial' which
narrows-down the anticipated number of runs to 6, it's very difficult to do
because most of the kernel revisions that are being tested have some bug in
them (they don't build at all, they have oopses, etc.) and I find myself
spending a lot of time only to have to do a 'git bisect skip' if I don't
want to try to work-around those problems.  Eventually I found myself simply
disabling modules in the build that I don't need to perform the test... And
that worked better until I started running into other problems in the test
that were not the same as the one I was having before... So when I'm doing
'git bisect' and come across a revision that doesn't work but doesn't have
the same problems as the target problem, what do I do?  Should I mark it
"bad" or "skip" it?

Thanks,

Lee.

