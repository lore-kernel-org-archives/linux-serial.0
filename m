From: David Lawyer <dave@lafn.org>
Subject: Re: Saving data from the serial port
Date: Thu, 17 Apr 2003 17:06:27 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030418000627.GB442@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D1A33E47@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zoon.lafn.org ([206.117.18.9]:51727 "EHLO zoon.lafn.org")
	by vger.kernel.org with ESMTP id S262689AbTDRAUj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2003 20:20:39 -0400
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33E47@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: "'alexm@ndtel.com'" <alexm@ndtel.com>, linux-serial@vger.kernel.org

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
> Overruns happen when the UART receiver FIFO buffer is completely
> full when the next date character is received. The byte that did
> not fit is discarded and the overrun status is posted. 
> 
> the root cause is either that the data is not being read fast 
> enough by the program, or system interrupt latency is too long
> to let the driver service the UART before an overrun occurs. 

Or if the interrupt is misset.  This is what may be happening.  If the
interrupt is wrong, there are no interrupts but a sort of slow polling
takes place and fetches the contents of the FIFO.  Don't confuse this
with the fast polling you get if you set the IRQ to 0.  With the slow
polling there's a delay before the next poll and data is often lost due
to overruns of the FIFO.  The slow polling wasn't intended to be polling
but that's what it amounts to.  So check that your interrupt is working
OK by setting the IRQ to 0 with setserial to enable fast polling.  If
that seemingly fixes it, you had an interrupt problem.

> If the data source supports XON/XOFF or hardware flow control, 
> you could set that to hold off the data source when the system 
> is not ready to receive more data. 

I don't think so (but of course you should use flow control).  There
just isn't any way to use flow control to protect the FIFO buffers from
overruns in Linux.  Flow control (for the input flow into a PC) only
protects the serial 8K buffer in main memory.

			David Lawyer
