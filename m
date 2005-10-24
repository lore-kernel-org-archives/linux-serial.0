From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] serial: support the Exsys EX-4055 4S four-port card
Date: Mon, 24 Oct 2005 22:13:59 +0100
Message-ID: <20051024211359.GD26959@flint.arm.linux.org.uk>
References: <200510241058.31419.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20751 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751299AbVJXVOG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Oct 2005 17:14:06 -0400
Content-Disposition: inline
In-Reply-To: <200510241058.31419.bjorn.helgaas@hp.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-serial@vger.kernel.org, Wolfgang Denk <wd@denx.de>

On Mon, Oct 24, 2005 at 10:58:31AM -0600, Bjorn Helgaas wrote:
> Tested by Wolfgang Denk with this device:
> 
>     00:0f.0 Network controller: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 01)
>         Subsystem: Exsys EX-4055 4S(16C550) RS-232
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=128]
>         Region 1: I/O ports at 7080 [size=128]
>         Region 2: I/O ports at 7400 [size=32]
> 
>     00:0f.0 Class 0280: 10b5:9050 (rev 01)
>         Subsystem: d84d:4055
> 
> Results with this patch:
> 
>     Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
>     ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>     PCI: Found IRQ 10 for device 0000:00:0f.0
>     ttyS4 at I/O 0x7400 (irq = 10) is a 16550A
>     ttyS5 at I/O 0x7408 (irq = 10) is a 16550A
>     ttyS6 at I/O 0x7410 (irq = 10) is a 16550A
>     ttyS7 at I/O 0x7418 (irq = 10) is a 16550A
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
