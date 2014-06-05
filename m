From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v3 6/9] ARM: Move some macros from entry-armv to entry-header
Date: Thu,  5 Jun 2014 10:53:11 +0100
Message-ID: <1401961994-18033-7-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfou>
List-Id: linux-serial@vger.kernel.org

From: Anton Vorontsov <anton.vorontsov@linaro.org>

Just move the macros into header file as we would want to use them for
KGDB FIQ entry code.

The following macros were moved:

 - svc_entry
 - usr_entry
 - kuser_cmpxchg_check
 - vector_stub

To make kuser_cmpxchg_check actually work across different files, we
also have to make kuser_cmpxchg64_fixup global.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
---
 arch/arm/kernel/entry-armv.S   | 151 +------------------------------------
 arch/arm/kernel/entry-header.S | 164 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 150 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1879e8d..ed95b95 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -140,53 +140,6 @@ ENDPROC(__und_invalid)
  * SVC mode handlers
  */
 
-#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
-#define SPFIX(code...) code
-#else
-#define SPFIX(code...)
-#endif
-
-	.macro	svc_entry, stack_hole=0
- UNWIND(.fnstart		)
- UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
-#ifdef CONFIG_THUMB2_KERNEL
- SPFIX(	str	r0, [sp]	)	@ temporarily saved
- SPFIX(	mov	r0, sp		)
- SPFIX(	tst	r0, #4		)	@ test original stack alignment
- SPFIX(	ldr	r0, [sp]	)	@ restored
-#else
- SPFIX(	tst	sp, #4		)
-#endif
- SPFIX(	subeq	sp, sp, #4	)
-	stmia	sp, {r1 - r12}
-
-	ldmia	r0, {r3 - r5}
-	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
-	mov	r6, #-1			@  ""  ""      ""       ""
-	add	r2, sp, #(S_FRAME_SIZE + \stack_hole - 4)
- SPFIX(	addeq	r2, r2, #4	)
-	str	r3, [sp, #-4]!		@ save the "real" r0 copied
-					@ from the exception stack
-
-	mov	r3, lr
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r2 - sp_svc
-	@  r3 - lr_svc
-	@  r4 - lr_<exception>, already fixed up for correct return/restart
-	@  r5 - spsr_<exception>
-	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	stmia	r7, {r2 - r6}
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
-	.endm
-
 	.align	5
 __dabt_svc:
 	svc_entry
@@ -306,73 +259,8 @@ ENDPROC(__pabt_svc)
 
 /*
  * User mode handlers
- *
- * EABI note: sp_svc is always 64-bit aligned here, so should S_FRAME_SIZE
  */
 
-#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5) && (S_FRAME_SIZE & 7)
-#error "sizeof(struct pt_regs) must be a multiple of 8"
-#endif
-
-	.macro	usr_entry
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)	@ don't unwind the user space
-	sub	sp, sp, #S_FRAME_SIZE
- ARM(	stmib	sp, {r1 - r12}	)
- THUMB(	stmia	sp, {r0 - r12}	)
-
-	ldmia	r0, {r3 - r5}
-	add	r0, sp, #S_PC		@ here for interlock avoidance
-	mov	r6, #-1			@  ""  ""     ""        ""
-
-	str	r3, [sp]		@ save the "real" r0 copied
-					@ from the exception stack
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r4 - lr_<exception>, already fixed up for correct return/restart
-	@  r5 - spsr_<exception>
-	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	@ Also, separately save sp_usr and lr_usr
-	@
-	stmia	r0, {r4 - r6}
- ARM(	stmdb	r0, {sp, lr}^			)
- THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
-
-	@
-	@ Enable the alignment trap while in kernel mode
-	@
-	alignment_trap r0
-
-	@
-	@ Clear FP to mark the first stack frame
-	@
-	zero_fp
-
-#ifdef CONFIG_IRQSOFF_TRACER
-	bl	trace_hardirqs_off
-#endif
-	ct_user_exit save = 0
-	.endm
-
-	.macro	kuser_cmpxchg_check
-#if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS) && \
-    !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
-#ifndef CONFIG_MMU
-#warning "NPTL on non MMU needs fixing"
-#else
-	@ Make sure our user space atomic helper is restarted
-	@ if it was interrupted in a critical region.  Here we
-	@ perform a quick test inline since it should be false
-	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r4, #TASK_SIZE
-	blhs	kuser_cmpxchg64_fixup
-#endif
-#endif
-	.endm
-
 	.align	5
 __dabt_usr:
 	usr_entry
@@ -819,6 +707,7 @@ __kuser_cmpxchg64:				@ 0xffff0f60
 	ldmfd	sp!, {r4, r5, r6, pc}
 
 	.text
+	.global kuser_cmpxchg64_fixup
 kuser_cmpxchg64_fixup:
 	@ Called from kuser_cmpxchg_fixup.
 	@ r4 = address of interrupted insn (must be preserved).
@@ -960,44 +849,6 @@ __kuser_helper_end:
  * SP points to a minimal amount of processor-private memory, the address
  * of which is copied into r0 for the mode specific abort handler.
  */
-	.macro	vector_stub, name, mode, correction=0
-	.align	5
-
-vector_\name:
-	.if \correction
-	sub	lr, lr, #\correction
-	.endif
-
-	@
-	@ Save r0, lr_<exception> (parent PC) and spsr_<exception>
-	@ (parent CPSR)
-	@
-	stmia	sp, {r0, lr}		@ save r0, lr
-	mrs	lr, spsr
-	str	lr, [sp, #8]		@ save spsr
-
-	@
-	@ Prepare for SVC32 mode.  IRQs remain disabled.
-	@
-	mrs	r0, cpsr
-	eor	r0, r0, #(\mode ^ SVC_MODE | PSR_ISETSTATE)
-	msr	spsr_cxsf, r0
-
-	@
-	@ the branch table must immediately follow this code
-	@
-	and	lr, lr, #0x0f
- THUMB(	adr	r0, 1f			)
- THUMB(	ldr	lr, [r0, lr, lsl #2]	)
-	mov	r0, sp
- ARM(	ldr	lr, [pc, lr, lsl #2]	)
-	movs	pc, lr			@ branch to handler in SVC mode
-ENDPROC(vector_\name)
-
-	.align	2
-	@ handler addresses follow this label
-1:
-	.endm
 
 	.section .stubs, "ax", %progbits
 __stubs_start:
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index efb208d..5d794d6 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -356,3 +356,167 @@ scno	.req	r7		@ syscall number
 tbl	.req	r8		@ syscall table pointer
 why	.req	r8		@ Linux syscall (!= 0)
 tsk	.req	r9		@ current thread_info
+
+/*
+ * SVC mode handler macros
+ */
+
+#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
+#define SPFIX(code...) code
+#else
+#define SPFIX(code...)
+#endif
+
+	.macro	svc_entry, stack_hole=0
+ UNWIND(.fnstart		)
+ UNWIND(.save {r0 - pc}		)
+	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+#ifdef CONFIG_THUMB2_KERNEL
+ SPFIX(	str	r0, [sp]	)	@ temporarily saved
+ SPFIX(	mov	r0, sp		)
+ SPFIX(	tst	r0, #4		)	@ test original stack alignment
+ SPFIX(	ldr	r0, [sp]	)	@ restored
+#else
+ SPFIX(	tst	sp, #4		)
+#endif
+ SPFIX(	subeq	sp, sp, #4	)
+	stmia	sp, {r1 - r12}
+
+	ldmia	r0, {r3 - r5}
+	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
+	mov	r6, #-1			@  ""  ""      ""       ""
+	add	r2, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+ SPFIX(	addeq	r2, r2, #4	)
+	str	r3, [sp, #-4]!		@ save the "real" r0 copied
+					@ from the exception stack
+
+	mov	r3, lr
+
+	@
+	@ We are now ready to fill in the remaining blanks on the stack:
+	@
+	@  r2 - sp_svc
+	@  r3 - lr_svc
+	@  r4 - lr_<exception>, already fixed up for correct return/restart
+	@  r5 - spsr_<exception>
+	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
+	@
+	stmia	r7, {r2 - r6}
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
+	.endm
+
+/*
+ * User mode handler macros
+ *
+ * EABI note: sp_svc is always 64-bit aligned here, so should S_FRAME_SIZE
+ */
+
+#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5) && (S_FRAME_SIZE & 7)
+#error "sizeof(struct pt_regs) must be a multiple of 8"
+#endif
+
+	.macro	usr_entry
+ UNWIND(.fnstart	)
+ UNWIND(.cantunwind	)	@ don't unwind the user space
+	sub	sp, sp, #S_FRAME_SIZE
+ ARM(	stmib	sp, {r1 - r12}	)
+ THUMB(	stmia	sp, {r0 - r12}	)
+
+	ldmia	r0, {r3 - r5}
+	add	r0, sp, #S_PC		@ here for interlock avoidance
+	mov	r6, #-1			@  ""  ""     ""        ""
+
+	str	r3, [sp]		@ save the "real" r0 copied
+					@ from the exception stack
+
+	@
+	@ We are now ready to fill in the remaining blanks on the stack:
+	@
+	@  r4 - lr_<exception>, already fixed up for correct return/restart
+	@  r5 - spsr_<exception>
+	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
+	@
+	@ Also, separately save sp_usr and lr_usr
+	@
+	stmia	r0, {r4 - r6}
+ ARM(	stmdb	r0, {sp, lr}^			)
+ THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
+
+	@
+	@ Enable the alignment trap while in kernel mode
+	@
+	alignment_trap r0
+
+	@
+	@ Clear FP to mark the first stack frame
+	@
+	zero_fp
+
+#ifdef CONFIG_IRQSOFF_TRACER
+	bl	trace_hardirqs_off
+#endif
+	ct_user_exit save = 0
+	.endm
+
+	.macro	kuser_cmpxchg_check
+#if !defined(CONFIG_CPU_32v6K) && defined(CONFIG_KUSER_HELPERS) && \
+    !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
+#ifndef CONFIG_MMU
+#warning "NPTL on non MMU needs fixing"
+#else
+	@ Make sure our user space atomic helper is restarted
+	@ if it was interrupted in a critical region.  Here we
+	@ perform a quick test inline since it should be false
+	@ 99.9999% of the time.  The rest is done out of line.
+	cmp	r4, #TASK_SIZE
+	blhs	kuser_cmpxchg64_fixup
+#endif
+#endif
+	.endm
+
+/*
+ * Vector stubs macro.
+ */
+	.macro	vector_stub, name, mode, correction=0
+	.align	5
+
+vector_\name:
+	.if \correction
+	sub	lr, lr, #\correction
+	.endif
+
+	@
+	@ Save r0, lr_<exception> (parent PC) and spsr_<exception>
+	@ (parent CPSR)
+	@
+	stmia	sp, {r0, lr}		@ save r0, lr
+	mrs	lr, spsr
+	str	lr, [sp, #8]		@ save spsr
+
+	@
+	@ Prepare for SVC32 mode.  IRQs remain disabled.
+	@
+	mrs	r0, cpsr
+	eor	r0, r0, #(\mode ^ SVC_MODE | PSR_ISETSTATE)
+	msr	spsr_cxsf, r0
+
+	@
+	@ the branch table must immediately follow this code
+	@
+	and	lr, lr, #0x0f
+ THUMB(	adr	r0, 1f			)
+ THUMB(	ldr	lr, [r0, lr, lsl #2]	)
+	mov	r0, sp
+ ARM(	ldr	lr, [pc, lr, lsl #2]	)
+	movs	pc, lr			@ branch to handler in SVC mode
+ENDPROC(vector_\name)
+
+	.align	2
+	@ handler addresses follow this label
+1:
+	.endm
+
+
-- 
1.9.0
