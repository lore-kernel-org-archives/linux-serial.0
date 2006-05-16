From: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 16 May 2006 14:09:04 +0200
Message-ID: <4469C0E0.3030009@246tNt.com>
References: <87ac9o3ak3.fsf@sleipner.barco.com>	<20060511222001.GC28693@flint.arm.linux.org.uk> <87slnapagf.fsf@LKG7F3A44.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:2432 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750929AbWEPMJr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 May 2006 08:09:47 -0400
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
        by outmx018.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k4GC9fFD015231
        for <linux-serial@vger.kernel.org>; Tue, 16 May 2006 14:09:42 +0200
        (envelope-from <tnt@246tNt.com>)
In-Reply-To: <87slnapagf.fsf@LKG7F3A44.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org

Peter Korsgaard wrote:
> Hi,
>
> Sorry for the slow reply, I've been away all weekend...
>
>  >> Comments and suggestions are welcome. I'm especially wondering about
>  >> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
>  >> driver ..
>
>  Russell> That's for the mpc52xx folk to comment about.  I personally
>  Russel>  don't like> it.
>
> What do you say Sylvain? Reusing device nodes seems pretty common
> (pxa.c, at91_serial.c, ..), and I cannot imagine anyone making a
> system with uartlite and mpc52xx UARTs ..
>   

It's true that both devices are never gonna be used together (who
would want to implement a mpc5200 in a fpga ? ;), and personally I don't
really care if you reuse them as it's never gonna create any functional
problems.

The issue is more a "style" issue and if the maintainers allows you to
do that
(even if he doesn't like it ;), then it's fine by me. It's true that it
took me almost
2 month to get official ids ...


    Sylvain
