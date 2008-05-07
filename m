From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BUG] NULL pointer dereference in uart_write_room().
Date: Wed, 7 May 2008 20:19:26 +0100
Message-ID: <20080507191926.GA19802@flint.arm.linux.org.uk>
References: <261636618@web.de> <200805022300.GIB30385.FJOVHQSMFtOOFL@I-love.SAKURA.ne.jp> <200805041716.DDG43279.JOSMHVFOFFQLOt@I-love.SAKURA.ne.jp> <20080505113055.5284052e@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57220 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765541AbYEGTYm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 May 2008 15:24:42 -0400
Content-Disposition: inline
In-Reply-To: <20080505113055.5284052e@core>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 05, 2008 at 11:30:55AM +0100, Alan Cox wrote:
> > (5) uart_remove_one_port() is called by serial8250_register_port()
> >     since ttyS0 is already in use but it is requested to be once removed.
> 
> That means 8250_pnp is taking over and then trying to delete the console,
> so its breakage in the serial layer glue. Perhaps Russell has some ideas
> as its hard to tell what he intended to happen originally.

Looking at the original report, yes, it is (and will) try to delete the
console.

However, it's doing the best it can to tell the tty layer "oi, this is
port going away, don't do anything more with it" by hanging it up.

The real question is: why, after we try to hang up a specific port, is
the tty layer continuing to use the port... and the answer is that the
tty layer exempts the console from the usual hangup processing.

IOW, you can not hang up the console port or indeed ever safely unregister
it.

Other solutions?  Well, we could modify it in place but that gets awfully
icky and racy with... the console, so we wouldn't actually be solving
anything.

The only other solution I can think of is to basically deny any change
to the console port, so it never disappears, and therefore never becomes
owned by PNP, PCI or whatever.  Which also means that it'll probably
mess up power management of it.  I guess broken console PM is more
preferable than oopsing peoples machines.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
