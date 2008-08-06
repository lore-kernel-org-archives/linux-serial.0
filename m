From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Wed, 6 Aug 2008 18:33:06 +0200
Message-ID: <000601c8f7e2$1b73e9b0$2e01a8c0@acksys.local>
References: <1218033008.6275.86.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp01.msg.oleane.net ([62.161.4.1]:57051 "EHLO
	smtp01.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943AbYHFQfH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Aug 2008 12:35:07 -0400
In-Reply-To: <1218033008.6275.86.camel@thetriton.toftronix.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Christopher Gibson' <chris@toftronix.com.au>, linux-serial@vger.kernel.org



> -----Original Message-----
> From: Christopher Gibson
>
> Been a few years since I ran into this issue, but are faced with it
> again.  Last time the timing wasn't to critical and I managed to use
> user space control of the RTS line to achieve RS485 buffer direction
> control.  In this case I had control of the response time of the slave
> processor, so got away with it.  This time I haven't got that much
> control over the timing of the slave units, and a bit more load on the
> Linux system, and a user space solution is just not cutting it.  Have
> hacked up a kernel to give me the RTS control I need, but started
> working on a more generic (and less CPU wasting) solution.
> It was part
> of this work that lead me to this mail group, as I was looking for
> conventions on how to enable RTS direction control.  It would seem,
> looking through this mail list that any convention is yet to
> be defined for Linux.
>
> On Tue, 2008-08-05 at 14:55 +0200, Tosoni wrote:
> > > -----Original Message-----
> > > From: Laurent Pinchart
> > (...)
> >
> > > We already have 3 distinct modes for RTS/CTS (see my mail
> > > from today 11:23:36 in this thread). If we add DSR/DTR
> > > hardware support we can easily get 5 or 6 modes. We will run
> > > out of bits in c_cflags.
> > >
> > The three modes which you identify are
> > (A) bus direction
> > (B) send data request (well... RTS=Request To Send :-))
> which should be
> > acknowledged by CTS
> > (C) input flow control
> > but, the RTS is widely used for (A)=bus direction BECAUSE
> it is the same
> > behaviour than (B)=request to send... because RTS was
> initially made to set
> > the "bus direction" in the attached modem.
> > So the three modes are really 2.
> (--->8---)
>
> The only case above that is actually RS232 is (B), the rest are just
> asynchronous serial communications.
>
> Saying that (A) and (B) are the same negates the timing requirements
> that (A) may have that are unimportant in (B).

In an ideal world I do believe that the standard defined
the CTS signal to provide this timing info (from modems).
So, CTS should always be used as a output flow control.

But in the real world I agree that usually the RS485
does not provide such signaling.

>
> In some situations you can get case (A) from a type (B) implementation
> by tying RTS and CTS together, but for other UARTS, this just doesn't
> work.  You can end up losing characters that are in the tx shift
> register and end of FIFO, or in the other timing extreme, losing the
> response from a RS485 slave unit.
>
> I would say that it's important to make the RS485 RTS
> direction control
> mode distinct from the RTS/CTS RS232 hand shaking mode.  I
> would foresee
> that it may be necessary to allow setup of different timing modes, to
> allow for example chewing up CPU resources for the sake of fast
> direction turn around when using ill conceived UARTS.  (Maybe an ill
> conceived UART is just an ART;)  Also if this is to also be useful for
> radio communications then it may be necessary to provide a mechanism
> where lead in and lead out times can be specified for the control.
>
> As far as IOCTL names go I dislike the CRTSTOGGLE, toggling
> the RTS line
> is an incorrect description of function.

It is incorrect only if you introduce the timings. Please note that Windows
has RTS_TOGGLE, no extra timings, and nobody seems to complain.
Wait wait... I am not saying that you are wrong. Last year I had to write a
(non unix) driver to handle these kinks of timings. But the case is not
usual.

>  I prefer CARTS as it is not an
> incorrect description of function.  CARTS - auto request to send is
> rather ambiguous though.  If I was to suggest a name it would
> be RTSADC
> - request to send auto direction control (maybe with a
> preceding C if it
> went into termios cflags).
>
> >From what I can gather through the man pages it seems
> inappropriate to
> add this to termios cflag, though the CRTSCTS flag does set a
> precedent.
> I'm an advocate of the idea of introducing a new IOCTL for setting up
> non standard hand-shaking settings.  I would suggest that things that
> should be considered in the interface are settings for lead-in and
> lead-out timing on the direction line (for the use of radio modems for
> example) and means to specify if it's appropriate to have the CPU spin
> on the shift register empty flag on the last byte of a block, if RTS
> timing really is that critical.

There would be 2 implementations of this ioctl. One for the
zero-timing case which can be handled by some chips (Ox16C950), and
one for the some-timing or old-uart case.

>
> I'm rather excited by the idea that a standard interface for RTS
> direction control is going to be introduced.
>
> --
> Christopher Gibson <chris@toftronix.com.au>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

