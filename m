From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: serial: samsung: add clkdev based clock lookup and device tree support
Date: Tue, 27 Sep 2011 00:37:09 +0530
Message-ID: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-serial@vger.kernel.org

This patchset adds clkdev based clock lookup support and device tree based
discovery for Samsung uart controller driver. Passing of clock names in
platform data is removed.

In the process of adding these features, other changes have also been made
that merges all the SoC specfic extensions into the parent driver.

This patch has been tested with a following addtional macro suggested by
Russell King (<rmk+kernel@arm.linux.org.uk>) but this macro is not
included in this patch nor is it available in any tree yet. There is a
seperate work going on to prepare a patch series that consolidates
the macros used to instantiate a 'struct clk_lookup'. This patchset
would use that work when it is submitted.

diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 457bcb0..13ffbb8 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -24,6 +24,13 @@ struct clk_lookup {
        struct clk              *clk;
 };

+#define CLKDEV_INIT(dev, con, ck)      \
+       {                       \
+               .dev_id = dev,  \
+               .con_id = con,  \
+               .clk = ck,      \
+       }
+
 struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
        const char *dev_fmt, ...);


This patchset is based on the following tree
https://github.com/kgene/linux-samsung.git  branch: for-next

with the following two patches applied
[PATCH] serial: samsung: Add unified interrupt handler for s3c64xx and later SoC's
[PATCH] ARM: SAMSUNG: Remove uart irq handling from plaform code

and tested on the following boards.
SMDK2440, SMDK2416, SMDK6410, SMDK6440, SMDK6450, SMDKC100, SMDKV210, SMDKV310.


Thomas Abraham (9):
  serial: samsung: Keep a copy of the location of platform data in driver's private data
  serial: samsung: move handling of fclk/n clock to platform code
  serial: samsung: switch to clkdev based clock lookup
  serial: samsung: remove struct 's3c24xx_uart_clksrc' and all uses of it
  serial: samsung: remove all uses of get_clksrc and set_clksrc
  arm: samsung: register uart clocks to clock lookup list
  serial: samsung: merge all SoC specific port reset functions
  serial: samsung: merge probe() function from all SoC specific extensions
  serial: samsung: add device tree support

 arch/arm/mach-exynos4/clock.c                    |  106 +++--
 arch/arm/mach-exynos4/init.c                     |   21 +-
 arch/arm/mach-s3c2410/mach-bast.c                |   22 -
 arch/arm/mach-s3c2410/mach-vr1000.c              |   24 -
 arch/arm/mach-s3c2410/s3c2410.c                  |    6 +
 arch/arm/mach-s3c2412/clock.c                    |    7 +
 arch/arm/mach-s3c2440/clock.c                    |   44 ++
 arch/arm/mach-s3c2440/mach-anubis.c              |   22 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c           |   22 +-
 arch/arm/mach-s3c2440/mach-osiris.c              |   24 +-
 arch/arm/mach-s3c2440/mach-rx1950.c              |   18 +-
 arch/arm/mach-s3c2440/mach-rx3715.c              |   19 +-
 arch/arm/mach-s3c64xx/clock.c                    |   37 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c            |   32 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c            |   32 +-
 arch/arm/mach-s5p64x0/init.c                     |   31 -
 arch/arm/mach-s5pc100/clock.c                    |   33 +-
 arch/arm/mach-s5pv210/clock.c                    |  107 +++--
 arch/arm/mach-s5pv210/init.c                     |   19 -
 arch/arm/plat-s3c24xx/s3c2443-clock.c            |   22 +-
 arch/arm/plat-samsung/include/plat/regs-serial.h |   45 +-
 drivers/tty/serial/Kconfig                       |   45 +--
 drivers/tty/serial/Makefile                      |    5 -
 drivers/tty/serial/s3c2410.c                     |  115 ----
 drivers/tty/serial/s3c2412.c                     |  149 -----
 drivers/tty/serial/s3c2440.c                     |  178 ------
 drivers/tty/serial/s3c6400.c                     |  149 -----
 drivers/tty/serial/s5pv210.c                     |  158 ------
 drivers/tty/serial/samsung.c                     |  639 +++++++++++++---------
 drivers/tty/serial/samsung.h                     |   32 +-
 30 files changed, 737 insertions(+), 1426 deletions(-)
 delete mode 100644 drivers/tty/serial/s3c2410.c
 delete mode 100644 drivers/tty/serial/s3c2412.c
 delete mode 100644 drivers/tty/serial/s3c2440.c
 delete mode 100644 drivers/tty/serial/s3c6400.c
 delete mode 100644 drivers/tty/serial/s5pv210.c
