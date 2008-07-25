From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Fix oops in the 8250 serial driver when accessing a removed device
Date: Fri, 25 Jul 2008 10:51:29 +0100
Message-ID: <20080725095128.GC21452@flint.arm.linux.org.uk>
References: <200807221737.06224.laurentp@cse-semaphore.com> <20080722165408.38a75a57@lxorguk.ukuu.org.uk> <200807221831.54473.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54143 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbYGYJvn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jul 2008 05:51:43 -0400
Content-Disposition: inline
In-Reply-To: <200807221831.54473.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Tue, Jul 22, 2008 at 06:31:50PM +0200, Laurent Pinchart wrote:
> Hi Russell,
> 
> On Tuesday 22 July 2008, Alan Cox wrote:
> > > When a plug-and-play 8250 device is detected, the driver reuses one of the
> > > dummy ports. If that device is later removed, the port goes pack to the
> > > dummy ports pool. The capabilities field is not reset, which causes a oops
> > > when trying to access the port.
> > 
> > Some day we need to allocate new dummy ports so there is always one free.
> > 
> > > This patch resets the capabilities field when a 8250 device is
> > > unregistered. 
> > 
> > Looks good to me. Would appreciate Russell's view though.
> 
> Could you please review the patch (available at http://marc.info/?l=linux-serial&m=121674107306179&w=2) ?
> I'd like it to go into 2.6.27 if possible.

Is there a link to the oops as well?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
