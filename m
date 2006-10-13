From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] serial: handle pci_enable_device() failure upon resume
Date: Fri, 13 Oct 2006 13:15:16 -0700
Message-ID: <20061013131516.227e99ee.akpm@osdl.org>
References: <20061012014720.GA12935@havoc.gtf.org>
	<20061013075953.GC28654@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:49347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751865AbWJMUP5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Oct 2006 16:15:57 -0400
In-Reply-To: <20061013075953.GC28654@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, 13 Oct 2006 08:59:53 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Oct 11, 2006 at 09:47:20PM -0400, Jeff Garzik wrote:
> > Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> NAK.  What happens to the ports if pci_enable_device() fails and someone
> has them open?

They're screwed either way.

> It's far better to leave the must_check warning behind until it can be
> _correctly_ solved, rather than papering over the problem with bogus
> patches to return errors without taking an appropriate additional action.
> 
> IOW, the warnings serve as a reminder that *proper* error handling needs
> to be implemented.

What would that error handling do?

Until that has been implemented, it would be good if we could at least spit
a printk telling people what failed, so when the machine later goes kaput
we know why it happened.

An appropriate place in which to perform that reporting is up in the
high-level resume code, so Jeff's patch is appropriate.

Right now, we get silent failure *and* a compile-time warning.  It's hard
to see how that situation could be made worse.

