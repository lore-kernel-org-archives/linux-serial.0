From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite driver
Date: Fri, 16 May 2008 09:41:47 +0200
Message-ID: <87zlqqg0g4.fsf@macbook.be.48ers.dk>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost>
	<fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com>
	<4827E073.9020301@seznam.cz> <482C494D.2050306@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:1551 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbYEPHl7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 May 2008 03:41:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so307216nfc.21
        for <linux-serial@vger.kernel.org>; Fri, 16 May 2008 00:41:57 -0700 (PDT)
In-Reply-To: <482C494D.2050306@dlasys.net> (David H. Lynch, Jr.'s message of "Thu\, 15 May 2008 10\:31\:41 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dhlii@dlasys.net
Cc: monstr@seznam.cz, Grant Likely <grant.likely@secretlab.ca>, John Williams <john.williams@petalogix.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

 David> I am also not happy with the register definitions hard coded
 David> as 0,4,8,12 I have not read the Xilinx UartLite docs recently,
 David> but there was older Xilinx code that implied the registers
 David> could be 8, 16 or 32 bits.  There is also atleast one
 David> implimentation out there that accesses the UartLite via DCR.

Can the Xilinx core be configured for anything else than 32bit offset?
I don't think so.

 David>      Can we just move all the in's and outs to something like:

 David> static unsigned int
 David> serial_in(struct uart_port *port, int offset) {
 David>     unsigned int value;

 David>     switch (port->iotype) {
 David>         case UPIO_PORT:
 David>             value = mfdcr(offset);
 David>             break;
 David>         default:
 David>             offset <<= port->regshift;
 David>             value = readb(port->membase + offset);
 David>     }
 David>     return value;
 David> }

 David> Then we can handle all the 8/16/32 BE/LE, DCR, .... in one place ?
 David> I think that is what is done in other drivers.

The only one that afaik does this is 8250.c because of the mindblowing
number of more-or-less compatible 8250 implementations. That's surely
not the case for the uartlite.

But ok, if the DCR access mode is supported by Xilinx - Why not?
Patches are welcome.

-- 
Bye, Peter Korsgaard
