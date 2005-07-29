From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] SERIAL: add MMIO support to 8250_pnp
Date: Fri, 29 Jul 2005 04:22:41 -0700
Message-ID: <20050729042241.46f52ec1.akpm@osdl.org>
References: <200507271647.12882.bjorn.helgaas@hp.com>
	<20050729113205.D10345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:35464 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262506AbVG2LX5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Jul 2005 07:23:57 -0400
In-Reply-To: <20050729113205.D10345@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: bjorn.helgaas@hp.com, linux-serial@vger.kernel.org, ambx1@neo.rr.com, linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Wed, Jul 27, 2005 at 04:47:12PM -0600, Bjorn Helgaas wrote:
> > Add support for UARTs in MMIO space and clean up a little whitespace.
> > 
> > HP legacy-free ia64 machines need this.
> 
> Due to the restrictions caused by the new new kernel development model,
> I'm unable to merge this for 2.6.13.  I already have other stuff already
> queued in my serial tree which probably isn't suitable for merging.
> 
> If someone else (Andrew or Adam) wishes to merge this then fine - it
> looks reasonable.  Let me know what you're doing so I know whether to
> add it to my serial tree or not.

Yup, I queued it up.
