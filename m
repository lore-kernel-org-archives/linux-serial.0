From: "Alex Moen" <alexm@ndtel.com>
Subject: RE: Saving data from the serial port
Date: Fri, 18 Apr 2003 13:38:48 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <225501c305d9$c3427360$443d24c0@S0029770574>
References: <20030418000627.GB442@lafn.org>
Reply-To: <alexm@ndtel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ndtc.ndtel.com ([66.163.128.13]:51244 "EHLO ndtc.ndtel.com")
	by vger.kernel.org with ESMTP id S263197AbTDRS1J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2003 14:27:09 -0400
In-Reply-To: <20030418000627.GB442@lafn.org>
List-Id: linux-serial@vger.kernel.org
To: 'David Lawyer' <dave@lafn.org>, 'Ed Vance' <EdV@macrolink.com>
Cc: linux-serial@vger.kernel.org

Yep.  The BIOS of the computer had the serial ports set to "auto" rather
than an interrupt.  I set them, and everything works properly now.

Thanks all!!!

Alex

-----Original Message-----
From: David Lawyer [mailto:dave@lafn.org] 
Sent: Thursday, April 17, 2003 6:06 PM
To: Ed Vance
Cc: 'alexm@ndtel.com'; linux-serial@vger.kernel.org
Subject: Re: Saving data from the serial port


On Thu, Apr 17, 2003 at 12:10:39PM -0700, Ed Vance wrote:
> On Thu, Apr 17, 2003 at 11:44 AM, Alex Moen wrote:
> > 
> > I want to take the data from a serial port from our PBX and
> > log it to a file.  Sounds simple, right?  I can (Winblows) 
> > hyperterm to the port and gather the data.  I can connect 
> > the port to a serial printer and get the data.  But, when I 
> > connect my linux box to the serial port, I am only getting 
> > PART of the data.  For instance, I am only getting the 
> > first 14-16 characters of each line, with really no line 
> > breaks.  I also notice with statserial that I am getting an 
> > overrun (wth is that???).  I have the port settings in the 
> > software set at what Windows and the printer are set at
> > (9600-8-N-1).
> > 
> > I have read through the serial howto, tried a few programs
> > that are suggested (two that look promising but are giving 
> > the above results are linbar and logserial), and am stumped.
> > 
> > I'd hate to have to set up a Win98 box running hyperterm
> > logging to a file, and then manually rotate that each day....
> > 
> Overruns happen when the UART receiver FIFO buffer is completely full 
> when the next date character is received. The byte that did not fit is 
> discarded and the overrun status is posted.
> 
> the root cause is either that the data is not being read fast
> enough by the program, or system interrupt latency is too long
> to let the driver service the UART before an overrun occurs. 

Or if the interrupt is misset.  This is what may be happening.  If the
interrupt is wrong, there are no interrupts but a sort of slow polling takes
place and fetches the contents of the FIFO.  Don't confuse this with the
fast polling you get if you set the IRQ to 0.  With the slow polling there's
a delay before the next poll and data is often lost due to overruns of the
FIFO.  The slow polling wasn't intended to be polling but that's what it
amounts to.  So check that your interrupt is working OK by setting the IRQ
to 0 with setserial to enable fast polling.  If that seemingly fixes it, you
had an interrupt problem.

> If the data source supports XON/XOFF or hardware flow control,
> you could set that to hold off the data source when the system 
> is not ready to receive more data. 

I don't think so (but of course you should use flow control).  There just
isn't any way to use flow control to protect the FIFO buffers from overruns
in Linux.  Flow control (for the input flow into a PC) only protects the
serial 8K buffer in main memory.

			David Lawyer

