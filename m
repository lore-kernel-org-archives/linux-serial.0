From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH][BUG] Fix possible NULL pointer access in 8250 serial driver
Date: Wed, 18 Apr 2007 20:18:12 +0100
Message-ID: <20070418191812.GA21211@flint.arm.linux.org.uk>
References: <46242DD2.7030207@soft.fujitsu.com> <20070416225206.cf7d8cd2.akpm@linux-foundation.org> <1176884513.3945.54.camel@kane-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4660 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993059AbXDRTSX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Apr 2007 15:18:23 -0400
Content-Disposition: inline
In-Reply-To: <1176884513.3945.54.camel@kane-linux>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, izumi <izumi2005@soft.fujitsu.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Apr 18, 2007 at 05:21:53PM +0900, Kenji Kaneshige wrote:
> > I'd imagine that other serial drivers might get upset having their
> > ->get_mcrtl() called prior to being opened.  Perhaps we should be fixing
> > this in uart_read_proc()?
> > 
> 
> I looked at other serial drivers and I could not find any other
> drivers which accesses port->info in their ->get_mctrl(). This 
> is why we fix this problem in 8250 driver. But if there is a
> possibility that other drivers accesses port->info in their
> ->get_mctrl(), we should be fixing this in uart_read_proc(), as
> you said.

NAK.  This means that you change the list of ports available on the
machine to be limited to only those which are currently open.  Utterly
useless for debugging, where you normally want people to dump the
contents of /proc/tty/driver/*.

The original patch was better.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
