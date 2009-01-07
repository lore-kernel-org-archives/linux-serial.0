From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with
	some Exar UARTs
Date: Thu, 08 Jan 2009 00:42:15 +1100
Message-ID: <1231335735.29906.37.camel@thetriton.toftronix.com.au>
References: <200812190048.35249.mfuchs@ma-fu.de>
	 <200812221902.27752.mfuchs@ma-fu.de>
	 <1230038587.17555.68.camel@thetriton.toftronix.com.au>
	 <200901021629.38459.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:35581 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751477AbZAGNcb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Jan 2009 08:32:31 -0500
In-Reply-To: <200901021629.38459.mfuchs@ma-fu.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-serial@vger.kernel.org, Laurent Pinchart <laurentp@cse-semaphore.com>

Thanks for the reply.

On Fri, 2009-01-02 at 16:29 +0100, Matthias Fuchs wrote:
> Hi Christopher,
> 
> I checked all your referenced threads. Here is my summary:
> 
> 1) RS485 seems to be an issue for several people.
> 2) enabling hardware RS485 via ioct is never totally dismissed.
> 3) Discussion about software direction control will never end.
> 

Fair points.

I was considering the possibility of combining both a software and
hardware combination such that software would provide for pre-and post
delays if the required delays were outside the abilities of the
hardware.  Am yet to create an implementation of this though, and I'm
still pondering on how to cleanly communicate the abilities between the
general serial-core and the lower level hardware interface.

> 
> 
> So I suggest not to mix hardware and software direction control
> as the same issue. When the hardware supports direction control
> we should implement it as ioctl.
> 
> Even this sounds a little bit egoistic, it might bring us a little forward.
> 

I fully support this.  I may, if I get my act together, use your patch
as a basis for demonstrating a software/hardware combination (but don't
hold your breath!).

Christopher Gibson



