From: Ed Vance <EdV@macrolink.com>
Subject: RE: Update on problems with UPS
Date: Thu, 27 Feb 2003 13:29:10 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DBB@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: 'Ross Boylan' <RossBoylan@stanfordalumni.org>
Cc: linux-serial@vger.kernel.org

Hi Ross,

I'm not the sender that you were replying to, but here's my attempt at the
answers: 8)

On Thu, Feb 27, 2003 at 12:43 PM, Ross Boylan wrote:
> Thank you for all this useful information.  I'm not sure I followed
> all of it, so I want to clarify a couple of points.
> 
> I talked about pnp resetting the modem or the serial port on the card.
> You say it would only affect the port.  What I had in mind was that
> pnp might reset the IRQ for one device, but not the other, so they
> wouldn't be able to communicate.  Are you saying that's so?
> 
No. The modem is hardware attached to the serial side of the serial port and
cannot be pried loose with mere software. In fact, the modem part's _only_
logical connection to the system is through the serial port.

> I think what you mean is that only the serial port needs an IRQ, since
> the modem talks to the serial port talks to the computer.  So
> regardless of how I set pnp, the serial port and modem will be able to
> communicate.  Correct?
> 
Yes. Exactly.

> Further, the reason I lose communication with the port/modem after
> manually running pnp is that the serial driver does not know that the
> port has moved.  If I manually change the IRQ with pnp, I need to
> manually tell the driver with setserial.  Correct?
> 
Yes. The serial driver knows nothing about the changes made by pnp.

> Thanks.
> 
Cheers,
Ed
