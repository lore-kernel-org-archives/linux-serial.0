From: folkert <folkert@vanheusden.com>
Subject: serial port on pci-e adapter not working / on-board neither
Date: Thu, 12 Jul 2012 22:04:51 +0200
Message-ID: <20120712200450.GH27892@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from keetweej.vanheusden.com ([80.101.105.103]:39406 "EHLO
	keetweej.vanheusden.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758140Ab2GLUEx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 16:04:53 -0400
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 4E01515F893
	for <linux-serial@vger.kernel.org>; Thu, 12 Jul 2012 22:04:51 +0200 (CEST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have a C7 system with an on-board serial port. This port is detected
and I can 'cat' it (no 'safety check engaged').
It seems this port is not usuable for a baycom modem though. I verified
that the baycom modem works fine on an other system. On this system it
doesn't work; it doesn't "see" that the system sends data.

So for that I added a PCI-E serial port adapter:
02:00.0 Serial controller: NetMos Technology Device 9904 (prog-if 02
[16550])
        Subsystem: Device a000:1000
        Flags: fast devsel, IRQ 24
        I/O ports at d480 [size=3D8]
        Memory at fe9f9000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at fe9f8000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, MSI 00

02:00.1 Serial controller: NetMos Technology Device 9904 (prog-if 02
[16550])
        Subsystem: Device a000:1000
        Flags: fast devsel, IRQ 25
        I/O ports at d800 [size=3D8]
        Memory at fe9fb000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at fe9fa000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, MSI 00

02:00.2 Serial controller: NetMos Technology Device 9904 (prog-if 02
[16550])
        Subsystem: Device a000:1000
        Flags: fast devsel, IRQ 26
        I/O ports at d880 [size=3D8]
        Memory at fe9fd000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at fe9fc000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, MSI 00

02:00.3 Serial controller: NetMos Technology Device 9904 (prog-if 02
[16550])
        Subsystem: Device a000:1000
        Flags: fast devsel, IRQ 27
        I/O ports at dc00 [size=3D8]
        Memory at fe9ff000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at fe9fe000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, MSI 00

Problem now is: it is detected but no serial ports are "created".

[    1.165293] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.165430] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.165930] 00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.166139] serial 0000:02:00.0: PCI->APIC IRQ transform: INT A -> I=
RQ 24
[    1.166174] serial 0000:02:00.1: PCI->APIC IRQ transform: INT B -> I=
RQ 25
[    1.166206] serial 0000:02:00.2: PCI->APIC IRQ transform: INT C -> I=
RQ 26
[    1.166238] serial 0000:02:00.3: PCI->APIC IRQ transform: INT D -> I=
RQ 27

This is with 'acpi=3Doff'. If I do not add that, then I get a message t=
hat
'INT A-D is disabled'.

Anyone got a suggestion what to do?


=46olkert van Heusden

--=20
MultiTail =E8 uno flexible tool per seguire di logfiles e effettuazione
di commissioni. Feltrare, provedere da colore, merge, 'diff-view',
etc. http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
