From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 20/34] MIPS: jz4740: remove clock.h
Date: Wed, 4 Feb 2015 15:21:49 +0000
Message-ID: <1423063323-19419-21-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

The only thing remaining in arch/mips/jz4740/clock.h is declarations of
the jz4780_clock_{suspend,resume} functions. Move these to
arch/mips/include/asm/mach-jz4740/clock.h for consistency with similar
functions, and remove the redundant arch/mips/jz4740/clock.h header.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/clock.h |  3 +++
 arch/mips/jz4740/clock.h                  | 25 -------------------------
 arch/mips/jz4740/pm.c                     |  2 --
 3 files changed, 3 insertions(+), 27 deletions(-)
 delete mode 100644 arch/mips/jz4740/clock.h

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
index 16659cd..104d2df 100644
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ b/arch/mips/include/asm/mach-jz4740/clock.h
@@ -22,6 +22,9 @@ enum jz4740_wait_mode {
 
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
 
+void jz4740_clock_suspend(void);
+void jz4740_clock_resume(void);
+
 void jz4740_clock_udc_enable_auto_suspend(void);
 void jz4740_clock_udc_disable_auto_suspend(void);
 
diff --git a/arch/mips/jz4740/clock.h b/arch/mips/jz4740/clock.h
deleted file mode 100644
index 86a3e01..0000000
--- a/arch/mips/jz4740/clock.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC clock support
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef __MIPS_JZ4740_CLOCK_H__
-#define __MIPS_JZ4740_CLOCK_H__
-
-#include <linux/clk.h>
-#include <linux/list.h>
-
-void jz4740_clock_suspend(void);
-void jz4740_clock_resume(void);
-
-#endif
diff --git a/arch/mips/jz4740/pm.c b/arch/mips/jz4740/pm.c
index d8e2130..2d8653f 100644
--- a/arch/mips/jz4740/pm.c
+++ b/arch/mips/jz4740/pm.c
@@ -20,8 +20,6 @@
 
 #include <asm/mach-jz4740/clock.h>
 
-#include "clock.h"
-
 static int jz4740_pm_enter(suspend_state_t state)
 {
 	jz4740_clock_suspend();
-- 
1.9.1
