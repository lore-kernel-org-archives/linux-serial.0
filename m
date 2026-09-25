Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D94AC14D
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346897; cv=none; b=hZx3RmsNqS8sMr1rrUNP6J3xbhuzy2PJGDR+9bg07OYrOWt7cJrKoujxAUe4kQ/yBWJywKVbk42grkPCH+yst1xnNbIcXzPzr2jtPoAQtAY5nI8ULnqRb/zxNTLtuj9iI45omkahaDfPLTLPubLUWHyC6MRRtfwJvouK0Ys+L1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346897; c=relaxed/simple;
	bh=GGoh6Kufr7QSWF7cuMhdrdbFo+Ou2x2Yq1VA6kLnc44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j1iY84d7jiKfF5NSb1XwrYy2fJnPU5QUnrQTyc59w0TXoIlsEFJi/fDiCSKcyiP0fN+VVgYlkIWvnLMPjp1HPT970eeL/L5hBPOORvCBNxKQX0/U7L40ioQMBMJeuFMZV9Da89V6Fexqwgg+dV41mMS63D/ThAxA4Kc5OT789JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz3zmHL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz3zmHL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF21F000FF;
	Fri, 25 Sep 2026 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346888;
	bh=E0CSkHTK9HJB5foqEI4PTHFagBS/1IODd/hOXdSnt3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vz3zmHL7Nlue8BBPiyZhMQ0xRc8lV/adgQ0XaWkkgOSgB04cJSUxidsSyCiuru8xa
	 cL7hjrZDQWL42hogbnn0g1n++wQQwgbqGVBtgSYSrCirbkSTjrY0hq8yuz4fyznHno
	 1nMz10/0MKMdp/baNYRnmtNF+CytnKl6M1dmryGX6RfNNI6giDofht7TTVYSN9T4VH
	 yjDPLnZhnQdP2AoPfpVzQP9Hw7yQ0Z41Fv+C9NdBRU4tVrMxYgJSqiSrakClWzgof/
	 a3TDqIdpI1pZWyyPbELNuWWL6QOsUMXsJ9RQbgjFDUvRtyvvViEwVuOD74tMFGkdDm
	 0Pf6M6hD6MLRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925141729.173943-2-pmladek@suse.com>
References: <20260925141729.173943-1-pmladek@suse.com>
 <20260925141729.173943-2-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 14:34:47 +0000
Message-Id: <20260925143448.30CF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] printk: deadlock in braille_write() when preempting same-priority =
nbcon owner
- [Medium] printk: oops_in_progress fallback in braille_write() is silently=
 dropped
--

commit 4140aba45f3709d38f4f94fc9c6bd39ccfc9cce4
Author: Petr Mladek <pmladek@suse.com>

braille: nbcon: Allow to use a serial console with NBCON API as Braille con=
sole

This commit updates the Braille console driver to use the NBCON atomic
write callback when the underlying serial driver uses the NBCON API. It
adds functions to acquire and release the nbcon lock from the Braille
console and attempts to provide an oops-in-progress fallback.

> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/ac=
cessibility/braille/braille_console.c
> index 06b43b678d6ea..bae177cb8cf92 100644
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
> @@ -62,14 +62,36 @@ static void braille_write(u16 *buf)
>  {
>  	static u16 lastwrite[WIDTH];
>  	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum =3D 0, *c;
> +	struct nbcon_write_context wctxt =3D { };
> +	unsigned long flags;
> +	bool locked;
> +
>  	u16 out;
>  	int i;
> =20
>  	if (!braille_co)
>  		return;
> =20
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
> +		do {
> +			locked =3D nbcon_braille_try_acquire(braille_co, &wctxt);
> +			if (!locked)
> +				cpu_relax();
> +		} while (!locked && !oops_in_progress);

[Severity: High]
Can this loop cause a deadlock on the same CPU?

If uart_port_lock() is used, it acquires the nbcon lock at NBCON_PRIO_NORMAL
but does not disable interrupts. If an interrupt fires on this same CPU and
calls printk(), the VT legacy console will invoke braille_write().

Because braille_write() disables interrupts and enters this busy loop, and
nbcon_braille_try_acquire() hardcodes NBCON_PRIO_NORMAL, the acquisition fa=
ils
unconditionally. A context cannot preempt its own priority level.

Since interrupts are disabled, the interrupted lock owner can never resume =
to
release the lock, resulting in an infinite loop.

> +	}
> +
>  	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
> -		return;
> +		goto release_nbcon;
>  	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
> =20
>  #define SOH 1
[ ... ]
> @@ -102,7 +124,24 @@ static void braille_write(u16 *buf)
>  	*c++ =3D csum;
>  	*c++ =3D ETX;
> =20
> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		if (braille_co->write_atomic &&
> +		    !(braille_co->flags & CON_NBCON_ATOMIC_UNSAFE)) {
> +			nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> +			braille_co->write_atomic(braille_co, &wctxt);

[Severity: Medium]
Will this fallback silently drop oops messages if the lock is held by anoth=
er
CPU?

If oops_in_progress is set and the lock is held by another CPU, the busy lo=
op
above exits with locked =3D false. It then attempts to print directly by ca=
lling
braille_co->write_atomic() here.

Because wctxt does not own the console, the underlying driver's mandatory
nbcon_enter_unsafe() check will immediately fail, as nbcon_owner_matches()
returns false. This causes the underlying console driver to abort printing =
and
return immediately, discarding the oops message.

> +		} else {
> +			pr_warn_once("Braille requires a safe braille_co->write_atomic callba=
ck\n");
> +		}
> +	} else {
> +		braille_co->write(braille_co, data, c - data);
> +	}
> +
> +release_nbcon:
> +	if (braille_co->flags & CON_NBCON) {
> +		if (locked)
> +			nbcon_braille_release(&wctxt);
> +		local_irq_restore(flags);
> +	}
>  }
> =20
>  /* Follow the VC cursor*/
[ ... ]
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d17704fe93ae1..e5a0506330eba 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
[ ... ]
> +bool nbcon_braille_try_acquire(struct console *con,
> +			   struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	ctxt->console =3D con;
> +	/* Keep in sync with nbcon_device_try_acquire(). */
> +	ctxt->prio =3D NBCON_PRIO_NORMAL;

[Severity: High]
Does hardcoding NBCON_PRIO_NORMAL here prevent the lock from being acquired
when the interrupted context on the same CPU already holds it?

> +
> +	return nbcon_context_try_acquire(ctxt, false);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925141729.1739=
43-1-pmladek@suse.com?part=3D1
