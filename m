From: Brad Davis <enrock@gmail.com>
Subject: Us Robotics (5610) Modem on PPC
Date: Tue, 26 Jul 2005 20:09:33 -0600
Message-ID: <88e823ff050726190921813727@mail.gmail.com>
Reply-To: Brad Davis <enrock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:5490 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262000AbVG0CJe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jul 2005 22:09:34 -0400
Received: by zproxy.gmail.com with SMTP id i11so77247nzh
        for <linux-serial@vger.kernel.org>; Tue, 26 Jul 2005 19:09:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm trying to get a PCI-USRobotics Modem (Yes, it is a true hardware
modem) working on a G4 with Kernel version 2.6.10.

Everything looks good with lspci -vv (below). The card has an
allocated IO address (0x1020) and IRQ (53). It is disabled (I/O-), but
I understand the serial driver will enable it when it is found. There
are no /dev/ttyS* devices, but I also understand that these will be
created by the driver/udev system when the module has been correctly
loaded.

The problem is when I try to "modprobe 8250_pci". I get the following
error message:

WARNING: Error inserting 8250
(/lib/modules/2.6.10enrock.2/kernel/drivers/serial/8250.ko): No such
device
FATAL: Error inserting 8250_pci
(/lib/modules/2.6.10enrock.2/kernel/drivers/serial/8250_pci.ko):
Unknown symbol in module, or unknown parameter (see dmesg)

The appropriate lines from dmesg are:

serial8250_init: nothing to do on PowerMac
8250_pci: Unknown symbol serial8250_unregister_port
8250_pci: Unknown symbol serial8250_resume_port
8250_pci: Unknown symbol serial8250_register_port
8250_pci: Unknown symbol serial8250_suspend_port

Which to me appear to be errors due to the fact that the 8250 (a
dependancy of 8250_pci) doesn't load. The "serial_core" module (a
dependancy of 8250) seems to be correctly loaded as it shows up with a
lsmod. I get the same results whether I enable the PCI card (via
"setpci -d 12b9:1008 command=1") before the modprobe or not.

I am currently dual-booting this machine with YDL (2.3??), and the
modem works fine there. Of course it is using the 2.4.X kernel so I
suspect something has changed in the new 2.6.X modules.

Output from lspci -vv:
0001:11:03.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model
5610 (rev 01) (prog-if 02 [16550])
        Subsystem: 5610 56K FaxModem USR 56k Internal Voice Modem (Model 2976)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 53
        Region 0: I/O ports at 1020 [disabled] [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Can someone point me in the right direction to get this card working
with the 2.6 kernel stream?

Thanks in advance for any help.
-- 
enrock@gmail.com
