From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 0/2] serial: samsung: add support for early console
Date: Fri, 23 Jan 2015 14:47:40 +0100
Message-ID: <1422020862-10169-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, thomas.ab@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene@kernel.org>
List-Id: linux-serial@vger.kernel.org

This patchset adds support for early console defined in device tree. As
an example, DTS files for all Exynos4 based machines are updated with
the correct value for common chosen/sdtout property.

To get it fully functional on ARM architecture, additional improvements
(support for early_ioremap) are needed in early console code.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v4:
- added 'tested-by' tags, resend

v3: http://www.spinics.net/lists/linux-samsung-soc/msg37922.html
- rebased onto v3.18-rc1
- removed options from documentation (they are not yet supported)

v2: http://www.spinics.net/lists/linux-samsung-soc/msg37278.html
- added support for command line based initialization

v1: http://www.spinics.net/lists/linux-samsung-soc/msg37094.html
- initial version

Tomasz Figa (2):
  serial: samsung: Add support for early console
  ARM: dts: exynos4: Add stdout-path properties

 Documentation/kernel-parameters.txt             |  12 +++
 arch/arm/boot/dts/exynos4210-origen.dts         |   1 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |   1 +
 arch/arm/boot/dts/exynos4210-trats.dts          |   1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 +
 arch/arm/boot/dts/exynos4412-origen.dts         |   1 +
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |   1 +
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   4 +
 arch/arm/boot/dts/exynos4412-trats2.dts         |   1 +
 drivers/tty/serial/Kconfig                      |   1 +
 drivers/tty/serial/samsung.c                    | 103 ++++++++++++++++++++++++
 12 files changed, 131 insertions(+)

-- 
1.9.2
