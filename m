From: Alexandre Courbot <Alexandre.Courbot@lifl.fr>
Subject: Re: Disabling the FIFO on the UART - Bug in 8250 mode?
Date: Mon, 14 Jun 2004 15:43:49 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <40CDAB95.1020706@lifl.fr>
References: <40CDA6BD.2020606@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:64453 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S263019AbUFNNpo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jun 2004 09:45:44 -0400
Received: from malonne.lifl.fr (malonne.lifl.fr [134.206.10.29])
          by reserv6.univ-lille1.fr (8.12.11/jtpda-5.3.1) with ESMTP id i5EDje0q024458
          for <linux-serial@vger.kernel.org>; Mon, 14 Jun 2004 15:45:40 +0200
Received: from lifl.fr (helios.lifl.fr [134.206.10.253])
          by malonne.lifl.fr  with ESMTP id i5EDjhV03795
          for <linux-serial@vger.kernel.org>; Mon, 14 Jun 2004 15:45:43 +0200 (MEST)
In-Reply-To: <40CDA6BD.2020606@lifl.fr>
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org


> So I tried doing so (setserial /dev/ttyS0 uart 8250), and that's where 
> the weird things start. My device then only receives one byte on 16 
> (i.e. the latest to enter the FIFO when the serial interrupt is 
> triggered!). It is clearly stated that a 8250 uart does not have any 
> FIFO, so I'm starting to suspect a bug here. I've tested on two Linux 
> x86 machines, runnning kernels 2.6.3 and 2.6.6, the behavior is the 
> same. I've also tried with UARTs16550 and 16450.

Sorry for replying to myself - just to point out that with kernel 
2.4.25, on the same machines, it behaves properly (i.e. I'm receiving 
all the bytes). So it looks like there is a bug in the 2.6 series of the 
serial driver, not disabling the FIFO when setting the 8250 mode.

Would still be nice if it was possible to explicitely disable or tune 
the 16550A's FIFO with, say, setserial! :)

Alex.
-- 
Alexandre Courbot - PhD student
RD2P/LIFL
http://www.lifl.fr/~courbot
