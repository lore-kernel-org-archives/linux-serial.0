From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] pinctrl: zynq: fix offset address for {SD0,SD1}_WP_CD_SEL
Date: Wed, 20 May 2015 17:38:34 +0900
Message-ID: <1432111114-21163-3-git-send-email-yamada.masahiro@socionext.com>
References: <1432111114-21163-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432111114-21163-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The address for SD0_WP_CD_SEL, SD1_WP_CD_SEL is 0xf8000830,
0xf8000834, respectively.

Each offset address must be prefixed with 0x.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-zynq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 77c5a98..04748a4 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -745,15 +745,15 @@ static const struct zynq_pinmux_function zynq_pmux_functions[] = {
 	DEFINE_ZYNQ_PINMUX_FUNCTION(spi1, 0x50),
 	DEFINE_ZYNQ_PINMUX_FUNCTION(sdio0, 0x40),
 	DEFINE_ZYNQ_PINMUX_FUNCTION(sdio0_pc, 0xc),
-	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio0_wp, 0, 130, ZYNQ_SDIO_WP_MASK,
+	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio0_wp, 0, 0x130, ZYNQ_SDIO_WP_MASK,
 					ZYNQ_SDIO_WP_SHIFT),
-	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio0_cd, 0, 130, ZYNQ_SDIO_CD_MASK,
+	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio0_cd, 0, 0x130, ZYNQ_SDIO_CD_MASK,
 					ZYNQ_SDIO_CD_SHIFT),
 	DEFINE_ZYNQ_PINMUX_FUNCTION(sdio1, 0x40),
 	DEFINE_ZYNQ_PINMUX_FUNCTION(sdio1_pc, 0xc),
-	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio1_wp, 0, 134, ZYNQ_SDIO_WP_MASK,
+	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio1_wp, 0, 0x134, ZYNQ_SDIO_WP_MASK,
 					ZYNQ_SDIO_WP_SHIFT),
-	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio1_cd, 0, 134, ZYNQ_SDIO_CD_MASK,
+	DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(sdio1_cd, 0, 0x134, ZYNQ_SDIO_CD_MASK,
 					ZYNQ_SDIO_CD_SHIFT),
 	DEFINE_ZYNQ_PINMUX_FUNCTION(smc0_nor, 4),
 	DEFINE_ZYNQ_PINMUX_FUNCTION(smc0_nor_cs1, 8),
-- 
1.9.1
