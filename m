From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Thu, 25 Feb 2010 00:11:50 -0800
Message-ID: <201002250011.51269.david-b@pacbell.net>
References: <20091229222006.1ddb28a4@feng-desktop> <201002242043.15231.david-b@pacbell.net> <20100225154411.6d1ec4d0@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:40293 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753319Ab0BYILw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 03:11:52 -0500
In-Reply-To: <20100225154411.6d1ec4d0@feng-i7>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Wednesday 24 February 2010, Feng Tang wrote:
> Good point about the DW controller specific data, I'll remove them.

Good.


> For those "bits_per_word" setting, I think we can put it here instead of
> the board initialization code, as many types of boards can leverage the
> setting here as it only works in 16b mode.

Yes.  The bits-per-word setting is mostly driver-specific, so
that's appropriate as something the driver updates.

- Dave

