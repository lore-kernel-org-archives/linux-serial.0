From: Ed Vance <EdV@macrolink.com>
Subject: RE: overruns with kernel 2.4.19
Date: Tue, 18 Feb 2003 16:34:34 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DA0@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Joachim Buermann' <jbuermann@zes.com>, 'David Lawyer' <dave@lafn.org>
Cc: linux-serial@vger.kernel.org

Hi Joachim and David,

Do I need an external data source to reproduce this, or does it also fail
with a looped back 115200 baud data stream (ttyS1 -> ttyS0)? I can try it on
my 333 MHz Pentium II when it frees up in a couple of days. 

So, 2.2.20 works okay and 2.4.19 fails. Anybody have a rough idea of when
the receive data overrun behavior crept in? 

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              serial24 (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

-----Original Message-----
From: David Lawyer [mailto:dave@lafn.org]
Sent: Tuesday, February 18, 2003 3:06 PM
To: linux-serial@vger.kernel.org
Subject: Re: overruns with kernel 2.4.19


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
-
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
