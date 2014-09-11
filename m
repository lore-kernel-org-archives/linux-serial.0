From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 0/9] ARM: meson: add preliminary support for MesonX/Meson6 SoCs
Date: Thu, 11 Sep 2014 22:11:31 +0200
Message-ID: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:54584 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbaIKUMB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 16:12:01 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com
Cc: Carlo Caione <carlo@caione.org>

Amlogic AML8726-MX (codename Meson6) is a highly integrated multimedia
application processor SoC for Multimedia Internet Device (MID), tablet
and Set Top Box (STB). It integrates a powerful CPU, a 2D/3D graphics
subsystem and a state-of-the-art video decoding engine together with
all major peripherals. It is manufactured by Amlogic, inc.

This patchset introduces preliminary support for Meson6-based SoCs but
several IPs and drivers are common among all the MesonX SoCs.

Amlogic doesn't release any documentation about their SoCs, so the code
has been reverse-engineered from the messy source code released at:

http://openlinux.amlogic.com:8000/download/

Notes:
* The patchset requires https://lkml.org/lkml/2014/7/7/344
* Patch [3/9] is already in tty-next branch

Changes since v1:
* clocksource driver: deleted useless pointers to timers not used and code
  restyling
* machine file: deleted useless compatibles and .init_machine
* DTS: addressed several issues
* defconfigs: deleted meson_defconfig
* documentation: split documentation patch and added bindings documentation

Carlo Caione (9):
  ARM: meson: debug: add debug UART for earlyprintk support
  ARM: meson: documentation: add UART documentation
  ARM: meson: serial: add MesonX SoC on-chip uart driver
  ARM: meson: documentation: add timer documentation
  ARM: meson6: clocksource: add Meson6 timer support
  ARM: meson: documentation: add bindings documentation
  ARM: meson: add basic support for MesonX SoCs
  ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
  ARM: meson: update multi_v7_defconfig

 Documentation/devicetree/bindings/arm/amlogic.txt  |   8 +
 .../devicetree/bindings/arm/geniatech.txt          |   5 +
 .../bindings/serial/amlogic,meson-uart.txt         |  17 +
 .../bindings/timer/amlogic,meson6-timer.txt        |  16 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  14 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/meson.dtsi                       |  74 +++
 arch/arm/boot/dts/meson6-atv1200.dts               |  25 +
 arch/arm/boot/dts/meson6.dtsi                      |  40 ++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/include/debug/meson.S                     |  35 ++
 arch/arm/mach-meson/Kconfig                        |  13 +
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/meson.c                        |  27 +
 drivers/clocksource/Kconfig                        |   3 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/meson6_timer.c                 | 167 ++++++
 drivers/tty/serial/Kconfig                         |  18 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/meson_uart.c                    | 634 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 24 files changed, 1109 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi
 create mode 100644 arch/arm/include/debug/meson.S
 create mode 100644 arch/arm/mach-meson/Kconfig
 create mode 100644 arch/arm/mach-meson/Makefile
 create mode 100644 arch/arm/mach-meson/meson.c
 create mode 100644 drivers/clocksource/meson6_timer.c
 create mode 100644 drivers/tty/serial/meson_uart.c

-- 
1.9.1

