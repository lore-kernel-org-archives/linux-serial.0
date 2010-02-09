From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH v2] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 9 Feb 2010 09:25:02 +0000
Message-ID: <20100209092502.25ca2231@lxorguk.ukuu.org.uk>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59971 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752256Ab0BIJ3E (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Feb 2010 04:29:04 -0500
In-Reply-To: <20100208162010.b1f69728.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg KH <greg@kroah.com>

> > +			for (i = 0; i < len; i++) {
> > +				obuf[i] = (u8)xmit->buf[xmit->tail] | WD_TAG;
> > +				xmit->tail = (xmit->tail + 1) &
> > +						(UART_XMIT_SIZE - 1);
> 
> Could this driver use include/linux/kfifo.h, rather than open-coding it?

The circ buffer stuff comes from the serial layer. The whole serial layer
wants switching to kfifo (as and when we know why the kfifo changes seem
to have broken USB serial) but the driver can't do that itself and use
the serial core code until then.

(Actually most of the serial_core code wants a rewrite but having had a
couple of goes at doing it I've not figured out any way to do it without
simply breaking all sorts of embedded platform serial drivers that need
specific hardware to fix).

> > +			}
> > +			max3110_write_then_read(max, (u8 *)obuf,
> > +						(u8 *)ibuf, len * 2, 0);
> 
> Error codes are ignored.

The drivers/serial midlayer has no provision for reporting them.

Alan
