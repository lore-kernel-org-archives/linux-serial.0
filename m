From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 2 Mar 2010 20:51:58 -0800
Message-ID: <201003022051.58688.david-b@pacbell.net>
References: <20091229222006.1ddb28a4@feng-desktop> <20100208165946.0e4dde83@feng-i7> <20100303105744.1eec10d7@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:39864 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753717Ab0CCEwA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Mar 2010 23:52:00 -0500
In-Reply-To: <20100303105744.1eec10d7@feng-i7>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Tuesday 02 March 2010, Feng Tang wrote:
> + * 3. This driver doesn't support work with a spi cotnroller in DMA mode, 

As Grant said:  That's a bug ... one that will randomly
kick in based on whether the underlying SPI controller driver
happens to use DMA for a given transaction.


