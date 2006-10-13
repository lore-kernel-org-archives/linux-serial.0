From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] serial: handle pci_enable_device() failure upon resume
Date: Fri, 13 Oct 2006 08:59:53 +0100
Message-ID: <20061013075953.GC28654@flint.arm.linux.org.uk>
References: <20061012014720.GA12935@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3081 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750818AbWJMIAA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Oct 2006 04:00:00 -0400
Content-Disposition: inline
In-Reply-To: <20061012014720.GA12935@havoc.gtf.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Oct 11, 2006 at 09:47:20PM -0400, Jeff Garzik wrote:
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

NAK.  What happens to the ports if pci_enable_device() fails and someone
has them open?

It's far better to leave the must_check warning behind until it can be
_correctly_ solved, rather than papering over the problem with bogus
patches to return errors without taking an appropriate additional action.

IOW, the warnings serve as a reminder that *proper* error handling needs
to be implemented.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
