From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: =?UTF-8?q?=5BPATCH=2009/11=5D=20ARM=3A=20Add=20KGDB/KDB=20FIQ=20debugger=20generic=20code?=
Date: Wed, 19 Sep 2012 16:42:00 -0700
Message-ID: <1348098122-11041-9-git-send-email-anton.vorontsov@linaro.org>
References: <20120919234003.GA24143@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39814 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab2ISXtS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Sep 2012 19:49:18 -0400
Received: by pbbrr13 with SMTP id rr13so3678221pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 19 Sep 2012 16:49:17 -0700 (PDT)
In-Reply-To: <20120919234003.GA24143@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

The FIQ debugger may be used to debug situations when the kernel stuck
in uninterruptable sections, e.g. the kernel infinitely loops or
deadlocked in an interrupt or with interrupts disabled.

By default KGDB FIQ is disabled in runtime, but can be enabled with
kgdb_fiq.enable=3D1 kernel command line option.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/Kconfig                 |  18 ++++++
 arch/arm/include/asm/kgdb.h      |   8 +++
 arch/arm/kernel/Makefile         |   1 +
 arch/arm/kernel/kgdb_fiq.c       | 124 +++++++++++++++++++++++++++++++=
++++++++
 arch/arm/kernel/kgdb_fiq_entry.S |  87 +++++++++++++++++++++++++++
 5 files changed, 238 insertions(+)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..fa10a2d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -171,6 +171,24 @@ config GENERIC_ISA_DMA
 config FIQ
 	bool
=20
+config ARCH_MIGHT_HAVE_KGDB_FIQ
+	bool
+
+config KGDB_FIQ
+	bool "KGDB/KDB FIQ debugger"
+	depends on KGDB_KDB && ARCH_MIGHT_HAVE_KGDB_FIQ && !THUMB2_KERNEL
+	select FIQ
+	help
+	  The FIQ debugger may be used to debug situations when the
+	  kernel stuck in uninterruptable sections, e.g. the kernel
+	  infinitely loops or deadlocked in an interrupt or with
+	  interrupts disabled.
+
+	  By default KGDB FIQ is disabled in runtime, but can be
+	  enabled with kgdb_fiq.enable=3D1 kernel command line option.
+
+	  If unsure, say N.
+
 config NEED_RET_TO_USER
 	bool
=20
diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 48066ce..807e547 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -11,6 +11,8 @@
 #define __ARM_KGDB_H__
=20
 #include <linux/ptrace.h>
+#include <linux/linkage.h>
+#include <asm/exception.h>
=20
 /*
  * GDB assumes that we're a user process being debugged, so
@@ -47,6 +49,12 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
=20
+extern char kgdb_fiq_handler;
+extern char kgdb_fiq_handler_end;
+asmlinkage void __exception_irq_entry kgdb_fiq_do_handle(struct pt_reg=
s *regs);
+extern int __init kgdb_register_fiq(unsigned int mach_kgdb_fiq,
+		     void (*mach_kgdb_enable_fiq)(unsigned int irq, bool on),
+		     bool (*mach_is_kgdb_fiq)(unsigned int irq));
 #endif /* !__ASSEMBLY__ */
=20
 /*
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 7ad2d5c..5aa079b 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ATAGS_PROC)	+=3D atags.o
 obj-$(CONFIG_OABI_COMPAT)	+=3D sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+=3D thumbee.o
 obj-$(CONFIG_KGDB)		+=3D kgdb.o
+obj-$(CONFIG_KGDB_FIQ)		+=3D kgdb_fiq_entry.o kgdb_fiq.o
 obj-$(CONFIG_ARM_UNWIND)	+=3D unwind.o
 obj-$(CONFIG_HAVE_TCM)		+=3D tcm.o
 obj-$(CONFIG_OF)		+=3D devtree.o
diff --git a/arch/arm/kernel/kgdb_fiq.c b/arch/arm/kernel/kgdb_fiq.c
new file mode 100644
index 0000000..f3df754
--- /dev/null
+++ b/arch/arm/kernel/kgdb_fiq.c
@@ -0,0 +1,124 @@
+/*
+ * KGDB FIQ
+ *
+ * Copyright 2010 Google, Inc.
+ *		  Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
+ *		  Colin Cross <ccross@android.com>
+ * Copyright 2012 Linaro Ltd.
+ *		  Anton Vorontsov <anton.vorontsov@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished
+ * by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/hardirq.h>
+#include <linux/atomic.h>
+#include <linux/kdb.h>
+#include <linux/kgdb.h>
+#include <asm/fiq.h>
+#include <asm/exception.h>
+
+static int kgdb_fiq_enabled;
+module_param_named(enable, kgdb_fiq_enabled, int, 0600);
+MODULE_PARM_DESC(enable, "set to 1 to enable FIQ KGDB");
+
+static unsigned int kgdb_fiq;
+static bool (*is_kgdb_fiq)(unsigned int irq);
+
+asmlinkage void __exception_irq_entry kgdb_fiq_do_handle(struct pt_reg=
s *regs)
+{
+	if (!is_kgdb_fiq(kgdb_fiq))
+		return;
+	if (!kgdb_nmi_poll_knock())
+		return;
+
+	nmi_enter();
+	kgdb_handle_exception(1, 0, 0, regs);
+	nmi_exit();
+}
+
+static struct fiq_handler kgdb_fiq_desc =3D {
+	.name =3D "kgdb",
+};
+
+static long kgdb_fiq_setup_stack(void *info)
+{
+	struct pt_regs regs;
+
+	regs.ARM_sp =3D __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER) +
+			THREAD_START_SP;
+	WARN_ON(!regs.ARM_sp);
+
+	set_fiq_regs(&regs);
+	return 0;
+}
+
+static void (*kgdb_enable_fiq)(unsigned int irq, bool on);
+
+/**
+ * kgdb_fiq_enable_nmi - Manage NMI-triggered entry to KGDB
+ * @on: Flag to either enable or disable an NMI
+ *
+ * This function manages NMIs that usually cause KGDB to enter. That i=
s, not
+ * all NMIs should be enabled or disabled, but only those that issue
+ * kgdb_handle_exception().
+ *
+ * The call counts disable requests, and thus allows to nest disables.=
 But
+ * trying to enable already enabled NMI is an error.
+ */
+static void kgdb_fiq_enable_nmi(bool on)
+{
+	static atomic_t cnt;
+	int ret;
+
+	ret =3D atomic_add_return(on ? 1 : -1, &cnt);
+	if (ret > 1 && on) {
+		/*
+		 * There should be only one instance that calls this function
+		 * in "enable, disable" order. All other users must call
+		 * disable first, then enable. If not, something is wrong.
+		 */
+		WARN_ON(1);
+		return;
+	}
+
+	kgdb_enable_fiq(kgdb_fiq, ret > 0);
+}
+
+int __init kgdb_register_fiq(unsigned int mach_kgdb_fiq,
+		void (*mach_kgdb_enable_fiq)(unsigned int irq, bool on),
+		bool (*mach_is_kgdb_fiq)(unsigned int irq))
+{
+	int err;
+	int cpu;
+
+	if (!kgdb_fiq_enabled)
+		return -ENODEV;
+	if (kgdb_fiq)
+		return -EBUSY;
+
+	kgdb_fiq =3D mach_kgdb_fiq;
+	kgdb_enable_fiq =3D mach_kgdb_enable_fiq;
+	is_kgdb_fiq =3D mach_is_kgdb_fiq;
+
+	err =3D claim_fiq(&kgdb_fiq_desc);
+	if (err) {
+		pr_warn("%s: unable to claim fiq", __func__);
+		return err;
+	}
+
+	for_each_possible_cpu(cpu)
+		work_on_cpu(cpu, kgdb_fiq_setup_stack, NULL);
+
+	set_fiq_handler(&kgdb_fiq_handler,
+			&kgdb_fiq_handler_end - &kgdb_fiq_handler);
+
+	arch_kgdb_ops.enable_nmi =3D kgdb_fiq_enable_nmi;
+	return 0;
+}
diff --git a/arch/arm/kernel/kgdb_fiq_entry.S b/arch/arm/kernel/kgdb_fi=
q_entry.S
new file mode 100644
index 0000000..d6becca
--- /dev/null
+++ b/arch/arm/kernel/kgdb_fiq_entry.S
@@ -0,0 +1,87 @@
+/*
+ * KGDB FIQ entry
+ *
+ * Copyright 1996,1997,1998 Russell King.
+ * Copyright 2012 Linaro Ltd.
+ *		  Anton Vorontsov <anton.vorontsov@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished
+ * by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/memory.h>
+#include <asm/unwind.h>
+#include "entry-header.S"
+
+	.text
+
+@ This is needed for usr_entry/alignment_trap
+.LCcralign:
+	.long	cr_alignment
+.LCdohandle:
+	.long	kgdb_fiq_do_handle
+
+	.macro	fiq_handler
+	ldr	r1, =3D.LCdohandle
+	mov	r0, sp
+	adr	lr, BSYM(9997f)
+	ldr	pc, [r1]
+9997:
+	.endm
+
+	.align	5
+__fiq_svc:
+	svc_entry
+	fiq_handler
+	mov	r0, sp
+	ldmib	r0, {r1 - r14}
+	msr	cpsr_c, #FIQ_MODE | PSR_I_BIT | PSR_F_BIT
+	add	r8, r0, #S_PC
+	ldr	r9, [r0, #S_PSR]
+	msr	spsr_cxsf, r9
+	ldr	r0, [r0, #S_R0]
+	ldmia	r8, {pc}^
+
+ UNWIND(.fnend		)
+ENDPROC(__fiq_svc)
+	.ltorg
+
+	.align	5
+__fiq_usr:
+	usr_entry
+	kuser_cmpxchg_check
+	fiq_handler
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user_from_irq
+ UNWIND(.fnend		)
+ENDPROC(__fiq_usr)
+	.ltorg
+
+	.global kgdb_fiq_handler
+kgdb_fiq_handler:
+
+	vector_stub	fiq, FIQ_MODE, 4
+
+	.long	__fiq_usr			@  0  (USR_26 / USR_32)
+	.long	__fiq_svc			@  1  (FIQ_26 / FIQ_32)
+	.long	__fiq_svc			@  2  (IRQ_26 / IRQ_32)
+	.long	__fiq_svc			@  3  (SVC_26 / SVC_32)
+	.long	__fiq_svc			@  4
+	.long	__fiq_svc			@  5
+	.long	__fiq_svc			@  6
+	.long	__fiq_svc			@  7
+	.long	__fiq_svc			@  8
+	.long	__fiq_svc			@  9
+	.long	__fiq_svc			@  a
+	.long	__fiq_svc			@  b
+	.long	__fiq_svc			@  c
+	.long	__fiq_svc			@  d
+	.long	__fiq_svc			@  e
+	.long	__fiq_svc			@  f
+
+	.global kgdb_fiq_handler_end
+kgdb_fiq_handler_end:
--=20
1.7.11.5

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
