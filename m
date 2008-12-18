From: Theodore Tso <tytso@mit.edu>
Subject: Re: Enabling auto RS485 half-duplex control
Date: Wed, 17 Dec 2008 22:32:00 -0500
Message-ID: <20081218033200.GB9871@mit.edu>
References: <200812172224.13608.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.org ([69.25.196.31]:46283 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751994AbYLRDcE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Dec 2008 22:32:04 -0500
Content-Disposition: inline
In-Reply-To: <200812172224.13608.mfuchs@ma-fu.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org

On Wed, Dec 17, 2008 at 10:24:13PM +0100, Matthias Fuchs wrote:
> Hi,
> 
> some Exar UARTs like the XR16C2850 support a feature
> called auto RS485 half-duplex control. In this mode the
> RTS line has a special role when using the UART for 
> RS485 communication.

So I haven't maintained the serial driver for a long time, but when I
did, I refused to try to implement hardware half-duplex control
because there was absolutely no standards in this space.  Which RS-232
lines are involved wasn't standardized, and there was often very
strange timing restrictions as well.  Some devices required there to
be a minimum delay of XX milliseconds between when RTS is raised
and when DTR is raised.  Other devices have a maximum time between
when one side raises RTS and the others side raises DTR.

So the challenge is designing an interface for half-duplex which is
sufficiently general that it will actually work for all/most of the
half-dozen people in the world who still care about half-ruplex RS-232
communications.  :-)

						- Ted
