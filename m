From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite - ulite_transmit
Date: Thu, 06 Jan 2011 10:49:37 +0100
Message-ID: <87mxnegy4u.fsf@macbook.be.48ers.dk>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu>
	<87vd22h3dq.fsf@macbook.be.48ers.dk> <4D257D61.2060400@monstr.eu>
	<87r5cqh0bn.fsf@macbook.be.48ers.dk> <4D25871D.2000408@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61669 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab1AFJtl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 04:49:41 -0500
Received: by wyb28 with SMTP id 28so16221590wyb.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2011 01:49:40 -0800 (PST)
In-Reply-To: <4D25871D.2000408@monstr.eu> (Michal Simek's message of "Thu, 06
	Jan 2011 10:10:53 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:

Hi,

 >> But I still don't understand why you would want to burn CPU spinning
 >> when you know the UART will be busy for a while. Leaving it alone
 >> until it generates the TX fifo empty interrupt seems more logical to
 >> me.

 Michal> I didn't know when tx fifo was full and then empty interrupt is
 Michal> generated. I have added some debug things to driver and I am going to
 Michal> look into.

 Michal> I just changed return value and I have got correct output and
 Michal> then I sent this email to check if is correct or not.

According to the spec, you should get an interrupt when RX !empty or TX
empty.

We wouldn't ever be able to send more bytes than fits in the TX fifo if
it didn't.

 >> Yeah, that loop should probably be time based (and perhaps calculated
 >> from baud rate).

 Michal> It is hard to say if you can find out any accurate number of loops
 Michal> which is baud rate dependent.

Not loops, microseconds (or rather jiffies).

-- 
Bye, Peter Korsgaard
