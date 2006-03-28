From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: 8250: Platform override of is_real_interrupt
Date: Tue, 28 Mar 2006 15:04:50 +0200
Message-ID: <87wteen2j1.fsf@sleipner.barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kuu212123311.barco.com ([212.123.3.11]:25199 "HELO
	kuuvir01.barco.com") by vger.kernel.org with SMTP id S1751247AbWC1NFC
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Mar 2006 08:05:02 -0500
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <peter.korsgaard@barco.com>)
	id 1FODsQ-0001i5-9W
	for linux-serial@vger.kernel.org; Tue, 28 Mar 2006 15:04:50 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I'm using the 8250 driver on a ML300 based PPC board which uses
interrupt vector 0 for the UART.

is_real_interrupt() unfortunately interpretes IRQ0 as meaning no
interrupt, so performance is kinda crap.

How to fix? 8250.c is setup so that asm/serial.h is included after the
definition of is_real_interrupt and the idea is that you can redefine
it in your platform header if needed. Now, this doesn't work on PPC as
the platform headers are included in asm/io.h AND asm/serial.h so they
won't be reparsed the second time.

I see 3 options:

1) Put an #ifndef is_real_interrupt around the is_real_interrupt
   definition so the platform header can define it's own independent
   of inclusion order.

2) A lot of platforms (but not all) define NO_IRQ to something
   sensible (-1). Define is_real_interrupt in terms of NO_IRQ instead
   of testing against 0. For the remaining platforms we could locally
   define NO_IRQ to 0 to keep the old behavior.

3) Put the redefine directly in asm/serial.h surrounded by an #ifdef
   CONFIG_XILINX_ML300 (ugly)

Which solution is preferable?

-- 
Bye, Peter Korsgaard
