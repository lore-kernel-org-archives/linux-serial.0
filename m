From: Mark Lord <lkml@rtr.ca>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
Date: Mon, 19 Jun 2006 15:45:06 -0400
Message-ID: <4496FEC2.8050903@rtr.ca>
References: <20060619180658.58945.qmail@web52908.mail.yahoo.com> <20060619184706.GH3479@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:45232 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964866AbWFSTpI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jun 2006 15:45:08 -0400
In-Reply-To: <20060619184706.GH3479@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Russell King wrote:
>
> This seems to be an invalid situation - you appear to have an _ISA_
> NE2000 card using IRQ3, trying to share the same interrupt as a
> serial port.
> 
> ISA interrupts aren't sharable without additional hardware support
> or specific software support in the Linux kernel interrupt
> architecture.

If the drivers are written "correctly", they shouldn't grab the IRQ
until someone actually opens the device.  Which means they should be
able the share the IRQ, so long as both devices are not in use (open)
at the same time.

Cheers

