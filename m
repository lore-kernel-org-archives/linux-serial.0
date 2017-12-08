From: Helge Deller <deller@gmx.de>
Subject: Re: Have my PA8800 back online... (serial port missing on v4.14)
Date: Fri, 8 Dec 2017 20:06:44 +0100
Message-ID: <20171208190644.GA22228@ls3530.fritz.box>
References: <53815372-58e8-70e2-bab4-1777e848cf5e@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53815372-58e8-70e2-bab4-1777e848cf5e@web.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Frank Scheiner <frank.scheiner@web.de>, linux-parisc@vger.kernel.org, John David Anglin <dave.anglin@bell.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org
Cc: debian-hppa@lists.debian.org
List-Id: linux-serial@vger.kernel.org

Adding the linux-serial mailing list:

* Frank Scheiner <frank.scheiner@web.de>:
> On 12/04/2017 03:54 PM, Helge Deller wrote:
> > Anyway, the *only* problem we have right now is, that the Linux kernel 4.14 doesn't detect all serial ports which were detected in earlier kernels.
> > Thus the kernel will talk to the non-existant serial port at 0xfffffffff4050010 instead of 0xfffffffff4050000.
> > 
> > 4.13:
> > [   28.882849] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [   28.898720] 0000:e0:01.0: ttyS0 at MMIO 0xfffffffff4051000 (irq = 73, base_baud = 115200) is a 16450
> > [   28.934669] 0000:e0:01.1: ttyS1 at MMIO 0xfffffffff4050000 (irq = 73, base_baud = 115200) is a 16550A
> > [   28.963031] 0000:e0:01.1: ttyS2 at MMIO 0xfffffffff4050010 (irq = 73, base_baud = 115200) is a 16550A
> > [   28.984946] 0000:e0:01.1: ttyS3 at MMIO 0xfffffffff4050038 (irq = 73, base_baud = 115200) is a 16550A
> 
> > 
> > ...but for v4.14.x only the following serial ports are detected:
> > [   28.671984] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [   28.708902] 0000:e0:01.1: ttyS0 at MMIO 0xfffffffff4050000 (irq = 73, base_baud = 115200) is a 16550A
> > [   28.731145] 0000:e0:01.1: ttyS1 at MMIO 0xfffffffff4050010 (irq = 73, base_baud = 115200) is a 16550A
> > 
> > 
> > Maybe reverting this commit brings back the old behavior:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d8905d064058f4b65057e0101588f362f288bc0
> 
> I'm unsure about this commit, it speaks more of avoiding duplicate messages
> for device enabling.

Reverting this commit:

commit 7d8905d064058f4b65057e0101588f362f288bc0
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Jul 24 20:28:32 2017 +0300

    serial: 8250_pci: Enable device after we check black list

indeed fixes the problem.

After reverting, the serial port from the Diva card shows up as ttyS0 (as before).
With that patch applied, the serial port from the Diva card gets
ignored and the previous ttyS1 port becomes ttyS0 which then breaks
booting the parisc machine because the kernel expects the serial port on
ttyS1.


I'm not sure what the best way forward is.
Fact is, that the patch above changes the behaviour and serial ports
which were existant before suddenly vanish with kernel 4.14.

This following patch does work, and adds back the Diva serial port on parisc.
Not sure if it's acceptable though.

Helge

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0c101a7470b0..61319e968e8c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3393,6 +3393,10 @@ static int serial_pci_is_class_communication(struct pci_dev *dev)
 	 * (Should we try to make guesses for multiport serial devices
 	 * later?)
 	 */
+	if (IS_ENABLED(CONFIG_PARISC) &&
+	    (dev->class >> 8) == PCI_CLASS_COMMUNICATION_OTHER)
+		return 0;
+
 	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
 	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
 	    (dev->class & 0xff) > 6)
