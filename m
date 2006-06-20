From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Wed, 21 Jun 2006 01:20:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0606210049190.4702@be1.lrz>
References: <6pwmi-8mW-1@gated-at.bofh.it> <6px8R-Y7-43@gated-at.bofh.it>
 <6pxV5-2ci-13@gated-at.bofh.it> <6pz12-3Rg-67@gated-at.bofh.it>
 <6pzX4-5jE-19@gated-at.bofh.it> <6pA6B-5K8-33@gated-at.bofh.it>
 <E1FshOP-0000pd-No@be1.lrz> <20060620180313.GC7463@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:46727 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751375AbWFTXUZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jun 2006 19:20:25 -0400
In-Reply-To: <20060620180313.GC7463@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: 7eggert@gmx.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <lkml@rtr.ca>, Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 20 Jun 2006, Russell King wrote:
> On Tue, Jun 20, 2006 at 04:39:49PM +0200, Bodo Eggert wrote:

> > There are thousands of NE2K-clones, the driver can't know if sharing the IRQ
> > will be OK for a given card. Is the change for sharing IRQs trivial enough
> > to allow an if/else based on a load-time module parameter?
> 
> Not if it's an ISA card.  You need to loop over all interrupt source
> devices until you're certain that they have released the interrupt
> line before returning, otherwise you will end up with the IRQ line
> stuck in a state where it can't cause any further interrupts.
> 
> The kernel has no such infrastructure, except within the serial driver
> to allow multiple serial ports to share a common interrupt.

What a pity - I hoped for a grab_shared_irq() which would do what you 
describe.

-- 
Is reading in the bathroom considered Multitasking? 
