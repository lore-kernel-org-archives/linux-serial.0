From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3 0/7] ACPI: parse the DBG2 table
Date: Mon, 29 Feb 2016 15:41:57 +0300
Message-ID: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>
List-Id: linux-serial@vger.kernel.org

"ARM Server Base Boot Requirements" [1] mentions DBG2 (Microsoft Debug
Port Table 2) [2] as a mandatory ACPI table that specifies debug ports.

- Move earlycon early_param handling to serial to parse earlycon option once
- Add definition of DBG2 subtypes.  It's the same patch as in the SPCR series [3]
- Refactor ACPI linker tables code to enable iterating over subtables other than
  subtables having acpi_subtype header (such as DBG2)
- Implement macros

	ACPI_DBG2_DECLARE(name, type, subtype, setup_fn, data_ptr)

  that defines a handler for the port of the given type and subtype.
- For each port defined by that macros that is also described in the ACPI DBG2
  table call provided callback.
- Implement a helper macros that can be used to define early serial console
- Enable DBG2 on ARM64
- Define early console for pl011 serial

Based on the work by Leif Lindholm <leif.lindholm@linaro.org> [4]

Should be applied to next-20160229.

Tested on last QEMU with patches that introduce DBG2 and fix a QEMU bug:

https://git.linaro.org/people/aleksey.makarov/qemu.git amakarov/gdb2.03

v3:
- Drop "arm64: move acpi/dt decision earlier in boot process".  It is incorrect.
  (Matthias Brugger)
- Fix the message at port discovery.

v2:
https://lkml.kernel.org/g/1456333819-13482-1-git-send-email-aleksey.makarov@linaro.org
- Fix parse_acpi() (Matthias Brugger)
- Add a reference to QEMU DBG2 patches and to original work
- Rebase to the last linux-next

v1:
https://lkml.kernel.org/g/1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] http://go.microsoft.com/fwlink/p/?LinkId=234837
[3] https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org
[4] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org

Aleksey Makarov (6):
  ACPI: add definitions of DBG2 subtypes
  ACPI: genaralize iterating over subtables in ACPI_PROBE_TABLE()
  ACPI: parse DBG2 table
  ACPI: serial: implement earlycon on ACPI DBG2 port
  ACPI: enable ACPI_DBG2_TABLE on ARM64
  serial: pl011: add ACPI DBG2 serial port

Leif Lindholm (1):
  of/serial: move earlycon early_param handling to serial

 Documentation/kernel-parameters.txt  |   3 +
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/kernel/acpi.c             |   2 +
 drivers/acpi/Kconfig                 |   3 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/dbg2.c                  |  88 +++++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |  44 ++++++++++-----
 drivers/clocksource/arm_arch_timer.c |   3 +-
 drivers/irqchip/irq-gic.c            |   4 +-
 drivers/of/fdt.c                     |  11 +---
 drivers/tty/serial/amba-pl011.c      |   3 +
 drivers/tty/serial/earlycon.c        |  61 ++++++++++++++++++++
 include/acpi/actbl2.h                |   5 ++
 include/asm-generic/vmlinux.lds.h    |   1 +
 include/linux/acpi.h                 | 104 ++++++++++++++++++++++++-----------
 include/linux/acpi_dbg2.h            |  68 +++++++++++++++++++++++
 include/linux/clocksource.h          |   2 +-
 include/linux/irqchip.h              |   5 +-
 include/linux/of_fdt.h               |   2 +
 19 files changed, 348 insertions(+), 63 deletions(-)
 create mode 100644 drivers/acpi/dbg2.c
 create mode 100644 include/linux/acpi_dbg2.h

-- 
2.7.1

