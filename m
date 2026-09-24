Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543A3E7BD5
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278748; cv=none; b=VGEZYQHYuXTyXDCmSCae0mowekgXKBpQH+Wm6PCwOYV8DAPRjcMtFgsaeSbj5SAwghvvYGMBwYppdY2Fz+mzIHVHlL/+MrMuRxAeZo+WTln/d3475rRw6/XedyM04JoLcXRhOFxmo2dHCrQ0z4hAdABZoKt+EnUTYqyh7cioinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278748; c=relaxed/simple;
	bh=Ql8zH3+nppy1Z2e4Npk9oGKYJLPPOiGtQ8weRuakUmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lM/Jbsf77YoLjOvs4vT7ihePZgBayUKneUDVTPSbkfLIMMyu1zsVEZ4vZL03QCYAixJPHEaCuzYs0gLQ79LXkaNzjdC2oehIDr36IWeig9c8crzMe9hVqNLT/JKE3YGZ4xaTe0e4kpbBf03adsLPtwnZBokLhHPPHU0L8HEgXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hohiQYv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hohiQYv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984FD1F000FF;
	Thu, 24 Sep 2026 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790278744;
	bh=ZFbNcEdDweFecLTvu8/5TTHFLj+C0WdoHR8pamX9gAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hohiQYv8K2zv89gcDPW3916piuq5qN9+9OQMZvEGAjygUPPVUjZhzKCy1ouGw3XJk
	 JX9P2TM2tcLntCSpfdCKQpgzkUh9vFeIxt37Jr1EMThDvfPvo5kr2ZK2ObDr92JvAa
	 giLH0mxgMoZ7R1OO/YNbsEvmOZ8I/NgWHd/P2e9Gi/5WaNw13ci2/mBXYnnqIisAfI
	 hRFcYdmZJ4Ku8ULSQfG7I2YQEfvEBMHECGroqcX251SCBLEVl9IrtGDj6Sg3meOuWp
	 tmN8F1Nm/Y1W5QkYTphCwQ6NoWzDv6AIltTRtU4UqzgkceXJUOpWkqw/mWoacFBx++
	 WQ/518k6KM6NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: core: shut down initialized port on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Putko" <igorpetindev@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924192224.3175-1-igorpetindev@gmail.com>
References: <20260924192224.3175-1-igorpetindev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:39:04 +0000
Message-Id: <20260924193904.984FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: data race on port->console in serial_core_remove_one_port()
--

commit ff681977bacb42b18c6925085fd5fa965af4c283
Author: Igor Putko <igorpetindev@gmail.com>

serial: core: shut down initialized port on removal

This commit addresses a use-after-free read during IRQ setup by ensuring
initialized console ports are properly shut down before removal. It clears
the console flag and calls uart_shutdown() under the port mutex.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484b..030735da6b8c5 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3210,8 +3210,15 @@ static void serial_core_remove_one_port(struct uar=
t_driver *drv,
>  	/*
>  	 * If the port is used as a console, unregister it
>  	 */
> -	if (uart_console(uport))
> +	if (uart_console(uport)) {
>  		unregister_console(uport->cons);
> +		port->console =3D false;

[Severity: Medium]
Could this assignment cause a data race on the port->console bitfield?

If a user process holds the serial console open while the underlying device
is removed, serial_core_remove_one_port() will synchronously hang up the
tty by calling tty_port_tty_vhangup().

If the user process then calls close(), the syscall path will execute
tty_release() -> uart_close() -> tty_port_close() -> tty_port_shutdown().

In tty_port_shutdown(), the code acquires port->mutex and evaluates
port->console. Concurrently, the assignment above happens without
holding port->mutex.

While this might be practically benign at the machine level since byte stor=
es
are usually atomic, concurrent read/write access without synchronization is
undefined behavior in C and can trigger KCSAN warnings.

> +	}
> +
> +	guard(mutex)(&port->mutex);
> +
> +	if (tty_port_initialized(port))
> +		uart_shutdown(NULL, state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924192224.3175=
-1-igorpetindev@gmail.com?part=3D1
