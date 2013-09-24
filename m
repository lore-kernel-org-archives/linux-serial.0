From: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Subject: [PATCH 6/6] ARM: shmobile: kzm9d-reference: Use common clock
 framework
Date: Tue, 24 Sep 2013 13:17:03 +0900
Message-ID: <20130924131703.4834a055892285858338003c@ops.dti.ne.jp>
References: <52410F86.4040301@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52410F86.4040301-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Use common clock framework version of clock
 drivers/clk/shmobile/clk-emev2.c
instead of sh-clkfwk version
 arch/arm/mach-shmobile/clock-emev2.c

kzm9d(without -reference) still uses sh-clkfwk version.

Because two of that framework can not live in one kernel binary,
there will be SoCs and Boards that can not be in one binary as
multiplatform binary or so.
For example, kzm9d and kzm9d-reference is now exclusive.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-shmobile/Kconfig                 | 1 +
 arch/arm/mach-shmobile/board-kzm9d-reference.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 50bab8d..d20d4ce 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -237,6 +237,7 @@ config MACH_KZM9D_REFERENCE
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
+	select COMMON_CLK
 	---help---
 	   Use reference implementation of KZM9D board support
 	   which makes a greater use of device tree at the expense
diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
index 8f8bb2f..e0b8317 100644
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
@@ -20,15 +20,14 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 #include <mach/emev2.h>
 #include <mach/common.h>
 #include <asm/mach/arch.h>
 
 static void __init kzm9d_add_standard_devices(void)
 {
-	if (!IS_ENABLED(CONFIG_COMMON_CLK))
-		emev2_clock_init();
-
+	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
