From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: [RFC 0/5] console/acpi: add DBG2 and SPCR console configuration
Date: Tue,  8 Sep 2015 13:43:32 +0100
Message-ID: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, al.stone@linaro.org, torez@redhat.com, jcm@redhat.com, graeme.gregory@linaro.org, linaro-acpi@lists.linaro.org, lv.zheng@intel.com
List-Id: linux-serial@vger.kernel.org

Support for configuring bootconsole and console via the ACPI tables
DBG2 (Debug Port Table 2) [1] and SPCR (Serial Port Console Redirection
Table) [2], defined by Microsoft, has been discussed on and off over the
years.

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
[2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx

Licensing concerns have prevented this happening in the past, but as of
10 August 2015, these tables have both been released also under OWF 1.0
(http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0)
which is think is noncontroversially GPL-compatible?

This set is a first attempt at implementing this.

Submitting as an RFC since the SPCR handling currently depends on the
console driver being initialized after subsystem initcalls. Workaround
to enable testing surrounding infrastructure in 5/5, _really_ not
intended to be merged.
(Suggestions for acceptable ways of working around this appreciated.)

For testing the DBG2 stuff with pl011, you would need:
- A patch to unbreak pl011 earlycon, like
  http://permalink.gmane.org/gmane.linux.ports.arm.kernel/433219
- A QEMU that generates DBG2 tables, like current HEAD with the
  addition of
  http://lists.nongnu.org/archive/html/qemu-devel/2015-09/msg01719.html

SPCR support is included in QEMU's ARM mach-virt since 2.4 release.

DBG2 support has an Intel copyright notice added to it since my starting
point was Lv Zheng's 2012 DBGP/DBG2 set (although not much of the
original remains - this is quite a cut-down version).

Leif Lindholm (4):
  arm64: move acpi/dt decision earlier in boot process
  of/serial: move earlycon early_param handling to serial
  acpi/serial: add DBG2 earlycon support
  HACK: serial: move pl011 initcall to device_initcall

Torez Smith (1):
  tty/console: use SPCR table to define console

 arch/arm64/kernel/acpi.c         |  55 +++++----
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/console.c           | 260 +++++++++++++++++++++++++++++++++++++++
 drivers/of/fdt.c                 |  13 +-
 drivers/tty/serial/amba-pl011.c  |   2 +-
 drivers/tty/serial/earlycon.c    |  18 ++-
 drivers/tty/serial/serial_core.c |  14 ++-
 include/linux/acpi.h             |  13 ++
 include/linux/of_fdt.h           |   1 +
 include/linux/serial_core.h      |   9 +-
 10 files changed, 337 insertions(+), 49 deletions(-)
 create mode 100644 drivers/acpi/console.c

-- 
2.1.4

