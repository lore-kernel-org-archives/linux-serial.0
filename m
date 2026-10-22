Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664191;
	b=AJuubaOxNTMPDNOZLZQo9yy5m3SuaCKauoDJUIgeP2txE7oZbIEBHvBPQoecHQub5bgB
	 aE3RO64iKtZdQtKctZi/bYcA5j67ZYeN/LNWhWygHk7jQ0ZhBuU2rO290E7q/bbKOqZyb
	 pXN4DcjyIlNIkZHRRhUeGemj/2kLHc0XJro58xJIpF9m7I+o34VDvnbHSvdwx6unodTDv
	 VYgccbnKio+mSwjJdS25mabAe3oBAm/aaxp3D0tBy7/9/lNAF/8KYOMwSnENXoUnJLVnf
	 l1LNFLPo6Wk14Lr+JCy0bC87nHK2U4RjFkbQT4LHZ7bkRlXVE1puwhoDL7wntPS+faw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9BKfNfRngkNfeATUKWvpyTCcyqGngB55Nr2fYOt37Ok=;
	b=YZ+uj7U8dYL2wNUc3yQSDozdgjIPCXqmo+/Cze2UL0CRNOIAGMUYlz0SheKexCA/TOCg
	 5DXz8lFpaGQzj5mLW2i5v5BW6rDxOAkicswP1rIQCTkS0TCWu3QmCQpt5lEag8WNf2NTJ
	 zB+b8mgPZ9HGC8jS18iizKODtupWhueu4AO8Z+QKDfj+SPos9ZLWtVMaM8qwTxAk70p5A
	 jM3mzT8F5d5oP7vG8VDYiedAGUD/coVXU4NUpdWwB0YlbyoUl4QES1zOZyj9VxA/B4B4y
	 w5+W/IGHr6hg+bOlU45IaDf1E08svicsGTGwhOSqGXBGBgH2GECcaofIhaOc0zdBtDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhvTnDeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57383606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhvTnDeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BC31F000C1;
	Thu, 22 Oct 2026 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664191;
	bh=9BKfNfRngkNfeATUKWvpyTCcyqGngB55Nr2fYOt37Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XhvTnDeGXV17voUv2PzjM7b2syXiXACV/3Nauj0U48ZvLMydui8F4cGw5vPsrTRkY
	 Zl5ghVIHiiURLmTpOhcfw/Cw4ovQM8cg5SmZggaE8Cj0YyQeF6e65nTTQeMpPknngU
	 rju3g425/FvJlzGKKx9kKmEM6j4RKJsDcP9FGtMRjKkR4lPDxSz0xM9OsophQAfIbC
	 1dBJ24tUkG/MGHJub/JSDdHUJK0lSBLvCwDWdYRfpr3cuMOXMjHGjGpDD9R+BEJ9VT
	 ABPqMG9a1VjoD9h1Twt+UTq2Hj/8lIMzPJOMFYG8ck2CrneemNYqLKMiV0gSbB0k4s
	 mpCX+zx3x3Alw==
Message-ID: <sashiko-outbox-181319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: core: fix synchronous external abort in
 uart_tiocmget() for runtime-suspended ports
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-b4-serial_uart_tiocmget-v1-1-9608a5e4bb10@nxp.com>
References: <20261022-b4-serial_uart_tiocmget-v1-1-9608a5e4bb10@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 10:16:30 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> uart_tiocmget() reads the hardware through ops->get_mctrl(), and the
> only check it does first is whether TTY_IO_ERROR is set. That is not
> enough to know the port is powered.
>=20
> On last close, tty_port_close() calls tty_port_shutdown(), which runs
> uart_tty_port_shutdown() under port->mutex and powers the port down
> with uart_change_pm(UART_PM_STATE_OFF). port->mutex is then dropped,
> and only after that does tty_port_close() set TTY_IO_ERROR. A caller
> waiting for port->mutex in uart_tiocmget() gets the mutex in between,
> sees TTY_IO_ERROR still clear and reads a register of a port that has
> already been powered down.
>=20
> A TIOCMGET ioctl from userspace cannot get there, as it needs an open
> [ ... ]
> touching the hardware.
>=20
> Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_por=
t_close")
> Fixes: 6dec659896b4 ("leds: ledtrig-tty: Add additional line state evalua=
tion")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-serial_=
uart_tiocmget-v1-1-9608a5e4bb10@nxp.com?part=3D1

