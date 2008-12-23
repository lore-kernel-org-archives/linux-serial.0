From: Christopher Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with
	some Exar UARTs
Date: Wed, 24 Dec 2008 01:03:32 +1100
Message-ID: <1230041012.17555.85.camel@thetriton.toftronix.com.au>
References: <200812190048.35249.mfuchs@ma-fu.de>
	 <200812191613.29657.laurentp@cse-semaphore.com>
	 <1229853004.3216.14.camel@thewinkle.toftronix.com.au>
	 <20081222155956.GA13526@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:38141 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750997AbYLWNwO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Dec 2008 08:52:14 -0500
In-Reply-To: <20081222155956.GA13526@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>, Matthias Fuchs <mfuchs@ma-fu.de>, linux-serial@vger.kernel.org

On Mon, 2008-12-22 at 16:59 +0100, Wolfram Sang wrote:
> Hello Chris,
> 
> On Sun, Dec 21, 2008 at 08:50:04PM +1100, Chris Gibson wrote:
> > Two and a half weeks ago I submitted a patch to implement RS485 auto
> > direction control on either (or both) the RTS and the DTR lines with
> > varying pre and post delay settings that would work for _all_ uarts that
> > support mctrl.
> 
> Just observing the case, I assume that this concern about software RS485
> is still valid:
> 
> http://article.gmane.org/gmane.linux.serial/2568

Thank you for the reply.

In answer to the above thread - the implementation in the patch I
provided addresses some of the concerned mentioned.  The polling of the
shift empty register is done with a timer, so the loss of CPU time is
minimal.  The ioctl's provide a mechanism for which the driver
turnaround delay, and jitter can be established, allowing a user
application the ability to determine the suitability of a particular
direction control implementation to fulfil its timing requirements.

The short fall of the implementation is that it's timing is only as good
as the Linux system timer.  This is less of a limitation with the latter
kernels with higher speed system timers.

My main concern though is not whether or not this software
implementation of auto direction control is adopted into the kernel,
(though I guess I would feel proud if it was :) but rather that the
ioctl that has gone into V2.6.28-rc1 is only part way toward what it
should be, and this is starting to be used already.

best regards
-- 
Christopher Gibson <chris@toftronix.com.au>

