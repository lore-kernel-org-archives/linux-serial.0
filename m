From: Marc Boucher <marc@linuxant.com>
Subject: Major problem with serial driver and serial_pci_guess_board()
Date: Tue, 26 Aug 2003 14:27:46 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030826182745.GA29051@endlich.mbsi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:29449
	"EHLO valve.mbsi.ca") by vger.kernel.org with ESMTP id S262116AbTHZS2H
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Aug 2003 14:28:07 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: rmk@arm.linux.org.uk, serial-pci-info@lists.sourceforge.net, linux-serial@vger.kernel.org, arjanv@redhat.com, jsimon@linuxant.com

Hi folks,

It seems that serial_pci_guess_board() is incorrectly detecting
and claiming devices that it can't handle, like ALI AC97 modems
(and perhaps also others such as VIA, and Intel ICH MC97 codecs),
which are supported by our HSF and HCF modem drivers. But since
the serial driver has falsely claimed the device, our driver's
probe() routine never gets called.

This problem appears to be present in all recent serial driver variants,
including those in 2.6 and the latest RedHat Severn beta. It is
a serious issue preventing our drivers from working correctly.

For example:

00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]

00:08.0 Class 0703: 10b9:5457
        Subsystem: 103c:0025
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


PCI: Enabling device 00:08.0 (0000 -> 0003)
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (10b9,5457,103c,0025)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed

But the serial driver has, despite the autoconfig error messages,
still attached itself to the device, preventing any other
(proper) driver from doing so later.

If the serial driver is statically compiled in the kernel,
it seems that there is no workaround for the user other than
rebuilding the kernel which is not something that your average
new linux user is capable of doing. Doing a setserial uart none
on the port doesn't seem to release the PCI device.

IMHO an init/module parameter should exist to disable the
guessing and perhaps also a list of devices to be
automatically excluded from serial_pci_guess_board().

Opinions?

Arjan, any chance we could get this patched in time for the next
Redhat release?

Regards
Marc

PS: We would include the following PCI IDs in the list of exclusions:

ALI AC-Link
        PCI ID 10B9:5453
        PCI ID 10B9:5457

Intel AC-Link (ICH)
        PCI ID 8086:2416
        PCI ID 8086:2446
        PCI ID 8086:2486
        PCI ID 8086:24C6
        PCI ID 10DE:01C1 (Nvidia variant)

VIA AC-Link
        PCI ID 1106:3068


ATI AC-Link
		PCI ID 1002:434D

SIS AC-Link
		PCI ID 1039:7013

HSF/HSFi (Standard and SmartDAA)

        PCI ID {127A,14F1}:{2013,2014,2015,2016}
        PCI ID {127A,14F1}:4311 (RIPTIDE)
        PCI ID {127A,14F1}:{1023,1024,1025,1026} (else try HCF driver)
        PCI ID {127A,14F1}:{2004,2005,2006} (else try HCF driver)
        PCI ID 127A:2114

        PCI ID 14F1:{2043,2044,2045,2046}
        PCI ID 14F1:{2063,2064,2065,2066}
        PCI ID 14F1:2093
        PCI ID 14F1:{201A,201B}
        PCI ID 14F1:{204A,204B}
        PCI ID 14F1:{2143,2144,2145,2146}
        PCI ID 14F1:{2163,2164,2165,2166}
        PCI ID 14F1:{2343,2344,2345,2346}
        PCI ID 14F1:{2363,2364,2365,2366}
        PCI ID 14F1:{2443,2444,2445,2446}
        PCI ID 14F1:{2463,2464,2465,2466}

        PCI ID 14F1:{2F00,2F01,2F02,2F03,2F04}
        PCI ID 14F1:{2F10,2F11,2F12,2F13,2F14}
        PCI ID 14F1:2702
        PCI ID 14F1:2F02

        PCI ID 14F1:{158B,0001} (Allied Data Technologies)
        PCI ID 14F1:{158B,0005} (Allied Data Technologies)


HCF
        PCI ID {127A,14F1}:{1002,1003,1004,1005} (71DP v90)
        PCI ID {127A,14F1}:{1023,1024,1025,1026} (else try HSF driver)
        PCI ID {127A,14F1}:{2004,2005,2006} (else try HSF driver)
        PCI ID {127A,14F1}:{1033,1034,1035,1036}
        PCI ID {127A,14F1}:{1085}
        PCI ID {127A,14F1}:{4321} (RIPTIDE)
        PCI ID 14F1:{10B3,10B4,10B5,10B6}
        PCI ID 14F1:{1803,1813,1815} (LAN/Modem Combo)
        PCI ID 14F1:{1F10,1F11,1F14,1F15}
        PCI ID 14F1:{1053,1054,1055,1056} (SmartHCF board rev 3)
        PCI ID 14F1:{1052,1057,1059} (SmartHCF board rev 4)
        PCI ID 14F1:{1063,1064,1065,1066} (SmartHCF US-only, Dell)
        PCI ID 14F1:{1453,1454,1455,1456} (SmartHCF mini-PCI board rev
3)
        PCI ID 14F1:{1452,1457,1459} (SmartHCF mini-PCI board rev 4)
        PCI ID 148D:1003 (DIGICOM Systems)
        PCI ID 158B:0015 (Allied Data Technologies Tornado VFM56x-PRC)
        PCI ID 141A:1035 (Apache Micro)

