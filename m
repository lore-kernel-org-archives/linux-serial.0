From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Mon, 4 Jul 2011 21:27:31 +0200
Message-ID: <201107042127.31649.arnd@arndb.de>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de> <201107041835.22660.arnd@arndb.de> <20110704180216.4dc9c79d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61166 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab1GDT2O (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2011 15:28:14 -0400
In-Reply-To: <20110704180216.4dc9c79d@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Monday 04 July 2011 19:02:16 Alan Cox wrote:

> > My question is whether we should still care about those. If
> > we can remove the reconfiguration of existing ports or move
> > it to one of the more obscure parts of the driver, it's possible
> > to confine the dependencies on the ioport_ops to the front-end
> > drivers, while the core 8250 library driver would not need it
> > any more.
> 
> otherwise you need a table that drivers register their port types
> in and to take module references on the table entry to pin the relevant
> driver code ?

I hadn't even thought of that, but yes. I would consider that
worse than leaving both UPIO variants defined in the 8250 core
file after some cleanups, and adding the #ifdef that you object
to.

Yet another option would be to separate out the ioport_ops into
a file for each one, but make them conditionally compiled, with
a direct reference from 8250.o that gets compiled out if no
other front-end ever needs it.

> > Today, most ports don't set the UPF_FIXED flag, even though
> > the ports definitely have fixed resources, e.g. all of the
> > 8250-platform drivers in arch/ or the 8250_pnp and 8250_cs
> > front-ends. Do you think it would be reasonable to mark all
> > 8250 ports except the ISA ones as UPF_FIXED, and move the
> > reconfiguration logic into the 8250_isa driver along with
> > old_serial_port, serial8250_isa_devs,  and
> > serial8250_isa_init_ports?
> 
> I suspect one or two people will scream about some peculiar configuration
> that should be handled automatically anyway and those are best fixed
> properly if so rather than by allowing setserial incantations to work
> around stuff like unknown PCI idents.

Ok, makes sense. If I split this out to the ISA driver, I would
probably also disallow changing io_type, as ISA 8250 ports are
all based on PIO mode.

The only use cases that I can think of for run-time configuration
of MMIO based 8250 ports are the misdetected PCI cards you mentioned
and weird embedded systems that fail to register the port correctly.

Both can be addressed by fixing them at the source.

	Arnd
