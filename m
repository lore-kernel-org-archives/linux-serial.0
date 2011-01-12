From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite - ulite_transmit
Date: Wed, 12 Jan 2011 10:40:08 +0100
Message-ID: <87ei8izchz.fsf@macbook.be.48ers.dk>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu>
	<87vd22h3dq.fsf@macbook.be.48ers.dk> <4D257D61.2060400@monstr.eu>
	<87r5cqh0bn.fsf@macbook.be.48ers.dk> <4D25871D.2000408@monstr.eu>
	<87mxnegy4u.fsf@macbook.be.48ers.dk> <4D26C538.3010101@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53262 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab1ALJkO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Jan 2011 04:40:14 -0500
Received: by wyb28 with SMTP id 28so348999wyb.19
        for <linux-serial@vger.kernel.org>; Wed, 12 Jan 2011 01:40:13 -0800 (PST)
In-Reply-To: <4D26C538.3010101@monstr.eu> (Michal Simek's message of "Fri, 07
	Jan 2011 08:48:08 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:

Hi,

 Michal> I looked at that loop and I think that we should reread actual
 Michal> status before ulite_transmit because status reg can be changed
 Michal> when ulite_receive is executed. What do you think? (BTW: status
 Michal> reading can be moved directly to ulite_receive/transmit
 Michal> functions)

 Michal>     do {
 Michal>         int stat = ioread32be(port->membase + ULITE_STATUS);
 Michal>         busy  = ulite_receive(port, stat);
 Michal>         stat = ioread32be(port->membase + ULITE_STATUS); // check
 Michal> status again
 Michal>         busy |= ulite_transmit(port, stat);
 Michal>         n++;
 Michal>     } while (busy);

It shouldn't really matter - ulite_transmit() only looks at TXFULL, and
in the unlikely case where it was full but 1 character got transmitted
during ulite_receive, we will catch it during the 2nd iteration of the
loop (as busy will be true).

The logic was afaik more-or-less directly copied from 8250.c

 Michal> 1. Before fault happen:
 Michal> ISR is called, status is 0x18 (interrupt enabled, tx fifo full) just
 Michal> to ulite_transmit and detect TXFULL and return to ISR. Head and tail
 Michal> are correct
 Michal> 2. Broken part
 Michal> ISR is called, status is 0x14 (interrupt enabled, tx fifo empty), jump
 Michal> to ulite_transmit. Here I am printing (head and tail values are
 Michal> zero). Xmit buffer address is the same. Then uart_circ_empty(xmit)
 Michal> detects that head and tail are the same which means nothing to print.

 Michal> My question: Is there any part of the code which can change xmit head
 Michal> and tail values?

Yes, ulite_transmit does (for tail). head is only changed by the serial core.

 Michal> BTW: Getty is providing that login prompt. Could it be an issue with getty?

Maybe. Or the fact that it calls set_termios or similar. Are you unable
to reproduce the problem with other programs?

-- 
Bye, Peter Korsgaard
