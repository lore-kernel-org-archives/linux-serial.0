From: Luca <kronos@kronoz.cjb.net>
Subject: Re: Garbage on serial console after serial driver loads
Date: Fri, 25 Mar 2005 22:01:32 +0100
Message-ID: <20050325210132.GA11201@dreamland.darkstar.lan>
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:42904 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261800AbVCYVBm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2005 16:01:42 -0500
Content-Disposition: inline
In-Reply-To: <20050325203853.C12715@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Linux Serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org

Il Fri, Mar 25, 2005 at 08:38:53PM +0000, Russell King ha scritto: 
> On Fri, Mar 25, 2005 at 09:24:15PM +0100, Luca wrote:
> > I attached a null modem cable to my notebook and I'm seeing garbage as
> > soon as the serial driver is loaded. I tried booting with init=/bin/bash
> > to be sure that it's not some rc script doing strange things to the
> > serial port, but this didn't solve the problem.
> 
> I'm uncertain how this problem can occur, unless you have one of:
> 
> * serial debugging enabled (which isn't compatible with serial console)

Do you mean #define DEBUG in serial_core.c? No.

> * a NS16550A, in which case dwmw2 needs to rework his autodetect code to
>   adjust the baud rate appropriately.

Well, serial_core seems to think so:

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A

Luca
-- 
Home: http://kronoz.cjb.net
La mia opinione puo` essere cambiata, ma non il fatto che ho ragione.
