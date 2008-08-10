From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Sun, 10 Aug 2008 13:49:40 +1000
Message-ID: <1218340180.9309.57.camel@thetriton.toftronix.com.au>
References: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
	 <1218033008.6275.86.camel@thetriton.toftronix.com.au>
	 <200808071050.35380.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:47570 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752384AbYHJDuz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Aug 2008 23:50:55 -0400
In-Reply-To: <200808071050.35380.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org

On Thu, 2008-08-07 at 10:50 +0200, Laurent Pinchart wrote:
> On Wednesday 06 August 2008, Christopher Gibson wrote:
> > Been a few years since I ran into this issue, but are faced with it
--- >8 ---
> > conventions on how to enable RTS direction control.  It would seem,
> > looking through this mail list that any convention is yet to be defined
> > for Linux.
> 
> That's right. Hopefully we should achieve a consensus on the API soon.
> 
> > On Tue, 2008-08-05 at 14:55 +0200, Tosoni wrote:
> > > > -----Original Message-----
> > > > From: Laurent Pinchart
> > > (...)
> > > 
> > > > We already have 3 distinct modes for RTS/CTS (see my mail
> > > > from today 11:23:36 in this thread). If we add DSR/DTR
> > > > hardware support we can easily get 5 or 6 modes. We will run
> > > > out of bits in c_cflags.
> > > >
> > > The three modes which you identify are
> > > (A) bus direction
> > > (B) send data request (well... RTS=Request To Send :-)) which should be
> > > acknowledged by CTS
> > > (C) input flow control
> > > but, the RTS is widely used for (A)=bus direction BECAUSE it is the same
> > > behaviour than (B)=request to send... because RTS was initially made to
> > > set the "bus direction" in the attached modem.
> > > So the three modes are really 2.
> > (--->8---)
> > 
> > The only case above that is actually RS232 is (B), the rest are just
> > asynchronous serial communications.
> 
> (C) has actually been standardized in TIA-232-E (formerly RS-232-E). See http://en.wikipedia.org/wiki/RS-232

Sorry I stand corrected.

> 
> > Saying that (A) and (B) are the same negates the timing requirements
> > that (A) may have that are unimportant in (B).
> > 
> > In some situations you can get case (A) from a type (B) implementation
> > by tying RTS and CTS together, but for other UARTS, this just doesn't
> > work.  You can end up losing characters that are in the tx shift
> > register and end of FIFO, or in the other timing extreme, losing the
> > response from a RS485 slave unit.
> > 
> > I would say that it's important to make the RS485 RTS direction control
> > mode distinct from the RTS/CTS RS232 hand shaking mode.  I would foresee
> > that it may be necessary to allow setup of different timing modes, to
> > allow for example chewing up CPU resources for the sake of fast
> > direction turn around when using ill conceived UARTS.  (Maybe an ill
> > conceived UART is just an ART;)  Also if this is to also be useful for
> > radio communications then it may be necessary to provide a mechanism
> > where lead in and lead out times can be specified for the control.
> 
> This is getting more complex than I would have thought, although your point is quite valid :-/ I don't think we should implement any hardware handshake mode in software thought. Drivers should export the capabilities of the hardware. If an UART doesn't support mode (A) it's quite pointless to try to emulate it in the driver. Timing requirements will be violated at some point, users will complain, and developers will point out that the software implementation didn't come with any guarantee. Everybody will be disappointed in the end.
> 
> Is there any UART that supports lead in/lead out timing configuration in hardware ?

Think that I was getting carried away with the suggestion of lead/in
lead out timing implementation.  I have seen it implemented in a
proprietary operating system, and it worked quite well, but it was a
software solution, not hardware.  The product was designed specifically
for radio communications.  With the timings required for radios (decent
fractions of seconds), it's not difficult to implement this in user
space, and hard to justify introducing a kernel interface, to support
it.  Also this form of radio communications is an out-dated technology.

I would say that it would be very hard to justify introducing an
interface for these timing controls.

> 
> > As far as IOCTL names go I dislike the CRTSTOGGLE, toggling the RTS line
> > is an incorrect description of function.  I prefer CARTS as it is not an
> > incorrect description of function.  CARTS - auto request to send is
> > rather ambiguous though.  If I was to suggest a name it would be RTSADC
> > - request to send auto direction control (maybe with a preceding C if it
> > went into termios cflags).
> 
> Let's first decide where it should go, then we'll try to find appropriate names. 
> The number of free bits in c_cflags is quite limited, 
> so I think a new ioctl is probably required with a new data structure to 
> pass additional data such as timing information in addition to the handshaking mode.

Was thinking on this.  There are already two bits allocated to use of
handshaking lines in the c_cflags:  CLOCAL and CRTSCTS.  Introducing a
third flag would give a total of 8 different handshaking line mode
possibilities.  If care is taken to ensure backward compatibility with
the CLOCAL and CRTSCTS states you still have the possibility of 4 new
modes.

eg:

#define CFLOW_EXT (08000000)
#define CFLOW	(CLOCAL | CRTSCTS | CFLOW_EXT)
#define CRTSADC (CFLOW_EXT)		/*RTS auto flow control*/
#define CDTRADC (CFLOW_EXT | CLOCAL)	/*DTR auto flow control*/

I don't know if 08000000 is free in all architectures, just throwing up
possiblities.

> 
> > From what I can gather through the man pages it seems inappropriate to
> > add this to termios cflag, though the CRTSCTS flag does set a precedent.
> > I'm an advocate of the idea of introducing a new IOCTL for setting up
> > non standard hand-shaking settings.  I would suggest that things that
> > should be considered in the interface are settings for lead-in and
> > lead-out timing on the direction line (for the use of radio modems for
> > example) and means to specify if it's appropriate to have the CPU spin
> > on the shift register empty flag on the last byte of a block, if RTS
> > timing really is that critical.
> 
> I don't think we want to introduce software emulation, but feel free to prove me wrong.

I need to  introduce software flow control in my particular case.  This
need not make it into the kernel proper, but will be made available to
anyone interested as a patch.  The important thing here is that we end
up with a consistent interface for enabling these features.

> 
> > I'm rather excited by the idea that a standard interface for RTS
> > direction control is going to be introduced.
> 
> Best regards,
> 
-- 
Christopher Gibson <chris@toftronix.com.au>

