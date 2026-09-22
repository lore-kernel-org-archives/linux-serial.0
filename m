Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707D388868
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062651; cv=none; b=aNaFZsSKFim5LctD3R/HVMHsCaWAPAlJz9lbpp5oEYyxQ4ysR/0XviTnjBEd26mGZdFXKxF4FChohkl/tDHuH1KI6YZQ1Bel8XIN7MrTYjTb5kUlwn8XHM2MPBxdKRLsgUC8GwExYGltTGgh/SmaBfjXyzdXcDqanJ8fQ8F75iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062651; c=relaxed/simple;
	bh=hxikL+94iLTZZZAB/E+vESPGHs4tFRPDmwUFrZpOSvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N0aFcsgRwL4VS+9zsOgGUh6B30B/wuEvGBVFKbUm9SARvlWvyLBJ70jujeKxoJmkYqpibnjhLwAKOoyrP3nn3rqbld2DpbCIQ0hXRCP7s8ub/3QPZnABGfLoRCaFnGC9UIHQRPa9KWgKxDtcd7MqJIO+hn6Ox5ULaM95vGDczbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WixLIV7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WixLIV7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADCD1F000FF;
	Tue, 22 Sep 2026 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062648;
	bh=dV7PZ0H4VEvPcYQMilIn9G9Zx9uT83W9pCLnmMK7u5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WixLIV7OF6c9s4LfiDORrg2sGROsFfVNRLqyPvfBkGJJP5SE27Pdok7MgikRTTCBa
	 lyAMd3gCHbUmTg0McKLerz7lKEpEy9UUYnZVsTROy2fmt/yYItYnZKGf0OAEQtjza3
	 jk8qq+nZBVQdBZ76kxcMIWlaJQvB//UvSFstamer6MGDYBugeAps/xmBAG7kdOWZCD
	 zTNXxJOcgeg8ZW8zTn+VVN6DfkNHg+WC2XM9aFfCuc8YDKn3Lidm2l6ALn4Jx3eA6z
	 ODjtkMJFxIca+OZCPPSJDw+7Rn6pLy3o7FGHfm97Xb5U6CI1hPh1iMsM0wQbj9LCqf
	 KgbfM8aMhuQIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] braille: nbcon: Use nbcon atomic console callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922072558.98854-3-pmladek@suse.com>
References: <20260922072558.98854-1-pmladek@suse.com>
 <20260922072558.98854-3-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:37:27 +0000
Message-Id: <20260922073728.2ADCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] braille: operator precedence bug disables braille atomic write
- [High] braille: infinite spinlock in braille_write() during same-CPU unsa=
fe takeover
--

commit a7f38c0383481bd6ad9c244405d8d201d604569b
Author: Petr Mladek <pmladek@suse.com>

braille: nbcon: Use nbcon atomic console callbacks

This commit adapts the braille console driver to support the new NBCON API.
It introduces logic to acquire the nbcon console ownership before printing
and uses the atomic write callback to output the buffer. The serial8250
driver is also adjusted to skip prepending newlines for braille consoles.

> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/ac=
cessibility/braille/braille_console.c
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -62,14 +62,32 @@ static void braille_write(u16 *buf)

[ ... ]

> +	if (braille_co->flags & CON_NBCON) {
> +		/*
> +		 * Braille console might be called from unknown context via
> +		 * vt_console_print() from console_unlock() from printk().
> +		 * Use the atomic callback and synchronize it just using
> +		 * the console context. Disable interrupts to prevent a nested
> +		 * call into the driver code which might cause a deadlock when
> +		 * trying to acquire the console ownership, see
> +		 * __nbcon_atomic_flush_pending_con().
> +		 */
> +		local_irq_save(flags);
> +		while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> +			cpu_relax();

[Severity: High]
Could this loop become an infinite spinlock if triggered from a nested
context on the same CPU?

If an interrupt preempts the underlying nbcon console driver (such as 8250)
while it is in an unsafe region, and that interrupt triggers a printk(),
the legacy VT console might be flushed via console_unlock(), eventually
calling braille_write().

Since local interrupts are disabled here, the preempted nbcon context on
this same CPU can never resume to release the console. Because
nbcon_context_try_acquire() rejects handovers to the same CPU when the
console is in an unsafe state, won't this loop spin indefinitely?

[ ... ]

> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		if (braille_co->write_atomic &&
> +		    !braille_co->flags & CON_NBCON_ATOMIC_UNSAFE) {

[Severity: High]
Does this operator precedence evaluate as intended?

Because the logical not (!) operator has higher precedence than the bitwise
and (&) operator, this expression parses as:

(!braille_co->flags) & CON_NBCON_ATOMIC_UNSAFE

Since braille_co->flags is known to be non-zero (as CON_NBCON was just
checked above), evaluating the logical not against the flags yields 0. This
makes the condition permanently false, which bypasses the braille atomic
write callback unconditionally.

Should this be grouped with parentheses to evaluate the bitwise and first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922072558.9885=
4-1-pmladek@suse.com?part=3D2
