From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 17/20] ARM: sunxi: Introduce Allwinner A23 support
Date: Tue, 17 Jun 2014 22:52:54 +0800
Message-ID: <1403016777-15121-18-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBZNMQGOQKGQEZB4RRNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1403016777-15121-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The Allwinner A23 is a dual-core Cortex-A7-based SoC. It re-uses most of
the IPs found in previous SoCs, notably the A31.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm/mach-sunxi/Kconfig |  8 ++++++++
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 0fbd4f1..6434e3b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -35,4 +35,12 @@ config MACH_SUN7I
 	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
 
+config MACH_SUN8I
+	bool "Allwinner A23 (sun8i) SoCs support"
+	default ARCH_SUNXI
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_GIC
+	select MFD_SUN6I_PRCM
+	select RESET_CONTROLLER
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 3f9587b..962ff30 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -53,3 +53,13 @@ static const char * const sun7i_board_dt_compat[] = {
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 	.dt_compat	= sun7i_board_dt_compat,
 MACHINE_END
+
+static const char * const sun8i_board_dt_compat[] = {
+	"allwinner,sun8i-a23",
+	NULL,
+};
+
+DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
+	.init_time	= sun6i_timer_init,
+	.dt_compat	= sun8i_board_dt_compat,
+MACHINE_END
-- 
2.0.0
