From: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Subject: [RFC PATCH v2 2/3] genirq: Add a function to set irq affinity of
 candidate IRQs
Date: Wed, 29 Jul 2015 08:12:59 +0000
Message-ID: <1438157443-19447-3-git-send-email-t-kageyama@cp.jp.nec.com>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>
Cc: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

This new function can specify which CPU is used for interrupt probing.

An interrupt probing code expects a CPU detects an interrupt from the
target device, but it doesn't work when the CPU has interrupts disabled
during the waiting time.
The probing code can use this function to specify which CPU detects the
interrupt and reduce the risk of the failure as far as possible.

Signed-off-by: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/autoprobe.c    | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git v4.2-rc4.org/include/linux/interrupt.h v4.2-rc4.work/include/linux/interrupt.h
index be7e75c..4f08f6d 100644
--- v4.2-rc4.org/include/linux/interrupt.h
+++ v4.2-rc4.work/include/linux/interrupt.h
@@ -647,10 +647,14 @@ static inline unsigned int probe_irq_mask(unsigned long val)
 {
 	return 0;
 }
+static inline void probe_irq_set_affinity(unsigned long val, cpumask_t *mask)
+{
+}
 #else
 extern unsigned long probe_irq_on(void);	/* returns 0 on failure */
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
+extern void probe_irq_set_affinity(unsigned long, cpumask_t *);
 #endif
 
 #ifdef CONFIG_PROC_FS
diff --git v4.2-rc4.org/kernel/irq/autoprobe.c v4.2-rc4.work/kernel/irq/autoprobe.c
index 0119b9d..24e7647 100644
--- v4.2-rc4.org/kernel/irq/autoprobe.c
+++ v4.2-rc4.work/kernel/irq/autoprobe.c
@@ -183,3 +183,34 @@ int probe_irq_off(unsigned long val)
 }
 EXPORT_SYMBOL(probe_irq_off);
 
+/**
+ *	probe_irq_set_affinity	- change smp_affinity during autodetect
+ *	@val: mask of potential interrupts (unused)
+ *
+ *	Sets smp_affinity of candidate irq lines if possible.
+ *
+ *	An interrupt probing code expects a CPU detects an interrupt
+ *	from the target device, but it doesn't work when the CPU has
+ *	interrupts disabled during the waiting time.
+ *	The code can use this function to specify which CPU detects
+ *	the interrupt and reduce the risk of the failure.
+ */
+void probe_irq_set_affinity(unsigned long val, cpumask_t *mask)
+{
+	int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		raw_spin_lock_irq(&desc->lock);
+
+		if (desc->istate & IRQS_AUTODETECT) {
+			struct irq_data *data = &desc->irq_data;
+
+			if (data->chip && data->chip->irq_set_affinity)
+				irq_do_set_affinity(data, mask, false);
+		}
+		raw_spin_unlock_irq(&desc->lock);
+	}
+}
+EXPORT_SYMBOL(probe_irq_set_affinity);
+
-- 
2.4.6
