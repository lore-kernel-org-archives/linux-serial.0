Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCC3B19B7
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831801; cv=none; b=g7dSgysck1ZpxRZ+lEj2J+XsuIdbLN706p4Qh/4Ak4p6soUhyjrc01Or3Lm2+y3FdhGcALJ1cw/NyPi969D/hiJaZZ5FZWps1shsXuWP2r5mkrsZdyZiDnXKBhBKT8gN4jAYaH8/8F5rT1OTnp9QR6+Z2xiabTldpOsN3lxMwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831801; c=relaxed/simple;
	bh=chAXJHEBhcJafQZd16p4J8gGLF7BNtaPEE/cumRbVrs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P7KjmfWu4PYCplaUTWTvI4+5/1hu11ccrH5U+jNsWfp83XN7Ra50hxQTCr+v0dyp3zx4H9cbZkgl+lnSPBu3oDMMQxQcrpUEa1ScQQoxYxLLWvMY5CcAR06LQnar7zQS+Dp6IwaQIUCH5U7OCuIKpanBn1Bf7i68KZHilksK2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnCpMYYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnCpMYYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB51F0089B;
	Mon, 12 Oct 2026 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831799;
	bh=dHdpaKQQ7aVuN1uJOXyZPsi3BYUdRRq2TgvMtPWCVDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnCpMYYn94nWr0VfkAGWMDOjpMn6U8UiDzT3wpQ5minhasYlhiZl3extgDzNnU1IK
	 XDOxjcSksxPdpnCmgNFVQQQ9NLknZmXVPDmrVrZsDo9V1uu6vY810NXdKVhXxwyPEG
	 ubNStdWKB0i0280CKjnOsOSGyBxXZd1nu0m6SZxmrUAoG4N0jGlF+q1iYPxWrhddS2
	 lpYnydNxTCyyYi4EfIiQu/jnQXaom4PMykZN6kKyO+5hPkbC9k3hhJFOkika3rMfAL
	 XWiSVwGqYC9xjbjEXuXT9CjwcCJgNt6L3vNIwPrw+xEqofY3vmS4jHKsoT4LPpM1z+
	 6L2PDqctix13g==
Message-ID: <sashiko-outbox-168563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] sparc64: add SPARC64 VII CPU, MMU and SMP
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012184826.986050-7-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
 <20261012184826.986050-7-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 19:03:18 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] sparc64: missing membar #Sync in VII __flush_tlb_mm and xcall_=
flush_tlb_mm
- [High] sparc64: off-by-one error in VII TLB slot verification loop causes=
 false panic
--

commit 83e75cdd0104cea9f29069ae3640894a08ee2f5f
Author: Magnus Lindholm <linmag7@gmail.com>
Subject: sparc64: add SPARC64 VII CPU, MMU and SMP support

This commit adds support for SPARC64 VII CPU, MMU, and SMP hardware paths.
It handles topology, interrupt dispatch, restrained ECC handling, and
synchronizes context writes and instruction demaps for supported firmware
modes.

Link: https://lore.kernel.org/oe-kbuild-all/202610121549.5ejZQ08o-lkp@intel=
.com/

> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
[ ... ]
> @@ -675,6 +675,50 @@ static unsigned long kern_large_tte(unsigned long pa=
ddr);
> =20
> +/*
> + * Reserve two 4MB kernel mappings and an adjacent slot in the lower half
> + * of the fully associative bank. Check existing reservations, firmware
> + * status and physical slot readback before using the mappings.
> + */
> +static void __init vii_check_slots(void)
> +{
> +	int i;
> +
> +	if (num_kernel_image_mappings > 2) {
> +		prom_printf("VII-BOOT: kernel exceeds initial 8MB mapping budget\n");
> +		prom_halt();
> +	}
> +	for (i =3D 15 - num_kernel_image_mappings; i <=3D 15; i++) {
> +		unsigned long d =3D cheetah_get_ldtlb_data(i);

[Severity: High]
Does this loop bounds check evaluate an extra unallocated slot?

Since remap_kernel() exclusively populates slots tlb_ent - i, the kernel
only uses slots 14 and 15 when num_kernel_image_mappings is 2. However,
evaluating 15 - num_kernel_image_mappings results in iterating through
slots 13, 14, and 15.

If the firmware legitimately uses slot 13 for its own translations, will
this false conflict cause the kernel to incorrectly panic and halt on boot?

> diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
> --- a/arch/sparc/mm/ultra.S
> +++ b/arch/sparc/mm/ultra.S
[ ... ]
> +	.globl		sparc64_vii_patch_cachetlbops
> +sparc64_vii_patch_cachetlbops:
> +	save		%sp, -128, %sp
> +
> +	sethi		%hi(__flush_tlb_mm), %o0
> +	or		%o0, %lo(__flush_tlb_mm), %o0
> +	sethi		%hi(__cheetah_flush_tlb_mm), %o1
> +	or		%o1, %lo(__cheetah_flush_tlb_mm), %o1
> +	call		tlb_patch_one

[Severity: Critical]
Does patching __flush_tlb_mm with __cheetah_flush_tlb_mm violate the VII
hardware synchronization requirements?

The commit message notes that VII requires a membar #Sync to safely
synchronize context writes and instruction demaps, but __cheetah_flush_tlb_=
mm
lacks this barrier after restoring ASI_DMMU.

Could this omission cause the hardware to execute the demap against the
wrong MMU context, leading to silent TLB corruption during process address
space teardowns like exit() or large munmap() operations?

[ ... ]
> +	sethi		%hi(__flush_tlb_kernel_range), %o0
> +	or		%o0, %lo(__flush_tlb_kernel_range), %o0
> +	sethi		%hi(__vii_flush_tlb_kernel_range_patch), %o1
> +	or		%o1, %lo(__vii_flush_tlb_kernel_range_patch), %o1
> +	call		tlb_patch_one
> +	 mov		3, %o2
> +
> +#ifdef CONFIG_SMP
> +	sethi		%hi(xcall_flush_tlb_page), %o0
> +	or		%o0, %lo(xcall_flush_tlb_page), %o0
> +	sethi		%hi(__vii_xcall_flush_tlb_page_patch), %o1
> +	or		%o1, %lo(__vii_xcall_flush_tlb_page_patch), %o1
> +	call		tlb_patch_one
> +	 mov		3, %o2
> +
> +	/* VII uses 32-entry fTLBs: do not use the Spitfire 64-slot sweep. */
> +	sethi		%hi(xcall_flush_tlb_kernel_range), %o0

[Severity: Critical]
Is xcall_flush_tlb_mm unintentionally omitted from being patched here?

Failing to patch xcall_flush_tlb_mm causes SMP cross-CPU MM flushes on VII
to fall back to the generic Spitfire default.

Since the Spitfire default also lacks the necessary membar #Sync
synchronization before its DEMAP instructions, this appears to leave a path
for TLB corruption on SMP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012184826.9860=
50-1-linmag7@gmail.com?part=3D6
