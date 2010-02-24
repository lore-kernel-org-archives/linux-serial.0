From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 24 Feb 2010 10:44:19 +0000
Message-ID: <20100224104419.753dd138@lxorguk.ukuu.org.uk>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
	<fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
	<20100209093644.2dead2d9@feng-i7>
	<20100217225817.GD31557@kroah.com>
	<20100224131130.61530b62@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60472 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756561Ab0BXKlL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Feb 2010 05:41:11 -0500
In-Reply-To: <20100224131130.61530b62@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, 24 Feb 2010 13:11:30 +0800
Feng Tang <feng.tang@intel.com> wrote:

> Hi All,
> 
> Here is a driver for Maxim 3110 SPI-UART device, please help to review.
> 
> It has been validated with Designware SPI controller (drivers/spi: dw_spi.c &
> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read, and
> provides a console.

Ack for the serial side

Acked-by: Alan Cox <alan@linux.intel.com>

