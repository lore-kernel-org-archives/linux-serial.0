From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 0/8] ACPI: parse the DBG2 table
Date: Mon, 22 Feb 2016 16:46:48 +0300
Message-ID: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

ARM Server Base Boot Requiremets' [1] mentions DBG2 (Microsoft Debug
Port Table 2) [2] as a mandatory ACPI table that specifies debug ports.

- Move acpi/dt decision earlier in boot process on ARM64
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

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] http://go.microsoft.com/fwlink/p/?LinkId=234837
[3] https://lkml.kernel.org/g/455559532-8305-1-git-send-email-aleksey.makarov@linaro.org

Aleksey Makarov (6):
  ACPI: add definitions of DBG2 subtypes
  ACPI: genaralize iterating over subtables in ACPI_PROBE_TABLE()
  ACPI: parse DBG2 table
  ACPI: serial: implement earlycon on ACPI DBG2 port
  ACPI: enable ACPI_DBG2_TABLE on ARM64
  serial: pl011: add ACPI DBG2 serial port

Leif Lindholm (2):
  arm64: move acpi/dt decision earlier in boot process
  of/serial: move earlycon early_param handling to serial

 Documentation/kernel-parameters.txt  |   3 +
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/kernel/acpi.c             |  56 ++++++++++---------
 drivers/acpi/Kconfig                 |   3 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/dbg2.c                  |  85 ++++++++++++++++++++++++++++
 drivers/acpi/scan.c                  |  44 ++++++++++-----
 drivers/clocksource/arm_arch_timer.c |   3 +-
 drivers/irqchip/irq-gic.c            |   4 +-
 drivers/of/fdt.c                     |  11 +---
 drivers/tty/serial/amba-pl011.c      |   3 +
 drivers/tty/serial/earlycon.c        |  57 +++++++++++++++++++
 include/acpi/actbl2.h                |   5 ++
 include/asm-generic/vmlinux.lds.h    |   1 +
 include/linux/acpi.h                 | 104 ++++++++++++++++++++++++-----------
 include/linux/acpi_dbg2.h            |  68 +++++++++++++++++++++++
 include/linux/clocksource.h          |   2 +-
 include/linux/irqchip.h              |   5 +-
 include/linux/of_fdt.h               |   2 +
 19 files changed, 370 insertions(+), 88 deletions(-)
 create mode 100644 drivers/acpi/dbg2.c
 create mode 100644 include/linux/acpi_dbg2.h

-- 
2.7.1
