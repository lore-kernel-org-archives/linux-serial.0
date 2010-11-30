From: Greg KH <greg@kroah.com>
Subject: Re: 2.6.25 upgraded to 2.6.36: serial app stops working
Date: Tue, 30 Nov 2010 08:42:32 -0800
Message-ID: <20101130164232.GB18017@kroah.com>
References: <20101130162754.GI5654@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:42007 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab0K3QoE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Nov 2010 11:44:04 -0500
Content-Disposition: inline
In-Reply-To: <20101130162754.GI5654@belle.intranet.vanheusden.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: folkert <folkert@vanheusden.com>
Cc: linux-serial@vger.kernel.org

On Tue, Nov 30, 2010 at 05:27:55PM +0100, folkert wrote:
> Hi,
> 
> I upgraded my linux system to 2.6.36. Now suddenly my serial driver for
> my MSF receiver stopped working. Two things I noticed: I need to open
> the serial device (/dev/ttyS0, a regular uart, see below) with O_NDELAY
> for open() to return at all. Then something funny happens: I read bytes
> from the device (at 50bps) which runs fine for a while but then suddenly
> I get a burst of '0x00' bytes - precisely at the point at which the MSF
> radio device sends a timecode! So I think the device fiddles with one of
> the pins of the serial port confusing the linux serial driver. This
> worked fine upto and including 2.6.25 (maybe later too) but with 2.6.36
> this fails.
> Anyone an idea what might go wrong here? And how to fix it?

Any chance you could use 'git bisect' on the kernel tree to see what
caused the change?  Moving from .25 to .36 is a huge jump, many many
years of development and loads of things have changed so we need some
help to narrow the problem down.

thanks,

greg k-h
