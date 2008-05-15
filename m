From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Uartlite driver & CONFIG_CONSOLE_POLL
Date: Thu, 15 May 2008 10:45:36 -0400
Message-ID: <482C4C90.8060606@dlasys.net>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost> <fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com> <4827E073.9020301@seznam.cz>
Reply-To: dhlii@dlasys.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outbound-mail-101.bluehost.com ([69.89.22.11]:36379 "HELO
	outbound-mail-101.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754446AbYEOOwh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 May 2008 10:52:37 -0400
In-Reply-To: <4827E073.9020301@seznam.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@seznam.cz
Cc: Grant Likely <grant.likely@secretlab.ca>, John Williams <john.williams@petalogix.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

    One of the key differences between my uartlite driver and Peter's
is that like many other serial drivers I have a timer to support irqless
use. Just like Peter has UartLite Like devices with 16bit datapaths,
I have UartLites with no interrupts.

   I have tried (unsuccessfully) several times to migrate my timer
code into Peter's driver. This is probably the most fundimental
remaining reason I can not use Peter's driver.

    More recently I noticed a CONFIG_CONSOLE_POLL option show
up. There are remarks that this is similar to NETPOLL - though
it seems to be implimented using a getc and putc rather than a
poll entry.

    Is this a general serial facility, rather than just for consoles ?
    If I create the polled getc/putc routines can I expect a serial driver
to be functional without having to implement  my own  timer based
polling ?
   
    Is this the proper way to do this ?





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

