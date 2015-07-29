From: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Subject: [RFC PATCH v2 3/3] serial: 8250: Fix autoconfig_irq() to reduce the
 risk of failure
Date: Wed, 29 Jul 2015 08:13:01 +0000
Message-ID: <1438157443-19447-4-git-send-email-t-kageyama@cp.jp.nec.com>
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

autoconfig_irq() expects a CPU detects an interrupt from a serial
port, but it doesn't work when the CPU has interrupts disabled
during the waiting time.
New one tries to specify own CPU to probe the interrupt
and reduce the risk of the failure as far as possible.

Signed-off-by: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Suggested-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git v4.2-rc4.org/drivers/tty/serial/8250/8250_core.c v4.2-rc4.work/drivers/tty/serial/8250/8250_core.c
index ed1e23e..85e8cdf 100644
--- v4.2-rc4.org/drivers/tty/serial/8250/8250_core.c
+++ v4.2-rc4.work/drivers/tty/serial/8250/8250_core.c
@@ -1295,6 +1295,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	unsigned int ICP = 0;
 	unsigned long irqs;
 	int irq;
+	cpumask_t this_cpu;
 
 	if (port->flags & UPF_FOURPORT) {
 		ICP = (port->iobase & 0xfe0) | 0x1f;
@@ -1313,6 +1314,13 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	serial_out(up, UART_MCR, UART_MCR_OUT1 | UART_MCR_OUT2);
 
 	irqs = probe_irq_on();
+
+	/* Try to detect irq on the current CPU */
+	cpumask_clear(&this_cpu);
+	preempt_disable();
+	cpumask_set_cpu(smp_processor_id(), &this_cpu);
+	probe_irq_set_affinity(irqs, &this_cpu);
+
 	serial_out(up, UART_MCR, 0);
 	udelay(10);
 	if (port->flags & UPF_FOURPORT) {
@@ -1330,6 +1338,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	serial_out(up, UART_TX, 0xFF);
 	udelay(20);
 	irq = probe_irq_off(irqs);
+	preempt_enable();
 
 	serial_out(up, UART_MCR, save_mcr);
 	serial_out(up, UART_IER, save_ier);
-- 
2.4.6
