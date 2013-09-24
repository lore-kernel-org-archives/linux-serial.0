From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Subject: [PATCH 0/6] ARM: shmobile: kzm9d-reference:  migrate to common clock
 framework with DT
Date: Tue, 24 Sep 2013 13:05:26 +0900
Message-ID: <52410F86.4040301@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: SH-Linux <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch series makes kzm9d-reference to move to new clk implementation
 based on the common clock framework and device tree.

First three are for preparation.
[PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
[PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
[PATCH 3/6] sh: clkfwk: Select sh-/common- clkfwk alternatively

Next one is a proposal document of DT bindings.
[PATCH 4/6] ARM: shmobile: emev2: Define SMU clock DT bindings

This is the implementation, and dts which carries clock tree description.
[PATCH 5/6] clk: emev2: Add support for emev2 SMU clocks with DT

Last one is small modification needed for migration.
[PATCH 6/6] ARM: shmobile: kzm9d-reference: Use common clock

These patches do not remove sh-clkfwk version, even on emev2.
kzm9d(without -reference) target still uses sh-clkfwk.
I believe this method encourages step-by-step migration on other sh-mobile
 targets, too.

Patches should be applied and compiled both on
 v3.12-rc2 and
 kernel/git/horms/renesas.git tag:renesas-devel-20130922 

Confirmed on kernel/git/horms/renesas.git tag:renesas-devel-20130922 
for boot up to command prompt.
- kzm9d board / multiplatform + kzm9d-reference configuration
- kzm9d board / kzm9d-reference configuration
- kzm9d board / kzm9d (with sh-clkfwk) configuration for regression.
- ape6evm (with sh-clkfwk) for regression.
for compile only
- sh7757lcr (in arch/sh with sh-clkfwk) for regression.


Shinya Kuribayashi (2):
  clocksource: em_sti: convert to clk_prepare/unprepare
  serial8250-em: convert to clk_prepare/unprepare

Takashi YOSHII (4):
  sh: clkfwk: Select sh-/common- clkfwk alternatively
  ARM: shmobile: emev2: Define SMU clock DT bindings
  clk: emev2: Add support for emev2 SMU clocks with DT
  ARM: shmobile: kzm9d-reference: Use common clock framework

 .../devicetree/bindings/clock/emev2-clock.txt      |  99 ++++++++++++++++++++
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/dts/emev2.dtsi                       |  84 +++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   1 +
 arch/arm/mach-shmobile/board-kzm9d-reference.c     |   5 +-
 arch/sh/Kconfig                                    |   1 +
 drivers/clk/Makefile                               |   2 +
 drivers/clk/shmobile/Makefile                      |   5 +
 drivers/clk/shmobile/clk-emev2.c                   | 104 +++++++++++++++++++++
 drivers/clocksource/em_sti.c                       |   4 +-
 drivers/sh/clk/Makefile                            |   3 +-
 drivers/tty/serial/8250/8250_em.c                  |   6 +-
 12 files changed, 305 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/emev2-clock.txt
 create mode 100644 drivers/clk/shmobile/Makefile
 create mode 100644 drivers/clk/shmobile/clk-emev2.c

-- 
1.8.1.5
