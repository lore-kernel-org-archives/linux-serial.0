From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 0/3] rework quirks for the "kt" serial port
Date: Tue, 10 Apr 2012 14:10:48 -0700
Message-ID: <20120410210438.13805.40525.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Changes since v3: http://marc.info/?l=linux-serial&m=133400008811070&w=2

* Cleaned up "tegra, serial8250: add ->handle_break() uart_port op" to
  incorporate Stephen's feedback of just using CONFIG_ARCH_TEGRA instead
  of adding CONFIG_SERIAL_TEGRA.

* Added Arnd's ack

* The other two patches have not changed.

---

Dan Williams (2):
      tegra, serial8250: add ->handle_break() uart_port op
      serial/8250_pci: fix suspend/resume vs init/exit quirks

Sudhakar Mamillapalli (1):
      serial/8250_pci: Clear FIFOs for Intel ME Serial Over Lan device on BI


 arch/arm/mach-tegra/board-harmony.c   |    2 +
 arch/arm/mach-tegra/board-paz00.c     |    3 ++
 arch/arm/mach-tegra/board-seaboard.c  |    2 +
 arch/arm/mach-tegra/board-trimslice.c |    2 +
 drivers/tty/serial/8250/8250.c        |   44 ++++++++++----------------------
 drivers/tty/serial/8250/8250.h        |    2 +
 drivers/tty/serial/8250/8250_pci.c    |   45 +++++++++++++++++++++++++++++++++
 drivers/tty/serial/of_serial.c        |   26 +++++++++++++++++++
 include/linux/of_serial.h             |   17 ++++++++++++
 include/linux/serial_8250.h           |    1 +
 include/linux/serial_core.h           |    5 ++++
 11 files changed, 118 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/of_serial.h
