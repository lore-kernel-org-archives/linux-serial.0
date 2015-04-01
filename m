From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V3 0/1] serial: 8250_pci: Fintek products S3 patch
Date: Wed,  1 Apr 2015 14:00:20 +0800
Message-ID: <1427868021-4027-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, hpeter+kernel@gmail.com, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The patch works for Fintek F81504/F81508/F81512 PCI to Serial Port IC.
Serial port of this IC will failed after wakeup from S3(STR).

It's due to this PCI device's configuration space from 0x40 to 
0x40 + max_port * 0x08 should be re-configured when the system wakeup from 
S3(STR). If had no re-configure after S3, It's will all zero. It's will make
uart function disabled.

We move all initialization from pci_fintek_setup() to pci_fintek_init() and
set it to pci_serial_quirks struct .init section. It's will re-init this 
device when system wakeup from pciserial_resume_ports().

V3 changelog
1. due to cleanup code patch is applied, this patch is following branch
   tty_testing fbf47635315ab308c9b58a1ea0906e711a9228de.

V2 changelog (old)
1. swap pci_fintek_setup() / pci_fintek_init() location in source code to
   make diff more readable

V1 changelog (old)
1. Initial version, including 2 patches, one is cleanup code, another is fix
   S3 bug. 

Peter Hung (1):
  serial: 8250_pci: port failed after wakeup from S3

 drivers/tty/serial/8250/8250_pci.c | 114 ++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 64 deletions(-)

-- 
1.9.1
