From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 1/4] mfd: exynos-lpass: Enable UART module support
Date: Fri, 21 Dec 2018 15:32:28 +0100
Message-ID: <20181221143228.934-1-m.szyprowski@samsung.com>
References: <20181221103907.GK13248@dell>
        <CGME20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861@eucas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20181221103907.GK13248@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

From: Beomho Seo <beomho.seo@samsung.com>

This patch enables proper interrupts routing between UART module
in Exynos Audio SubSystem and the rest of the SoC. This routing is
completely transparent for UART device and CPU/GIC. UART driver requests
interrupts from the respective controller and enables/masks/handles it
by itself via standard methods.

There are boards (for example TM2), which use UART module in Exynos Audio
SubStem for communication with BlueTooth chip.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
[mszyprow: rephrased commit message, added UART reset]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changelog
v2:
- rephrased and extended commit message
---
 drivers/mfd/exynos-lpass.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index ca829f85672f..2713de989f05 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -82,11 +82,13 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
 		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
 
 	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
-		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
+		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S |
+		     LPASS_INTR_UART);
 
 	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
+	exynos_lpass_core_sw_reset(lpass, LPASS_UART_SW_RESET);
 }
 
 static void exynos_lpass_disable(struct exynos_lpass *lpass)
-- 
2.17.1
