From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V2 RESEND 0/2] serial: 8250_pci: Fintek products patches
Date: Tue, 17 Mar 2015 18:02:13 +0800
Message-ID: <1426586535-6900-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

These series patches works for Fintek F81504/F81508/F81512 PCI to Serial Port.
and patch 0002 is following with patch 0001.

patch 0001 is just cleanup non-used source code.
patch 0002 is major patch.

The serial port of our product will failed after wakeup from S3(STR).

It's due to when the system wakeup from S3(STR), this PCI device's
configuration space from 0x40 to 0x40 + max_port * 0x08 should be
re-configured. If had no re-configure, It's will all zero.

We move all initialization from pci_fintek_setup() to pci_fintek_init() and
set it to pci_serial_quirks struct .init section. It's will re-init this 
device when system wakeup from pciserial_resume_ports().

Peter Hung (2):
  serial: 8250_pci: remove non-used var for F81504
  serial: 8250_pci: port failed after wakeup from S3

 drivers/tty/serial/8250/8250_pci.c | 121 +++++++++++++++----------------------
 1 file changed, 50 insertions(+), 71 deletions(-)
 mode change 100644 => 100755 drivers/tty/serial/8250/8250_pci.c

-- 
1.9.1
