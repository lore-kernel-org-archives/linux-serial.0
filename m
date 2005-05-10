From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] add ignore_ports option
Date: Tue, 10 May 2005 10:01:05 -0300
Message-ID: <20050510130104.GE3907@cathedrallabs.org>
References: <20050510121151.GA4676@cathedrallabs.org> <20050510135000.B3358@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from panda.sul.com.br ([200.219.150.4]:12557 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S261643AbVEJNbr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 09:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20050510135000.B3358@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org

Hi,
> > Hi,
> > 	this patch adds an option to 8250 driver to avoid probing for a
> > 	serial port in specified addresses.
> > 	Please consider applying
> 
> You don't say why this is desireable.
	this is needed when you have to compile serial driver built-in
	for serial console but have, for example, an IRDA device in one
	of the ports. In my notebook this happens and I'm unable to load
	nsc-ircc driver after that because the I/O range is already
	taken:
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
(...)
nsc-ircc, Found chip at base=0x02e
nsc-ircc, driver loaded (Dag Brattli)
nsc_ircc_open(), can't get iobase of 0x2f8

-- 
Aristeu

