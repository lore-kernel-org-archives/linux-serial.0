From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [RFC v2 0/4] ACPI: SPCR: 32-bit access and non-standard baud rate
Date: Tue,  6 Dec 2016 23:58:25 +0600
Message-ID: <20161206175830.6989-1-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-serial@vger.kernel.org

ACPI [SPCR] (Serial Port Console Redirection Table) specifies which console
should be used by system.  'ARM Server Base Boot Requirements' [SBBR] mentions
SPCR as a mandatory ACPI table.  Support for this table for Linux kernel
([SPCR v10]) was merged for 4.9 (patches 1/4-3/4) and 4.10 (patch 4/4).

It turns out that this approach does not work for all the existing hardware.
There are two problems with AppliedMicro X-Gene based boards
([discussion], [v1]):

1. Their console is a 16550 port that requires 32-bit access.  Now SPCR does not
   have any method to specify this.

2. Some of the boards don't use the "standard" 16550 clock rate so supplying
   a baud rate makes it change to a random baud rate.

Patch 1/4 uses 'Register Bit Width' field of the ACPI Generic Address
Structure that specifies the address of the UART registers to
decide if the driver should use "mmio32" access instead of "mmio".
This fixes problem 1 for existing hardware/firmware.

To fix problem 2, I suggest to introduce a new value '0' for the "Baud Rate"
field of SPCR (now this value is reserved).  I would like to discuss if this
could be added to SPCR spec and will fix the problem.

Patch 2/4 introduces a check for this value.  In this case the code does not
emit baud rate specification for initialization of the console.  This fixes
problem 2.

It was also suggested ([v1]) to add a new Microsoft Debug Port Table 2 ([DBG2])
(the table used to enumerate the various subtypes of serial port covered by the
SPCR) 16550 UART subtype that may be needed for some additional platforms,
such as those based upon AppliedMicro X-Gene ARMv8 SoCs.  This new subtype would
be 16550-compatible with 32-bit access.  There already exists 32-bit variant
ACPI_DBG2_ARM_SBSA_32BIT of SBSA console ACPI_DBG2_ARM_SBSA_GENERIC.

Patch 3/4 introduces this value for DBG2 table.

Patch 4/4 uses it.

RFC v2:
  - Add a fix for consoles with non-standard baud rate.
  - Introduce a new type of console that is 16550 with 32-bit access
  - Check for that type of console.

v1: [v1]

[SPCR]       https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
[DBG2]       http://go.microsoft.com/fwlink/p/?LinkId=234837
[SBBR]       http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[SPCR v10]   https://lkml.kernel.org/r/20160905123617.18775-1-aleksey.makarov@linaro.org
[discussion] https://lkml.kernel.org/r/7fa523de-3fbb-1566-f521-927143f73d1e@redhat.com
[v1]         https://lkml.kernel.org/r/20161205130534.11080-1-aleksey.makarov@linaro.org

Aleksey Makarov (4):
  ACPI: SPCR: check bit width for the 16550 UART
  ACPI: SPCR: don't initialize baud rate
  ACPI: DBG2: add 16550 UART with 32-bit access
  ACPI: SPCR: support 16550 UART with 32-bit access

 drivers/acpi/spcr.c   | 29 ++++++++++++++++++++++-------
 include/acpi/actbl2.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.10.2

