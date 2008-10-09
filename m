From: Rick Bolen <rickbolgm@gmail.com>
Subject: RE: serial port being reset at top of every hour?
Date: Wed, 08 Oct 2008 23:32:53 -0400
Message-ID: <1223523173.4856.6.camel@atlas.bolenworks.net>
References: <510839DAB7024F1FAA28BFF21F2EC14E@acksys.local>
	 <1223494964.3199.10.camel@atlas.bolenworks.net>
Reply-To: rickbolgm@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:27793 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbYJIDdB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2008 23:33:01 -0400
Received: by wx-out-0506.google.com with SMTP id h27so984103wxd.4
        for <linux-serial@vger.kernel.org>; Wed, 08 Oct 2008 20:33:00 -0700 (PDT)
In-Reply-To: <1223494964.3199.10.camel@atlas.bolenworks.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Whatever resets the ttyS0 every hour isn't calling serial_core.o
uart_open().

So, where should I add dump_stack() so that I am *certain* to see what
PID is resetting the baud rate? Where is the "closest to the hardware"
function call that sets baud?

Thx, Rick


On Wed, 2008-10-08 at 15:44 -0400, Rick Bolen wrote:
> I've looked for cron jobs and logins, but no joy. In fact, I've
> reinstalled Debian to EtchnHalf (2.6.24) and built a custom kernel
> (supporting VIA C7 proc and removing SMP).
> 
> So now I want to instrument serial_core.c to dump_stack() at every
> uart_open(), and see what the stack looks like at the top-of-the-hour.
> 
> At times, this issue has appeared on the first port of a MOXA card
> (ttyMI0), but currently is presenting on ttyS0. Will modifying
> uart_open() in serial_core.c catch *all* open calls on *all* serial
> ports (including mxser_new, i.e. moxa driver)?
> 
> Any recommendations or words of caution?
> 
> Also, under Debian, is there a way for me to recompile just
> serial_core.c without having to build an entire kernel?
> 
> Thanks,
> 
> Rick
> 
> On Thu, 2008-09-18 at 14:59 +0200, Tosoni wrote:
> > Look for 'cron' jobs
> > Look for a login process in /etc/inittab
> > Best regards
> > 
> > > -----Original Message-----
> > > From: linux-serial-owner@vger.kernel.org
> > > [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of Rick Bolen
> > > Sent: Thursday, September 18, 2008 2:14 PM
> > > To: linux-serial@vger.kernel.org
> > > Subject: serial port being reset at top of every hour?
> > > 
> > > 
> > > Hello all,
> > > 
> > > I've been trying to chase down an issue for about one month now.
> > > 
> > > Config:
> > > Debian Etch (4.04a) w/xfce, kernel 2.6.18-6-686, VIA PC2500E 
> > > mobo, Moxa 
> > > Smartio C168H/PCI (rev 01)
> > > 
> > > Symptoms:
> > > I run a Perl based home automation software package, 
> > > Misterhouse (been 
> > > running it on various versions of Debian since ~'98). It 
> > > interfaces to 
> > > numerous serial devices through the mobo's ttyS0 and the Moxa ttyMx 
> > > ports. It uses the SerialPort.pm PERL module (POSIX) for initializing 
> > > and utilizing ports.
> > > 
> > > At the top of the hour, some [other] process resets either ttyM0 or 
> > > ttyS0 (randomly determined at boot?) which causes the home automation 
> > > software to lose communication to the device.
> > > 
> > > Question:
> > > How can I determine what process is resetting the port? Is there any 
> > > logging available to list PIDs that access a port? ...or a 
> > > way to attach 
> > > a debugger to "the system" so I can identify the process?
> > > 
> > > I used strace on the home automation process to verify that it wasn't 
> > > clobbering itself, but I have no idea what other processes may be 
> > > "candidates", so I need to watch this from the system level.
> > > 
> > > Thank you,
> > > 
> > > Rick Bolen
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-serial" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 

