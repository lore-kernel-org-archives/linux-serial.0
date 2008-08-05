From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Tue, 5 Aug 2008 14:55:42 +0200
Message-ID: <002101c8f6fa$9273ab10$2e01a8c0@acksys.local>
References: <200808051141.07707.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp01.msg.oleane.net ([62.161.4.1]:43573 "EHLO
	smtp01.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762507AbYHEM5l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2008 08:57:41 -0400
In-Reply-To: <200808051141.07707.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Laurent Pinchart' <laurentp@cse-semaphore.com>, 'Grant Edwards' <grante@visi.com>
Cc: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Laurent Pinchart
>
> On Monday 04 August 2008, Grant Edwards wrote:
> > On 2008-08-04, Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

(...)

> We already have 3 distinct modes for RTS/CTS (see my mail
> from today 11:23:36 in this thread). If we add DSR/DTR
> hardware support we can easily get 5 or 6 modes. We will run
> out of bits in c_cflags.
>
The three modes which you identify are
(A) bus direction
(B) send data request (well... RTS=Request To Send :-)) which should be
acknowledged by CTS
(C) input flow control
but, the RTS is widely used for (A)=bus direction BECAUSE it is the same
behaviour than (B)=request to send... because RTS was initially made to set
the "bus direction" in the attached modem.
So the three modes are really 2.

People require the (A+B) usage because is in the RS232 and also in V24
specs. But DTR+DSR handshake, really, it's not standardized in any way nor
in broad use. I don't think this is a real need (my personal opinion). My
company once had a card implementing DTR/DSR flow control, nobody used it
and it has been dropped from newer cards.
If we really want it we could resort to a setserial flag to say "RTS/CTS
flow is implemented with DTR/DSR", but then, why not swapping the pin
cabling on the connector then ?

My conclusion: only one bit is needed in c_cflags.
BUT: think of all the upper APIs (termio, termios, tcset/get... and people
using directly TCSET/TCGET ioctls. I am afraid that changing a single bit in
such a widely used API might break a lot of existing apps.

(...)
>
> As the number of bits in c_cflags is not infinite we will
> need an ioctl to configure the desired hardware handshake
> mode (as most modes don't control the data flow I'd rather
> talk about hardware handshake which is a more generic name).
> We can either use one of the struct serial_struct reserved
> fields with TIOCSSERIAL, or create another ioctl.
>
In the Linux CRIS architecture I've seen an IOCTL doing exactly this, with
extra parameters to set the delays RTS-to-Tx and /Tx-to-/RTS. It sounds like
a non intrusive way of adding the feature.

This would definitely be my preferred way of doing (it's the one which I use
in my 16C950 driver).

JP Tosoni

