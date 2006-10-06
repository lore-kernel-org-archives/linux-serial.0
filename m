From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 06 Oct 2006 00:14:36 -0400
Message-ID: <4525D82C.7090200@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com> <878xlgercm.fsf@slug.be.48ers.dk> <20060912093301.77f75bfb@localhost.localdomain> <87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk> <20060913100110.1e33d885@localhost.localdomain> <451CDA3D.2060109@dlasys.net> <87hcykkrzu.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:60121
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP
	id S1751774AbWJFESq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 00:18:46 -0400
Received: from l-dhlii.dlasys.net ([206.223.20.247]:1235)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GVh1A-0001az-Rw by authid <dhlii> with plain_server
	for <linux-serial@vger.kernel.org>; Fri, 06 Oct 2006 00:09:00 -0400
In-Reply-To: <87hcykkrzu.fsf@slug.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> Hi,
>
>  David>     You force the port regshift value to 2 in your init code,
>  David> but then you ignore it and hard code the register offsets
>  David> preshifted.
>
> Yes, the regshift value is not used by the driver, I just kept the
> initialization as documentation. The Xilinx IP block afaik cannot be
> configured with a different regshift value than 2, so I hardcoded
> it.
>
> We can change that if it would ever be a problem, but there's
> unfortunately no clean way of representing this in the
> device/ressource data, so I would prefer to leave that out unless it's
> needed.
>   
    That is actually one of my more major issues. I am NOT the right 
person to speak for what direction things are going.
    But the majority of drivers - platform device based or otherwise, 
pass arround a uart_port structure with the irq, addresses, etc.
    the uart_port struct has provisions for a regshift - as well as 
other things.

    DCR is another issue. I have never personally seen a UartLite DCR 
implimentation, but I have a driver from somebody else that started from 
mine, that assumes
    DCR instead of memory mapped ports. I think the Xilinx Gigabit 
Reference System Design connects the UartLite via DCR.
   
    I think DCR has to be a consideration. I do not KNOW that there is a 
UartLite implimentation with a regshift other than 2.
    But I have seen occasional code that uses different values - The 
GreenHills Integrity UartLite driver
    has it as a configurable parameter.

     If your driver is going to become the officail UartLite driver, 
even if it does not already work with every UartLite implimentation, it 
still should not start with assumptions that
    are going to make supporting others difficult.
   
  




>  David> Also there is no provision for running the UartLite without
>  David> using interrupts.  The Pico E12/E14 frequently use FPGA
>  David> firmare that does not include a PIC.  Some implimentations of
>  David> the UartLite use dcr instead of memory mapped ports.
>    
> No - again like the early serial stuff that's something that can be
> added once the base driver is mainlined if there's demand.
>
> Does polling even work decently with the small fifo size of the
> uartlite?
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

