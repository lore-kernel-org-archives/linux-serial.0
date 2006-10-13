From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 13 Oct 2006 10:12:04 -0400
Message-ID: <452F9EB4.3060801@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:35482
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP
	id S1750725AbWJMOOi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Oct 2006 10:14:38 -0400
Received: from l-dhlii.dlasys.net ([206.223.20.247]:3710)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GYNfw-0002KZ-Pn by authid <dhlii> with plain_server
	for <linux-serial@vger.kernel.org>; Fri, 13 Oct 2006 10:06:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> Hi,
>
>
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
     I do not care about DCR,  but as the responsible party for the only
board I am aware of that does use the uartlite as its
     primary serial device, which typically does not have interrupt
support, that is something I care about alot.

     You can poll a serial port on an 8080 running 1Mhz with a serial
port with no fifo.
     16 bytes on a 300Mhz PPC is heaven. Works fine at 115K baud.



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too 
numerous to list.

"Any intelligent fool can make things bigger and more complex... It 
takes a touch of genius - and a lot of courage to move in the opposite 
direction."
Albert Einstein
