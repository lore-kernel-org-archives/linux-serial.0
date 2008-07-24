From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Thu, 24 Jul 2008 15:47:24 +0100
Message-ID: <20080724144724.GE9327@flint.arm.linux.org.uk>
References: <200807241347.33261.laurentp@cse-semaphore.com> <20080724125706.19844a96@lxorguk.ukuu.org.uk> <20080724122402.GC9327@flint.arm.linux.org.uk> <20080724132746.1a961584@lxorguk.ukuu.org.uk> <20080724125210.GD9327@flint.arm.linux.org.uk> <48888E0E.3050601@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38416 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183AbYGXOrn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 10:47:43 -0400
Content-Disposition: inline
In-Reply-To: <48888E0E.3050601@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Laurent Pinchart <laurentp@cse-semaphore.com>, linux-serial@vger.kernel.org

On Thu, Jul 24, 2008 at 09:13:34AM -0500, Matt Schulte wrote:
> Russell King wrote:
> >
> >It's true of all 8250 compatibles which don't have hardware RS485
> >support.  I think that's all of them except 16850 and 16960.
> >
> 
> Just for the sake of completeness, the Oxford Semi 16c950 also has 
> hardare 485 control, as do Exar's PCI based 17d15x UARTs.

For the elimination of confusion, that '960' was a typo - it should've
been 950, since it was the set of Oxford 950 devices I was referring to.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
