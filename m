From: David Lawyer <dave@lafn.org>
Subject: Re: Update on problems with UPS
Date: Thu, 27 Feb 2003 13:49:17 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030227214917.GE1307@lafn.org>
References: <11E89240C407D311958800A0C9ACF7D1A33DBB@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from localhost (mail@host-66-81-16-55.rev.o1.com [66.81.16.55])
	by zoon.lafn.org (8.12.3/8.11.3) with ESMTP id h1RM6lNc024494
	for <linux-serial@vger.kernel.org>; Thu, 27 Feb 2003 14:06:48 -0800 (PST)
	(envelope-from dave@lafn.org)
Received: from dave by localhost with local (Exim 3.36 #1 (Debian))
	id 18oVu1-0000Ps-00
	for <linux-serial@vger.kernel.org>; Thu, 27 Feb 2003 13:49:17 -0800
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DBB@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

> 
> On Thu, Feb 27, 2003 at 12:43 PM, Ross Boylan wrote:
> > I talked about pnp resetting the modem or the serial port on the card.
> > You say it would only affect the port.  What I had in mind was that
> > pnp might reset the IRQ for one device, but not the other, so they
> > wouldn't be able to communicate.  Are you saying that's so?
> > 
On Thu, Feb 27, 2003 at 01:29:10PM -0800, Ed Vance wrote:
> No. The modem is hardware attached to the serial side of the serial port and
> cannot be pried loose with mere software. In fact, the modem part's _only_
> logical connection to the system is through the serial port.

After I wrote the following, I realized that the gist of it has already
been stated.  But here it is.  The modem itself has no IRQ or IO address.
Only the serial port that the modem is connected to has an IRQ and IO
address.  This is true both for an internal and external modem.  But for
an internal modem, it's serial port is located on the same card and
can't be used for anything else except for the modem.

			David Lawyer
