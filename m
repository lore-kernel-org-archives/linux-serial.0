From: Grant Edwards <grante@visi.com>
Subject: Re: Enabling auto RS485 half-duplex control
Date: Thu, 18 Dec 2008 15:51:36 +0000 (UTC)
Message-ID: <gidri8$7i6$1@ger.gmane.org>
References: <200812172224.13608.mfuchs@ma-fu.de>
 <20081218033200.GB9871@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39823 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbYLRPvu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Dec 2008 10:51:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LDLA8-0008SP-It
	for linux-serial@vger.kernel.org; Thu, 18 Dec 2008 15:51:44 +0000
Received: from 64.251.14.41 ([64.251.14.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2008 15:51:44 +0000
Received: from grante by 64.251.14.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2008 15:51:44 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-12-18, Theodore Tso <tytso@mit.edu> wrote:
> On Wed, Dec 17, 2008 at 10:24:13PM +0100, Matthias Fuchs wrote:
>> Hi,
>> 
>> some Exar UARTs like the XR16C2850 support a feature
>> called auto RS485 half-duplex control. In this mode the
>> RTS line has a special role when using the UART for 
>> RS485 communication.
>
> So I haven't maintained the serial driver for a long time, but
> when I did, I refused to try to implement hardware half-duplex
> control because there was absolutely no standards in this
> space. Which RS-232 lines are involved wasn't standardized,

Yes there are.  The standard is that RTS is asserted when one
whishes to transmit (and de-asserted when one has finished
transmitting). Optionally, one waits for CTS to be asserted
before transmitting.  Isn't that the definition of RTS and CTS
that's in the standard?

> and there was often very strange timing restrictions as well.
> Some devices required there to be a minimum delay of XX
> milliseconds between when RTS is raised and when DTR is
> raised.  Other devices have a maximum time between when one
> side raises RTS and the others side raises DTR.

I've been doing half-duplex stuff for 30 years, and I've never
seen DTR used in half-duplex flow control.

> So the challenge is designing an interface for half-duplex
> which is sufficiently general that it will actually work for
> all/most of the half-dozen people in the world who still care
> about half-ruplex RS-232 communications.  :-)

-- 
Grant Edwards                   grante             Yow! I'm in direct contact
                                  at               with many advanced fun
                               visi.com            CONCEPTS.

