From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 2 Mar 2010 22:16:08 -0800
Message-ID: <201003022216.08888.david-b@pacbell.net>
References: <20091229222006.1ddb28a4@feng-desktop> <201003022051.58688.david-b@pacbell.net> <20100303135205.4fc277c5@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:29248 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753825Ab0CCGQK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 01:16:10 -0500
In-Reply-To: <20100303135205.4fc277c5@feng-i7>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Tuesday 02 March 2010, Feng Tang wrote:
> On Wed, 3 Mar 2010 12:51:58 +0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > On Tuesday 02 March 2010, Feng Tang wrote:
> > > + * 3. This driver doesn't support work with a spi cotnroller in
> > > DMA mode, 
> > 
> > As Grant said:  That's a bug ... one that will randomly
> > kick in based on whether the underlying SPI controller driver
> > happens to use DMA for a given transaction.
> > 
> > 
> From this perspective, yes, it's a bug that this driver use non DMA-safe
> IO buffer, which prevents it to be portable for all kinds of controllers,

Yes, that's a bug ... you're using a programming interface which
has portability as a core goal.  In an operating system kernel
which also has such a goal.


> and I can make it DMA safe. 

That's the right solution.


> Here comes another idea, can we add a capability flag in struct spi_master
> indicating the master supporting poll or dma or both. Also we add similar
> bits in struct spi_transfer indicating the this transfer wants to be handled
> in poll or dma mode.

Let's not do either of those.  There's no need to introduce such complexity,
or to enable the associated new failure modes and bugs.

Much simpler to just use DMA-safe I/O buffers in the first place ... which is
what pretty much every driver stack in Linux already expects or requires.

- Dave

