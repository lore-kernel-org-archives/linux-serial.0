From: Christopher Gibson <chris@toftronix.com.au>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 07 Aug 2008 00:30:08 +1000
Message-ID: <1218033008.6275.86.camel@thetriton.toftronix.com.au>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:57407 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753114AbYHFPSE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Aug 2008 11:18:04 -0400
Received: from localhost ([127.0.0.1] ident=chris)
	by thetriton.toftronix.com.au with esmtp (Exim 4.69)
	(envelope-from <chris@toftronix.com.au>)
	id 1KQk1g-0002Zz-C1
	for linux-serial@vger.kernel.org; Thu, 07 Aug 2008 00:30:08 +1000
In-Reply-To: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Been a few years since I ran into this issue, but are faced with it
again.  Last time the timing wasn't to critical and I managed to use
user space control of the RTS line to achieve RS485 buffer direction
control.  In this case I had control of the response time of the slave
processor, so got away with it.  This time I haven't got that much
control over the timing of the slave units, and a bit more load on the
Linux system, and a user space solution is just not cutting it.  Have
hacked up a kernel to give me the RTS control I need, but started
working on a more generic (and less CPU wasting) solution.  It was part
of this work that lead me to this mail group, as I was looking for
conventions on how to enable RTS direction control.  It would seem,
looking through this mail list that any convention is yet to be defined
for Linux.

On Tue, 2008-08-05 at 14:55 +0200, Tosoni wrote:
> > -----Original Message-----
> > From: Laurent Pinchart
> (...)
> 
> > We already have 3 distinct modes for RTS/CTS (see my mail
> > from today 11:23:36 in this thread). If we add DSR/DTR
> > hardware support we can easily get 5 or 6 modes. We will run
> > out of bits in c_cflags.
> >
> The three modes which you identify are
> (A) bus direction
> (B) send data request (well... RTS=Request To Send :-)) which should be
> acknowledged by CTS
> (C) input flow control
> but, the RTS is widely used for (A)=bus direction BECAUSE it is the same
> behaviour than (B)=request to send... because RTS was initially made to set
> the "bus direction" in the attached modem.
> So the three modes are really 2.
(--->8---)

The only case above that is actually RS232 is (B), the rest are just
asynchronous serial communications.

Saying that (A) and (B) are the same negates the timing requirements
that (A) may have that are unimportant in (B).

In some situations you can get case (A) from a type (B) implementation
by tying RTS and CTS together, but for other UARTS, this just doesn't
work.  You can end up losing characters that are in the tx shift
register and end of FIFO, or in the other timing extreme, losing the
response from a RS485 slave unit.

I would say that it's important to make the RS485 RTS direction control
mode distinct from the RTS/CTS RS232 hand shaking mode.  I would foresee
that it may be necessary to allow setup of different timing modes, to
allow for example chewing up CPU resources for the sake of fast
direction turn around when using ill conceived UARTS.  (Maybe an ill
conceived UART is just an ART;)  Also if this is to also be useful for
radio communications then it may be necessary to provide a mechanism
where lead in and lead out times can be specified for the control.

As far as IOCTL names go I dislike the CRTSTOGGLE, toggling the RTS line
is an incorrect description of function.  I prefer CARTS as it is not an
incorrect description of function.  CARTS - auto request to send is
rather ambiguous though.  If I was to suggest a name it would be RTSADC
- request to send auto direction control (maybe with a preceding C if it
went into termios cflags).

>From what I can gather through the man pages it seems inappropriate to
add this to termios cflag, though the CRTSCTS flag does set a precedent.
I'm an advocate of the idea of introducing a new IOCTL for setting up
non standard hand-shaking settings.  I would suggest that things that
should be considered in the interface are settings for lead-in and
lead-out timing on the direction line (for the use of radio modems for
example) and means to specify if it's appropriate to have the CPU spin
on the shift register empty flag on the last byte of a block, if RTS
timing really is that critical.

I'm rather excited by the idea that a standard interface for RTS
direction control is going to be introduced.

-- 
Christopher Gibson <chris@toftronix.com.au>

