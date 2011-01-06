From: Michal Simek <monstr@monstr.eu>
Subject: Re: Uartlite - ulite_transmit
Date: Thu, 06 Jan 2011 09:29:21 +0100
Message-ID: <4D257D61.2060400@monstr.eu>
References: <4D2465E0.2000707@monstr.eu> <4D246672.3070002@monstr.eu> <87vd22h3dq.fsf@macbook.be.48ers.dk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47309 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1AFI3g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 03:29:36 -0500
Received: by fxm20 with SMTP id 20so15814622fxm.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2011 00:29:34 -0800 (PST)
In-Reply-To: <87vd22h3dq.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "Michal" == Michal Simek <monstr@monstr.eu> writes:
> 
>  Michal> Hi Peter, [cc: Grant]
>  Michal> I have found one thing which I would like to check with you.
>  Michal> It is about mdm console which is uartlite compatible but it is slow.
>  Michal> The problem which I think it is there is in ulite_transmit function if
>  Michal> TXFULL is reported then it was returned 0. ulite_transmit is called from
>  Michal> do-while loop in ulite_isr (shown below).
> 
>  Michal>     do {
>  Michal>         int stat = readb(port->membase + ULITE_STATUS);
>  Michal>         busy  = ulite_receive(port, stat);
>  Michal>         busy |= ulite_transmit(port, stat);
>  Michal>     } while (busy);
> 
>  Michal> If tx is full then loop ends but there could be a lot of characters
>  Michal> which need to be send that's why will be good to wait a little bit. I
>  Michal> think it could be done by returning 1 in that case.
> 
>  Michal> What do you think? Patch is below.
> 
> That would make us spin in the interrupt for potentially quite a while,
> E.G. until all data is transferred to the TX fifo.

yep. That's truth but shouldn't be a problem for standard systems. Maybe 
worth to count how many times is tx fifo full on standard systems.

> 
> What kind of problem are you trying to fix in the first place? You
> should get an interrupt when the TX fifo empties, which fill completely
> fill up the fifo again and so on - That should work just fine even with
> a low baud rate.

I am trying to solve the problem for xilinx mdm IP (compatible with 
uartlite) where there are some missing characters on serial console.

Maybe there is something wrong in different place but there are 
definitely missing characters.

Just for the record: I also have to extend for loop in 
ulite_console_wait_tx to get all chars for console.

Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
