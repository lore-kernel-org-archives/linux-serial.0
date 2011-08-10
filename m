From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 0/2] Update uart irq handling for s3c64xx and later SoC's
Date: Wed, 10 Aug 2011 15:51:18 +0530
Message-ID: <1312971680-3898-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, grant.likely@secretlab.ca, ben-linux@fluff.org
List-Id: linux-serial@vger.kernel.org

s3c64xx and later SoC's include the uart interrupt mask and pending registers
in the uart controller, unlike their s3c24xx predecessor. This allows the
uart irq handling to be moved from the platform code to the driver. This
patchset does this change and removes all the macros that will not be
required with this update.

Thomas Abraham (2):
  serial: samsung: Add unified interrupt handler for s3c64xx and later SoC's
  ARM: SAMSUNG: Remove uart irq handling from plaform code

 arch/arm/Kconfig                                 |    1 -
 arch/arm/mach-s3c64xx/dev-uart.c                 |   60 ++-----------
 arch/arm/mach-s3c64xx/include/mach/irqs.h        |   30 ------
 arch/arm/mach-s3c64xx/irq.c                      |   25 -----
 arch/arm/plat-s5p/Kconfig                        |    1 -
 arch/arm/plat-s5p/dev-uart.c                     |   84 +++---------------
 arch/arm/plat-s5p/include/plat/irqs.h            |   35 -------
 arch/arm/plat-s5p/irq.c                          |   34 -------
 arch/arm/plat-samsung/Kconfig                    |    5 -
 arch/arm/plat-samsung/Makefile                   |    1 -
 arch/arm/plat-samsung/include/plat/regs-serial.h |    5 +
 arch/arm/plat-samsung/irq-uart.c                 |   96 -------------------
 drivers/tty/serial/samsung.c                     |  107 +++++++++++++++++++---
 drivers/tty/serial/samsung.h                     |    1 +
 14 files changed, 121 insertions(+), 364 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/irq-uart.c
