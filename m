From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/2] acpi, x86: Add SPCR table support
Date: Thu,  7 Dec 2017 12:29:10 -0500
Message-ID: <20171207172912.17868-1-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-serial@vger.kernel.org

The SPCR (Serial Port Console Redirection) Table provides information
about the configuration of serial port.  This information can be used
to configure the early console.

SPCR support was added for arm64 and is made available across all arches
in this patchset.  The first patch adds a weak per-arch configuration function
and moves the SPCR code into ACPI.  The second patch adds support to x86.

The existing behaviour on arm64 is maintained.  If the SPCR exists the
earlycon and console are automatically configured.

The existing default behaviour on x86 is also maintained.  If no console or
earlycon parameter is defined and the SPCR exists , the serial port is not
configured.  If the earlycon parameter is used both the early console
and the console are configured using the data from the SPCR.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Prarit Bhargava (2):
  acpi, spcr: Make SPCR avialable to other architectures
  acpi, x86: Use SPCR table for earlycon on x86

 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 arch/arm64/Kconfig                              |   1 -
 arch/arm64/kernel/acpi.c                        | 128 +++++++++++++++++-
 arch/x86/kernel/acpi/boot.c                     |   3 +
 drivers/acpi/Kconfig                            |  11 +-
 drivers/acpi/spcr.c                             | 171 ++++++------------------
 drivers/tty/serial/earlycon.c                   |  16 +--
 include/linux/acpi.h                            |  14 +-
 include/linux/serial_core.h                     |   2 -
 9 files changed, 195 insertions(+), 160 deletions(-)

-- 
1.8.3.1
