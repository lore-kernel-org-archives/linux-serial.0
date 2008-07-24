From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] 8250: Add PowerPC-style MMIO support to the 8250 driver
Date: Thu, 24 Jul 2008 13:14:25 +0100
Message-ID: <20080724121425.GB9327@flint.arm.linux.org.uk>
References: <200807241411.15735.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35600 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbYGXMOm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 08:14:42 -0400
Content-Disposition: inline
In-Reply-To: <200807241411.15735.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thu, Jul 24, 2008 at 02:11:15PM +0200, Laurent Pinchart wrote:
> This patch adds support for memory-mapped 8250-like UARTs on PowerPC platforms.

What is different about in_8() from readb() ?  Why can't PowerPC use
readb()?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
