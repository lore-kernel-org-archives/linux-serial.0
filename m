From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 5/5] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
Date: Thu, 30 Nov 2017 14:12:02 +0100
Message-ID: <1512047522-16312-6-git-send-email-geert+renesas@glider.be>
References: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

CONFIG_EXPERT exposes too many config options that do not matter for
development. However, CONFIG_EMBEDDED selects CONFIG_EXPERT, so it
cannot be disabled.

Hence disable CONFIG_EMBEDDED, and compensate for the loss of
CONFIG_DEBUG_KERNEL by enabling the latter.

Actual impact:
  - CONFIG_NAMESPACES=y,
  - CONFIG_SYSCTL_SYSCALL=n,
  - CONFIG_SERIAL_SH_SCI_NR_UARTS changed from 20 to 18,
  - CONFIG_SERIAL_SH_SCI_EARLYCON=y,
  - Some HID support became enabled,
  - CONFIG_DEBUG_MEMORY_INIT=y,

Refresh the result.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7b4fc01431483f21..41eccc1b6cef7251 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -5,8 +5,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_ARCH_RENESAS=y
@@ -34,7 +32,6 @@ CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=8
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -106,7 +103,6 @@ CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
-CONFIG_SERIAL_SH_SCI_DMA=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_DEMUX_PINCTRL=y
@@ -166,7 +162,6 @@ CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
@@ -225,4 +220,5 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
 # CONFIG_ARM_UNWIND is not set
-- 
2.7.4
