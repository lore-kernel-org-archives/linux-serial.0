From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Wed, 04 Oct 2006 17:34:25 +0200
Message-ID: <87lknwksce.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk> <451BA096.9050209@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from astra.telenet-ops.be ([195.130.132.58]:32421 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1161243AbWJDPer (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Oct 2006 11:34:47 -0400
In-Reply-To: <451BA096.9050209@dlasys.net> (David H. Lynch, Jr.'s message of
	"Thu, 28 Sep 2006 06:14:46 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linux-serial@vger.kernel.org

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Sorry for the delay, I've been ill..

 David>    There is more than one UartLite driver. I have one from someone
 David> else that includes DCR support.
 David>    I wrote one that includes early boot console support - which is
 David> fairly trivial.

Yes, I know (after writing mine). That's why getting the driver
mainline is important, otherwise people will keep on reinventing the
wheel..

 David>    I will try to separate out my early boot console patches - would
 David> this be the appropriate place to post them ?

Yes, presumably once the base driver goes in.

 David>   I beleive my driver is the one Peter  believes is broken.

Me? I don't even think I ever tried your driver..

 David>       I can't quite understand why one would build a Xilinx FPGA with both.

We have done it several times. 16550s for when you need full
functionality (changeable baudrate, control lines, ..) and uartlites
for dedicated links.

 David>    If Peter's driver is likely to get accepted I have all of the
 David> platform device code done for my own driver I can move it to his.
 David>    I did a BSP for the Pico E12/E14, they use either UartLite out of
 David> the box, or a pseudo serial device they call the Keyhole
 David>    that can be used if the E12/E14 are hosted (they are CF/Cardbus
 David> cards respectively)

Ok, but where would you add it? The ML300/403 boards are afaik the
only ones in mainline.

-- 
Bye, Peter Korsgaard
