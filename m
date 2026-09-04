Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C546AEF4
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522944; cv=none; b=otXMX4RpuWNg31dIJOW0Ee14rcnnH2yGj2M7ymuEa1fkuU5GeKFptY9WYPFAsnDkM4v9MAJTMxVsu5lvXaiJVNVxj5F5S1K/jrRnMb9Ft6Tf+VFem5wMlqUr4qY6ob50IS8svPVk64TOuM8bkwN0q/hpuGLW11zbDqF9ujV6akM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522944; c=relaxed/simple;
	bh=0CeYG5ZrGxD4AMcjstfp+6yoJ77E4OEUJOMDoJjT0wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+U4y/bqtmAhH1zycQ/sbvkmfl14yJ7AbUevHyZ1Y+PBElbjAHua1YDKBXl0bttTtos7zvJaMUYuPqbAMw7DmQ3xZH3OPSBOf/UyUjj8CR4Y4XiFLTrF7PUJLZAKQKXd0p00TqzrmkBUt+0YplK7+vPTn+xriHcuMbfYpmfMaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afKfVNIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afKfVNIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20D11F00A3D;
	Fri,  4 Sep 2026 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522943;
	bh=8+GU2Zc3khB/ii/w+ZnVsAOxggeLSAx007dtBWIagPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=afKfVNIXH1k/ihmmfW8ggMAO7cViuBHwYq1UzYoezsjMejK3Mw25EZDKFtMDuhVwr
	 Cdd/WHADGjDChCZFMoz7asKwy9J3hKv59BcNSkyzD2b9PAWaSX5WESvpTqeUJQqnHr
	 6m/TW+mazmMnbeqs3NSwKS7nU56Rco+t2wkFHbm+yXY/YYxO2C9w3HdWDaNjjgw7mh
	 F70aIarbQq3ZgjkKVftZNY+Tk0F38PtkZAJC+XeYAhiXAMtYVGlt2frl8aNEFw2Q1F
	 YanMODgkGCyCVl+MuvsvrhkDoPh1asJbQeNEXYuhNBIu/y8Ffz4mIFzvW5RXXEDEF6
	 38NmsG8YjxsVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: fix ioctl hangup race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260904114448.1664502-1-johan@kernel.org>
References: <20260904114448.1664502-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:55:42 +0000
Message-Id: <20260904115542.E20D11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Mixing goto-based error handling with scope-based cleanup (scope=
d_guard) in the same function.

Pre-existing issues:
- [High] Missing hangup check (tty_io_error) inside the TIOCMIWAIT wait loo=
p causes indefinite hangs on device removal.
- [High] Task state is set to TASK_INTERRUPTIBLE after evaluating the wait =
condition, causing potential missed wakeups.
--

commit 971660f9118e5ac27dcc58fb0e95856b75c73a98
Author: Johan Hovold <johan@kernel.org>
serial: fix ioctl hangup race

This patch adds missing checks to make sure the tty port has not been hung
up before accessing the hardware in several serial ioctls. This helps avoid
issues like kernel panics due to unclocked accesses on devices that are
already gone or powered down.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484b..b0d3902fe4fca 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
[ ... ]
> @@ -1213,9 +1213,17 @@ static int uart_wait_modem_status(struct uart_stat=
e *state, unsigned long arg)
>  	uport =3D uart_port_ref(state);
>  	if (!uport)
>  		return -EIO;
> -	scoped_guard(uart_port_lock_irq, uport) {
> -		memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
> -		uart_enable_ms(uport);
> +
> +	scoped_guard(mutex, &port->mutex) {
> +		if (tty_io_error(tty)) {
> +			ret =3D -EIO;
> +			goto out_deref;
> +		}

[Severity: Medium]
Does this mix goto-based error handling with scope-based cleanup blocks?

According to the kernel cleanup subsystem guidelines in include/linux/clean=
up.h,
mixing goto-based cleanup targets (like out_deref below) with scoped_guard()
in the same function can lead to confusing ownership semantics. Should this
function fully convert its resources to scope-based cleanup, or stick entir=
ely
to manual locking?

[ ... ]
>  	add_wait_queue(&port->delta_msr_wait, &wait);
>  	for (;;) {
>  		scoped_guard(uart_port_lock_irq, uport)
>  			memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));

[Severity: High]
This is a pre-existing issue, but does this loop lack a hangup check
(tty_io_error(tty)) upon waking?

If a userspace process calls TIOCMIWAIT and blocks in schedule(), and the
device is hot-unplugged or hung up, tty_port_hangup() wakes the queue. If t=
he
process ignores SIGHUP, signal_pending() is false. Without a check for devi=
ce
removal here, could the task resume, observe no changes to the hardware
counters, and go back to sleep indefinitely?

> =20
>  		set_current_state(TASK_INTERRUPTIBLE);

[Severity: High]
This is also a pre-existing issue, but does setting the task state to
TASK_INTERRUPTIBLE after reading the wait conditions create a race window?

If a modem status interrupt fires immediately after the lock is released
(when memcpy finishes) but before set_current_state() is called, the
interrupt handler will wake the queue and set the task to TASK_RUNNING.
Could the task then incorrectly overwrite its state to TASK_INTERRUPTIBLE,
see the stale counters, and call schedule(), potentially losing the wakeup?

[ ... ]
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	remove_wait_queue(&port->delta_msr_wait, &wait);
> +out_deref:
>  	uart_port_deref(uport);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904114448.1664=
502-1-johan@kernel.org?part=3D1
