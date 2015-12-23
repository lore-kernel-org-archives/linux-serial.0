From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 0/3] Add AMBA bus probing support to ACPI
Date: Wed, 23 Dec 2015 17:19:39 +0300
Message-ID: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>
List-Id: linux-serial@vger.kernel.org

As discussed when Shannon Zhao sent a patch to add platform_device support
to pl061 driver. Russel and other maintainers prefered that ACPI learned
how to create AMBA devices rather than converting/adding platform_device
support to AMBA drivers.

http://comments.gmane.org/gmane.linux.ports.arm.kernel/431364

1) Adds basic AMBA device probing support to ACPI, it uses a whitelist of
device IDs as the number of AMBA devices is limited. Currently the two ids
present are those used in QEMU for arm64.

2) Adds the plumbing into ACPI probe sequence.

3) From ACPI pl011 is only defined (SBSA document) to be in SBSA mode which has
reduced functionality. There may be a better method to do this that I have
overlooked.

v4:
- A memory leak has been fixed (Vladimir Zapolskiy)
- ACPI_COMPANION() -> has_acpi_companion() (Andy Shevchenko)
- pr_err() -> dev_err() (Andy Shevchenko)
- The call to amba_register_dummy_clk() has been moved to to acpi_amba_init()
  (Vladimir Zapolskiy)
- Return value has been fixed (Vladimir Zapolskiy)

v3:
https://lkml.kernel.org/g/1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org
- Compilation without CONFIG_ARM_AMBA has been fixed

v2:
https://lkml.kernel.org/g/1450709399-7246-1-git-send-email-aleksey.makarov@linaro.org
- A new ACPI scan handler for AMBA devices has been implemented
- The order of `if` branches in amba-pl011.c has been changed
- A couple of `static`s have been added
- The compilation of the acpi_amba.c unit has made conditional
- A comment on SBSA UART has been added

v1:
https://lkml.kernel.org/g/1443609530-21524-1-git-send-email-graeme.gregory@linaro.org

Graeme Gregory (3):
  ACPI: amba bus probing support
  ACPI: scan add in amba probing
  serial: amba-pl011: add ACPI support to AMBA probe

 drivers/acpi/Makefile           |   1 +
 drivers/acpi/acpi_amba.c        | 140 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h         |   5 ++
 drivers/acpi/scan.c             |   1 +
 drivers/tty/serial/amba-pl011.c |  37 +++++++----
 5 files changed, 173 insertions(+), 11 deletions(-)
 create mode 100644 drivers/acpi/acpi_amba.c

-- 
2.6.4

