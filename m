From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 3 Mar 2010 14:37:31 +0800
Message-ID: <20100303143731.0c009c64@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<201003022051.58688.david-b@pacbell.net>
	<20100303135205.4fc277c5@feng-i7>
	<201003022216.08888.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1860 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535Ab0CCGeO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 01:34:14 -0500
In-Reply-To: <201003022216.08888.david-b@pacbell.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>


> 
> > Here comes another idea, can we add a capability flag in struct
> > spi_master indicating the master supporting poll or dma or both.
> > Also we add similar bits in struct spi_transfer indicating the this
> > transfer wants to be handled in poll or dma mode.
> 
> Let's not do either of those.  There's no need to introduce such
> complexity, or to enable the associated new failure modes and bugs.

This idea has nothing to do with the dma-safe problem you pointed out, I will
make the buffer dma safe anyway.

What I proposed just wants to provide some flexibility for protocol device
drivers, it will use dma-safe buffer always, but it prefer not to use DMA
for its one-word transfers, and hope to have a choice to do that. For current
existing controller and device drivers, they can simply ignore the new 
working mode setting in struct spi_master and spi_transfer and leave them
as 0.

Thanks,
Feng

> 
> Much simpler to just use DMA-safe I/O buffers in the first place ...
> which is what pretty much every driver stack in Linux already expects
> or requires.
> 
> - Dave
> 
