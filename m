From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: How can I help?
Date: Fri, 18 Apr 2014 18:54:44 -0400
Message-ID: <20140418225444.GA6166@thunk.org>
References: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov>
 <20140418220903.GA22429@kroah.com>
 <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:49140 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353AbaDRWyr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 18:54:47 -0400
Content-Disposition: inline
In-Reply-To: <E4E661B3-7296-4666-8A59-D9D52BC3D6D0@usgs.gov>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org

On Fri, Apr 18, 2014 at 03:37:53PM -0700, Larry Baker wrote:
> 
> What about my question of vendor supported vs. reverse engineered
> USB serial drivers.  If there is a chip with (better) vendor Linux
> driver support, I can complain to them and they can fix it instead
> of us.

So here's the problem with vendor supported drivers.  More often than
not, it will be for some distribution kernel, and not something which
can be contributed to the upstream kernel.  Very often, it was
whatever kernel version the last Major Customer of said vendor was
using, and the work was done by a contractor (or by an engineer who is
no longer with the vendor), and the driver can't be easily ported to
some other kernel.

You yourself mentioned using a 2.6.32 CentOS kernel.  The 2.6.32
kernel was released some four years ago, in 2010.  Most of the
community developers work on the upstream kernel; we have trouble
remembering what was in a kernel from your years ago.  (``In the
internet, two years is infinity'')

The more enlightened companies these days will insist that the
peripheral vendor will provide if there is a open source driver which
has been contributed to the upstream kernel.  That way, eventually all
of the distributions can get the same driver, and we don't have to
worry about multiple out-of-tree drivers only barely supported by the
vendors (because the contractor or the employee has moved on).

This works well if you are an IBM or a HP, or if you are Samsung or a
LG, and you can say, "we're only going to buy millions of dollars of
your serial chip / scsi controller / whatever if your driver gets
submitted upstream.

> If you were to buy a USB-to-Serial adapter, which chip would
> you buy?

So it's been a long time since I've had to use an RS-232 device (which
is why I stepped down as the serial maintainer years ago), but
speaking generally, what you want is a chip which is actively vendor
supported, and in the mainline source tree.  So if I were looking, I'd
probably do some looking at git commits for the USB serial drivers,
and see which ones seem to be actively maintained by someone who is
clearly either working for one of the vendors, or is actively being
supported by one the vendors.

Good luck,

					- Ted
