From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
Date: Mon, 12 Dec 2011 10:55:03 +1100
Message-ID: <1323647703.19891.13.camel@pasglop>
References: <20111023141108.856998818@telegraphics.com.au>
	 <20111023141115.208699274@telegraphics.com.au>
	 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
	 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
	 <1323318004.12793.21.camel@pasglop> <1323318638.12793.23.camel@pasglop>
	 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
	 <1323647315.19891.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48642 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab1LKXzP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Dec 2011 18:55:15 -0500
In-Reply-To: <1323647315.19891.10.camel@pasglop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org

On Mon, 2011-12-12 at 10:48 +1100, Benjamin Herrenschmidt wrote:
> Any chance you can test this patch ? I would not be surprised if it
> broke m68k since I had to do some of the changes in there "blind",
> so let me know... with this, I can again suspend/resume properly on
> a Pismo while using the internal modem among other things.

 ..../....

Forgot to commit a fix before sending, but it's a trivial one:

> -#ifdef DEBUG_HARD
> +#ifde DEBUG_HARD
>  	pmz_debug("irq, r3: %x\n", r3);
>  #endif

Remove that hunk :-)

Cheers,
Ben.


