From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Uartlite driver
Date: Thu, 15 May 2008 10:31:41 -0400
Message-ID: <482C494D.2050306@dlasys.net>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost> <fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com> <4827E073.9020301@seznam.cz>
Reply-To: dhlii@dlasys.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outbound-mail-09.bluehost.com ([69.89.17.209]:60666 "HELO
	outbound-mail-09.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752299AbYEOOio (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 May 2008 10:38:44 -0400
In-Reply-To: <4827E073.9020301@seznam.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@seznam.cz
Cc: Grant Likely <grant.likely@secretlab.ca>, John Williams <john.williams@petalogix.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Michal Simek wrote:
>>
>> I fully understand the reason for the +3.  What makes it 'magic' is
>> the fact that it is an undocumented value added to the base address
>> with no comment describing what it is for.
>>     
>
> This is documented offset - look at uartlite manual - useful bits are 24-31.
> On big endian systems with 32bit access is everything ok because the least
> significant byte is the last in memory. But when you changed from 32bits to 8
> bits access than you have to move your base address to +3 offset.
>
> This is not undocumented value.
    I do not buy that as any way documented.
    Are there substantial numbers of other drivers for other devices
    where  a +3  jumps in from nowhere ?
    I am also not happy with the register definitions hard coded as 0,4,8,12
   
    I have not read the Xilinx UartLite docs recently, but there was older
    Xilinx code  that implied the registers could be 8, 16 or 32 bits.
    There is also atleast one implimentation out there that accesses
    the UartLite via DCR.

     Can we just move all the in's and outs to something like:

static unsigned int
serial_in(struct uart_port *port, int offset) {
    unsigned int value;

    switch (port->iotype) {
        case UPIO_PORT:
            value = mfdcr(offset);
            break;
        default:
            offset <<= port->regshift;
            value = readb(port->membase + offset);
    }
    return value;
}

Then we can handle all the 8/16/32 BE/LE, DCR, .... in one place ?
I think that is what is done in other drivers.




   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

