Return-Path: <SRS0=hEVs=4Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0051AC10F27
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D766A20866
	for <linux-serial@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCHQcs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:32:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgCHQcs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61ED5AD77;
        Sun,  8 Mar 2020 16:32:45 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC 00/11] ARM: Initial Sunplus Plus1 SP7021 and BPI-F2S support
Date:   Sun,  8 Mar 2020 17:32:18 +0100
Message-Id: <20200308163230.4002-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

This patch series adds initial drivers and Device Trees for Sunplus Plus1
series (codename Pentagram) SP7021 SoC and Banana Pi BPI-F2S SBC.

First, minimal Kconfig, DT and earlycon driver are prepared to get serial
output at all. Next, interrupt controller and full serial driver are added
that allow to boot into an initrd with interactive serial console.

Device Tree files added are for the CPU-Chip (aka A-Chip) with quad Cortex-A7,
but the file split prepares for also adding the Peripheral-Chip (B-Chip) with
ARM9 later. However, for now this is not reflected in the .dts filename; this
corresponds to the vf610- vs. vf610m4- naming scheme, whereas an alternative
would be to use sp7021-cchip- vs. -pchip- prefix (as sp7021-cpu- looks weird).
It is assumed we can reuse the same SoC and board bindings for CA7 and ARM9
and only differ for IP blocks where needed.

My inquiry to Sunplus about their GIC (anticipating complaints from Marc)
remained unanswered, so I've added the two extra regions and irq myself,
without being able to test KVM due to BSP U-Boot not booting in HYP mode.
According to Sunplus the mode can be changed in U-Boot (but where/how?).

Similarly, the architectural timer is not properly initialized in BSP U-Boot,
so that I currently have a mach- hack in my tree below. Unlike RTD1195,
we do have U-Boot sources (v2019.04 based), so should be able to fix this
in the bootloader rather than in the kernel, thus not included as patch here.

Based on SoC online manual [1] and downstream BPI-F2S BSP tree [2] as well as
my previous Actions serial and Realtek irqchip drivers and DTs.

More details at:
https://en.opensuse.org/HCL:BananaPi_F2S

Latest experimental patches at:
https://github.com/afaerber/linux/commits/f2s-next

Have a lot of fun!

Cheers,
Andreas

[1] https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/pages/470450252/SP7021+Technical+Manual
[2] https://github.com/BPI-SINOVOIP/BPI-F2S-bsp

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
Cc: Dvorkin Dmitry <dvorkin@tibbo.com>

Andreas Färber (11):
  dt-bindings: vendor-prefixes: Add Sunplus
  dt-bindings: arm: Add Sunplus SP7021 and Banana Pi BPI-F2S
  ARM: Prepare Sunplus Plus1 SoC family
  dt-bindings: interrupt-controller: Add Sunplus SP7021 mux
  dt-bindings: serial: Add Sunplus SP7021 UART
  tty: serial: Add Sunplus Plus1 UART earlycon
  ARM: dts: Add Sunplus Plus1 SP7021 and Banana Pi F2S
  tty: serial: sunplus: Implement full UART driver
  irqchip: Add Sunplus SP7021 interrupt (mux) controller
  ARM: dts: sp7021-cpu: Add interrupt controller node
  ARM: dts: sp7021-cpu: Add dummy UART0 clock and interrupt

 Documentation/devicetree/bindings/arm/sunplus.yaml |  22 +
 .../sunplus,pentagram-intc.yaml                    |  50 ++
 .../bindings/serial/sunplus,pentagram-uart.yaml    |  24 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts     |  29 +
 arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi        |  93 +++
 arch/arm/boot/dts/pentagram-sp7021.dtsi            |  61 ++
 arch/arm/mach-sunplus/Kconfig                      |  10 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-sp7021.c                       | 285 ++++++++
 drivers/tty/serial/Kconfig                         |  19 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/sunplus-uart.c                  | 770 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 17 files changed, 1375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,pentagram-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml
 create mode 100644 arch/arm/boot/dts/pentagram-sp7021-bpi-f2s.dts
 create mode 100644 arch/arm/boot/dts/pentagram-sp7021-cpu.dtsi
 create mode 100644 arch/arm/boot/dts/pentagram-sp7021.dtsi
 create mode 100644 arch/arm/mach-sunplus/Kconfig
 create mode 100644 drivers/irqchip/irq-sp7021.c
 create mode 100644 drivers/tty/serial/sunplus-uart.c

-- 
2.16.4

