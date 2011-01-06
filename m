From: Michal Simek <monstr@monstr.eu>
Subject: Re: Uartlite - ulite_transmit
Date: Thu, 06 Jan 2011 10:10:53 +0100
Message-ID: <4D25871D.2000408@monstr.eu>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu>	<87vd22h3dq.fsf@macbook.be.48ers.dk> <4D257D61.2060400@monstr.eu> <87r5cqh0bn.fsf@macbook.be.48ers.dk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42223 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1AFJK5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 04:10:57 -0500
Received: by fxm20 with SMTP id 20so15835753fxm.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2011 01:10:56 -0800 (PST)
In-Reply-To: <87r5cqh0bn.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:
> 
> Hi,
> 
>  >> That would make us spin in the interrupt for potentially quite a
>  >> while, E.G. until all data is transferred to the TX fifo.
> 
>  Michal> yep. That's truth but shouldn't be a problem for standard
>  Michal> systems. Maybe worth to count how many times is tx fifo full on
>  Michal> standard systems.
> 
> But I still don't understand why you would want to burn CPU spinning
> when you know the UART will be busy for a while. Leaving it alone until
> it generates the TX fifo empty interrupt seems more logical to me.

I didn't know when tx fifo was full and then empty interrupt is 
generated. I have added some debug things to driver and I am going to 
look into.

I just changed return value and I have got correct output and then I 
sent this email to check if is correct or not.


> 
>  >> What kind of problem are you trying to fix in the first place? You
>  >> should get an interrupt when the TX fifo empties, which fill completely
>  >> fill up the fifo again and so on - That should work just fine even with
>  >> a low baud rate.
> 
>  Michal> I am trying to solve the problem for xilinx mdm IP (compatible
>  Michal> with uartlite) where there are some missing characters on
>  Michal> serial console.
> 
> Strange. It's been a few years since I worked with Xilinx stuff and
> never used microblaze, so I don't know anything about MDM.

It is console over jtag. Just different connection.

> 
>  Michal> Maybe there is something wrong in different place but there are
>  Michal> definitely missing characters.
> 
>  Michal> Just for the record: I also have to extend for loop in
>  Michal> ulite_console_wait_tx to get all chars for console.
> 
> Yeah, that loop should probably be time based (and perhaps calculated
> from baud rate).

It is hard to say if you can find out any accurate number of loops which 
is baud rate dependent.

Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
