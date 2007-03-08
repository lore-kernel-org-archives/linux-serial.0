From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Thu, 8 Mar 2007 13:48:00 +0000
Message-ID: <20070308134800.GA30023@flint.arm.linux.org.uk>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <200703071019.55896.rgetz@blackfin.uclinux.org> <57354eff0703071330k2395e9c8n58e12f2111dcb25a@mail.gmail.com> <200703080844.32157.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751854AbXCHNsP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200703080844.32157.rgetz@blackfin.uclinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 08, 2007 at 08:44:31AM -0500, Robin Getz wrote:
> On Wed 7 Mar 2007 16:30, Oleksiy Kebkal pondered:
> > 2007/3/7, Robin Getz <rgetz@blackfin.uclinux.org>:
> > > Right - so the question is where to manage the default state? I was
> > > thinking in the resource might be a good idea, but there isn't really a
> > > good place for it. (You could re-use some bits if flags, but I think that
> > > would not be a good idea).
> >
> > /proc/tty/driver/uartN/settings?
> >
> 
> That would let you change things are run time, but the problem is at boot 
> time. A default setting needs to be set, so when things initialize, and proc 
> does not exist yet, it is still set properly...

I disagree.  "proc does not exist yet" - the only time that applies is
long before userspace as active.

As I've said already, having a console on the same port as your application
program is just asking for trouble.  All bets are off - the kernel _will_
corrupt your data stream in random places.

Don't do it - it will _NEVER_ be reliable.

Never, ever, mix kernel consoles with application serial ports.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
