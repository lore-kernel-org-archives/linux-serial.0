From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 3 Mar 2010 13:52:05 +0800
Message-ID: <20100303135205.4fc277c5@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100303105744.1eec10d7@feng-i7>
	<201003022051.58688.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19449 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395Ab0CCFsx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 00:48:53 -0500
In-Reply-To: <201003022051.58688.david-b@pacbell.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Wed, 3 Mar 2010 12:51:58 +0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 02 March 2010, Feng Tang wrote:
> > + * 3. This driver doesn't support work with a spi cotnroller in
> > DMA mode, 
> 
> As Grant said:  That's a bug ... one that will randomly
> kick in based on whether the underlying SPI controller driver
> happens to use DMA for a given transaction.
> 
> 
>From this perspective, yes, it's a bug that this driver use non DMA-safe
IO buffer, which prevents it to be portable for all kinds of controllers,
and I can make it DMA safe. 

But I still don't think it's a good idea to use DMA for Max3110 for
performance reason, I know there is some spi controller who only works in
DMA mode. 

Here comes another idea, can we add a capability flag in struct spi_master
indicating the master supporting poll or dma or both. Also we add similar
bits in struct spi_transfer indicating the this transfer wants to be handled
in poll or dma mode. For spi controller driver, it can claim its
capability when registering as a spi_master, for a spi device driver, it can
select the working mode based on spi_master's capability and set the working
mode in struct spi_transfer. Then controller and device don't need to guess
what the other is capable, and make the info public. Any thoughts?

Thanks,
Feng
