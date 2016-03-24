From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v6 0/5] ACPI: parse the SPCR table
Date: Thu, 24 Mar 2016 15:51:58 +0300
Message-ID: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
Console Redirection Table) [2] as a mandatory ACPI table that
specifies the configuration of serial console.

Move "earlycon" early_param handling to earlycon.c to parse this option once

Patch "ACPI: add definitions of DBG2 subtypes" is required for the next patch.
ACPI maintainers said that they had got it for the next release of ACPICA,
but it has not appeared in linux-next yet.

Parse SPCR table, setup earlycon and add register specified console.

Enable parsing this table on ARM64.  Earlycon should be set up
as early as possible.  ACPI boot tables are mapped in
arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch()
and that's where we parse spcr.  So it has to be opted-in per-arch.

Implement console_match() for pl011.

Based on the work by Leif Lindholm [3]
Thanks to Peter Hurley for explaining how this should work.

Should be applied to next-20160324.

Tested on QEMU.  SPCR support is included in QEMU's ARM mach-virt
since 2.4 release.

v6:
- add documentation for parse_spcr() functioin (Yury Norov)
- don't initialize err variable (Yury Norov)
- add __initdata for the earlycon_init_is_deferred flag variable
- rename the function exported in "of/serial: move earlycon early_param handling
  to serial" to avoid clash with the function from arch/microblaze/kernel/prom.c
- defer initialization of DT earlycon until DT/ACPI decision is made
  (Rob Herring, Peter Hurley)
- use snprintf instead of sprintf (Andy Shevchenko)
- drop patch that adds EARLYCON_DECLARE for pl011 as EARLYCON_DECLARE is
  equivalent to OF_EARLYCON_DECLARE for 4.6+ (Peter Hurley).  This means that
  SPCR earlycon will not work on the kernels before 4.6

v5:
https://lkml.kernel.org/g/1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org
- drop patch "serial: pl011: use ACPI SPCR to setup 32-bit access" because
  it is ugly. Also because Christopher Covington came with a better solution [4]
- remove error message when the table is not provided by ACPI (Andy Shevchenko)
- rewrite spcr.c following the suggestions by Peter Hurley
- add console_match() for pl011 in a separate patch
- add EARLYCON_DECLARE for pl011 in a separate patch
- add patch "of/serial: move earlycon early_param handling to serial" from
  the GDB2 series

v4:
https://lkml.kernel.org/g/1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org
- drop patch "ACPI: change __init to __ref for early_acpi_os_unmap_memory()"
  ACPI developers work on a new API and asked not to do that.
  Instead, use acpi_get_table_with_size()/early_acpi_os_unmap_memory() once
  and cache the result. (Lv Zheng)
- fix some style issues (Yury Norov)

v3:
https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org

Greg Kroah-Hartman did not like v2 so I have rewritten this patchset:

- drop acpi_match() member of struct console
- drop implementations of this member for pl011 and 8250
- drop the patch that renames some vars in printk.c as it is not needed anymore
- drop patch that introduces system wide acpi_table_parse2().
  Instead introduce a custom acpi_table_parse_spcr() in spcr.c

Instead of introducing a new match_acpi() member of struct console,
this patchset introduces a new function acpi_console_check().
This function is called when a new uart is registered at serial_core.c
the same way OF code checks for console.  If the registered uart is the
console specified by SPCR table, this function calls add_preferred_console()

The restrictions of this approach are:

- only serial consoles can be set up
- only consoles specified by the memory/io address can be set up
  (SPCR can specify devices by PCI id/PCI address)

v2:
https://lkml.kernel.org/g/1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org
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

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
[3] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
[4] https://lkml.kernel.org/g/1457415800-8799-1-git-send-email-cov@codeaurora.org

Aleksey Makarov (4):
  ACPI: add definitions of DBG2 subtypes
  ACPI: parse SPCR and enable matching console
  ACPI: enable ACPI_SPCR_TABLE on ARM64
  serial: pl011: add console matching function

Leif Lindholm (1):
  of/serial: move earlycon early_param handling to serial

 arch/arm64/Kconfig              |   1 +
 arch/arm64/kernel/acpi.c        |   5 +-
 drivers/acpi/Kconfig            |   3 +
 drivers/acpi/Makefile           |   1 +
 drivers/acpi/spcr.c             | 125 ++++++++++++++++++++++++++++++++++++++++
 drivers/of/fdt.c                |  11 +---
 drivers/tty/serial/amba-pl011.c |  56 ++++++++++++++++++
 drivers/tty/serial/earlycon.c   |  11 +++-
 include/acpi/actbl2.h           |   5 ++
 include/linux/acpi.h            |   8 +++
 include/linux/of_fdt.h          |   2 +
 11 files changed, 215 insertions(+), 13 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

-- 
2.7.4

