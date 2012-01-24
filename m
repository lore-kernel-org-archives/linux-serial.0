From: Greg KH <greg@kroah.com>
Subject: Re: Support for Perle Systems Speed/LE-8
Date: Tue, 24 Jan 2012 09:11:41 -0800
Message-ID: <20120124171141.GA26908@kroah.com>
References: <4F1E4D69.3040907@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35242 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393Ab2AXRTT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Jan 2012 12:19:19 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 60D2C21145
	for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2012 12:19:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4F1E4D69.3040907@redfish-solutions.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Philip Prindeville <philipp@redfish-solutions.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jan 23, 2012 at 11:19:21PM -0700, Philip Prindeville wrote:
> Hi.
> 
> I have a Perle Speed/LE-8 card that's poorly supported (cough) by the vendor.
> 
> The design seems to be plain-vanilla enough: it uses Oxford 9501 and 9511 chips.
> 
> $ lspci -v -n -s 04:07
> 04:07.0 0700: 155f:b008 (prog-if 06 [16950])
> 	Subsystem: 1415:9501
> 	Flags: medium devsel, IRQ 21
> 	I/O ports at ec00 [size=32]
> 	Memory at fbfff000 (32-bit, non-prefetchable) [size=4K]
> 	I/O ports at e880 [size=32]
> 	Memory at fbffe000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [40] Power Management version 1
> 	Kernel driver in use: perle-serial
> 	Kernel modules: perle-serial
> 
> 04:07.1 0680: 155f:b008
> 	Subsystem: 1415:9511
> 	Flags: medium devsel, IRQ 21
> 	I/O ports at e800 [size=32]
> 	Memory at fbffd000 (32-bit, non-prefetchable) [size=4K]
> 	I/O ports at e480 [size=32]
> 	Memory at fbffc000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [40] Power Management version 1
> 	Kernel driver in use: perle-serial
> 	Kernel modules: perle-serial
> 
> 
> $
> 
> There's nothing funky about this card except that one of the lines is
> either DTR or RTS if I've understood the scarce documentation.
> 
> Anyway, I was wondering what's involved in getting the
> drivers/tty/serial/8250_pci.c to support this?

Have you tried adding the pci device ids to the driver and see how well
it works, or not?

greg k-h
