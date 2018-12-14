From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/4] Samsung TM2(e): add Bluetooth support (resend)
Date: Fri, 14 Dec 2018 12:34:06 +0100
Message-ID: <20181214113410.22848-1-m.szyprowski@samsung.com>
References: <CGME20181214113415eucas1p16dd61a4312d88216cb0d737887c751b7@eucas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi All

This patchset enables Bluetooth support on TM2/TM2e boards using mainline
HCI_BCM driver. It requires a few fixes to Samsung serial driver and
adding a proper node to device tree description of the mentioned boards.
Patches can be applied independently to each subsystem.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


(resend reason: added respective maintainers and lists to cc)

Patch summary:

Beomho Seo (2):
  mfd: exynos-lpass: Enable UART module support
  tty: serial: samsung: Properly set flags in autoCTS mode

Marek Szyprowski (1):
  arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards

Seung-Woo Kim (1):
  tty: serial: samsung: Increase maximum baudrate

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 14 ++++++++++++++
 drivers/mfd/exynos-lpass.c                         |  4 +++-
 drivers/tty/serial/samsung.c                       |  5 ++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1
