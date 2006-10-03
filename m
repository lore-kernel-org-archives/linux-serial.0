From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 03 Oct 2006 06:27:06 -0400
Message-ID: <45223AFA.5080502@dlasys.net>
References: <87ac9o3ak3.fsf@sleipner.barco.com>	<878xlgercm.fsf@slug.be.48ers.dk>	<20060912093301.77f75bfb@localhost.localdomain>	<87ejugxqbw.fsf@slug.be.48ers.dk>	<871wqfyjgi.fsf@slug.be.48ers.dk> <20060913100110.1e33d885@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:33420
	"EHLO mx.dlasys.net") by vger.kernel.org with ESMTP id S964873AbWJCK23
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Oct 2006 06:28:29 -0400
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

	I spent the better part of the past 4 days trying to move to your driver.
	
	The ulite_console_write() performance issue seems to be related to
using uart_console_write() to output the string. I can recreate the
problem - though not quite as bad, in my own driver by using that
instead of a simple internal puts(). It is possible that some paramater
or something needs tweeked somewhere to make uart_console_write()
perform better. That is beyond my current knowledge. I would hope there
is something because it appears serial console drivers are to be using
uart_console_write(), and I have seen tty's run faster than what I get
with it.

	I am supporting the Pico E series of boards. They frequently do not
have a PIC and therefor no serial interupts. Your driver does not have
any support for running polled, and adding working polling was less than
trivial. That is critical for my environment.

	I was having sufficient problems, I reverted to your base driver
without any of my own patches and tried to get it working using an E12
with interrupt support.
	Once your driver switched from the ulite_console output to fully up and
interrupt driven, it started dropping characters all over.
	I was never able to get any permutation of your driver to accept input.
	The missing early_serial_setup(struct uart_port*) routine I mentioned
earlier, seems to be somewhat less critical than I thought.
providing a completely empty stub seems to keep make happy and as best
as I can tell works.
	That said numerous ppc, mips, and a few other boards call
early_serial_setup() either for KGDB support or for early console text
support - passing a uart_port structure. Typically this only for 8250's
or the few other serial ports with boot to bash serial support. But I
have code to provide boot-bash UartLite support.
	This raises another issue. Your driver pulls memory and irq information
from platform device structures using IORESOURCE_MEM and IORESOURCE_IRQ
- perfectly resonable, but most of the 8250 based systems - particularly
the XILINX ml300, and ml403 have a uart_port structure embedded in their
platform data instead, and that is consistent with what
early_serial_setup() passes to the driver. A quick grep of
drivers/serial seemed to indicate no consistency passing configuration
data. But boot-bash serial IO will be easier if you follow the pattern
used for the 8250 in the Xilinx ml300/ml403.

	Finally, for boot-bash serial support it makes sense to extract the
register/bit defines into a separate include/linux/serial_uartlite.h
as there will be other code that uses them. I deliberately chose to name
all the values exactly as the 8250 defines - even thought I do not like
some of the names, UART_LSR_THRE means the same thing in every driver I
deal with wither it is an 8250, UartLite, Keyhole or even in another OS.
But that is personal preference.

	Eventually, I gave up and reverted back to my own driver. Patching
yours for early serial, tracking down the input problem, the output
problem, and adding polling was a larger undertaking, considering I have
a driver that works for me. Your driver did provoke me to check
my own in a pure interrupt driven environment and I have a problem of
my own their I need to fix.

	
	





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



-
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

