From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite - ulite_transmit
Date: Thu, 06 Jan 2011 08:56:17 +0100
Message-ID: <87vd22h3dq.fsf@macbook.be.48ers.dk>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42711 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1AFH5D (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 02:57:03 -0500
Received: by wwa36 with SMTP id 36so17159325wwa.1
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2011 23:57:01 -0800 (PST)
In-Reply-To: <4D246672.3070002@monstr.eu> (Michal Simek's message of "Wed, 05
	Jan 2011 13:39:14 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:

 Michal> Hi Peter, [cc: Grant]
 Michal> I have found one thing which I would like to check with you.
 Michal> It is about mdm console which is uartlite compatible but it is slow.
 Michal> The problem which I think it is there is in ulite_transmit function if
 Michal> TXFULL is reported then it was returned 0. ulite_transmit is called from
 Michal> do-while loop in ulite_isr (shown below).

 Michal>     do {
 Michal>         int stat = readb(port->membase + ULITE_STATUS);
 Michal>         busy  = ulite_receive(port, stat);
 Michal>         busy |= ulite_transmit(port, stat);
 Michal>     } while (busy);

 Michal> If tx is full then loop ends but there could be a lot of characters
 Michal> which need to be send that's why will be good to wait a little bit. I
 Michal> think it could be done by returning 1 in that case.

 Michal> What do you think? Patch is below.

That would make us spin in the interrupt for potentially quite a while,
E.G. until all data is transferred to the TX fifo.

What kind of problem are you trying to fix in the first place? You
should get an interrupt when the TX fifo empties, which fill completely
fill up the fifo again and so on - That should work just fine even with
a low baud rate.

-- 
Bye, Peter Korsgaard
