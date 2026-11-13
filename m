Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585721;
	b=m0nqAh+SzMLdKugR36nA3hy818T70imZtJS6D3iE+1Ki/uJ9Mxem8tUlZF0+hig3uz3c
	 q6lHq+UPdkeQQVSWun8Plpqng/Rtb8Oih/B2V+eyXjpI46tbox+iOZiErRXwCVZVzlyqO
	 tHSwJV7Yuv1dmsZAk6mzK3v79haBOhcxB83TQFqaCjnDTanSm7l7n9OcMUNgqfB+Uni8X
	 +Uvldust60TrqYKz5bCTQ8q/pmdr7BDMcTN8FaalztbouleIgxnPlOQxEndsnu+4jjaBV
	 B6gZZo6JK9jiXGQN59EvSG6E6c4BpIymok2LHsVUF6ySZQrJeemhIislLeosibZ2R6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Egw9JjCK+DUmz8g6ZcDlqjh7BkFWqzrS4U0GifCOv6s=;
	b=SXJ9fteM41sTzLKCur24BSu9/D1unOaQ170+MbaEb9i5AlZ5FmL4Nhzl5l9Kl6U7aADH
	 DKZ7klukplFC4rQlRxzmvapc6S1peyltQ2r7uu4j7lWB+W+gykuWuBXomDR5dBR4Ek0PN
	 1K5YHMd76x/IiF3rU6HFzyCX0msoL3X6cVLR6NKS9MElKJ3ZiMtOj3LvaXciyE3v/A725
	 MK/wpQmNrosKyV4mGI/hxejnMgfBFYjsU/XB+f8Ixza68jTfRrdezSe2tUzQ+2FjS2r25
	 J6HSMb/klEE1MdneM/48tNcGEVhqg+aIjyu27xbVeNFgImuF4tX0xpcCS2kZqhHJf+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l8GsoVO/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F15606A8A9
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8GsoVO/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F0E1F000C6;
	Fri, 13 Nov 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585721;
	bh=Egw9JjCK+DUmz8g6ZcDlqjh7BkFWqzrS4U0GifCOv6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8GsoVO/I24b7tvwkYz41N0M+8SbkFDbt4LKay1DN6YeVI/2FWxoUmxex8jZ5hxHm
	 p/RuHmcN7vYGOGZltQo06O6AErxbkqs1CzlF/pPUOV9E4VDaa9UcI/oxm7CeTmxfoG
	 7DSYVslCz+xUCjSz8GAXc0jRGiT1c+TXcTWVulCUkLSFK1a1ipuBsXQE+6Gk0+pRr0
	 7LmOQWWrMytkVqI0VKmVX1rUtcPJnvioJkauM305ELr0M0T9sStNsfPJKpqhYdKdQq
	 Bfn9Bf0PeqDkR3YNuJvQJHTXFWrDXgyFD3ZJcuseawP8IYSDeaK8TgY3gYYGdX5LTd
	 hIZ5tfNiCY2Hw==
Message-ID: <sashiko-outbox-213142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tty: serial: lpuart: Add port lock for registers
 read in lpuart32_set_termios()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-lpuart_port_lock-v3-1-895c8758a9db@nxp.com>
References: <20261113-lpuart_port_lock-v3-1-895c8758a9db@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:02:00 +0000
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
> lpuart32_set_termios() reads UARTCTRL at function entry without holding
> the port lock. lpuart32_console_write() can run concurrently on another
> CPU and temporarily clears the RIE (Receiver Interrupt Enable) bit while
> it polls characters out. If the unlocked read in set_termios lands inside
> that window, the stale snapshot is written back, permanently clearing
> RIE. Once lost, no normal code path re-enables them, so the UART stops
> receiving characters and becomes unresponsive.
>=20
> Need to add port lock for the registers read in lpuart32_set_termios() to
> avoid the unlocked snapshot captured. Since neither uart_get_baud_rate()
> nor lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, the register
> reads and bit manipulations could be moved into the existing
> uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().
>=20
> Please note that this only fix the normal printk path, in the
> oops_in_progress path of lpuart32_console_write(), when trylock fails,
> RIE is cleared and old_cr restored without the port lock held, there is
> still a risk of stale snapshot, but it's acceptable for the post-oops
> state and the trylock-fail window.
>=20
> Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interf=
ace support")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-lpuart_por=
t_lock-v3-1-895c8758a9db@nxp.com?part=3D1

