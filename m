From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 2/2] 8250_pnp: register x86 COM ports at the conventional
 ttyS names
Date: Fri, 18 Jan 2008 13:10:29 -0500
Message-ID: <4790EB95.203@zytor.com>
References: <9MjWa-VI-9@gated-at.bofh.it> <9MjWb-VI-11@gated-at.bofh.it> <9MlEG-3Mx-13@gated-at.bofh.it> <9Mmra-56f-29@gated-at.bofh.it> <E1JFEwb-0000zs-2q@be1.7eggert.dyndns.org> <478E6C20.2030005@zytor.com> <478E946D.9040105@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44483 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762071AbYARSUs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2008 13:20:48 -0500
In-Reply-To: <478E946D.9040105@keyaccess.nl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: 7eggert@gmx.de, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Russell King <rmk+serial@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Rene Herman wrote:
> 
> The number of places expected to contain something sensible should I 
> believe first be verified at 0x410 -- the equipment word. Bits 11-9 
> (0x0e00) should be the number of serial ports, 0 to 4 (so 5-7 is also a 
> sanity check) and if BIOSes can be expected to zero out the non-used 
> base-addresses (at 0x400, 0x402, 0x404, 0x406) that's another sanity 
> check. Don't know if they can though...
> 

Probably not.  However, the ports marked valid should be nonzero and 
aligned-8.

	-hpa

