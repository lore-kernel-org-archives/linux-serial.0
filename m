From: David Lawyer <dave@lafn.org>
Subject: Re: Interpretation of termios flags on a serial driver
Date: Thu, 27 Mar 2003 11:06:52 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030327190652.GA1233@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D1A33E05@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from davespc1 (mail@host-66-81-24-223.rev.o1.com [66.81.24.223])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h2RJxH1j061968
	for <linux-serial@vger.kernel.org>; Thu, 27 Mar 2003 11:59:18 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by davespc1 with local (Exim 3.36 #1 (Debian))
	id 18yciD-0000Ka-00
	for <linux-serial@vger.kernel.org>; Thu, 27 Mar 2003 11:06:53 -0800
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33E05@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: 'linux-serial' <linux-serial@vger.kernel.org>

On Wed, Mar 26, 2003 at 04:59:11PM -0800, Ed Vance wrote:
> On Wed, Mar 26, 2003 at 4:17 PM, Henrique Gobbi wrote:
> > 
> > Hello Ed !
> > Thanks for the feedback. 
> > 
> > Please read my comments (doubts actually) below:
> > 
> > > > 4 - INPCK flag: What's the purpose of this flag. What's the 
> > > > difference in relation to IGNPAR;
[snip]
> > 

>From the code snippet, it seems that INPCK only determines how to "mark"
a parity error (when PARENB is set and IGNPAR is unset) and can be
overridden by PARMRK (prefixes the bad char. with \377\0).  INPCK has
no effect unless IGNPAR and PARMRK are both unset.  If they are both
unset then: INPCK set results in the bad character being replaced by \0,
while if INPCK is unset, then the bad character (less the parity bit) is
passed thru.  I've use "mark" in a broad sense, since in one case it's
not marked at all and in the other case it's marked by deleting it and
substituting a \0.

The man page for termios needs revision to make this clear.  One can't
just say that INPCK "enables parity checking"; it's a lot more involved.

> 
>    IGNPAR    INPCK         ACTION:
>      0         0           Deliver all data to the user-level, as is.
>      0         1           Deliver nulls in place of erroneous bytes
>      1         0           Discard erroneous bytes, deliver the rest
>      1         1           Discard erroneous bytes, deliver the rest 
> 
> IGNPAR gets processed before INPCK: 
> (from drivers/char/n_tty.c:488)
> 
> static inline void n_tty_receive_parity_error(struct tty_struct *tty,
>                                               unsigned char c)
> {
>         if (I_IGNPAR(tty)) {
>                 return;          /* discard data */
>         }
>         if (I_PARMRK(tty)) {
>                 put_tty_queue('\377', tty);
>                 put_tty_queue('\0', tty);
>                 put_tty_queue(c, tty);
>         } else  if (I_INPCK(tty))
>                 put_tty_queue('\0', tty);     /* deliver null */
>         else
>                 put_tty_queue(c, tty);        /* deliver data */
>         wake_up_interruptible(&tty->read_wait);
> }
> 
> > 
> > > > 5 - If the TTY knows the data status (PARITY, FRAMING, 
> > > > OVERRUN, NORMAL), 
> > > > why the driver has to deal with the flag IGNPAR. Shouldn't 
> > > > the TTY being 
> > > > doing it ?
> > > 
> > > Not sure I understand the question. Received data does not carry any
> > > information about errors with it after it leaves the driver, unless 
> > > PARMRK is set. 
> > 
> > When the driver copy the data from the controller to the flip buffer it
> > copies the data to the buffer tty->flip.char_buf_ptr and it set a flag
> > (TTY_NORMAL, TTY_PARITY, TTY_FRAME, etc) on the buffer
> > tty->flip.flag_buf_ptr telling the TTY how this byte was received. So
> > the TTY knows if certain byte was problematic or not. Did you 
> > understand my doubt know ?
> 
> Yes. I call that part a "line discipline". n_tty is the TTY line 
> discipline that implements termio(s) and some legacy functionality.
> 
> And yes, for received data with parity errors, the line discipline 
> handles IGNPAR, as well INPCK and PARMRK. See snippet of n_tty.c above. 
> 
> > 
> > Thanks for your patience
> > Henrique
> > 
> 
> Cheers,
> Ed
> 
> ---------------------------------------------------------------- 
> Ed Vance              edv (at) macrolink (dot) com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
			David Lawyer
