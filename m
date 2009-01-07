From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] serial: add support for the cell network processor
 NWP device
Date: Tue, 6 Jan 2009 20:21:43 -0800
Message-ID: <20090106202143.b31b908e.akpm@linux-foundation.org>
References: <200811241453.32166.arnd@arndb.de>
	<1231297694.14860.55.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58769 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188AbZAGEWF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Jan 2009 23:22:05 -0500
In-Reply-To: <1231297694.14860.55.camel@pasglop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, Benjamin Krill <ben@codiert.org>, linuxppc-dev@ozlabs.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>

On Wed, 07 Jan 2009 14:08:14 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2008-11-24 at 14:53 +0100, Arnd Bergmann wrote:
> > From: Benjamin Krill <ben@codiert.org>
> > 
> > Add support for the nwp serial device which is connected to a DCR bus. It
> > uses the of_serial device driver to determine necessary properties from
> > the device tree.  The supported device is added as serial port number 84.
> > 
> > NWP stands for network processor and it is part of the QPACE - Quantum
> > Chromodynamics Parallel Computing on the Cell Broadband Engine project.
> > The implementation is a lightweight uart implementation with the focus
> > to consume as little resources as possible and it is connected to a
> > DCR bus.
> > 
> > Signed-off-by: Benjamin Krill <ben@codiert.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> There have been no comment nor objection about this patch.

That doesn't mean anyone looked at it ;)

> Andrew, do we have a serial maintainer or should I merge it via the
> powerpc tree ?

OK by me.  Maybe Alan wants to grab it.


My version is mucked up anyway - PORT_NWPSERIAL has the same value as
PORT_S3C6400.


