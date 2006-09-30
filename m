From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Sat, 30 Sep 2006 05:25:31 -0400
Message-ID: <451E380B.5000401@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com>	<878xlgercm.fsf@slug.be.48ers.dk>	<20060912093301.77f75bfb@localhost.localdomain>	<87ejugxqbw.fsf@slug.be.48ers.dk>	<871wqfyjgi.fsf@slug.be.48ers.dk> <20060913100110.1e33d885@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:34446
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP
	id S1751191AbWI3J2J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 30 Sep 2006 05:28:09 -0400
In-Reply-To: <20060913100110.1e33d885@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, jacmet@sunsite.dk

Olof Johansson wrote:
> On Wed, 13 Sep 2006 15:39:09 +0200 Peter Korsgaard <jacmet@sunsite.dk> wrote:
>
>   
>>>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
>>>>>>>               
>>  Olof> 2. There seems to be some timeout issues with tx_empty.
>>
>>  Peter> Huh, that's odd - I haven't noticed that. I'll test it again and get
>>  Peter> back to you.
>>
>> Ahh, found it - I didn't update the uart timeout in set_termios so it
>> used a very long timeout. Please give the updated patch a try.
>>     
>
> Looks good. Thanks.
>   

Peter;
	
	I have been working to move from my UartLite driver to yours.

	Aside from the missing early_serial_setup() routine which was fairly
easy to add, as well as adding a timer to poll IO to keep things working
if there was no UartLite interrupt, I have encounter a few other issues.

	Your ulite_console_write performance is pretty slow - almost an order
of magnitude slower than what I am seeing in my driver. I beleive it is
because you are waiting for the Tx FIFO to be empty before and after
sending each character rather than only waiting while the Tx FIFO is full.

	That may also be an issue in the rest of the driver but I have been
unable to get it to through registering the driver.
	I suspect that is because your driver is a platform driver, but you did
not provide patches to the arch/ppc/platforms/4xx/virtex.* or
xilinx_ml???.* to setup the platform device structure.
	If you could provide a copy I would appreciate it.
	
	



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



