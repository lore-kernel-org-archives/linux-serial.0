From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 06 Oct 2006 00:14:57 -0400
Message-ID: <4525D841.4080900@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com> <878xlgercm.fsf@slug.be.48ers.dk> <20060912093301.77f75bfb@localhost.localdomain> <87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk> <20060913100110.1e33d885@localhost.localdomain> <451D7ABF.1010103@dlasys.net> <87d598krti.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:61913
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP
	id S1751777AbWJFESw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Oct 2006 00:18:52 -0400
Received: from l-dhlii.dlasys.net ([206.223.20.247]:1236)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1GVh1W-0001bV-75 by authid <dhlii> with plain_server
	for <linux-serial@vger.kernel.org>; Fri, 06 Oct 2006 00:09:22 -0400
In-Reply-To: <87d598krti.fsf@slug.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> Hi,
>
>  David> 	You need an "early_serial_setup()" routine inside the
>  David> CONFIG_SERIAL_UARTLITE_CONSOLE code.
>
> Isn't that just for early serial support?
>
>   
    Honestly,  I can not tell. It is implimented in 8250.c, and I think 
some other drivers. I think it was  related to early_serial. But I think 
that is now moved into the main driver, not a separate early_serial driver.
    I stubbed it out to nothing just to make the linker happy and 
noticed no obvious difference in behavior. But due to printk buffering, 
it might be very hard to see a difference - unless there was an early 
failure.

    What I know is that:
                 the ml403 8250 support (as well as many other drivers), 
impliment it
                 that they pass a uart_port structure
                 and that it may be called for each port,
               
    I beleive that it may be more important than the uartlite_tty.c and 
uartlite_dbg.c that get used very breifly by much earlier code.
    But I am just guessing.
   
    I know that my driver impliments it and as a result I usually see 
messages up to the moment of failure when there is a failure, and do not 
get into a bind because they are stuck in a printk buffer.




 





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

