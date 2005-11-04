From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pmac serial_pci_guess_board problem
Date: Sat, 05 Nov 2005 08:47:40 +1100
Message-ID: <1131140861.29195.13.camel@gaston>
References: <436BD229.3090401@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:64720 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750940AbVKDVss (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Nov 2005 16:48:48 -0500
In-Reply-To: <436BD229.3090401@am.sony.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

On Fri, 2005-11-04 at 13:27 -0800, Geoff Levand wrote:
> Russell,
> 
> I found that the serial port probe code in drivers/serial/8250_pci.c 
> no longer works properly for PowerMac G5 in 2.6.14.  It seems some new
> code now takes the PCI device info directly from the G5's Open 
> Firmware.  The trouble is that OF sets the address length to 16 bytes, 
> not the expected 8 bytes.
> 
> Here's a fix, but I'd be interested to hear your comments.

I wouldn't do the ifdef at all ... Why do we bother testing the size
anyway ? Russell ?

Ben.

