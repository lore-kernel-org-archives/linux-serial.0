From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 03/34] MIPS: irq_cpu: declare irqchip table entry
Date: Wed, 4 Feb 2015 15:21:32 +0000
Message-ID: <1423063323-19419-4-git-send-email-Zubair.Kakakhel@imgtec.com>
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

Allow the MIPS CPU interrupt controller to be probed from DT using the
generic __irqchip_of_table for platforms which use irqchip_init. This
will avoid such platforms needing to duplicate the compatible string &
init function pointer.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/kernel/irq_cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 590c2c9..981d6a3 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -38,6 +38,8 @@
 #include <asm/mipsmtregs.h>
 #include <asm/setup.h>
 
+#include "../../drivers/irqchip/irqchip.h"
+
 static inline void unmask_mips_irq(struct irq_data *d)
 {
 	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
@@ -163,3 +165,4 @@ int __init mips_cpu_irq_of_init(struct device_node *of_node,
 	__mips_cpu_irq_init(of_node);
 	return 0;
 }
+IRQCHIP_DECLARE(cpu_intc, "mti,cpu-interrupt-controller", mips_cpu_irq_of_init);
-- 
1.9.1
