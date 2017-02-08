From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 0/7] serial: exar: Fixes and cleanups
Date: Wed,  8 Feb 2017 17:09:02 +0100
Message-ID: <cover.1486570149.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Changes in v2:
- line rewrapped in patch 2 [Andy]
- reordered PCI ID list [Andy]
- removed obsolete constants from 8250_pci [Andy]
- added Commtech devices to 8250_pci blacklist [Andy]

Original intro:

Fixes one fall-out from the exar split-up and two longer pending issue
regarding the correct initialization of exar registers ports > 0.
Furthermore, it moves remaining exar code over to the new module and
also cleans up & fixes some registers defines.

This includes the previously posted "Fix EXAR feature control register
constants".

Note that I have no chance to test the Commtech change on real hardware.

Jan

Jan Kiszka (7):
  serial: exar: Fix mapping of port I/O resources
  serial: exar: Fix initialization of EXAR registers for ports > 0
  serial: exar: Fix feature control register constants
  serial: exar: Move Commtech adapters to 8250_exar as well
  serial: pci: Remove unused pci_boards entries
  serial: exar: Move register defines from uapi header to consumer site
  serial: exar: Enable MSI support

 drivers/tty/serial/8250/8250_exar.c | 129 ++++++++++++++++++++++++-----
 drivers/tty/serial/8250/8250_pci.c  | 161 +-----------------------------------
 drivers/tty/serial/8250/8250_port.c |   6 ++
 include/uapi/linux/serial_reg.h     |  18 ----
 4 files changed, 117 insertions(+), 197 deletions(-)

-- 
2.1.4
