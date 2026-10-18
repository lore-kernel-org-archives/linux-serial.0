Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729B397935
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332100; cv=none; b=Vow9RiVXk/FkIlnIKnqL6kUbOFD5g+c8aCyhtw0Qj+WluICwO1NJhQb6C/qVnrgMADFjbCt7EJOdgW5HtsBgpJctiBStPcPRq/sRzn/lX2rFXrTdiqhbZF8KMo1WfZ9c/FflccME+910fZ2yMjhKcjPLbiKNISe6sEr3agaMa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332100; c=relaxed/simple;
	bh=SpW9PVHpUqRZMMW8upeHU60eSTAsU893f7duRnxGAjk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ji4e4KiE0+srp6Y16rf5ZKbR3IDbSCIjivhJ1YjeWAl6WSMoT6llIUnigsA98+x+9H2rd3yUgM4ykL2qbm1u31EOztvhldm/De5YuVpYz2SeVDCcTGEvzfO8lUPAXoELXylbTctvFMc9U5cwJKek/Cs/3b64nmIf5zQRKMI+YSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfkomDFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfkomDFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B381F000C4;
	Sun, 18 Oct 2026 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792332099;
	bh=4Jhg45Bdmb2/EI3yzdSI4n97/LMCygvi1sJMddGP4Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZfkomDFYcHfj11pWpXWZa7yQw+Nas2aWlVoVwiUduMrbPiqZRWWX0vK513VooHS8t
	 f5SLi4J6pt/qcgRE7/sll8iSDtjh/NImHBuVcuP4ObGYO8Fg+RiK4DhC0LwXB35tVX
	 p7pKNyz3IuTRBLIgn7GlYEXPgJyS3GYoTfM2Kyx+5Z+CxCZzoopo/5uD4ixfWUdlP2
	 3zRVom1qkrZA7Y5iZPWEmzmJAb7vS3bVGUMYOhRggtqZGJVbt2dqpZZAehgZ20W5Lt
	 lLRuuQkzilhoE5HsKa4YoicEard8KyEEZkLdLylsLWFCvHyjfoj29IMgQuwoHyBgNQ
	 WnfXnuWC8hYgg==
Message-ID: <sashiko-outbox-176175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] sparc64: honor queued spinlock layout in
 secondary startup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-3-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-3-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:01:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] sparc64: invalid [%g2 + %lo(prom_entry_lock) + 3] operand in trampo=
line_64.S
--

commit 3122e42ebc7be814860c71cd7ad49ac4a1876063
Author: Magnus Lindholm <linmag7@gmail.com>

sparc64: honor queued spinlock layout in secondary startup

This commit updates secondary CPU startup in arch/sparc/kernel/trampoline_6=
4.S
to acquire prom_entry_lock as a 32-bit word with CASA and release byte offs=
et 3
with STB to match the big-endian queued spinlock layout.

> diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampo=
line_64.S
> index 51bf1eb92a36e..4473347301229 100644
> --- a/arch/sparc/kernel/trampoline_64.S
> +++ b/arch/sparc/kernel/trampoline_64.S

[ ... ]

> @@ -212,7 +222,13 @@ startup_continue:
>  	 nop
> =20
>  	sethi		%hi(prom_entry_lock), %g2
> -	stb		%g0, [%g2 + %lo(prom_entry_lock)]
> +	/*
> +	 * Retain explicit assembly release ordering; C unlock relies on TSO.
> +	 * The predicted branch protects Spitfire erratum 51.
> +	 */
> +	ba,pt		%xcc, 2f
> +	 membar		#StoreStore | #LoadStore
> +2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
> =20
>  	ba,pt		%xcc, after_lock_tlb
>  	 nop

[ ... ]

> @@ -389,7 +415,13 @@ after_lock_tlb:
>  	 add		%sp, (2047 + 128), %o0
> =20
>  3:	sethi		%hi(prom_entry_lock), %g2
> -	stb		%g0, [%g2 + %lo(prom_entry_lock)]
> +	/*
> +	 * Retain explicit assembly release ordering; C unlock relies on TSO.
> +	 * The predicted branch protects Spitfire erratum 51.
> +	 */
> +	ba,pt		%xcc, 2f
> +	 membar		#StoreStore | #LoadStore
> +2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]

[Severity: Low]
Does this assemble on SPARC64 SMP builds (CONFIG_SPARC64=3Dy && CONFIG_SMP=
=3Dy)?

In both startup_continue and after_lock_tlb in
arch/sparc/kernel/trampoline_64.S, the unlock sequences use:

    stb %g0, [%g2 + %lo(prom_entry_lock) + 3]

In SPARC assembly syntax (both GNU as and LLVM's SparcAsmParser), %lo(...) =
is
parsed as the single immediate operand in [rs1 + simm13] and does not accep=
t a
trailing "+ 3" after the closing parenthesis, which causes the assembler to
reject the instruction with "Error: Illegal operands".

Should the byte offset be placed inside the relocation modifier as
[%g2 + %lo(prom_entry_lock + 3)], or should %g2 first be formed with
"or %g2, %lo(prom_entry_lock), %g2" followed by "stb %g0, [%g2 + 3]"?

> =20
>  	ldx		[%l0], %g6
>  	ldx		[%g6 + TI_TASK], %g4

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D2
