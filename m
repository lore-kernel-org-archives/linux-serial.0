From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 0/3] ACPI: parse the SPCR table
Date: Mon, 25 Jan 2016 17:45:20 +0600
Message-ID: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

This patchset is based on the patchset by Leif Lindholm [1]

'ARM Server Base Boot Requirements' [2] mention SPCR 
(Serial Port Console Redirection Table) [3] as a mandatory
ACPI table that specifies the configuration of serial console.

Licensing concerns have prevented implementing it in the past, but as of
10 August 2015, these tables have both been released also under 
OWF 1.0 [4].

SPCR support is included in QEMU's ARM mach-virt since 2.4 release.

Parse the SPCR table and check if any registered console match
the description.  If it does, enable that console.

To implement that, introduce a new member
int (*acpi_match)(struct console *, struct acpi_table_spcr *);
of struct console.  It allows drivers to check if they provide
a matching console device.

Also add an implementation of this member function to the pl011 driver
and fix a minor issue in kernel/printk/printk.c

[1] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
[2] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[3] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
[4] http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0

Aleksey Makarov (3):
  printk: make preferred_console local static bool
  ACPI: parse SPCR and enable matching console
  serial: pl011: add acpi_match for amba-pl011.c

 arch/arm64/Kconfig              |  1 +
 drivers/acpi/Kconfig            |  3 ++
 drivers/acpi/Makefile           |  1 +
 drivers/acpi/spcr.c             | 85 +++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/amba-pl011.c | 14 ++++++
 include/acpi/actbl2.h           |  4 ++
 include/linux/console.h         | 12 ++++++
 kernel/printk/printk.c          | 94 +++++++++++++++++++++++++++++++----------
 8 files changed, 191 insertions(+), 23 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

-- 
2.7.0

