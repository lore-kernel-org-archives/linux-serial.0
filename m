From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 30/34] MIPS: jz4740: add jz4780 interrupt controller support
Date: Wed, 4 Feb 2015 15:21:59 +0000
Message-ID: <1423063323-19419-31-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

Allow the jz4780 interrupt controller to be probed from devicetree,
supporting the 64 interrupts it provides.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 3e53a32..de1c03e 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -137,6 +137,13 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
 
+static int __init jz4780_intc_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	return jz47xx_intc_of_init(node, 2);
+}
+IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", jz4780_intc_of_init);
+
 #ifdef CONFIG_DEBUG_FS
 
 static inline void intc_seq_reg(struct seq_file *s, const char *name,
-- 
1.9.1
