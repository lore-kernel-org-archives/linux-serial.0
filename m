Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FF470EA4
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932397; cv=none; b=gdOlAfAG5/dL2fmozxjjFmWKgzPP1l0JkM7+IF1zySDHLIp9s+LFanGW++zH0TaB2vSghq2uQCKfYnHwlJAvh1zsUF/2/pVMk8Qv2wgHmMnKkxtMLsWWC0ZPhWfXc4RE74zwGZZu8k/V8Oc6GsrIg3ibe4YiG3Cn9zYosoAn0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932397; c=relaxed/simple;
	bh=KBGDI+QN4HePY4DwpDxEATbVr4uZWKPe6JSqkopEvks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nsi0SMUaXut9pKburtBHs1oegMB5fQHCSotudaCpUiiFbFManUI7jKt5nw7yJq13caDBwLDdhVChA/5aEdCQRP8Cv0m68cJB+NpF+TzkNo+HXFdEi0W66un17oNT/03GNVSn2mHHlQxX0K2G17ch4CaYVWEGi8NPvjJh7goNcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg0n5PP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg0n5PP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675631F00898;
	Fri,  2 Oct 2026 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932395;
	bh=HLOeAMG5SbodmFXdhnHyqhGa1pLjbWgrGmI75je1LnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lg0n5PP9JgbETLEi/8KHbdDBHEaWem3l748DdEhh1Qx6luZ0teLojmdGqkc5ET0aT
	 HBEqj0YAx7tQE+JGhb0U8eO/1cJ7utBr6t7FySa1MkFji6RjsMIrHzjLM7sRRqzl4D
	 zTChkIAxXf3V1VzRiRLsOy3/TlPItg+3uJFzebIDJCpL1RjwS0iZGXjPrbtJUVF8q/
	 asplVsYL/O0Kb2SUqyWOWsLL/eWp42fDcpUiZDt8sfWQm4i/3HeTv5JsF9EOoQSsp8
	 MMfXHZkKTL6FrvLwAmkIonz2pH1RmYMfzadOKS2QkraEV+zJ6iBU0IVYfEvFLN6E4z
	 5ilDYS3LmHe6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] MIPS: SGI-IP27: print the NMI dump on an nbcon
 console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001191938.3256-1-kaloz@kernel.org>
References: <20261001191938.3256-1-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:15 +0000
Message-Id: <20261002091315.675631F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] printk: NMI dump output lost due to nbcon timeout if console is in=
 unsafe state
--

commit f9358977a85eff3b02febdb716b027b3e2f5107f
Author: Imre Kaloz <kaloz@kernel.org>

MIPS: SGI-IP27: print the NMI dump on an nbcon console

Since the 8250 console became nbcon, printk() in nmi_dump() only queues
records for a printer thread that never runs, as no CPU leaves the NMI
handler. Print from an emergency section and flush pending records
before the hub reset.

> diff --git a/arch/mips/sgi-ip27/ip27-nmi.c b/arch/mips/sgi-ip27/ip27-nmi.c
> index fc2816398d0cf..c502982621e6b 100644
> --- a/arch/mips/sgi-ip27/ip27-nmi.c
> +++ b/arch/mips/sgi-ip27/ip27-nmi.c
> @@ -183,6 +184,12 @@ static void nmi_dump(void)
>  	 */
>  	arch_spin_lock(&nmi_lock);

[Severity: High]
If another CPU was interrupted while holding an nbcon console in an unsafe
state, will it be trapped here spinning indefinitely on nmi_lock?

If so, it would never be able to release the console.

> =20
> +	/*
> +	 * No CPU leaves the NMI handler before the hub reset below, so an
> +	 * nbcon console's printer thread would never print the dump.
> +	 */
> +	nbcon_cpu_emergency_enter();

[Severity: High]
Does entering EMERGENCY priority here instead of PANIC prevent a hostile
takeover of the console?

Hostile unsafe takeovers require panic_on_this_cpu() to be true via
nbcon_allow_unsafe_takeover().

Since panic() is not called during this NMI dump sequence, it appears this
would fall short of allowing a takeover if the console is locked.

> +
>  #ifdef REAL_NMI_SIGNAL
>  	/*

[ ... ]

> @@ -227,5 +234,6 @@ static void nmi_dump(void)
>  	 * Save the nmi cpu registers for all cpu in the eframe format.
>  	 */
>  	nmi_eframes_save();
> +	printk_trigger_flush();

[Severity: High]
Will this flush completely suppress the dump output if the console was held
by one of the trapped CPUs?

If the system attempts a handover here, it will wait 2000us and time out
because the other CPU is trapped on nmi_lock.

Following the timeout, nbcon_context_try_acquire_hostile() will fail with
-EPERM because PANIC priority was not established.

Could this cause the flush to fail entirely, silently triggering a hardware
reset via LOCAL_HUB_S() without outputting any diagnostic information?

>  	LOCAL_HUB_S(NI_PORT_RESET, NPR_PORTRESET | NPR_LOCALRESET);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001191938.3256=
-1-kaloz@kernel.org?part=3D1
