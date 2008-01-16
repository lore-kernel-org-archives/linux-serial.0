From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/2] serial: explicitly request ttyS0-3 for COM1-4
Date: Wed, 16 Jan 2008 12:59:27 -0700
Message-ID: <200801161259.28723.bjorn.helgaas@hp.com>
References: <20080116170541.511233227@ldl.fc.hp.com> <20080116183933.GB23371@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:10197 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYAPT7E (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2008 14:59:04 -0500
In-Reply-To: <20080116183933.GB23371@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>

On Wednesday 16 January 2008 11:39:34 am Russell King wrote:
> On Wed, Jan 16, 2008 at 10:05:41AM -0700, Bjorn Helgaas wrote:
> > When 8250_pnp discovers COM ports, we only get the correct ttyS names
> > by accident -- we rely on serial8250_isa_init_ports(), which discovers
> > the COM ports earlier using the addresses in SERIAL_PORT_DFNS.
> 
> It's not by accident but by design.  It's quite intentional that it
> remembers the addresses of serial ports, and if another port is
> registered later with the same base address, it gets the same name.

It's certainly by design that if we register a port twice, it gets
the same name both times.

But that's not quite what I was referring to.  I meant that I don't
think 8250_pnp should depend on the fact that COM1-4 have been
previously discovered to get the right names.

Bjorn
