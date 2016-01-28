From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 9/9] tty: Use test_bit() with tty->flags
Date: Thu, 28 Jan 2016 14:22:16 -0800
Message-ID: <20160128222216.GA13513@kroah.com>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
 <1452486976-7594-10-git-send-email-peter@hurleysoftware.com>
 <20160128221329.GA6427@kroah.com>
 <56AA93D7.50002@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AA93D7.50002@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 28, 2016 at 02:19:03PM -0800, Peter Hurley wrote:
> On 01/28/2016 02:13 PM, Greg Kroah-Hartman wrote:
> > On Sun, Jan 10, 2016 at 08:36:16PM -0800, Peter Hurley wrote:
> >> tty->flags are handled with atomic bit ops; use test_bit() treewide.
> >>
> >> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> >> ---
> >>  arch/ia64/hp/sim/simserial.c       | 2 +-
> >>  drivers/char/pcmcia/synclink_cs.c  | 2 +-
> >>  drivers/isdn/i4l/isdn_tty.c        | 6 +++---
> >>  drivers/s390/char/tty3270.c        | 4 ++--
> >>  drivers/staging/dgap/dgap.c        | 2 +-
> >>  drivers/staging/dgnc/dgnc_tty.c    | 2 +-
> >>  drivers/tty/amiserial.c            | 6 +++---
> >>  drivers/tty/serial/68328serial.c   | 2 +-
> >>  drivers/tty/serial/crisv10.c       | 4 ++--
> >>  drivers/tty/serial/serial_core.c   | 6 +++---
> >>  drivers/tty/synclink.c             | 4 ++--
> >>  drivers/tty/synclink_gt.c          | 4 ++--
> >>  drivers/tty/synclinkmp.c           | 4 ++--
> >>  drivers/tty/tty_port.c             | 2 +-
> >>  net/irda/ircomm/ircomm_tty_ioctl.c | 6 +++---
> >>  15 files changed, 28 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
> >> index e70cade..2ab9ba6 100644
> >> --- a/arch/ia64/hp/sim/simserial.c
> >> +++ b/arch/ia64/hp/sim/simserial.c
> >> @@ -300,7 +300,7 @@ static int rs_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> >>  	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
> >>  	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
> >>  	    (cmd != TIOCMIWAIT)) {
> >> -		if (tty->flags & (1 << TTY_IO_ERROR))
> >> +		if (test_bit(TTY_IO_ERROR, &tty->flags))
> > 
> > I thought you were going to wrap these up in a tty_*() macro instead of
> > open-coding it everywhere?  That way you can change how those
> > bits/features are represented in the future, which is what I thought you
> > wanted to do?
> 
> I wasn't going to do that for tty->flags, just for tty_port->flags.

Ah, ok, my mistake.

> > Even if you don't want to do that, something like:
> > 
> > static inline int tty_is_io_error(struct tty_struct *tty)
> > {
> > 	return test_bit(TTY_IO_ERROR, &tty->flags);
> > }
> > 
> > and then this patch would just be:
> > 		if (tty_is_io_error(tty))
> > 
> > Or something like that, I'm not sold on the name, I'm sure you can pick
> > a better one :)
> >
> > Sound reasonable?
> 
> But I agree that seems better; I can certainly do something like that.
> I think just tty_io_error().

That would be great, thanks.

greg k-h
