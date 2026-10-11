Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458293290AA
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749372; cv=none; b=sMH9nEI7gU4zn566d9mf7syitO1DoAqSDpXj1ITRuwbAk9MViZSCRIRfHD8S87dn4EgsclOUIrpgN/xx5cOYFWkvFG3McZui5YuL2YAZ2Rs3z99W7dC4s+dQiELpUdjpspunpWHtw4zGJGOU20rEJ6k1GEuplUCJBp6Cj3gwyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749372; c=relaxed/simple;
	bh=rnYiWJ9VOvd3WsIYxa9/IJFGSXvywIacoL8nb0wHHkk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K8MLe0ActXRfWAQr9yT6ULNPUgJsIs+ax4zctCgC27rpgGAFFyBY7qpgdgN0kTF8JPdhvGpBTqLCmDXfa7sPhYnHTE7cPb79rm5cFbeFERx9snXbuua51rIV0WrsThm0Ij+VkaLPZd2wot+S3ug29yBbWAAoNvJCf5aC9gazo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkbNuo2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkbNuo2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA6B1F0089B;
	Sun, 11 Oct 2026 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749370;
	bh=EW3RQoCh802IvbpnApM9VBzlOpsk/OT9np+zs2hZ1uU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkbNuo2mgouSJzRgFSLJYgQrEb2bVzZtb4DrFdXuijf6Ra54SPxhAzfmJmL/0NKIe
	 EO1tBtFEZp5fJueJYYJvapEXhVBxSMXfZi2EUTsbzW5OpZeeArYCj97upYFgagS9we
	 1Q4iK0fq+HTF4oUACfSSr8EVCrrKAvXRXlAThkAlrTq9lwMfz/R6xll6EwrAQpVcSz
	 8lY7/WdVI9lgp3hEYuVp4VDQwpMhcuKRGGBi9nigs3lJ94OomCdsyv8W3eA/Bb0m04
	 CHilLqqjMg3YvQPDl3V0Wr7iJqdbGxi2W2On7XgdM0BZ13h+0XvRrmXFAau2hxg3eD
	 dZKNKNxg+Xt6Q==
Message-ID: <sashiko-outbox-167445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] sparc64: add SPARC64 VII CPU, MMU and SMP
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011195729.981243-5-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-5-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:09:30 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sparc64: missing VII membar synchronization for __flush_tlb_mm and=
 xcall
--

commit 3658cc67da72bc2e25beda7e9124cb710a511258
Author: Magnus Lindholm <linmag7@gmail.com>
sparc64: add SPARC64 VII CPU, MMU and SMP support

This commit adds support for SPARC64 VII and VII+ processors in the Fujitsu
M3000. It introduces separate CPU, MMU, and SMP paths, managing CPU topology
and restrainable ECC errors. It also provides separate demap routines to sa=
tisfy
hardware synchronization requirements that are missing in the Cheetah paths.

> diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
> index 70e658d107e02..c4a9647d6eb04 100644
> --- a/arch/sparc/mm/ultra.S
> +++ b/arch/sparc/mm/ultra.S
[ ... ]
> @@ -981,6 +981,242 @@ xcall_kgdb_capture:
> =20
>  #endif /* CONFIG_SMP */
> =20
[ ... ]
> +	.globl		sparc64_vii_patch_cachetlbops
> +sparc64_vii_patch_cachetlbops:
> +	save		%sp, -128, %sp
> +
> +	sethi		%hi(__flush_tlb_mm), %o0
> +	or		%o0, %lo(__flush_tlb_mm), %o0
> +	sethi		%hi(__cheetah_flush_tlb_mm), %o1
> +	or		%o1, %lo(__cheetah_flush_tlb_mm), %o1

[Severity: High]
Does this incorrectly reuse the Cheetah variant for VII hardware?

The commit message explicitly notes that SPARC64 VII requires hardware
synchronization (membar #Sync) for context writes and instruction demaps,
and that the existing Cheetah assembly does not establish this. However,
sparc64_vii_patch_cachetlbops patches __flush_tlb_mm using
__cheetah_flush_tlb_mm, which lacks the required membar #Sync after writing
to ASI_DMMU.

> +	call		tlb_patch_one
> +	 mov		19, %o2
> +
> +	sethi		%hi(__flush_tlb_page), %o0
[ ... ]
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
> +	or		%o0, %lo(xcall_flush_tlb_kernel_range), %o0
> +	sethi		%hi(__cheetah_xcall_flush_tlb_kernel_range), %o1
> +	or		%o1, %lo(__cheetah_xcall_flush_tlb_kernel_range), %o1
> +	call		tlb_patch_one
> +	 mov		44, %o2
> +#endif

[Severity: High]
Is xcall_flush_tlb_mm missing from this patch block?

By omitting xcall_flush_tlb_mm entirely, it seems remote CPUs will fall back
to the unpatched Spitfire handler. This would violate the JPS2 F.10.1
synchronization requirements and potentially leave the VII hardware exposed=
 to
stale TLB or pipeline states.

> +
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	sethi		%hi(__flush_dcache_page), %o0
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011195729.9812=
43-1-linmag7@gmail.com?part=3D4
