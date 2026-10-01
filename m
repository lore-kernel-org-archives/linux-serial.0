Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70751C058
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864649; cv=none; b=Pppn1fodbWXEK8elynTUEmYZkibpJ4Ff+QMgmC2XWGQu8D0Z7sz/F0DhTsMqPq8kQ26GB11OaWvfQg2ahvqd0pk+2X3em8xngcDIoHCQBi312azXdViJX2GJbooqu9GaU4sFbSC84640RgAhkjJDmAZ/BsGGJMmTyDOvzWgDPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864649; c=relaxed/simple;
	bh=pJ1j8R6WCsaTGNeAxdCP4s4N1I1cjDTMhLUvgVa6bzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nu5Flp2XrQWmd843SFzWoymdnIC/eTI2+Xu+aRGWhKobp+liYnrG2SVqIjyZIigbjKB8wy0kPUbkAQhhmLkwDBsxCLBLs15nh05to04UUhES4OT4VWkosnOFqivd8YKx7kQvSuwJ6eUylXxGtMmz6LbazRmTOf1JkdQMBSEvEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPdWXXRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPdWXXRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C721F000FF;
	Thu,  1 Oct 2026 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790864647;
	bh=Vyxvn4uidP8e9GbnXeInbiV7687WSpqyC1m7E+2zo0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPdWXXRXfnPm8KD/YMFXhwa8I3VOLYHX1NR5+r3XRHb+s4P2k+pj4Z2byc7fxjRkc
	 0AhVEDlPf6yilrOo93QIBl9BtvxOhONkygW8d8sJ8OELENOFUmkKEcwxs8n9yjUTY9
	 EXvRcxpXf1nn+BbOrrkuP11qMrKZpRu1TJ8SQ77yMs1xWc9LKB9indvGRMGP8jKe87
	 FjHbqbB48vtsDFofzyxYxFGCXAtMz1Cb4aUZUX4IFptaHuTw+DCH8tYkI1sLwLuC71
	 f3zgTrNbmxtrhL7Sp0Ozoq1GnS9ZJ+6BoRSG4vG0YDI7pfIJedDjRP6oxQ+w2qD5nS
	 LmbpP0mNr849Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001140727.124398-2-pmladek@suse.com>
References: <20261001140727.124398-1-pmladek@suse.com>
 <20261001140727.124398-2-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:24:07 +0000
Message-Id: <20261001142407.84C721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] console: deadlock in braille_write() from atomic/IRQ context
- [High] console: infinite loop in braille_write() when CONFIG_PRINTK is di=
sabled
--

commit 0bb1344e643dce4e38416fdf04095c16fe6023c8
Author: Petr Mladek <pmladek@suse.com>

braille: nbcon: Allow to use a serial console with NBCON API as Braille con=
sole

This patch integrates the Braille console with the NBCON API by allowing
braille_write() to attempt acquiring NBCON ownership before writing. It
simulates the original locking using nbcon_braille_try_acquire() and routes
output through write_atomic() or write_thread() callbacks.

> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/ac=
cessibility/braille/braille_console.c
> --- a/drivers/accessibility/braille/braille_console.c
> +++ b/drivers/accessibility/braille/braille_console.c
[ ... ]
> @@ -62,14 +62,50 @@ static void braille_write(u16 *buf)
[ ... ]
> +	if (braille_co->flags & CON_NBCON) {
> +		if (panic_on_this_cpu()) {
> +			/*
> +			 * This should be good enough in practice. Most/all
> +			 * serial console drivers have the atomic callback.
> +			 */
> +			if (!braille_co->write_atomic)
> +				return;
> +
> +			local_irq_save(flags);
> +			/* NBCON API strictly requires the ownership. */
> +			if (!nbcon_braille_try_acquire(braille_co, &wctxt)) {
> +				local_irq_restore(flags);
> +				return;
> +			}
> +		} else {
> +			braille_co->device_lock(braille_co, &flags);
> +			while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> +				cpu_relax();
> +		}
> +	}

[Severity: High]
Could this lead to a deadlock? braille_write() can be invoked by VT
notifiers from atomic or IRQ contexts (e.g., from keyboard interrupts or
console_flush_all()). By calling device_lock() and spinning on NBCON
ownership with a cpu_relax() loop, if the interrupted context already holds
the lock (like an active nbcon flush), nbcon_braille_try_acquire() will
permanently return false, causing an infinite busy-loop.

[ ... ]
> @@ -102,7 +138,24 @@ static void braille_write(u16 *buf)
[ ... ]
> -	braille_co->write(braille_co, data, c - data);
> +	if (braille_co->flags & CON_NBCON) {
> +		nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> +		if (panic_on_this_cpu())
> +			braille_co->write_atomic(braille_co, &wctxt);
> +		else
> +			braille_co->write_thread(braille_co, &wctxt);

[Severity: High]
Does this violate the write_thread API constraints? The
include/linux/console.h documentation specifies that write_thread must
strictly execute in a task context. Since braille_write() can be called
from an atomic or IRQ context, invoking the kthread-specific callback here
could be unsafe.

> +	} else {
> +		braille_co->write(braille_co, data, c - data);
> +	}
[ ... ]
> diff --git a/include/linux/console.h b/include/linux/console.h
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
[ ... ]
> @@ -678,8 +687,14 @@ static inline void nbcon_reacquire_nobuf(struct nbco=
n_write_context *wctxt) { }
>  static inline bool nbcon_kdb_try_acquire(struct console *con,
>  					 struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) =
{ }
> +static inline
> +bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt) {=
 return false; }
>  static inline bool console_is_usable(struct console *con, short flags,
>  				     bool use_atomic) { return false; }
> +static inline bool nbcon_braille_try_acquire(struct console *con,
> +					     struct nbcon_write_context *wctxt) { return false; }

[Severity: High]
Could this cause a hard lockup if CONFIG_A11Y_BRAILLE_CONSOLE is enabled
but CONFIG_PRINTK is disabled?

Since this fallback stub unconditionally returns false, the
while (!nbcon_braille_try_acquire(...)) cpu_relax(); loop in braille_write()
will never terminate when triggered by terminal output.

> +static inline void nbcon_braille_release(struct nbcon_write_context *wct=
xt) { }
> +static inline bool nbcon_is_braille(struct console *con) { return false;=
 }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001140727.1243=
98-1-pmladek@suse.com?part=3D1
