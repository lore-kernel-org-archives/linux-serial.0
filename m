Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E33CE0AE
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675839; cv=none; b=l3x4GDYnlch4CsGPDrlib5b/etpzEDUD0Pc/LypddWhJ0jLHnVNaRiTZiPv2dtWB8Dpvwyaj8QzoEIH0hw8SoNyLV/iPtyXrpu+/Mf8v0NPIdfT5/l4OkT0vbbnKxDv3HtOSClx+Fhk6FJCFDexCbCsMnGQ3zEqo4ybYQX8+q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675839; c=relaxed/simple;
	bh=N62wBeayJMkqF8PVrt+3QxN/AbAXeXHcJtlHve5a1hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1qwslE7Bnkw1DuyzUgEdXkH7Cu7mi4/P4BGFPDC/QlxRKZEP4ed28SvGbe+07X3dWtHtAtXk5mSnFg/V04Q43VvHPn6S6H5yMiejCxbT/x9HNJJHh5EONUx04eRyiNKXIlROigVhvg4a2iBDWfqxozTasHfh5AeMTWw0iklTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR3GpiZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR3GpiZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD811F000FF;
	Tue, 29 Sep 2026 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675838;
	bh=ZvIY5PmUmCu+v7Ms4KzLaVHcs6frVsF06TRRw5HyQ3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BR3GpiZNOpYCDhxHENdqxvF1v0m9MPBBJtqay6Fq6mR5sbbkbV4pvdz+eLCTDlRfA
	 61knVK9j4T1QpW9raBdNWLRmjDXtKxQAtt2muLR2RiX1rapOv4wxJ6mTjJ1GDQKRNY
	 CN53UqupT88zX5enNcXz9Usr9IGSyQ8k+hsKeDPgR3imVUSXQitkjpFgQKo1vow/FU
	 iYCqfkc1ClyE8NO0dUNLOPUjrGrI36jcRYfAcRtFTwunasaqBOQEb9b7CvVK3KKI9n
	 RgRUdKHONjIQckeWbySTl10BXd0vtHpDtANzGlgBY5kBr3erj8nDr4LnoBRZVHLTIl
	 rCiXvXZKF5BUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] serial: max310x: wait for TX to drain before
 powering down in shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 09:57:17 +0000
Message-Id: <20260929095718.3DD811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: max310x: local DoS via uninterruptible sleep in max310x_sh=
utdown()
--

commit 4e0091905a683e3eb7b2b59d98c46ef3bed3cdef
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: wait for TX to drain before powering down in shutdown

This commit modifies the max310x shutdown sequence to wait for the TX FIFO =
to
drain before powering down the port. It calculates a per-character duration
based on frame size and baud rate, then polls the TX empty status in a loop
to prevent truncating the final transmitted byte on close.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c

[ ... ]

> @@ -1231,6 +1236,20 @@ static int max310x_startup(struct uart_port *port)
> =20
>  static void max310x_shutdown(struct uart_port *port)
>  {
> +	struct max310x_one *one =3D to_max310x_port(port);
> +	unsigned int loops =3D port->fifosize + 1;
> +
> +	/*
> +	 * The tty layer waits for tx_empty() before close(), but tx_empty()
> +	 * only reflects the chip TX FIFO - the last character may still be in
> +	 * the transmit shift register. Let the FIFO drain and the final
> +	 * character clock out before the port is powered down, otherwise
> +	 * close() truncates the last byte on the wire.
> +	 */
> +	while (!max310x_tx_empty(port) && loops-- > 0)
> +		fsleep(one->one_char_duration_us);

[Severity: High]
Can this loop trigger a local denial of service or a hung task panic?

If a user configures a very low baud rate (e.g., 24 baud or lower), fills t=
he
hardware TX FIFO, stops the receiver from reading (e.g., via hardware flow
control CTS), and closes the port, they can hit Ctrl-C to abort the TTY cor=
e's
interruptible uart_wait_until_sent() call. The execution path then proceeds
directly to max310x_shutdown().

Because this loop ignores signals and waits in uninterruptible sleep, bypas=
sing
TTY layer timeouts, it forces the kernel to wait strictly on the baud rate.=
 At
24 baud, one character takes ~416 ms, leading to ~53 seconds (129 iteration=
s *
416 ms) of uninterruptible sleep while holding the port mutex. At 4 baud, t=
he
sleep jumps to ~322 seconds, which immediately triggers the default 120-sec=
ond
hung task watchdog.

> +	fsleep(one->one_char_duration_us);
> +
>  	/* Disable all interrupts */
>  	max310x_port_write(port, MAX310X_IRQEN_REG, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D4
