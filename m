From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 12/34] MIPS: jz4740: call jz4740_clock_init earlier
Date: Wed, 4 Feb 2015 15:21:41 +0000
Message-ID: <1423063323-19419-13-git-send-email-Zubair.Kakakhel@imgtec.com>
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

Call jz4740_clock_init before any uses of jz4740_clock_bdata occur. This
is in preparation for replacing uses of that struct with calls to
clk_get_rate, which will allow the clocks to be migrated towards common
clock framework & devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/clock.h | 2 ++
 arch/mips/jz4740/clock.c                  | 3 +--
 arch/mips/jz4740/time.c                   | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
index 16659cd..01d8468 100644
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ b/arch/mips/include/asm/mach-jz4740/clock.h
@@ -20,6 +20,8 @@ enum jz4740_wait_mode {
 	JZ4740_WAIT_MODE_SLEEP,
 };
 
+int jz4740_clock_init(void);
+
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
 
 void jz4740_clock_udc_enable_auto_suspend(void);
diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index 1b5f554..c257073 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -889,7 +889,7 @@ void jz4740_clock_resume(void)
 		JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
 }
 
-static int jz4740_clock_init(void)
+int jz4740_clock_init(void)
 {
 	uint32_t val;
 
@@ -921,4 +921,3 @@ static int jz4740_clock_init(void)
 
 	return 0;
 }
-arch_initcall(jz4740_clock_init);
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 5e430ce..9424344 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -19,6 +19,7 @@
 
 #include <linux/clockchips.h>
 
+#include <asm/mach-jz4740/clock.h>
 #include <asm/mach-jz4740/irq.h>
 #include <asm/mach-jz4740/timer.h>
 #include <asm/time.h>
@@ -109,6 +110,7 @@ void __init plat_time_init(void)
 	uint32_t clk_rate;
 	uint16_t ctrl;
 
+	jz4740_clock_init();
 	jz4740_timer_init();
 
 	clk_rate = jz4740_clock_bdata.ext_rate >> 4;
-- 
1.9.1
