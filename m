From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 0/7] ARM: meson: add preliminary support for MesonX/Meson6 SoCs
Date: Sun, 17 Aug 2014 12:49:47 +0200
Message-ID: <1408272594-10814-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:47410 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaHQKuX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 06:50:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com
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

Carlo Caione (7):
  ARM: meson: debug: add debug UART for earlyprintk support
  ARM: meson: serial: add MesonX SoC on-chip uart driver
  ARM: meson6: clocksource: add Meson6 timer support
  ARM: meson: add basic support for MesonX SoCs
  ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
  ARM: meson: update defconfigs
  ARM: meson: update documentation (uart, timer and vendors)

 .../bindings/serial/amlogic,meson-uart.txt         |  17 +
 .../bindings/timer/amlogic,meson6-timer.txt        |  16 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  14 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/meson.dtsi                       |  75 +++
 arch/arm/boot/dts/meson6-atv1200.dts               |  27 +
 arch/arm/boot/dts/meson6.dtsi                      |  44 ++
 arch/arm/configs/meson_defconfig                   |  99 ++++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/include/debug/meson.S                     |  35 ++
 arch/arm/mach-meson/Kconfig                        |  13 +
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/meson.c                        |  36 ++
 drivers/clocksource/Kconfig                        |   3 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/meson6_timer.c                 | 187 ++++++
 drivers/tty/serial/Kconfig                         |  18 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/meson_uart.c                    | 634 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 23 files changed, 1230 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi
 create mode 100644 arch/arm/configs/meson_defconfig
 create mode 100644 arch/arm/include/debug/meson.S
 create mode 100644 arch/arm/mach-meson/Kconfig
 create mode 100644 arch/arm/mach-meson/Makefile
 create mode 100644 arch/arm/mach-meson/meson.c
 create mode 100644 drivers/clocksource/meson6_timer.c
 create mode 100644 drivers/tty/serial/meson_uart.c

-- 
1.9.1

