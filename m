From: Bob Bell <bbell@users.sourceforge.net>
Subject: Re: Serial driver related problems on Linux
Date: Wed, 30 Mar 2005 07:49:19 -0500
Message-ID: <20050330124919.GA25704@newbie.macroped.net>
References: <20050310154125.GB12846@magick.macroped.net> <20050315021128.GC15418@thunk.org> <20050317180703.GA30572@newbie.macroped.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from srv01.macroped.com ([207.44.188.8]:64723 "EHLO
	srv01.macroped.com") by vger.kernel.org with ESMTP id S261823AbVC3Mtd
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Mar 2005 07:49:33 -0500
Content-Disposition: inline
In-Reply-To: <20050317180703.GA30572@newbie.macroped.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org

I don't recall seeing a reply to my email below (note that I'm not
subscribed to linux-serial, so if the reply went only to the list,
I missed it).  Is there more information that I can provide?  I don't
know how to interpret the output from SERIAL_DEBUG_INTR.

On Thu, Mar 17, 2005 at 01:07:03PM -0500, Bob Bell <bbell@users.sourceforge.net> wrote:
> On Mon, Mar 14, 2005 at 09:11:28PM -0500, Theodore Ts'o <tytso@mit.edu> wrote:
> > On Thu, Mar 10, 2005 at 10:41:27AM -0500, Bob Bell wrote:
> > > The user-visible symptoms of this problem are that after typing in a
> > > username and hitting enter, the serial login prompt hangs.  I've traced
> > > this hang to an ioctl in the login code (TCSETSF, a result of calling
> > > tcsetattr(,TCSAFLUSH,)).  I've further traced that ioctl to being stuck
> > > in tty_wait_until_sent().
> > 
> > It's possible this was caused by a lost transmitter interrupt, so the
> > transmit queue never drained; it's also possible that some UART's are
> > wired to not signal a transmitter interrupt while the serial port is
> > flow controlled.  In order to figure out what is going on, you'd have
> > to add debugging logic into the interrupt handler as well (i.e.,
> > #define SERIAL_DEBUG_INTR).
> 
> I've #defined SERIAL_DEBUG_INTR as you indicated.  In order to minimize
> the impact that might cause, I also #defined printk() to be equivalent
> to my debugging routine, dbg_addmsg().  The following was captured
> starting after I typing in my username, but before I hit enter:
>     rs_interrupt_single(4)...status = 61...DR0d:61...IIR = c1...end.
>     rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
>     <7>ttyS wait until sent...
>     <7>waiting ttyS...(1)
>     rs_interrupt_single(4)...status = 0...IIR = c1...end.
>     [ the preceding line repeats another 28x, about once every 10 seconds ]
>     <7>waiting ttyS...(62)
>     <7>waiting on ttyS interrupted
> 
> I've attached a complete log, starting at boot time, as
> log_complete.out.  I've also attached my updated patch to the Linux
> kernel that I used to capture the debugging output, just for
> completeness.
> 
> Thanks for the guidance.  I'm not sure what this output demonstrates,
> but I hope it gets us at least one step closer to the cause...
> 
> -- 
> Bob Bell <bbell@users.sourceforge.net>

> <6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> <6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1799...lsr = 96 (jiff=1799)...done
> In rs_wait_until_sent(3) check=1...jiff=1799...lsr = 96 (jiff=1799)...done
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1799...lsr = 96 (jiff=1799)...done
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1799...lsr = 96 (jiff=1799)...done
> In rs_wait_until_sent(3) check=1...jiff=1799...lsr = 96 (jiff=1799)...done
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1802...lsr = 0 (jiff=1802)...lsr = 96 (jiff=1803)...done
> In rs_wait_until_sent(3) check=1...jiff=1803...lsr = 96 (jiff=1803)...done
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(4)
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1804...lsr = 0 (jiff=1804)...lsr = 0 (jiff=1805)...lsr = 96 (jiff=1806)...done
> In rs_wait_until_sent(3) check=1...jiff=1806...lsr = 96 (jiff=1806)...done
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1806...lsr = 0 (jiff=1806)...lsr = 96 (jiff=1807)...done
> In rs_wait_until_sent(3) check=1...jiff=1807...lsr = 96 (jiff=1807)...done
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> In rs_wait_until_sent(6) check=1...jiff=1809...lsr = 96 (jiff=1809)...done
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(0)
> done waiting ttyS...(0)
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 61...DR0d:61...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 20...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 61...DR72:61...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 61...DR6f:61...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 61...DR6f:61...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 61...DR74:61...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...IIR = c1...end.
> rs_interrupt_single(4)...status = 61...DR0d:61...IIR = c1...end.
> rs_interrupt_single(4)...status = 60...THRE...IIR = c1...end.
> <7>ttyS wait until sent...
> <7>waiting ttyS...(1)
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> rs_interrupt_single(4)...status = 0...IIR = c1...end.
> <7>waiting ttyS...(62)
> <7>waiting on ttyS interrupted

> diff -rup --exclude '*SCCS*' --exclude BitKeeper linux.orig/drivers/char/serial.c linux/drivers/char/serial.c
> --- linux.orig/drivers/char/serial.c	Wed Mar  9 17:47:18 2005
> +++ linux/drivers/char/serial.c	Thu Mar 17 12:04:54 2005
> @@ -140,10 +140,10 @@ static char *serial_revdate = "2001-07-0
>  
>  /* Set of debugging defines */
>  
> -#undef SERIAL_DEBUG_INTR
> +#define SERIAL_DEBUG_INTR
>  #undef SERIAL_DEBUG_OPEN
>  #undef SERIAL_DEBUG_FLOW
> -#undef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
> +#define SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
>  #undef SERIAL_DEBUG_PCI
>  #undef SERIAL_DEBUG_AUTOCONF
>  
> @@ -265,6 +265,10 @@ static int serial_refcount;
>  
>  static struct timer_list serial_timer;
>  
> +extern pid_t watched_pid;
> +extern void dbg_addmsg(char *fmt, ...);
> +#define printk(...) dbg_addmsg(__VA_ARGS__)
> +
>  /* serial subtype definitions */
>  #ifndef SERIAL_TYPE_NORMAL
>  #define SERIAL_TYPE_NORMAL	1
> @@ -927,7 +931,7 @@ static void rs_interrupt_single(int irq,
>  		    ((iir & UART_IIR_ID) == UART_IIR_THRI))
>  			transmit_chars(info, 0);
>  		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
> -#if SERIAL_DEBUG_INTR
> +#ifdef SERIAL_DEBUG_INTR
>  			printk("rs_single loop break.\n");
>  #endif
>  			break;
> @@ -2942,12 +2946,12 @@ static void rs_wait_until_sent(struct tt
>  	if (!timeout || timeout > 2*info->timeout)
>  		timeout = 2*info->timeout;
>  #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
> -	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
> -	printk("jiff=%lu...", jiffies);
> +	if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
> +	if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk("jiff=%lu...", jiffies);
>  #endif
>  	while (!((lsr = serial_inp(info, UART_LSR)) & UART_LSR_TEMT)) {
>  #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
> -		printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
> +		if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk("lsr = %d (jiff=%lu)...", lsr, jiffies);
>  #endif
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		schedule_timeout(char_time);
> @@ -2957,7 +2961,7 @@ static void rs_wait_until_sent(struct tt
>  			break;
>  	}
>  #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
> -	printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
> +	if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk("lsr = %d (jiff=%lu)...done\n", lsr, jiffies);
>  #endif
>  }
>  
> diff -rup --exclude '*SCCS*' --exclude BitKeeper linux.orig/drivers/char/tty_ioctl.c linux/drivers/char/tty_ioctl.c
> --- linux.orig/drivers/char/tty_ioctl.c	Wed Mar  9 17:47:18 2005
> +++ linux/drivers/char/tty_ioctl.c	Thu Mar 17 12:04:56 2005
> @@ -25,7 +25,21 @@
>  #include <asm/uaccess.h>
>  #include <asm/system.h>
>  
> -#undef TTY_DEBUG_WAIT_UNTIL_SENT
> +char dbg_msgbuf[1024*256] = { '\0' };
> +char *dbg_msgcur = dbg_msgbuf;
> +void dbg_addmsg(char *fmt, ...) {
> +    va_list args;
> +    va_start(args, fmt);
> +    dbg_msgcur += vsprintf(dbg_msgcur, fmt, args);
> +    va_end(args);
> +    if (dbg_msgcur >= (dbg_msgbuf + sizeof(dbg_msgbuf))) {
> +	panic("debug message buffer overflow");
> +    }
> +}
> +
> +
> +#define TTY_DEBUG_WAIT_UNTIL_SENT
> +#define printk(...) dbg_addmsg(__VA_ARGS__)
>  
>  #undef	DEBUG
>  
> @@ -43,7 +57,7 @@ void tty_wait_until_sent(struct tty_stru
>  #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
>  	char buf[64];
>  	
> -	printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty, buf));
> +	if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty, buf));
>  #endif
>  	if (!tty->driver.chars_in_buffer)
>  		return;
> @@ -52,16 +66,21 @@ void tty_wait_until_sent(struct tty_stru
>  		timeout = MAX_SCHEDULE_TIMEOUT;
>  	do {
>  #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
> -		printk(KERN_DEBUG "waiting %s...(%d)\n", tty_name(tty, buf),
> +		if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk(KERN_DEBUG "waiting %s...(%d)\n", tty_name(tty, buf),
>  		       tty->driver.chars_in_buffer(tty));
>  #endif
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		if (signal_pending(current))
> +		if (signal_pending(current)) {
> +			if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk(KERN_DEBUG "waiting on %s interrupted\n", tty_name(tty, buf));
>  			goto stop_waiting;
> +		}
>  		if (!tty->driver.chars_in_buffer(tty))
>  			break;
>  		timeout = schedule_timeout(timeout);
>  	} while (timeout);
> +#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
> +	if (tty->driver.type != TTY_DRIVER_TYPE_PTY) printk("done waiting %s...(%d)\n", tty_name(tty, buf), tty->driver.chars_in_buffer(tty));
> +#endif
>  	if (tty->driver.wait_until_sent)
>  		tty->driver.wait_until_sent(tty, timeout);
>  stop_waiting:

-- 
Bob Bell <bbell@users.sourceforge.net>
