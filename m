From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Fri, 29 Sep 2006 15:57:51 -0400
Message-ID: <451D7ABF.1010103@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com>	<878xlgercm.fsf@slug.be.48ers.dk>	<20060912093301.77f75bfb@localhost.localdomain>	<87ejugxqbw.fsf@slug.be.48ers.dk>	<871wqfyjgi.fsf@slug.be.48ers.dk> <20060913100110.1e33d885@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:6354 "EHLO
	mx.dlasys.net") by vger.kernel.org with ESMTP id S1422710AbWI2UDF
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Sep 2006 16:03:05 -0400
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
	I am trying to switch from my driver to yours - as it appears yours is
on the way to getting accepted.
	
	I have been dropping my issues/comments as I go onto the list as I
encounter problems.


	You need an "early_serial_setup()" routine inside the
CONFIG_SERIAL_UARTLITE_CONSOLE code.


#if defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
int __init
early_serial_setup(struct uart_port *port)
{
	
	if (port->line >= ARRAY_SIZE(ulite_ports))
		return -ENODEV;

	ulite_init_ports();
	ulite_ports[port->line].port	= *port;
	ulite_ports[port->line].port.ops	= &ulite_pops;
	return 0;
}
#endif

ulite_init_ports() loops through all the ports in ulite_ports and sets
up the port data - similiar to your code in ulite_probe().




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


