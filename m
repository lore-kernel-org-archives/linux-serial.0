Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794E4C2251
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333381; cv=none; b=PckIXXRu4uojZA+ou3GT0Fz3HhSIkaj72A3UjtHjlaAJrf4P2lhBiKFa4mYYb53KDHnQYv/sAvemWvITJKK6RXGKB+D1GOn9KP1CSR49QV3QfFZUANCGlrO4CAUI0rEQoPQ8XuSw2sXPxFiQRt1mkuKqUG2In+/INpoxyu0jcPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333381; c=relaxed/simple;
	bh=1gtD0f5ppFSezrlOM1YRLUUx4wmXnrGcP6lFzv+w9a0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r4EoOBxyDqE1GycJm1PktL3dm5bXKihM4pTzyojlU2cHeitK33zt704fl4oFAYq92cAHQ/vbjKfFvD8/nZ3fhtbOXQ94MTv53wiKX5z1OWTeU48G8CvNEKoykIGxY1qAR4wm1koNAuscYjW6dZvkttTXvS677ijf1MhEN8wrLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMtkiEV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMtkiEV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53D01F000C4;
	Sun, 18 Oct 2026 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792333380;
	bh=RABRaBd/occHcczl+5rtc5fmQ5+CNb01ogAc9TicWiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMtkiEV6yWIc2q53i3wtuFxol2d5ZiXagjUT6UCi5BpVlOfx1NtySJVnJeJ0KnBkL
	 nOjUaTa9HgucJ2gOcgtQDR/lHM2sIsOhkJJUyT+SXeOqDwTe+iudoUOHqazuUy1r1F
	 TcsvJhxylK3q9E4yDQMb+zSegMBbOIE7e59HEhyo/ho5osLXu+FfUj69G0HELVvnJ9
	 S95bP/lUR7mCIJmKBE4ieQ8lomGQlt04Il26sSBXMN0gmcfmJaLG85PodWtuJrmIes
	 8Or37tFevEI9QSSR4UF5os69Mue8G25785OiysQ8Q7dPamk5ElemlBPLwFTM6VUzgl
	 MdZle0aEqR3jA==
Message-ID: <sashiko-outbox-176193@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] sparc64: add SPARC64 VII CPU, MMU and SMP
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-9-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-9-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:22:59 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sparc64: broken TL0/TL1 trap handling for sparc64_vii_ecc_error()
- [Medium] sparc64: missing sparc64_vii_check_mmu_state() call in setup_tra=
p_table()
- [Medium] sparc64: inverted core_id and proc_id hierarchy in vii_cpu_topol=
ogy()
--

commit 0bb62b166c246b99a1e65e42c594b6bc9e54632a
Author: Magnus Lindholm <linmag7@gmail.com>

sparc64: add SPARC64 VII CPU, MMU and SMP support

This commit adds runtime support for Fujitsu SPARC64 VII (implementation 7)
processors, including CPU identification, topology discovery, physical TSB
accesses, MMU demap and context synchronization, 47-bit physical address PTE
handling, SMP IPI delivery, and restrainable ECC trap handling.

> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
> index cf0549134234e..365ca8198ea0d 100644
> --- a/arch/sparc/kernel/head_64.S
> +++ b/arch/sparc/kernel/head_64.S
[ ... ]
> @@ -841,6 +860,7 @@ setup_trap_table:
>  	sllx	%o2, 32, %o2
>  	wr	%o2, 0, %tick_cmpr
> =20
> +	BRANCH_IF_SPARC64_VII(o2, o3, 1f)
>  	BRANCH_IF_ANY_CHEETAH(o2, o3, 1f)
> =20
>  	ba,a,pt	%xcc, 2f

[Severity: Medium]
The commit message states that disabled shared-context and TSB-prefetch val=
id
bits are required at CPU entry and firmware handoffs, and after_lock_tlb in
arch/sparc/kernel/trampoline_64.S runs VII_CHECK_MMU_STATE right after its
direct p1275buf CIF call to SUNW,set-trap-table.

However, in setup_trap_table() in arch/sparc/kernel/head_64.S (reached via
paging_init() -> setup_tba()), the boot CPU makes the same direct p1275buf
CIF call to SUNW,set-trap-table (bypassing p1275_cmd_direct() and
prom_world()):

arch/sparc/kernel/head_64.S:setup_trap_table:
	sethi	%hi(p1275buf), %g2
	or	%g2, %lo(p1275buf), %g2
	ldx	[%g2 + 0x08], %o1
	call	%o1
	 add	%sp, (2047 + 128), %o0

	/* Start using proper page size encodings in ctx register.  */
2:	sethi	%hi(sparc64_kern_pri_context), %g3

Should setup_trap_table() also call sparc64_vii_check_mmu_state() upon retu=
rn
from this firmware call before programming PRIMARY_CONTEXT and re-enabling
interrupts?

> diff --git a/arch/sparc/kernel/helpers.S b/arch/sparc/kernel/helpers.S
> index 9b3f74706cfbc..b4ea0ca95a37e 100644
> --- a/arch/sparc/kernel/helpers.S
> +++ b/arch/sparc/kernel/helpers.S
> @@ -64,3 +64,129 @@ real_hard_smp_processor_id:
>  #endif
>  	.size		real_hard_smp_processor_id,.-real_hard_smp_processor_id
>  EXPORT_SYMBOL_GPL(real_hard_smp_processor_id)
> +
> +	.align 32
> +	.globl sparc64_vii_ecc_trap
> +sparc64_vii_ecc_trap:
> +	TRAP(sparc64_vii_ecc_error)
> +	.globl sparc64_vii_ecc_trap_tl1
> +sparc64_vii_ecc_trap_tl1:
> +	TRAPTL1(sparc64_vii_ecc_error)

[Severity: High]
In vii_patch_error_traps(), trap 0x63 is routed to sparc64_vii_ecc_trap at
TL=3D0 (using TRAP / etrap) and sparc64_vii_ecc_trap_tl1 at TL>0 (using
TRAPTL1 / etraptl1), and sparc64_vii_ecc_error() returns normally when AFSR
is zero or indicates cache/TLB degradation.

Can a recoverable trap 0x63 at TL>0 safely use TRAPTL1(sparc64_vii_ecc_erro=
r)
and return through rtrap? Looking at etraptl1 in arch/sparc/kernel/etrap_64=
.S,
it is structured for fatal traps that never return:

arch/sparc/kernel/etrap_64.S:etraptl1:
		TRAP_LOAD_THREAD_REG(%g6, %g1)
		sub	%sp, ((4 * 8) * 4) + 8, %g2
		rdpr	%tl, %g1
		...
finish_tl1_capture:
		wrpr	%g0, 1, %tl
		...
		rdpr	%tstate, %g1
		sub	%g2, STACKFRAME_SZ + TRACEREG_SZ - STACK_BIAS, %g2
		ba,pt	%xcc, 1b
		 andcc	%g1, TSTATE_PRIV, %g0

First, etraptl1 computes %g2 directly from %sp, writes the traplog to
[%g2 + STACK_BIAS + ...], and branches to label 1b, bypassing the user-to-
kernel stack switch in etrap. If trap 0x63 occurs at TL=3D1 while %sp is st=
ill
a userspace stack pointer (for example, during a user TLB miss in tl0_iamiss
or tl0_damiss, a window spill/fill trap, or in etrap/rtrap before switching
stacks), won't etraptl1 write the traplog and pt_regs onto the user stack a=
nd
execute sparc64_vii_ecc_error() on the user stack?

Second, finish_tl1_capture forces %tl to 1, captures TL=3D1's %tstate, %tpc,
and %tnpc into pt_regs instead of TL=3D2's trap state, overwrites TL=3D1's =
trap
registers, and drops to TL=3D0 via done. When sparc64_vii_ecc_error() retur=
ns
to rtrap, won't rtrap restore TL=3D1's %tstate/%tpc/%tnpc and retry to TL=
=3D0
instead of resuming the interrupted TL=3D1 handler at TL=3D2's %tpc (aborti=
ng the
TL=3D1 handler mid-execution, or jumping to stale %tpc[1]/%tstate[1] values=
 if
the trap occurred while __vii_flush_tlb_page or __vii_flush_tlb_pending had
manually set %tl to 1)?

[ ... ]

> diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
> index aa4799cbb9c1d..c4448ec6e9190 100644
> --- a/arch/sparc/kernel/prom_64.c
> +++ b/arch/sparc/kernel/prom_64.c
> @@ -501,7 +501,30 @@ void __init of_populate_present_mask(void)
>  	of_iterate_over_cpus(record_one_cpu, 0);
>  }
> =20
> -static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
> +static void __init vii_cpu_topology(struct device_node *dp, int cpuid)
> +{
> +	struct device_node *core =3D dp->parent;
> +	struct device_node *package;
> +
> +	cpu_data(cpuid).core_id =3D 0;
> +	cpu_data(cpuid).proc_id =3D -1;
> +	cpu_data(cpuid).sock_id =3D cpuid;
> +	if (!core || !of_node_is_type(core, "core") ||
> +	    !of_device_is_compatible(core, "FJSV,SPARC64-VII"))
> +		return;
> +	package =3D core->parent;
> +	if (!package || !of_node_name_eq(package, "cmp"))
> +		return;
> +	if (core->unique_id >=3D USHRT_MAX || package->unique_id > SHRT_MAX)
> +		return;
> +
> +	/* Node IDs distinguish equal core addresses in different packages. */
> +	cpu_data(cpuid).core_id =3D core->unique_id + 1;
> +	cpu_data(cpuid).proc_id =3D package->unique_id;
> +	cpu_data(cpuid).sock_id =3D package->unique_id;
> +}

[Severity: Medium]
Does assigning the per-core ID to core_id and the per-package ID to proc_id
break the cpuinfo_tree hierarchy built by _cpu_map_rebuild() in
arch/sparc/kernel/cpumap.c?

When sun4u_irq_enable() or sun4u_set_affinity() calls irq_choose_cpu() ->
map_to_cpu() -> _cpu_map_rebuild(), enumerate_cpuinfo_nodes() and
build_cpuinfo_tree() construct a 4-level tree ordered as ROOT -> NODE ->
CORE (core_id) -> PROC (proc_id):

arch/sparc/kernel/cpumap.c:build_cpuinfo_tree() {
    ...
			if ((id !=3D prev_id[level]) || (cpu =3D=3D last_cpu)) {
				prev_id[level] =3D id;
				node =3D &new_tree->nodes[level_rover[level]];
				...
				if (level =3D=3D CPUINFO_LVL_PROC) {
					node->child_end =3D
					    (cpu =3D=3D last_cpu) ? cpu : prev_cpu;
				} else {
					node->child_end =3D
					    level_rover[level + 1] - 1;
				}
    ...
}

Because vii_cpu_topology() sets core_id per core and proc_id per cmp packag=
e,
all cores within a package share the same proc_id. When build_cpuinfo_tree()
advances from one core to the next within the same package, core_id changes
while proc_id does not, so level_rover[CPUINFO_LVL_PROC] has not advanced.

As a result, the previous CORE node gets child_end < child_start, and the n=
ew
CORE node points its child_start and rover to the same package-wide PROC
node. When iterate_cpu() walks this tree to populate cpu_distribution_map[],
single-package systems distribute IRQs sequentially to sibling threads on t=
he
same core before moving to the next core, while multi-package systems repeat
the first package's CPUs once per core in that package and omit CPUs on oth=
er
packages.

[ ... ]

> diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
> index 28cb0d66ab40c..3c693b7bd32b6 100644
> --- a/arch/sparc/kernel/traps_64.c
> +++ b/arch/sparc/kernel/traps_64.c
> @@ -2716,6 +2716,33 @@ void do_privact(struct pt_regs *regs)
>  	do_privop(regs);
>  }
> =20
> +/* SPARC64 VII Extensions, Appendix P.7.1 and P.7.4. */
> +#define VII_AFSR_DEGRADATION	((1UL << 12) | (1UL << 11) | (1UL << 10))
> +
> +void sparc64_vii_ecc_error(struct pt_regs *regs)
> +{
> +	enum ctx_state prev_state =3D exception_enter();
> +	unsigned long afsr;
> +
> +	__asm__ __volatile__("ldxa [%%g0] 0x4c, %0" : "=3Dr" (afsr));
> +	/* An ECC trap without a sticky error indication is explicitly allowed.=
 */
> +	if (!afsr)
> +		goto out;
> +
> +	/* No data recovery is implemented for raw UE or store bus errors. */
> +	if (afsr & ~VII_AFSR_DEGRADATION)
> +		panic("SPARC64 VII: unhandled ECC error, CPU %u AFSR=3D%lx TPC=3D%lx",
> +		      smp_processor_id(), afsr, regs->tpc);
> +
> +	/* Hardware has already reduced the affected cache/TLB associativity. */
> +	__asm__ __volatile__("stxa %0, [%%g0] 0x4c; membar #Sync"
> +			     : : "r" (afsr) : "memory");
> +	pr_warn_ratelimited("SPARC64 VII: CPU %u cache/TLB degradation, AFSR=3D=
%lx\n",
> +			    smp_processor_id(), afsr);
> +out:
> +	exception_exit(prev_state);
> +}

[Severity: High]
Because sparc64_vii_ecc_trap uses TRAP(sparc64_vii_ecc_error) rather than
TRAP_IRQ (or latching and clearing AFSR at TL=3D1 before re-enabling PSTATE=
_IE,
as c_cee in arch/sparc/kernel/cherrs.S and __spitfire_access_error in
arch/sparc/kernel/spiterrs.S do), etrap drops to TL=3D0 with TSTATE_IE set =
and
%pil unchanged (which is 0 when trapping from user mode or normal kernel
context).

Doesn't this run sparc64_vii_ecc_error() with hardware interrupts and
preemption enabled before the per-CPU AFSR register (ASI 0x4c) is read and
cleared, which can trigger a preemptible smp_processor_id() warning under
CONFIG_DEBUG_PREEMPT, allow the task to migrate to another CPU between the
ldxa and stxa on ASI 0x4c, or re-trigger trap 0x63 while sticky AFSR bits
remain set?

> +
>  /* Trap level 1 stuff or other traps we should never see... */
>  void do_cee(struct pt_regs *regs)
>  {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D8
