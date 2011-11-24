From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH 01/16] pmac_zilog: fix unexpected irq
Date: Fri, 25 Nov 2011 07:43:24 +1100
Message-ID: <1322167404.32635.7.camel@pasglop>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE1@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56959 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060Ab1KXUnn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Nov 2011 15:43:43 -0500
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE1@saturn3.aculab.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org

On Thu, 2011-11-24 at 15:28 +0000, David Laight wrote:
> > On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
> > masked. This can be a problem when pmac_zilog starts up.
> 
> Wouldn't this also happen if the interrupt were shared?
> Hopefully nothing vaguely modern uses the borked Zilog 8530 SCC
> (which I presume is the part in question - brings back
> too many nightmares....)

Yup. Afaik, the most recent you can find with that are PowerMacs which
used it for their internal modem (even my G5 has one wired to the
internal slot afaik), tho none of those had shared interrupts.

Cheers,
Ben.


