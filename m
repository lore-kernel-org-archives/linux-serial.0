From: Marc Boucher <marc@linuxant.com>
Subject: Re: Major problem with serial driver and serial_pci_guess_board()
Date: Tue, 26 Aug 2003 16:48:30 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030826204830.GA30364@endlich.mbsi.ca>
References: <20030826182745.GA29051@endlich.mbsi.ca> <20030826201601.J28810@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:42505
	"EHLO valve.mbsi.ca") by vger.kernel.org with ESMTP id S261353AbTHZUsk
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Aug 2003 16:48:40 -0400
Content-Disposition: inline
In-Reply-To: <20030826201601.J28810@flint.arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, arjanv@redhat.com, jsimon@linuxant.com

Hi Russell,

On Tue, Aug 26, 2003 at 08:16:01PM +0100, Russell King wrote:
> On Tue, Aug 26, 2003 at 02:27:46PM -0400, Marc Boucher wrote:
> > This problem appears to be present in all recent serial driver variants,
> > including those in 2.6 and the latest RedHat Severn beta. It is
> > a serious issue preventing our drivers from working correctly.
> 
> My only interest is in 2.6, and the messages appear to be from a
> 2.4 kernel.  It does seem that we are detecting a device incorrectly,
> since we aren't finding an 8250-compatible serial port.

The messages indeed came from a 2.4 kernel, specifically
2.4.21-20.1.2024.2.1.nptl (included in RedHat Severn).

But a similar problem occurs under 2.6 (tested with Arjan's
2.6.0-0.test4.1.32 rpm):

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ttyS2 at I/O 0x1428 (irq = 10) is a 8250
ttyS3 at I/O 0x1440 (irq = 10) is a 8250

[root@xe4000 root]# lspci -vvx -d 10b9:5457
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if
00 [Generic])
        Subsystem: Hewlett-Packard Company: Unknown device 0025
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0002000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at 1400 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 57 54 03 00 90 02 00 00 03 07 00 40 00 00
10: 00 20 00 e0 01 14 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 25 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00

After a closer look it seems that most of the boards I previously listed
(especially the newer ones) fortunately use PCI_CLASS_COMMUNICATION_OTHER,
not PCI_CLASS_COMMUNICATION_SERIAL or PCI_CLASS_COMMUNICATION_MODEM which
the serial driver looks for.

Still, the ALI AC-Link MC97 device (in an HP laptop here) uses
PCI_CLASS_COMMUNICATION_MODEM and has I/O ports so it gets picked
up by the serial driver.

> Unfortunately, we don't have tables of exclusion, nor do we have
> a clean method to do that at present in any kernel.

Would it not be possible to include devices we *know* use the confusing
class IDs in the pci_serial_quirks table with an initialization
routine that always fails? (under 2.6; for 2.4 we might need to
implement something equivalent)

> What I'd like to see is the output from lspci -vvx from a range of
> PCI cards with this problem to see if there is characteristic (eg,
> the PCI class/programming interface IDs) we can pick up on.

I'll try to send you that info as we confirm other cases..

Many thanks for the quick response,
Marc

> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
