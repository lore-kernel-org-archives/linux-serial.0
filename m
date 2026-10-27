Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101570;
	b=4L1d0O0DxdIx9l6k7ulGY93w+Q3Mvv2/U5+DCOEA7SHHTAdO+X49EMNJLuSY6uH1PxZJ
	 0mdrQJvEDYUuL4kO3c/NjAtXznNADe4IkaSlihlomwi1+ycfPr3SbtW1SSfwviv0X/c9i
	 /IWIbRYwpSKd/NejxSCSgQspQvoqVR60byNLpnN2J5JjsK2UVy2WkJm8dp/rBhyPCpCpV
	 Dkx1tKmJwU1/x7oM+7aCFpuWm7WRVWJrYx4tw5DW6SG8ezzDu6cD8H7QoY8k5pkECsIaj
	 K/gYg644DrhE3NvOueGOjZv1YkKSkvWs/f1IUxG2vLVljh3q7khV8yZWcznU6FYQThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j81aT5xR18Nn9AcfD4xxwUIP4FPi8CZiUasjTCVrar8=;
	b=I1dZ88V7npD5TyAt+Q/Hkgi3vrSUba0MMc587oeqwUK6KbD8IRgGRjk3Jo3cExqUUiWi
	 Vg/OJGrPYmilXhkkM0ODc7yT4yvK5mJuGBfPKTqqWTUkr978U/kNYIJ3bON8FuouK3+/6
	 LeoUyrtH5eWGms3heFZ3fhrKTyp2vYIb37+YiEI87eRO0fnr4LdEVfCxmvfPjmrNpeIRF
	 zKzVYCHeZw2lu70fSCS1/+RQ1Lb+6osXi+wHN6t4rh/+YaG8uCAvNSHe2Qv5FEUq7hf7x
	 JtlKGL0Lm9GwUP00JOu67SshpQADvoEPWfVVp9dAeYCg53GERThLGUA/7B8Y/sIiR6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns3Ivemx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F77606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns3Ivemx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471571F01180;
	Tue, 27 Oct 2026 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101569;
	bh=j81aT5xR18Nn9AcfD4xxwUIP4FPi8CZiUasjTCVrar8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ns3IvemxeXfcgUG58ztoMgiUCHRyrfX1t9SAJ3gtBzFbfzVnMRm9pACcLH8/4a/x3
	 SnPan3sqW7MTPreV9L9YCe4VvcTQUf5CnCYWDtqUQAv7OJ3VVRa6CkPjlCfALbOtTu
	 Hh7fPb9zUQ5oXrcctnJZlG38f3T1rr9tNnruM7YGWoflS2uBKABFdg+UeO2hrI8U/8
	 mjFhBS52LwZCcv68c+LDozSjYZAKcBNRiXoOJOHshBbQAP7yrK1ElJsJjvao7OYwn8
	 Ce54E+nL6E+NboPrDwaLyF8RviEw1ZJiDtl10i1EPFE0px9+s+lkCMtAY0fW4+k3zD
	 CzMZPR0AEqTlg==
Message-ID: <sashiko-outbox-186470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/24] serial: 8250: don't wait for the em485 timers
 locked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-3-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-3-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:46:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: 8250: em485 UAF and leak in serial8250_unregister_port()
--

commit 6643854d8da29baca2d8df19bd5e802596031b66
Author: Josef Bacik <josef@toxicpanda.com>

serial: 8250: don't wait for the em485 timers locked

This commit avoids a deadlock when disabling RS485 emulation by using
hrtimer_try_to_cancel() in serial8250_em485_destroy() while holding the port
lock and retaining the struct uart_8250_em485 instance in em485_idle. A new
serial8250_em485_free() helper is added to synchronously cancel the timers
without the port lock and free the structure during port unregistration.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 42319843cb5b0..0951d3e42e1f3 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -947,10 +947,7 @@ void serial8250_unregister_port(struct uart_8250_por=
t *uart)
>  {
>  	guard(mutex)(&serial_mutex);
> =20
> -	if (uart->em485) {
> -		guard(uart_port_lock_irqsave)(&uart->port);
> -		serial8250_em485_destroy(uart);
> -	}
> +	serial8250_em485_free(uart);
> =20
>  	uart_remove_one_port(&serial8250_reg, &uart->port);

[Severity: High]
Can calling serial8250_em485_free(uart) before uart_remove_one_port() cause=
 a
use-after-free or leak struct uart_8250_em485?

In serial8250_unregister_port(), only serial_mutex is held when
serial8250_em485_free() runs. Inside serial8250_em485_free(), uart->port.lo=
ck
is acquired to move uart->em485 / uart->em485_idle into a local variable and
then released before hrtimer_cancel() and kfree(em485):

drivers/tty/serial/8250/8250_port.c:serial8250_em485_free() {
	scoped_guard(uart_port_lock_irqsave, &p->port) {
		serial8250_em485_destroy(p);
		em485 =3D p->em485_idle;
		p->em485_idle =3D NULL;
	}
	...
	hrtimer_cancel(&em485->start_tx_timer);
	hrtimer_cancel(&em485->stop_tx_timer);
	kfree(em485);
}

Because uart_remove_one_port() has not yet detached the port, hung up the
tty, or unregistered the console, two races appear possible:

1. A concurrent TIOCSRS485 ioctl (uart_ioctl() -> uart_set_rs485_config()) =
or
PM resume (uart_resume_port() -> uart_rs485_config()) serializes on
state->port.mutex and uart->port.lock rather than serial_mutex. Once
serial8250_em485_free() drops uart->port.lock,->rs485_config() can call
serial8250_em485_config() -> serial8250_em485_init(), see both p->em485 and
p->em485_idle as NULL, and allocate a fresh struct uart_8250_em485. Neither
uart_remove_one_port() nor the rest of serial8250_unregister_port() calls
serial8250_em485_free() again, leaking the new allocation, reinitializing
uart->port.lock in serial8250_init_port() when serial8250_isa_devs is set, =
and
potentially leaving start_tx_timer or stop_tx_timer armed after the port is
unregistered.

2. If the port is used as a console, unregister_console() is not called unt=
il
uart_remove_one_port() -> serial_core_remove_one_port(). A concurrent
serial8250_console_write() caches up->em485 at entry and releases the nbcon
unsafe state across mdelay() before reading em485->tx_stopped:

drivers/tty/serial/8250/8250_port.c:serial8250_console_write() {
	struct uart_8250_em485 *em485 =3D up->em485;
	...
	if (em485) {
		mdelay(port->rs485.delay_rts_after_send);

		/* Toggle unsafe after possibly long delay */
		nbcon_exit_unsafe(wctxt);
		while (!nbcon_enter_unsafe(wctxt))
			nbcon_reacquire_nobuf(wctxt);

		if (em485->tx_stopped)
			up->rs485_stop_tx(up, false);
	}
}

If serial8250_em485_free() runs before uart_remove_one_port() unregisters t=
he
console, kfree(em485) can free the structure while serial8250_console_write=
()
still holds the cached pointer and subsequently dereferences
em485->tx_stopped.

Should serial8250_em485_free(uart) be called after uart_remove_one_port()
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D3
