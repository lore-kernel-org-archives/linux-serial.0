Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAE3446C7;
	Wed, 16 Sep 2026 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549548; cv=none; b=t7A3FhGoJl2ZZTXjIlLyi2LJ1/UE84c3ePUXakMX778vE1qeF74wZx1+fz65P89VGBTMbQOFkQwSu0WQUS1YqYV5UeZtIsrYarvN66TXMk3pwfaor+oJsvpJi9OmC4VaxWwmytxdPGO26pKysdrYRSno2KbBL366X6iMnC6/ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549548; c=relaxed/simple;
	bh=A8Q0b8L5+BXoHFoNXocjrY2G7gEBMM46smRXxo38cwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxcvF8pQMYGmwd6Oqx6Og9k/P8ABWzbvGFgFN6UxJMd9Sg0zzW/V6V3+aEWv7s+hMqjJ81RZUrSass+dK4i6gbs0ZfbABbbN3PuX7pMDRZHcLEuFOUKdSCtKZ3Y6QitdXvHM57ReOBtVW6765O+Q4RN3H5lh/QwX1MyAmX0laJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsaY1eKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsaY1eKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DFE1F000FF;
	Wed, 16 Sep 2026 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549542;
	bh=1x6SLiEE/4uqWpa1eZRcFuewx1nl4LpxOkOuCze/qJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GsaY1eKyKh+OiUEFd6kz5J6dQ5BaNpOyVLqv0fMCww3m2Ec+GSVxRph6hT8RvKHKb
	 0+d/m9pmxIshJr7zlID7uxxDEXi47WNIv1C9fEIrepKxrph/e0CeJmEm93F7owE2ZS
	 VckvdHAsps7SGuEQs5rRB1HMkYMowJ582wRXTexmlQb/Eq5ztm34zRI7IDO3NKDbUB
	 Pt9UZ1Oa34nRr9ux5wk9SBvkkhYH2Rc55I4+Dm2Kh2qxNNn10MovxOV6ztG5BD2XpZ
	 MqrYQBsi51+Mgq/gU9WYKjiACENjyg/oDSNHpWCHZ5HoDBR34rzBtkTsoFoyCdQ9pz
	 qi4JZ4g8D8EeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty
 FIFO read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Moteen Shah" <m-shah@ti.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260916085520.2259420-3-m-shah@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-3-m-shah@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:05:41 +0000
Message-Id: <20260916090542.40DFE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: serial: 8250: lockless data race on lsr_saved_flags in seri=
al8250_do_shutdown()
--

commit 174d9274c3df70fd0549f2a70fbdf6e13b92b8d2
Author: Moteen Shah <m-shah@ti.com>

serial: 8250_dw: Add capability to skip empty FIFO read

This commit introduces a new UART capability to guard against empty FIFO
reads during startup and shutdown. This prevents data aborts on the TDA54
IP block where reading an empty FIFO is fatal.

> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 38fa45e74a37a..f533310145849 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
[ ... ]
> @@ -2455,7 +2460,8 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	 * Read data port to reset things, and then unlink from
>  	 * the IRQ chain.
>  	 */
> -	serial_port_in(port, UART_RX);
> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (serial_lsr_in(=
up) & UART_LSR_DR))
> +		serial_port_in(port, UART_RX);

[Severity: Medium]
Does calling serial_lsr_in() here introduce a data race on up->lsr_saved_fl=
ags?

In serial8250_do_shutdown(), the uart_port_lock is explicitly released
before reaching this point. Calling serial_lsr_in() locklessly causes a
read-modify-write operation on the shared lsr_saved_flags state:

drivers/tty/serial/8250/8250.h:serial_lsr_in() {
	u16 lsr =3D up->lsr_saved_flags;

	lsr |=3D serial_in(up, UART_LSR);
	up->lsr_saved_flags =3D lsr & up->lsr_save_mask;

	return lsr;
}

If a console write occurs concurrently (e.g. an asynchronous printk() from
another CPU), serial8250_console_write() will also invoke serial_lsr_in()
via wait_for_xmitr() while holding the lock. Can this race corrupt the
lsr_saved_flags state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916085520.2259=
420-1-m-shah@ti.com?part=3D2
