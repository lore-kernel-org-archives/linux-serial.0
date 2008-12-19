From: Theodore Tso <tytso@mit.edu>
Subject: Re: Enabling auto RS485 half-duplex control
Date: Thu, 18 Dec 2008 23:10:42 -0500
Message-ID: <20081219041042.GA20215@mit.edu>
References: <200812172224.13608.mfuchs@ma-fu.de> <20081218033200.GB9871@mit.edu> <gidri8$7i6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.church-of-our-saviour.org ([69.25.196.31]:47142 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753455AbYLSEKq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Dec 2008 23:10:46 -0500
Content-Disposition: inline
In-Reply-To: <gidri8$7i6$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grante@visi.com>
Cc: linux-serial@vger.kernel.org

On Thu, Dec 18, 2008 at 03:51:36PM +0000, Grant Edwards wrote:
> Yes there are.  The standard is that RTS is asserted when one
> whishes to transmit (and de-asserted when one has finished
> transmitting). Optionally, one waits for CTS to be asserted
> before transmitting.  Isn't that the definition of RTS and CTS
> that's in the standard?

There's a standard, which is not necessarily well adhered to.  Heck,
full-duplex RTS/CTS standard was used by thousands if not millions of
modems in flagrent violation of the RS-232 standard for some 10 years
or more before TIA-232-E was released and bowed to reality.

I know I received all sorts of requests for very strange
implementations of half-duplex, with people sending me product specs
with all manner of requirements, both in terms of which RS-232 lines
were used (which may have been confusions caused by the fact that many
systems ship with random and wondrous DB9->DB25 cables, or strange
DTE/DCE conversion cables), but also in terms of mutually exclusive
requirements in terms of minimum and maximum turnaround times.

Someday when I'm board I can try to dig the requests out of the
archives, but I can definitely say that people asked for very strange
things, much of which was not in the standard (and as I pointed out,
until 1990 traditional full-duplex RTS/CTS hardware flow control was
not recognized by the RS-232 standard either).

					- Ted
