From: Dirk Arnold <dirk.arnold@cs.uni-dortmund.de>
Subject: cardbus modem not handled by the serial driver
Date: Tue, 14 Jan 2003 12:57:12 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3E23FB18.5080506@cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

   Hi there,

   My Xircom RBM56G cardbus modem works fine with the
serial_cb driver in 2.2 kernels, but is not handled
correctly by the serial driver in 2.4 kernels.  I've
been trying to add support for that modem to serial.c,
but I don't understand the driver well enough in order
to make it work.  If there is anyone who can help me
with suggestions, I'd be happy to do the testing.

   Here's what I've tried: as the modem/ethernet combo
apparently is handled correctly by the serial driver,
I tried adding

{   PCI_VENDOR_ID_XIRCOM, 0x0101,
      PCI_ANY_ID, PCI_ANY_ID, 0, 0,
      pbn_xircom_combo },

to __devinitdata.  The result in the system logs is
this:

kernel: cs: cb_alloc(bus 2): vendor 0x115d, device 0x0101
kernel: PCI: Enabling device 02:00.0 (0000 -> 0003)
kernel: ttyS4 at port 0x4000 (irq = 10) is a 16550A
cardmgr[527]: initializing socket 0
cardmgr[527]: socket 0: Serial or Modem
cardmgr[527]: executing: 'modprobe serial_cs'
kernel: serial_cs: ParseTuple: No more items
cardmgr[527]: executing: './serial start serial'
/etc/hotplug/pci.agent: ... no modules for PCI slot 02:00.0
cardmgr[527]: + don't know how to make device "serial"
cardmgr[527]: + /dev/serial: No such file or directory
last message repeated 2 times
cardmgr[527]: exiting

I'd be happy to hear any better suggestions.
   Thanks,
     Dirk

