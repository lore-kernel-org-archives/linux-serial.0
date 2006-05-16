From: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 16 May 2006 15:03:41 +0200
Message-ID: <4469CDAD.20506@246tNt.com>
References: <87ac9o3ak3.fsf@sleipner.barco.com> <20060511222001.GC28693@flint.arm.linux.org.uk> <87slnapagf.fsf@LKG7F3A44.lan> <20060516125329.GE15481@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outmx026.isp.belgacom.be ([195.238.4.91]:9927 "EHLO
	outmx026.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751020AbWEPNEd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 May 2006 09:04:33 -0400
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
        by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k4GD4Mh0001694
        for <linux-serial@vger.kernel.org>; Tue, 16 May 2006 15:04:26 +0200
        (envelope-from <tnt@246tNt.com>)
In-Reply-To: <20060516125329.GE15481@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-serial@vger.kernel.org

Russell King wrote:
> On Tue, May 16, 2006 at 11:48:00AM +0200, Peter Korsgaard wrote:
>   
>>>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:
>>>>>>>               
>> Hi,
>>
>> Sorry for the slow reply, I've been away all weekend...
>>
>>  >> Comments and suggestions are welcome. I'm especially wondering about
>>  >> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
>>  >> driver ..
>>
>>  Russell> That's for the mpc52xx folk to comment about.  I personally
>>  Russel>  don't like> it.
>>
>> What do you say Sylvain? Reusing device nodes seems pretty common
>> (pxa.c, at91_serial.c, ..), and I cannot imagine anyone making a
>> system with uartlite and mpc52xx UARTs ..
>>     
>
> Actually they're wishing they hadn't because they can't interoperate
> with standard 16550-based ports without resorting to nasty hacks.
> As such they're _both_ transitioning away from using the major 4
> space.
>   
Yes, I confirm that using the major 4 space is really a bad idea. The
mpc52xx driver
did this, up until the point of people reported very annoying problems
when pcmcia
serial card were presents ;)

I guess the point is : Yes obtaining official minors is not that fast
(depends on 1 guy
apparently and he's busy ;) but it will save you troubles later.


    Sylvain
