From: Joachim Buermann <jbuermann@zes.com>
Subject: Re: overruns with kernel 2.4.19
Date: Wed, 19 Feb 2003 10:35:23 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030219103523.5030ed1c.jbuermann@zes.com>
References: <11E89240C407D311958800A0C9ACF7D1A33DA0@EXCHANGE>
	<20030219080309.GA422@lafn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inv1253.zes.com (217.5.81.123)
          by websrvnt02 with MERCUR-SMTP/POP3/IMAP4-Server (v3.10.18 AS-0098309)
          for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003  10:40:21 +0100
Received: from inv1253.zes.com (localhost [127.0.0.1])
	by inv1253.zes.com (Postfix) with ESMTP id 8A5081F3B1
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003 10:35:31 +0100 (CET)
Received: from inv1428.zes.com (inv1428.zes.com [192.168.2.28])
	by inv1253.zes.com (Postfix) with SMTP id CFAF51F3A8
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003 10:35:23 +0100 (CET)
In-Reply-To: <20030219080309.GA422@lafn.org>
List-Id: linux-serial@vger.kernel.org
To: linux serial <linux-serial@vger.kernel.org>

Hello David,

On Wed, 19 Feb 2003 00:03:10 -0800
David Lawyer <dave@lafn.org> wrote:

> On Tue, Feb 18, 2003 at 04:34:34PM -0800, Ed Vance wrote:
> > Hi Joachim and David,
> > 
> > Do I need an external data source to reproduce this, or does it also fail
> > with a looped back 115200 baud data stream (ttyS1 -> ttyS0)? I can try it on
> > my 333 MHz Pentium II when it frees up in a couple of days. 
> > 
> > So, 2.2.20 works okay and 2.4.19 fails. Anybody have a rough idea of when
> > the receive data overrun behavior crept in? 
> 
> Sorry, but I reached wrong conclusions since I likely tested 2.4.19.
> when a backup program was putting a heavy load on the harddisk.
> For 2.2.20 there was likely no backup program running.  To check out the
> situation, I just now tried out surfing the web when a tar program was
> running creating a tarball of most of the drive.  The number of overruns
> was roughly the same for 2.4.19 and 2.2.20: about 1/3 % of the bytes
> received.  But since the FIFO buffer can hold 16 bytes, its a few
> percent of each buffer fetch operation.  This seems too high.
> 
> Without tar running, there were few overruns.  This indicates that the
> problem is due to the interference of the harddisk.  It seems just as
> bad at the serial port speed of 57.6k as at 115.2k.  It still may be
> that kernel 2.2.13 is a lot better.

This align with my experience on a embedded linux (AMD ELAN 130 MHz).
There was a great difference if I using a older harddisk or a newer one.
My 2.2.13 desktop machine has also older harddisk and the 2.4.19 machine
a modern harddisk, so I will do some tests at home. There are running a
2.2.13 and a 2.4.19 kernel on the same hardware (600 MHz Athlon).

Maybe it's not so a kernel problem, as a general behaviour with modern
harddisks.

But whatever, it doesn't resolve this problem :-( 

Joachim

> 
> > 
> > -----Original Message----- From: David Lawyer [mailto:dave@lafn.org]
> > Sent: Tuesday, February 18, 2003 3:06 PM To:
> > linux-serial@vger.kernel.org Subject: Re: overruns with kernel 2.4.19
> > 
> > 
> > On Tue, Feb 18, 2003 at 02:43:46PM +0100, Joachim Buermann wrote:
> > > Hello all,
> > > 
> > > I`m using linux mandrake kernel 2.4.19 on a 2 GHz Pentium 4 with 128
> > > MByte RAM. The serial port /dev/cua0 is connected to a external
> > > device and receives data with 115200 Baud.
> > The cua devices have been obsolete for some time.
> > > 
> > > Unfortunately I get a lot of fifo overruns. I have unmasked the hda
> > > interrupts with:
> > > 
> > > hdparm -u1 /dev/hda
> > > 
> > > also set the low_latency flag in the serial driver. The harddisk dma
> > > couldn't disabled.
> > > 
> > > I'm wonder at this behavior, because with a lower machine (Pentium I
> > > 120 MHz, Kernel 2.2.13) I get overruns only once in a blue moon. And
> > > I expected, that a 2 GHz machine should be quick enough, to responds
> > > to the serial interrupts.
> > 
> > Almost the same for me.  On a Pentium I 90 MHz I get no overruns with
> > kernel 2.2.20, but get hundreds of overruns on the same machine with
> > kernel 2.4.19.  Something is wrong with the software.
> > > 
> 			David Lawyer
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
