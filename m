From: ian <spyro@f2s.com>
Subject: Re: How to use serial ports from a kernel module.
Date: Sat, 26 Jan 2008 22:30:16 +0000
Message-ID: <1201386616.3368.10.camel@wirenth>
References: <1201375164.3368.6.camel@wirenth>
	 <Pine.LNX.4.64.0801262138470.3642@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mk-outboundfilter-4.mail.uk.tiscali.com ([212.74.114.32]:18807
	"EHLO mk-outboundfilter-4.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115AbYAZWaU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 Jan 2008 17:30:20 -0500
In-Reply-To: <Pine.LNX.4.64.0801262138470.3642@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-serial@vger.kernel.org


On Sat, 2008-01-26 at 21:41 +0100, Guennadi Liakhovetski wrote:

> You need to write a line discipline... have a look here: 
> http://www.linux.it/~rubini/docs/serial/serial.html

Hi,

Thanks for the reply!

What I cant see from that is how one can avoid touching userspace at all
- as far as I can see, only userspace can actually attach a line
discipline to a serial port. I'd like to have this happen in the kernel
so that I dont need some program sitting idly opening the serial device
the whole time.

Thanks,

-Ian!

