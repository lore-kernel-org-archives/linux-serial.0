From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/4] rework quirks for the "kt" serial port
Date: Mon, 09 Apr 2012 11:21:58 -0700
Message-ID: <20120409182041.317.33360.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Changes since v1: http://marc.info/?l=linux-serial&m=133373702606784&w=2

1/ rebased series on 3.4-rc2 to fix up a collision in patch 2 and
   dropped the recently accepted patches out of this series

2/ introduced quirk infrastructure for open firmware serial devices and
   hooked it up for Tegra's serial quirk

3/ updated the changelog in patch 4 to show the problems with quirk
   handling during resume

4/ added Alan's ack to patches 2-4.  patch 1 is new.

Patch 1-3 are targetted at 3.5 (pending an ack from Tegra folks), patch
4 is a RFC as the KT resume case was already fixed by "Revert
"serial/8250_pci: init-quirk msi support for kt serial controller"

---

Dan Williams (3):
      of_serial: add support for setup quirks
      tegra, serial8250: add ->handle_break() uart_port op
      serial/8250_pci: fix suspend/resume vs init/exit quirks

Sudhakar Mamillapalli (1):
      serial/8250_pci: Clear FIFOs for Intel ME Serial Over Lan device on BI


 arch/arm/configs/tegra_defconfig      |    1 
 arch/arm/mach-tegra/board-harmony.c   |    4 +
 arch/arm/mach-tegra/board-paz00.c     |    5 ++
 arch/arm/mach-tegra/board-seaboard.c  |    4 +
 arch/arm/mach-tegra/board-trimslice.c |    4 +
 arch/arm/mach-tegra/devices.h         |    1 
 drivers/tty/serial/8250/8250.c        |   44 +++++----------
 drivers/tty/serial/8250/8250.h        |    2 +
 drivers/tty/serial/8250/8250_pci.c    |   45 ++++++++++++++++
 drivers/tty/serial/Kconfig            |    8 +++
 drivers/tty/serial/of_serial.c        |   95 ++++++++++++++++++++++++++-------
 include/linux/of_serial.h             |   17 ++++++
 include/linux/serial_8250.h           |    1 
 include/linux/serial_core.h           |    5 ++
 14 files changed, 183 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/of_serial.h
