From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 00/12] Add support for the Armada 3700 SoC an mvebu ARM64 based
Date: Wed,  3 Feb 2016 19:41:17 +0100
Message-ID: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi,

This series introduce the support of the Armada 3700 family: it is the
first ARM64 SoC of the mvebu family submitted to the mainline!

Currently there are two members of the Armada 3700 family, the only
difference is the number of core: the Armada 3710 comes with one
Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
series we enabled only the minimum to boot, pinctrl and clock tree
will come soon.

This is the second version of the series, see the changelog for the
detail. The bigger change was the addition of two itqchip patches to
be able to use the the ARCH_MVEBU for the Armada 3700 SoCs. The first
ones is only here to have standalone series but it comes from Thomas
Petazzoni's series:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/472625

Then on top of it I added a small patch allowing building the kernel
without this driver for ARM64. So now there is a dependency :/

Besides this the patches are pretty usual:

The third patch introduces a new serial driver for the uart used on
this SoC. The driver remains simple even if the hardware is capable of
doing more.

The forth one adapts the ahci driver to support the Armada 3700 SoC.
The forth patch updates the binding documentation with the new
compatible string.

The fifth patch adds a new entry Kconfig entry for this SoC family.

I took the opportunity of this series to tidy up the Marvell related
files in the binding documentation with the seventh patch.

The eighth patch introduces the compatible string for the SoCs of the
Armada 3700 family.

The ninth patch could be considered as the bulk of this series: it
adds the device tree files for the Armada 3700 SoCs and for the
reference board.

With the introduction of this new family the MAINTAINERS file, the
Marvell README and the ARM64 defconfig files have to be updated: it is
the purpose of the last 3 patches.

The patches 3 and 4 could be taken directly by the maintainer of their
respective subsystem as there is no dependency at all with the rest of
the series. I think that the rest of the series should go through the
arm-soc maintainer but in doubt I also added the ARM64 maintainer as
suggested by get_maintainer.pl. 

Thanks,

Gregory

Changelog:
v1 -> v2
- Added Rob acked-by on patches 3, 6 and 7
- Used armada3700_uart instead of mvebu_uart for the uart driver:
  suggested by Mark
- In mvebu-uart, do not use anymore TTY_MAJOR, or ttyS, but dynamic
  major and ttyMV: pointed by Alan
- Use tty_termios_copy_hw in mvebu_uart_set_termios: suggested by Alan
- Use ARCH_MVEBU instead of creating ARCH_ARMADA_3700: suggested by
  Jisheng
- Added a new irqchip pacthes to fix build on ARM64 when ARCH_MVEBU is
  selected
- Removed marvell,armada3700 from the device tree binding and directly
  used marvell,armada3710 for common feature: pointed by Rob
- Fix memory node with coorect size in armada-3720-db.dts: suggested
  by Mark

Gregory CLEMENT (9):
  irqchip: armada-370-xp: do not enable it by default when ARCH_MVEBU is
    selected
  arm64: add mvebu architecture entry
  Documentation: dt-bindings: Add a new compatible for the Armada 3700
  Documentation: dt: Tidy up the Marvell related files
  devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC
    family
  arm64: dts: add the Marvell Armada 3700 family and a development board
  MAINTAINERS: Extend dts entry for ARM64 mvebu files
  Documentation: arm: update supported Marvell EBU processors
  arm64: defconfig: enable Armada 3700 related config

Lior Amsalem (1):
  ata: ahci_mvebu: add support for Armada 3700 variant

Thomas Petazzoni (1):
  irqchip: armada-370-xp: add Kconfig option for the driver

Wilson Ding (1):
  serial: mvebu-uart: initial support for Armada-3700 serial port

 Documentation/arm/Marvell/README                   |  13 +
 .../arm/{ => marvell}/armada-370-xp-pmsu.txt       |   0
 .../bindings/arm/{ => marvell}/armada-370-xp.txt   |   0
 .../bindings/arm/{ => marvell}/armada-375.txt      |   0
 .../bindings/arm/marvell/armada-37xx.txt           |  16 +
 .../{ => marvell}/armada-380-mpcore-soc-ctrl.txt   |   0
 .../bindings/arm/{ => marvell}/armada-38x.txt      |   0
 .../bindings/arm/{ => marvell}/armada-39x.txt      |   0
 .../arm/{ => marvell}/armada-cpu-reset.txt         |   0
 .../arm/{ => marvell}/coherency-fabric.txt         |   0
 .../bindings/arm/{ => marvell}/kirkwood.txt        |   0
 .../bindings/arm/{ => marvell}/marvell,berlin.txt  |   0
 .../bindings/arm/{ => marvell}/marvell,dove.txt    |   0
 .../arm/{ => marvell}/marvell,kirkwood.txt         |   0
 .../arm/{ => marvell}/mvebu-cpu-config.txt         |   0
 .../arm/{ => marvell}/mvebu-system-controller.txt  |   0
 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 .../devicetree/bindings/tty/serial/mvebu-uart.txt  |  13 +
 Documentation/kernel-parameters.txt                |   6 +
 MAINTAINERS                                        |   1 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/marvell/Makefile               |   4 +
 arch/arm64/boot/dts/marvell/armada-371x.dtsi       |  53 ++
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  86 +++
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  63 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 131 +++++
 arch/arm64/configs/defconfig                       |   5 +
 drivers/ata/ahci_mvebu.c                           |  14 +-
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/tty/serial/Kconfig                         |  22 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/mvebu-uart.c                    | 650 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 34 files changed, 1088 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt (100%)
 rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-371x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-372x.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-37xx.dtsi
 create mode 100644 drivers/tty/serial/mvebu-uart.c

-- 
2.5.0

