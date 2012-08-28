From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: unrecognized multi io pci card
Date: Tue, 28 Aug 2012 13:55:29 +0100
Message-ID: <20120828135529.6a826b19@pyramind.ukuu.org.uk>
References: <20120828122458.GB1258@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35461 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab2H1Muu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Aug 2012 08:50:50 -0400
In-Reply-To: <20120828122458.GB1258@server>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gianluca <gianluca@sottospazio.it>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

> After adding the IDs and descriptions I found unfortunately that the module
> 8250_pci reclaims the pci device as a serial card only and this prevents the
> successful registration of the parport_serial driver (which also depends on
> 8250_pci).
> 
> So I blacklisted the card in 8250_pci.c using the sofmodem blacklist mechanism
> already in place. I know this isn't really the right place to do it but it
> works and I didn't find another way.

Actually I think it is the right place to do it. Prior to that the only
cases we've had to deal with are board specifc rules such as for the
Timedia/Sunix card. The softmodem bit of the blacklist wants renaming and
a comment adding to each group giving the reason.

> Eventually the parallel and the serial ports are detected but only the parallel
> port works because the serial ports are wrongly recognized as XScale when they
> are actually 16550 clones: if I set the port type by hand with setserial they work.
> 
> So I changed the autoconfig function in 8250.c this way: checks also the RTOIE
> bit in IER to detect the port as XSCALE. I don't think this is really correct
> but I've no knowledge on XSCALE or my serial card hardware to do it better.

Trying to get autodetection right is always a little bit exciting and one
device tends to break another.

In this case you know the device type and have a PCI identifier you should
be able to set

	up->port.flags |= UPF_FIXED_TYPE;
	up->port.type = PORT_16550A;

before the call to serial8250_register_8250_port();

Alan
