From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: Enabling auto RS485 half-duplex control
Date: Thu, 18 Dec 2008 06:59:32 +0100
Message-ID: <200812180659.32771.mfuchs@ma-fu.de>
References: <200812172224.13608.mfuchs@ma-fu.de> <20081218033200.GB9871@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43071 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750AbYLRF7i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Dec 2008 00:59:38 -0500
In-Reply-To: <20081218033200.GB9871@mit.edu>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org

Hi Ted,

you missunderstood me. This special UART does all the required stuff
in hardware. You only have to enable this mode once by writing some
magic to a UART register. From that time on the UART will automatically
assert the RTS# line when transmitting.

I am not talking about a software implementation. Your arguments
deal with a software implementation where you have to do it all by hand,
which will not work safely as you mentioned.

Matthias


> On Wed, Dec 17, 2008 at 10:24:13PM +0100, Matthias Fuchs wrote:
> > Hi,
> >
> > some Exar UARTs like the XR16C2850 support a feature
> > called auto RS485 half-duplex control. In this mode the
> > RTS line has a special role when using the UART for
> > RS485 communication.
>
> So I haven't maintained the serial driver for a long time, but when I
> did, I refused to try to implement hardware half-duplex control
> because there was absolutely no standards in this space.  Which RS-232
> lines are involved wasn't standardized, and there was often very
> strange timing restrictions as well.  Some devices required there to
> be a minimum delay of XX milliseconds between when RTS is raised
> and when DTR is raised.  Other devices have a maximum time between
> when one side raises RTS and the others side raises DTR.
>
> So the challenge is designing an interface for half-duplex which is
> sufficiently general that it will actually work for all/most of the
> half-dozen people in the world who still care about half-ruplex RS-232
> communications.  :-)
>
> 						- Ted
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
