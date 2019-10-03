From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 0/2] drivers: make early_platform code SuperH-specific
Date: Thu,  3 Oct 2019 11:29:11 +0200
Message-ID: <20191003092913.10731-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some time ago I started a discussion about the need for a proper early device
probing mechanism[1]. One that would be based on real platform drivers and
support both platform data and device tree.

While we're far from reaching any consensus on the implementation, Arnd
suggested that I start off by moving the SuperH-specific early platform
drivers implementation to arch/sh[2].

This series is the first attempt at making way for a new, less hacky
implementation.

The first patch moves all the early_platform code to arch/sh.

The second patch prefixes all early_platform symbols with 'sh_'.

[1] https://lkml.org/lkml/2018/4/26/657
[2] https://lkml.org/lkml/2018/4/27/239

v1 -> v2:
- certain drivers are compiled for arm/mach-shmobile too - we need to
  add ifdefs for CONFIG_SUPERH around early_platform calls

v2 -> v3:
- added a stub for is_early_platform_device() which always returns false
  on non-SuperH architectures

v3 -> v4:
- rebased on top of v5.4-rc1
- removed patches that are already upstream from the series

Bartosz Golaszewski (2):
  drivers: move the early platform device support to arch/sh
  sh: add the sh_ prefix to early platform symbols

 arch/sh/drivers/Makefile               |   2 +-
 arch/sh/drivers/platform_early.c       | 347 +++++++++++++++++++++++++
 arch/sh/include/asm/platform_early.h   |  61 +++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   3 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   3 +-
 arch/sh/kernel/setup.c                 |   3 +-
 arch/sh/kernel/time.c                  |   5 +-
 drivers/base/platform.c                | 288 --------------------
 drivers/clocksource/sh_cmt.c           |  13 +-
 drivers/clocksource/sh_mtu2.c          |  13 +-
 drivers/clocksource/sh_tmu.c           |  14 +-
 drivers/tty/serial/sh-sci.c            |  11 +-
 include/linux/platform_device.h        |  64 +----
 40 files changed, 525 insertions(+), 387 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h

-- 
2.23.0
