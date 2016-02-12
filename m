From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 0/9] ACPI: parse the SPCR table
Date: Fri, 12 Feb 2016 20:43:31 +0300
Message-ID: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

This patchset is based on the patchset by Leif Lindholm [1]

'ARM Server Base Boot Requirements' [2] mentions SPCR (Serial Port
Console Redirection Table) [3] as a mandatory ACPI table that
specifies the configuration of serial console.

SPCR support is included in QEMU's ARM mach-virt since 2.4 release.

Parse the SPCR table and check if any registered console matches the
description.  If it does, enable that console.

Also add an implementation of this member function to the pl011 and 8250
drivers, fix a minor issue in printk.c and use SPCR to tell if SBSA serial
driver should use 32-bit access to registers.
To be able to access SPCR table each time any console is registered
change __init to __ref for early_acpi_os_unmap_memory()
and introduce acpi_table_parse2() in separate patches.

The patchset should be applied to tty-next.

v2:
- don't use SPCR if user specified console in command line
- fix initialization order of newcon->index = 0
- rename some variables at printk.c (Joe Perches, Peter Hurley)
- enable ACPI_SPCR_TABLE in a separate patch (Andy Shevchenko)
- remove the retry loop for console registering (Peter Hurley).
  Instead, obtain SPCR with acpi_get_table().  That works after
  call to acpi_early_init() i. e. in any *_initcall()
- describe design decision behind introducing acpi_match() (Peter Hurley)
- fix compilation for x86 + ACPI (Graeme Gregory)
- introduce DBG2 constants in a separate patch (Andy Shevchenko)
- fix a typo in DBG2 constants (Andy Shevchenko)
- add ACPI_DBG2_ARM_SBSA_32BIT constant (Christopher Covington)
- add support for ACPI_DBG2_ARM_SBSA_* consoles (Christopher Covington)
- add documentation for functions
- add a patch that uses SPCR to find if SBSA serial driver should use 32-bit
  accessor functions (Christopher Covington)
- change __init to __ref for early_acpi_os_unmap_memory() in a separate patch
- introduce acpi_table_parse2() in a separate patch
- fix fetching the SPCR table early (Mark Salter)
- add a patch from Mark Salter that introduces support for matching 8250-based
  consoles

v1:
https://lkml.kernel.org/g/1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org

[1] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
[2] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[3] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx

Aleksey Makarov (8):
  printk: fix name and type of some variables
  ACPI: Change __init to __ref for early_acpi_os_unmap_memory()
  ACPI: introduce acpi_table_parse2()
  ACPI: parse SPCR and enable matching console
  ACPI: enable ACPI_SPCR_TABLE on ARM64
  ACPI: add definition of DBG2 subtypes
  serial: pl011: add acpi_match
  serial: pl011: use SPCR to setup 32-bit access

Mark Salter (1):
  serial: 8250: add acpi_match

 arch/arm64/Kconfig                  |   1 +
 drivers/acpi/Kconfig                |   3 +
 drivers/acpi/Makefile               |   1 +
 drivers/acpi/osl.c                  |   6 +-
 drivers/acpi/spcr.c                 | 106 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c               |  49 ++++++++++++++---
 drivers/tty/serial/8250/8250_core.c |  23 ++++++++
 drivers/tty/serial/amba-pl011.c     |  24 ++++++++
 include/acpi/actbl2.h               |   5 ++
 include/linux/acpi.h                |   8 +++
 include/linux/console.h             |  17 ++++++
 kernel/printk/printk.c              |  40 ++++++++++----
 12 files changed, 264 insertions(+), 19 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

-- 
2.7.0
