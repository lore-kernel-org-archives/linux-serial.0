From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 3 Mar 2010 15:42:29 +0800
Message-ID: <20100303154229.5d0f3633@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<201003022216.08888.david-b@pacbell.net>
	<20100303143731.0c009c64@feng-i7>
	<201003022325.52315.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30604 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab0CCHkv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 02:40:51 -0500
In-Reply-To: <201003022325.52315.david-b@pacbell.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Wed, 3 Mar 2010 15:25:52 +0800
David Brownell <david-b@pacbell.net> wrote:

> If someone decided to update a SPI controller driver to avoid DMA in
> some cases, in favor of PIO, they could already code such heuristics
> without needing your proposed hinting from upper layers.
> 
> The result in the low-level driver would be just to use a different
> test (maybe "is this a one-word transfer?" instead of checking your
> per-transfer "use PIO?" hint)

Yup, good point, controller driver can be smarter

Thanks,
Feng
> before kicking in whatever logic you
> think would improve performance (by eliminating DMA setup and teardown
> costs, including cache cleaning).
> 
> - Dave
> 
