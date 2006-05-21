From: Mikhail Kolesnik <mike@openbunker.org>
Subject: Re: Oxford Semiconductor's OXCB950 in 8250_pci.c
Date: Sun, 21 May 2006 13:20:35 +0300
Message-ID: <20060521132035.1bec058c@mike.staff.sky>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from silver.biz.ua ([80.68.246.128]:25502 "EHLO silver.biz.ua")
	by vger.kernel.org with ESMTP id S1751505AbWEUKTY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 May 2006 06:19:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk

On Wed, 10 May 2006 20:20:49 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> > > This should probably be pbn_b0_1_115200?
> > 
> > The reason was (from the discussion mentioned):
> > > pbn_b0_bt_1_115200 has been used instead
> > > of pbn_b0_1_115200, because the latter is identical to
> > > pbn_default, and the effect should be the same since
> > > OXCB950 is single-port. 
> > 
> > Seems it is not the problem here (as card partially works). Or should I
> > try changing it?
> 
> The reason given there is no longer valid, and is just a preference.
Changed.
 
> What happens if you:
> 
> 1. setserial /dev/ttyS4 spd_cust divisor 104
> 2. set the baud rate to 38400 baud
I got 9600!

> If what I think has happened is correct, 104 should approximate 9600 baud,
> 52 should approximate 19200 baud, 26 should be 38400 baud, and 17 should
> approximate 57600 baud.
Yes, all this is correct, 'CONNECT...' string is the same as in MS Win.
Thanks!

What should be done to avoid such tricks in userspace and how to get
full 'divisor <-> result rate' list?

> It would be helpful if you could confirm that the modem does report the
> real DTE data rate under Windows.
Results:
 'Port set to'  'Modem Reports on connect (first is DTE rate)'
  300            CONNECT 230400/V34/LAPM/V42B/TX=28800/RX=31200
  1200           CONNECT 230400/V34/LAPM/V42B/TX=28800/RX=31200
  2400           CONNECT 230400/V34/LAPM/V42B/TX=28800/RX=31200
  4800           CONNECT 4800/V34/LAPM/V42B/TX=4800/RX=4800
  9600           CONNECT 9600/V34/LAPM/V42B/TX=9600/RX=9600
  19200          CONNECT 19200/V34/LAPM/V42B/TX=19200/RX=19200
  38400          CONNECT 38400/V34/LAPM/V42B/TX=28800/RX=31200
  57600          CONNECT 57600/V34/LAPM/V42B/TX=28800/RX=31200
  115200         CONNECT 115200/V34/LAPM/V42B/TX=28800/RX=31200
It seems to be real from 4800 to 115200 (with the same serial card).
On speeds lower than 4800 it looks odd as I can not talk to modem on
such speed.


-- 
Mikhail Kolesnik
ICQ: 260259143
IRC: mike_k at freenode/#crux, rusnet/#yalta
Jabber: mike_k@jabber.lafox.net
NIC handle: MKK83-UANIC
