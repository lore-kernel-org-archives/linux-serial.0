From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 0/5] Remove UPIO_DWAPB{,32} from 8250 driver
Date: Tue, 16 Aug 2011 15:20:26 +0100
Message-ID: <20110816142026.GH2786@pulham.picochip.com>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
 <201108161605.08811.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48601 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1HPOUe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 10:20:34 -0400
Received: by wwf5 with SMTP id 5so5926169wwf.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Aug 2011 07:20:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201108161605.08811.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org

On Tue, Aug 16, 2011 at 04:05:08PM +0200, Arnd Bergmann wrote:
> On Monday 15 August 2011, Jamie Iles wrote:
> > 
> > This is just a repost of a series from a couple of months ago to remove
> > the special DWAPB 8250 handling from the generic driver.
> > 
> > Arnd, I'd have a platform that needs some special handlers like these
> > using the device tree and of_serial.  Once these are merged I plan on
> > passing the serial_{in,out} and handle_irq callbacks through
> > platform_data to of_serial.  Does this seem sensible?
> 
> Do you mean passing through the uart_port? Yes, that seems sensible.
> Depending on how complicated the callbacks are, it might be
> simpler to write a new platform_driver based on of_serial.c for
> your device that hardcodes these.

Well for my platform it's handling the DesignWare variant of the 8250 
but the bus restricts us to 32-bit accesses.

> The of_serial driver started out with the goal of covering all sorts
> of serial port devices based on device tree probing, but with the
> direction that the platform drivers have moved to, this seems a bit
> silly, and I think we should take the NWPSERIAL support out and
> rename it to 8250_of.c.

In that case I could add an ns8250dw compatible string and put the 
handlers into here (both 8 and 32 bit variants).  Note that the MIPS 
user that I've removed in this series should probably still keep the 
accessors in the platform code as they've remapped the USR to a 
different location to the Synopsys spec.

Jamie
