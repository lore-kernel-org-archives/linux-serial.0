From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Thu, 28 Sep 2006 06:14:46 -0400
Message-ID: <451BA096.9050209@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com>	<878xlgercm.fsf@slug.be.48ers.dk>	<20060912093301.77f75bfb@localhost.localdomain> <87ejugxqbw.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:17291
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP id S965293AbWI1KRz
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Sep 2006 06:17:55 -0400
Received: from l-dhlii.dlasys.net ([206.223.20.247]:1729)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GSspg-0005bY-MJ by authid <dhlii> with plain_server
	for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2006 06:09:32 -0400
In-Reply-To: <87ejugxqbw.fsf@slug.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>
>  Olof> 1. There's no early boot console support for PPC. There's another
>  Olof> uartlite patch that's floating around that has this, very useful for
>  Olof> early bringup tasks. I'd like to see this expanded to include that as
>  Olof> well (the regular part of the other driver seems more or less broken
>  Olof> though, so this is a better base driver). That shouldn't stop this part
>  Olof> of the driver to go in though, just possible future work.
>   
    There is more than one UartLite driver. I have one from someone else 
that includes DCR support.
    I wrote one that includes early boot console support - which is 
fairly trivial.
    I will try to separate out my early boot console patches - would 
this be the appropriate place to post them ?
   I beleive my driver is the one Peter  believes is broken.
> True. The board I have an uartlite on also has a 8250 so it hasn't
> been an issue for me so far - But it would indeed be a nice
> addition. Adding new stuff to arch/ppc at this moment isn't that
> sensible, so perhaps it makes most sense to wait til 4xx is supported
> under arch/powerpc?
>   
       I can't quite understand why one would build a Xilinx FPGA with both.

>
>  Olof> 3. It would be useful to demonstrate how to hook up the device all the
>  Olof> way through to the board port (i.e. add a config option and include it
>  Olof> in the ml403 platform code or similar). It's not hard, but it'd make it
>  Olof> easier for whomever comes next. Of course, with 4xx hopefully soon
>  Olof> moving over to arch/powerpc, this would be taken care of through the
>  Olof> device tree instead.
>
> Yes - Afaik none of the Xilinx boards comes with uartlites
> configured so it's not usable out-of-the-box, but you can ofcause do a
> setup with the proper #ifdefs like the 8250 stuff in virtex.c.
>   
    If Peter's driver is likely to get accepted I have all of the 
platform device code done for my own driver I can move it to his.
    I did a BSP for the Pico E12/E14, they use either UartLite out of 
the box, or a pseudo serial device they call the Keyhole
    that can be used if the E12/E14 are hosted (they are CF/Cardbus 
cards respectively)



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

