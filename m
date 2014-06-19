From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 00/13] kgdb: NMI/FIQ support for ARM
Date: Thu, 19 Jun 2014 11:38:10 +0100
Message-ID: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfou>
List-Id: linux-serial@vger.kernel.org

This patchset makes it possible to use the kgdb NMI infrastructure on
ARM platforms by providing a mutli-platform compatible means for drivers
to manage FIQ routings.

First a quick summary of how the already mainlined kgdb NMI
infrastructure (mostly found in drivers/tty/serial/kgdb_nmi.c) works.
The kgdb infrastructure will re-route the kgdb console UART's interrupt
signal from IRQ to FIQ. Naturally the UART will no longer function
normally and will instead be managed by kgdb using the polled I/O
functions. Any character delivered to the UART causes the kgdb handler
function to be called.

Note that, within this patchset a serial driver explicitly consents (or
not) to the abuse outlined above by calling the appropriate registration
during the .poll_init() callback. In so doing it also commits to honour
the stringent runtime requirements imposed on FIQ handlers within its
polled I/O handlers.

Major remaining TODO item is to modify the code to halt the other CPUs;
at present this code sends IPIs (which use a normal IRQ) and busy waits
for the other CPUs to halt. This means the benefits of invoking the
debugger via NMI are only partially realized on SMP systems. However
there are no cross dependencies so the code is "good to go" without this
feature implemented.

Changes since v3:

* Corrected the FIQ uninstall code (Russell King).

* Removed named constants for EnableGrp0 and EnableGrp1 (Nicolas Pitre).
 
* Remove spin locks from gic_eoi_irq (Peter De Schrijver).

* Massively simplified things by avoiding allocation of shadow IRQ (Rob
  Herring)

* Correctly set the priority of FIQ interrupts by making the top bit
  follow ARM recommendations. Fixes robustness problem in the debugger
  itself.
 
* Auto-detect whether the platform can support FIQ and act
  accordingly. This permits proper dead code elimination when CONFIG_FIQ
  is not set.

* Ported to and tested on iMX6 (Wandboard quad). Included a patch from
  Dirk Behme that is required to get this device working properly with
  kgdb.

* Avoid using writel() (which takes spin locks) in polled I/O callbacks
  of supported serial drivers.
  
Changes since v2:

* Use flexible mappings to link a normal virq to a FIQ virq. This
  replaces the device tree proposals from the previous RFC
  (review of Russell King and Rob Herring).

* Reviewed all use of spin locks within .irq_eoi callbacks (and fixed
  the issue identified). Added comments to the FIQ registration
  functions making clear the requirements imposed on interrupt
  controller that call the FIQ API (thanks Russell King).

* Fixed a few whitespace issues (review of Srinivas Kandagatla)

* ARM64/defconfig build tests (no problems found)

Changes since v1:

* Fully fledged multi-platform support.

* Tested for correct FIQ operation on STiH416/B2020 (Cortex A9),
  qemu/versatile and qemu/vexpress-a15 (with self-written mods to the
  GIC model to support FIQ).

* Regression tested (and resulting bugs fixed) on qemu/versatile+DT and
  qemu/integreatorcp.

Anton Vorontsov (2):
  ARM: Move some macros from entry-armv to entry-header
  ARM: Add KGDB/KDB FIQ debugger generic code

Daniel Thompson (10):
  arm: fiq: Add callbacks to manage FIQ routings
  arm: fiq: Allow EOI to be communicated to the intc
  irqchip: gic: Provide support for interrupt grouping
  irqchip: gic: Add support for FIQ management
  irqchip: gic: Remove spin locks from eoi_irq
  irqchip: vic: Add support for FIQ management
  serial: amba-pl011: Pass FIQ information to KGDB.
  serial: asc: Add support for KGDB's FIQ/NMI mode
  serial: asc: Adopt readl_/writel_relaxed()
  serial: imx: Add support for KGDB's FIQ/NMI mode

Dirk Behme (1):
  serial: imx: clean up imx_poll_get_char()

 arch/arm/Kconfig                 |   2 +
 arch/arm/Kconfig.debug           |  18 +++++
 arch/arm/include/asm/fiq.h       |  13 ++++
 arch/arm/include/asm/kgdb.h      |   7 ++
 arch/arm/kernel/Makefile         |   1 +
 arch/arm/kernel/entry-armv.S     | 151 +----------------------------------
 arch/arm/kernel/entry-header.S   | 164 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/fiq.c            | 112 +++++++++++++++++++++++++-
 arch/arm/kernel/kgdb_fiq.c       | 124 +++++++++++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S |  87 +++++++++++++++++++++
 arch/arm/mach-versatile/core.c   |   2 +-
 drivers/irqchip/irq-gic.c        | 155 +++++++++++++++++++++++++++++++++---
 drivers/irqchip/irq-vic.c        |  92 +++++++++++++++++-----
 drivers/tty/serial/amba-pl011.c  |  99 +++++++++++++----------
 drivers/tty/serial/imx.c         |  88 ++++++++++++---------
 drivers/tty/serial/st-asc.c      |  34 +++++++-
 include/linux/irqchip/arm-vic.h  |   6 +-
 17 files changed, 892 insertions(+), 263 deletions(-)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

-- 
1.9.3
