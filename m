From: "Shankarmurthy, Akshay" <akshay.s-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 RESEND] serial: 8250: Add cpufreq support
Date: Tue, 15 May 2012 20:40:49 +0530
Message-ID: <1337094649-7691-1-git-send-email-akshay.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patch adds cpufreq support for 8250 serial driver. A clk structure
member has been added to the platform and port data structures. This
member is used by the cpufreq notifier callback to get the updated
clock rate. Also adds a member 'enable_cpufreq' to the plat_serial8250_port
and uart_port structures which decides the requirement of cpufreq registration
for each individual ports. If the port requires registration then
'enable_cpufreq' should be passed as TRUE from the board file.

Tested on TI DA850/OMAP-L138 EVM.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shankarmurthy, Akshay <akshay.s-l0cyMroinI0@public.gmane.org>
---
v2 includes following changes :

1. Used "tty_port_tty_get" API to get the tty struct instead of accesing it
directly from the uart_port structure.
2. Added a boolean member "enable_cpufreq" to the uart_port and
serial8250_port structures. This indicates the requirement of cpu freq
registration for each individual ports.
3. Renamed the function from "serial8250_cpufreq_deregister" to
"serial8250_cpufreq_unregister".

Changes are as per these discussions
http://www.mail-archive.com/davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org/msg22841.html

 drivers/tty/serial/8250/8250.c |   79 ++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250.h |    4 ++
 include/linux/serial_8250.h    |    2 +
 include/linux/serial_core.h    |    1 +
 4 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 5c27f7e..83b5585 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -38,6 +38,8 @@
 #include <linux/nmi.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/cpufreq.h>
+#include <linux/clk.h>
 #ifdef CONFIG_SPARC
 #include <linux/sunserialcore.h>
 #endif
@@ -3005,6 +3007,70 @@ void serial8250_resume_port(int line)
 	uart_resume_port(&serial8250_reg, port);
 }
 
+#ifdef CONFIG_CPU_FREQ
+static int serial8250_cpufreq_transition(struct notifier_block *nb,
+					     unsigned long val, void *data)
+{
+	struct uart_8250_port *p;
+	struct uart_port *uport;
+
+	p = container_of(nb, struct uart_8250_port, freq_transition);
+	uport = &p->port;
+
+	if (IS_ERR(p->clk))
+		goto cpu_freq_exit;
+
+	if (p->port.uartclk == clk_get_rate(p->clk))
+		goto cpu_freq_exit;
+
+	p->port.uartclk = clk_get_rate(p->clk);
+	if (val == CPUFREQ_POSTCHANGE) {
+		struct ktermios *termios;
+		struct tty_struct *tty;
+		if (uport->state == NULL)
+			goto cpu_freq_exit;
+
+		tty = tty_port_tty_get(&uport->state->port);
+		if (tty == NULL)
+			goto cpu_freq_exit;
+
+		termios = tty->termios;
+		if (termios == NULL) {
+			printk(KERN_WARNING "%s: no termios?\n", __func__);
+			goto cpu_freq_exit;
+		}
+
+		serial8250_set_termios(uport, termios, NULL);
+	}
+
+cpu_freq_exit:
+	return 0;
+}
+
+static inline int serial8250_cpufreq_register(struct uart_8250_port *p)
+{
+	p->freq_transition.notifier_call = serial8250_cpufreq_transition;
+
+	return cpufreq_register_notifier(&p->freq_transition,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void serial8250_cpufreq_unregister(struct uart_8250_port *p)
+{
+	cpufreq_unregister_notifier(&p->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+#else
+static inline int serial8250_cpufreq_register(struct uart_8250_port *p)
+{
+	return 0;
+}
+
+static inline void serial8250_cpufreq_unregister(struct uart_8250_port *p)
+{
+}
+#endif
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -3041,6 +3107,10 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.pm			= p->pm;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
+		port.enable_cpufreq	= p->enable_cpufreq;
+		if (p->clk)
+			serial8250_ports[i].clk = p->clk;
+
 		ret = serial8250_register_port(&port);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
@@ -3217,6 +3287,13 @@ int serial8250_register_port(struct uart_port *port)
 		ret = uart_add_one_port(&serial8250_reg, &uart->port);
 		if (ret == 0)
 			ret = uart->port.line;
+
+		if (port->enable_cpufreq) {
+			ret = serial8250_cpufreq_register(uart);
+			if (ret < 0)
+				printk(KERN_ERR
+					"Failed to add cpufreq notifier\n");
+		}
 	}
 	mutex_unlock(&serial_mutex);
 
@@ -3236,6 +3313,8 @@ void serial8250_unregister_port(int line)
 	struct uart_8250_port *uart = &serial8250_ports[line];
 
 	mutex_lock(&serial_mutex);
+	if (uart->port.enable_cpufreq)
+		serial8250_cpufreq_unregister(uart);
 	uart_remove_one_port(&serial8250_reg, &uart->port);
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 2868a1d..77d5876 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -37,6 +37,10 @@ struct uart_8250_port {
 	unsigned char		lsr_saved_flags;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
+	struct clk		*clk;
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+#endif
 };
 
 struct old_serial_port {
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 8f012f8..fa30b81 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -23,6 +23,8 @@ struct plat_serial8250_port {
 	resource_size_t	mapbase;	/* resource base */
 	unsigned int	irq;		/* interrupt number */
 	unsigned long	irqflags;	/* request_irq flags */
+	struct clk	*clk;
+	bool            enable_cpufreq; /* CPU freq status */
 	unsigned int	uartclk;	/* UART clock rate */
 	void            *private_data;
 	unsigned char	regshift;	/* register shift */
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2db407a..5db67a6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -380,6 +380,7 @@ struct uart_port {
 	unsigned char		suspended;
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
+	bool			enable_cpufreq;		/* CPU freq status */
 	void			*private_data;		/* generic platform data pointer */
 };
 
-- 
1.7.1
