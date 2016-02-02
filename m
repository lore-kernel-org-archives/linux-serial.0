From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 00/10] Add support for the Armada 3700 SoC an mvebu ARM64 based
Date: Tue,  2 Feb 2016 19:07:38 +0100
Message-ID: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

This series introduce the support of the Armada 3700 family: it is the
first ARM64 SoC of the mvebu family submitted to the mainline!

Currently there are two members of the Armada 3700 family, the only
difference is the number of core: the Armada 3710 comes with one
Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
series we enabled only the minimum to boot, pinctrl and clock tree
will come soon.

Besides this the patches are pretty usual:

The first patch introduces a new serial driver for the uart used on
this SoC. The driver remains simple even if the hardware is capable of
doing more.

The second one adapts the ahci driver to support the Armada 3700 SoC.
The forth patch updates the binding documentation with the new
compatible string.

The third patch adds a new entry Kconfig entry for this SoC family.

I took the opportunity of this series to tidy up the Marvell related
files in the binding documentation with the fifth patch.

The sixth patch introduces the compatible string for the SoCs of the
Armada 3700 family.

The seventh patch could be considered as the bulk of this series: it
adds the device tree files for the Armada 3700 SoCs and for the
reference board.

With the introduction of this new family the MAINTAINERS file, the
Marvell README and the ARM64 defconfig files have to be updated: it is
the purpose of the last 3 patches.

The first two patches could be taken directly by the maintainer of
their respective subsystem as there is no dependency at all with the
rest of the series. I think that the rest of the series should go
through the arm-soc maintainer but in doubt I also added the ARM64
maintainer as suggested by get_maintainer.pl. Actually all the patches
are independents.

Thanks,

Gregory

Gregory CLEMENT (8):
  arm64: add Armada 3700 architecture entry
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

Wilson Ding (1):
  serial: mvebu-uart: initial support for Armada-3700 serial port

 Documentation/arm/Marvell/README                   |  13 +
 .../arm/{ => marvell}/armada-370-xp-pmsu.txt       |   0
 .../bindings/arm/{ => marvell}/armada-370-xp.txt   |   0
 .../bindings/arm/{ => marvell}/armada-375.txt      |   0
 .../bindings/arm/marvell/armada-37xx.txt           |  17 +
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
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |  87 +++
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  63 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 131 +++++
 arch/arm64/configs/defconfig                       |   5 +
 drivers/ata/Kconfig                                |   2 +-
 drivers/ata/ahci_mvebu.c                           |  14 +-
 drivers/tty/serial/Kconfig                         |  22 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/mvebu-uart.c                    | 649 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 33 files changed, 1085 insertions(+), 6 deletions(-)
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

