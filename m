From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite - ulite_transmit
Date: Thu, 06 Jan 2011 10:02:20 +0100
Message-ID: <87r5cqh0bn.fsf@macbook.be.48ers.dk>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu>
	<87vd22h3dq.fsf@macbook.be.48ers.dk> <4D257D61.2060400@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37662 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab1AFJC0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 04:02:26 -0500
Received: by wyb28 with SMTP id 28so16191549wyb.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2011 01:02:25 -0800 (PST)
In-Reply-To: <4D257D61.2060400@monstr.eu> (Michal Simek's message of "Thu, 06
	Jan 2011 09:29:21 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:

Hi,

 >> That would make us spin in the interrupt for potentially quite a
 >> while, E.G. until all data is transferred to the TX fifo.

 Michal> yep. That's truth but shouldn't be a problem for standard
 Michal> systems. Maybe worth to count how many times is tx fifo full on
 Michal> standard systems.

But I still don't understand why you would want to burn CPU spinning
when you know the UART will be busy for a while. Leaving it alone until
it generates the TX fifo empty interrupt seems more logical to me.

 >> What kind of problem are you trying to fix in the first place? You
 >> should get an interrupt when the TX fifo empties, which fill completely
 >> fill up the fifo again and so on - That should work just fine even with
 >> a low baud rate.

 Michal> I am trying to solve the problem for xilinx mdm IP (compatible
 Michal> with uartlite) where there are some missing characters on
 Michal> serial console.

Strange. It's been a few years since I worked with Xilinx stuff and
never used microblaze, so I don't know anything about MDM.

 Michal> Maybe there is something wrong in different place but there are
 Michal> definitely missing characters.

 Michal> Just for the record: I also have to extend for loop in
 Michal> ulite_console_wait_tx to get all chars for console.

Yeah, that loop should probably be time based (and perhaps calculated
from baud rate).

-- 
Bye, Peter Korsgaard
