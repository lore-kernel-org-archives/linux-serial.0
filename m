From: David Lawyer <dave@lafn.org>
Subject: Re: overruns with kernel 2.4.19
Date: Tue, 18 Feb 2003 15:05:33 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030218230533.GB480@lafn.org>
References: <20030218144346.3e056a65.jbuermann@zes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-29-63.rev.o1.com [66.81.29.63])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1ING1nX043678
	for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2003 15:16:01 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18lGnt-0000B5-00
	for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2003 15:05:33 -0800
Content-Disposition: inline
In-Reply-To: <20030218144346.3e056a65.jbuermann@zes.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Tue, Feb 18, 2003 at 02:43:46PM +0100, Joachim Buermann wrote:
> Hello all,
> 
> I`m using linux mandrake kernel 2.4.19 on a 2 GHz Pentium 4 with 128
> MByte RAM. The serial port /dev/cua0 is connected to a external device
> and receives data with 115200 Baud.
The cua devices have been obsolete for some time.
> 
> Unfortunately I get a lot of fifo overruns. I have unmasked the hda
> interrupts with:
> 
> hdparm -u1 /dev/hda
> 
> also set the low_latency flag in the serial driver. The harddisk dma
> couldn't disabled.
> 
> I'm wonder at this behavior, because with a lower machine (Pentium I
> 120 MHz, Kernel 2.2.13) I get overruns only once in a blue moon. And I
> expected, that a 2 GHz machine should be quick enough, to responds to
> the serial interrupts.

Almost the same for me.  On a Pentium I 90 MHz I get no overruns with
kernel 2.2.20, but get hundreds of overruns on the same machine with
kernel 2.4.19.  Something is wrong with the software.
> 
			David Lawyer
