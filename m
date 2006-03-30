From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: ioremap_nocache() in setup_port() ok?
Date: Thu, 30 Mar 2006 11:12:26 -0700
Message-ID: <20060330181226.GD9454@colo.lackof.org>
References: <20060330075410.GB1722@colo.lackof.org> <20060330075752.GA19700@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:30383 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751346AbWC3SBV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Mar 2006 13:01:21 -0500
Content-Disposition: inline
In-Reply-To: <20060330075752.GA19700@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-serial@vger.kernel.org, willy@hp.com

On Thu, Mar 30, 2006 at 08:57:52AM +0100, Russell King wrote:
> On Thu, Mar 30, 2006 at 12:54:10AM -0700, Grant Grundler wrote:
> > Am I correct that serial also wants _nocache() for MMIO space?
> 
> Don't know - I've always taken ioremap_nocache() as a mis-understanding
> of what ioremap() itself is supposed to do.  Indeed, if you look at
> IO-mapping.txt, ioremap_nocache() is not mentioned, and it's pretty
> clear that ioremap() is what is intended to be used to map MMIO.

I think IO-mapping.txt is stale and whoever added ioremap_nocache
failed to update it.

It would be reasonable to ignore my patch (unless you wanted
to document the expected behavior of serial) if what willy
proposed an hour ago is accepted:
	http://lkml.org/lkml/2006/3/30/251

I'll update the IO-mapping.txt based on the outcome of
willy's patch.

thanks,
grant
