From: Jeff DeFouw <jeffd@i2k.com>
Subject: 8250 misses interrupt, stalls
Date: Fri, 8 Aug 2008 01:27:27 -0400
Message-ID: <20080808052727.GB23330@blorp.plorb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:46993
	"EHLO QMTA03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614AbYHHF13 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Aug 2008 01:27:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by blorp.plorb.com (Postfix) with ESMTP id 9DA3A16DD98
	for <linux-serial@vger.kernel.org>; Fri,  8 Aug 2008 01:27:27 -0400 (EDT)
Received: from blorp.plorb.com ([127.0.0.1])
	by localhost (blorp.plorb.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IuyEJigZUSo2 for <linux-serial@vger.kernel.org>;
	Fri,  8 Aug 2008 01:27:27 -0400 (EDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I have a Celeron ETX processor module with a Winbond W83627HF SuperIO 
chip, providing two 16550A compatible UARTs, which connects over LPC to 
an 82801DB south bridge.  I'm only using the first serial port at the 
moment.  The modules 8250 and 8250_pnp are loaded, and the serial port 
is on standard resources (irq 4).  After one of my complex applications 
at work runs for a few minutes, the serial port suddenly stops.  The 
UART IIR indicates an interrupt is pending, and the LSR indicates data 
is waiting to be received (as well as sent), but the interrupt handler 
is not being called.  If while it's stuck I reset the enabled interrupts 
(save IER, clear IER, restore IER) the I/O resumes.  I don't see 
anything wrong with the way the UART is being serviced.  The kernel is 
patched to 2.6.25.11, configured by Debian as SMP, no PREEMPT, shared 
IRQ (nothing else is on irq 4) and without any external modules loaded.  
It's a Celeron without any HT or multiple cores, so it's uniprocessor.  
I haven't been able to make a simple test case.  The real program is 
kind of a loopback that's continuously receiving and sending data at 
115200 8N1 with no flow control.  The full data rate isn't being used, 
and I'm not getting any overruns (until it stalls).  A simple loopback 
program doesn't demonstrate the problem, but the real application runs 
into it every time within 10 minutes (usually under 5).

-- 
Jeff DeFouw <jeffd@i2k.com>
