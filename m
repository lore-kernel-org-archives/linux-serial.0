From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: RE: Uartlite driver
Date: Thu, 15 May 2008 09:39:04 -0700
Message-ID: <20080515163905.C6C21F10082@mail163-wa4.bigfish.com>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost> <fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com> <4827E073.9020301@seznam.cz> <482C494D.2050306@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:46299 "EHLO
	outbound1-wa4-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551AbYEOXTN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 May 2008 19:19:13 -0400
Content-class: urn:content-classes:message
In-reply-to: <482C494D.2050306@dlasys.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dhlii@dlasys.net, monstr@seznam.cz
Cc: Grant Likely <grant.likely@secretlab.ca>, John Williams <john.williams@petalogix.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk



Somewhat off topic here, but related to David's suggestion below, I've
been pondering a 'control register' abstraction, partly because it
appears that new cores are being built which have the option to replace
dcr control interfaces with PLB interfaces, or replace PLB interfaces
with dcr interfaces, hence the drivers need to handle dcr interfaces and
plb interfaces more or less interchangeably.

One possibility would be to hijack the dcr-specific code that's already
there, but I'm not sure if that really makes alot of sense.  Comments
appreciated...

Steve

> -----Original Message-----
> From: David H. Lynch Jr. [mailto:dhlii@dlasys.net]
> Sent: Thursday, May 15, 2008 7:32 AM
> To: monstr@seznam.cz
> Cc: Grant Likely; John Williams; Josh Boyer;
linux-serial@vger.kernel.org; jacmet@sunsite.dk; Stephen
> Neuendorffer
> Subject: Re: Uartlite driver
> 
> Michal Simek wrote:
> >>
> >> I fully understand the reason for the +3.  What makes it 'magic' is
> >> the fact that it is an undocumented value added to the base address
> >> with no comment describing what it is for.
> >>
> >
> > This is documented offset - look at uartlite manual - useful bits
are 24-31.
> > On big endian systems with 32bit access is everything ok because the
least
> > significant byte is the last in memory. But when you changed from
32bits to 8
> > bits access than you have to move your base address to +3 offset.
> >
> > This is not undocumented value.
>     I do not buy that as any way documented.
>     Are there substantial numbers of other drivers for other devices
>     where  a +3  jumps in from nowhere ?
>     I am also not happy with the register definitions hard coded as
0,4,8,12
> 
>     I have not read the Xilinx UartLite docs recently, but there was
older
>     Xilinx code  that implied the registers could be 8, 16 or 32 bits.
>     There is also atleast one implimentation out there that accesses
>     the UartLite via DCR.
> 
>      Can we just move all the in's and outs to something like:
> 
> static unsigned int
> serial_in(struct uart_port *port, int offset) {
>     unsigned int value;
> 
>     switch (port->iotype) {
>         case UPIO_PORT:
>             value = mfdcr(offset);
>             break;
>         default:
>             offset <<= port->regshift;
>             value = readb(port->membase + offset);
>     }
>     return value;
> }
> 
> Then we can handle all the 8/16/32 BE/LE, DCR, .... in one place ?
> I think that is what is done in other drivers.
> 
> 
> 
> 
> 
> 
> 
> --
> Dave Lynch 					  	    DLA Systems
> Software Development:
Embedded Linux
> 717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
> fax: 1.253.369.9244 			           Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies
too numerous to list.
> 
> "Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a
> lot of courage to move in the opposite direction."
> Albert Einstein
> 


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

