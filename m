From: David Lawyer <dave@lafn.org>
Subject: Re: overruns with kernel 2.4.19
Date: Wed, 19 Feb 2003 00:03:10 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030219080309.GA422@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D1A33DA0@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-30-197.rev.o1.com [66.81.30.197])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1J8DinX093226
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003 00:13:45 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18lPCB-000072-00
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003 00:03:11 -0800
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DA0@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Tue, Feb 18, 2003 at 04:34:34PM -0800, Ed Vance wrote:
> Hi Joachim and David,
> 
> Do I need an external data source to reproduce this, or does it also fail
> with a looped back 115200 baud data stream (ttyS1 -> ttyS0)? I can try it on
> my 333 MHz Pentium II when it frees up in a couple of days. 
> 
> So, 2.2.20 works okay and 2.4.19 fails. Anybody have a rough idea of when
> the receive data overrun behavior crept in? 

Sorry, but I reached wrong conclusions since I likely tested 2.4.19.
when a backup program was putting a heavy load on the harddisk.
For 2.2.20 there was likely no backup program running.  To check out the
situation, I just now tried out surfing the web when a tar program was
running creating a tarball of most of the drive.  The number of overruns
was roughly the same for 2.4.19 and 2.2.20: about 1/3 % of the bytes
received.  But since the FIFO buffer can hold 16 bytes, its a few
percent of each buffer fetch operation.  This seems too high.

Without tar running, there were few overruns.  This indicates that the
problem is due to the interference of the harddisk.  It seems just as
bad at the serial port speed of 57.6k as at 115.2k.  It still may be
that kernel 2.2.13 is a lot better.

> 
> -----Original Message----- From: David Lawyer [mailto:dave@lafn.org]
> Sent: Tuesday, February 18, 2003 3:06 PM To:
> linux-serial@vger.kernel.org Subject: Re: overruns with kernel 2.4.19
> 
> 
> On Tue, Feb 18, 2003 at 02:43:46PM +0100, Joachim Buermann wrote:
> > Hello all,
> > 
> > I`m using linux mandrake kernel 2.4.19 on a 2 GHz Pentium 4 with 128
> > MByte RAM. The serial port /dev/cua0 is connected to a external
> > device and receives data with 115200 Baud.
> The cua devices have been obsolete for some time.
> > 
> > Unfortunately I get a lot of fifo overruns. I have unmasked the hda
> > interrupts with:
> > 
> > hdparm -u1 /dev/hda
> > 
> > also set the low_latency flag in the serial driver. The harddisk dma
> > couldn't disabled.
> > 
> > I'm wonder at this behavior, because with a lower machine (Pentium I
> > 120 MHz, Kernel 2.2.13) I get overruns only once in a blue moon. And
> > I expected, that a 2 GHz machine should be quick enough, to responds
> > to the serial interrupts.
> 
> Almost the same for me.  On a Pentium I 90 MHz I get no overruns with
> kernel 2.2.20, but get hundreds of overruns on the same machine with
> kernel 2.4.19.  Something is wrong with the software.
> > 
			David Lawyer
