From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Mon, 6 Aug 2007 21:29:55 +0200
Message-ID: <1288ff079974aa806119584018bab973@kernel.crashing.org>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange> <E1IHnhY-0008PO-IZ@jdl.com> <Pine.LNX.4.60.0708052336360.4120@poirot.grange> <200708052357.32650.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38446 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbXHFTah (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Aug 2007 15:30:37 -0400
In-Reply-To: <200708052357.32650.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>, linux-serial@vger.kernel.org

> Maybe the best solution would be for 824[15] to not claim compatibility
> with 8250 at all then.

Or at least it should have a more specific entry for this
"special" 16x50 UART, and that one should be probed first.

> If the device tree contains an entry that matches
> what the generic driver looks for, it better be something that can
> be handled by that driver.

Pretty much; you can't make this rule too strict though,
if a device mostly works with the generic driver, you can
claim compatibility with it -- keep in mind that that can
come back to bite you though, like in this case.  The
advantages do outweigh the disadvantages sometimes, it's
all a tradeoff; avoid it if possible.


Segher

