From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
Date: Fri, 09 Dec 2011 06:44:09 +1100
Message-ID: <1323373449.12793.40.camel@pasglop>
References: <20111023141108.856998818@telegraphics.com.au>
	 <20111023141115.208699274@telegraphics.com.au>
	 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
	 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
	 <1323318004.12793.21.camel@pasglop> <1323318638.12793.23.camel@pasglop>
	 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43687 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab1LHToX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Dec 2011 14:44:23 -0500
In-Reply-To: <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org

On Thu, 2011-12-08 at 22:26 +1100, Finn Thain wrote:
> 
> Maybe the modem wants a transition on DTR or similar, but it hasn't had 
> time to initialise when that happens during SCC resumption.
> 
> If so, calling pmz_shutdown() then pmz_startup() from the tail of 
> pmz_resume() without delay should probably fail to revive it... 

Well, we power the modem down and back up... but it's possible that we
fail to re-enable something, I'll check. That used to work (at least
with macserial, maybe I never tried this specific torture with pmz...).
I'll figure it out eventually.

Cheers,
Ben.


