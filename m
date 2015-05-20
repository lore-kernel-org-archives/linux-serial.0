From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] pinctrl: zynq: fix DEFINE_ZYNQ_PINMUX_FUNCTION_MUX macro
Date: Wed, 20 May 2015 17:38:33 +0900
Message-ID: <1432111114-21163-2-git-send-email-yamada.masahiro@socionext.com>
References: <1432111114-21163-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432111114-21163-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The offset to the mux register is missing.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-zynq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 3d5453a..77c5a98 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -714,12 +714,13 @@ static const char * const gpio0_groups[] = {"gpio0_0_grp",
 		.mux_val = mval,			\
 	}
 
-#define DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(fname, mval, mux, mask, shift)	\
+#define DEFINE_ZYNQ_PINMUX_FUNCTION_MUX(fname, mval, offset, mask, shift)\
 	[ZYNQ_PMUX_##fname] = {				\
 		.name = #fname,				\
 		.groups = fname##_groups,		\
 		.ngroups = ARRAY_SIZE(fname##_groups),	\
 		.mux_val = mval,			\
+		.mux = offset,				\
 		.mux_mask = mask,			\
 		.mux_shift = shift,			\
 	}
-- 
1.9.1
