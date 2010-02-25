From: Feng Tang <feng.tang@intel.com>
Subject: Re: [spi-devel-general] [RFC][PATCH] serial: spi: add spi-uart
 driver for Maxim 3110
Date: Thu, 25 Feb 2010 15:49:06 +0800
Message-ID: <20100225154906.7d3ac9f1@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<73BDC2BA3DA0BD47BAAEE12383D407EF303E943D@shzsmsx502.ccr.corp.intel.com>
	<1262112228.28396.93.camel@justakiss.home.at>
	<201002242047.14308.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15266 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab0BYHqs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 02:46:48 -0500
In-Reply-To: <201002242047.14308.david-b@pacbell.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Erwin Authried <eauth@softsys.co.at>, Baruch Siach <baruch@tkos.co.il>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Thu, 25 Feb 2010 12:47:13 +0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 29 December 2009, Erwin Authried wrote:
> > I think there's no need for a MAX3100 **and** a MAX3110 driver,
> > this is just confusing. The MAX3110 driver is identical to the
> > MAX3100 from the software view, it is simply a MAX3100 with
> > transceivers added to the chip. If there's any improvement, that
> > should be merged into the existing MAX3100 driver.
> 
> Assuming that's true ... who will resolve the issue?
> 
Hi David,

I've answered Erwin's comments before in v1 submission cycle, following
is the quote:

"I agree there should not be 2 drivers cover 1 family of HW, so this is a RFC.
I've thinked about merge with current 3100 code, but it depends on one char
per spi_transfer, while my driver relys on batch data transfer for efficiency.
Another key point is the console, SPI UART can't be directly accessed by
CPU, so every spi_transfer will go through tasklet/workqueue, which makes
supporting printk a big part of my driver."

I really did consider about that, but has no good clue, so I think better to
shape my driver first.

Thanks,
Feng
