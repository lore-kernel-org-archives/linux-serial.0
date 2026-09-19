Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBC17B50F
	for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857937; cv=none; b=Ov3mEWArG7QVpng1Ujm6E1TjCbHfoiO/Zootuhu8SJUTLDM1JLaafa6b0GS0sHvsabXgzB/I2c9xMosHad1Ud3Z2dkMPWwP/iCkPzFBrb8lpeH6ENzqm3X/YoOrwOhfmNYZ9h7qzPmGWBA4j5DjztYPuGTr87ycYMO9T92OwuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857937; c=relaxed/simple;
	bh=Kah84Rq4c8FVnHE8jN4PzJSAlJtbO+oO9fpF605Fwj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjGXGKKkQ+gJwS+z5BHXOoJfmRZyHlfj7SsUalQvLzPo2l4ftmSZrVRK3FIvOH4FjQqSuVMbS0x5iedHiZVwNaLzJoT9pzwKWEfc5AFpKjEbeZRn0FlraJZoCf9CONiZMu7xrwS0z9G5warqGoW8jULF0S28/yCMvqLyGibYPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D10sCdUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D10sCdUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C271F000FF;
	Sat, 19 Sep 2026 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789857936;
	bh=swov3N2puESaw4grZ3y86OJ3hB1J96HObVA95mARKVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D10sCdUDBVqErWmmJ4ZPnOoOnbOjv7WwZctCkGr1Ahbd0QZKO+UW/Qp+l718u74aY
	 /gzxupcQnOgeTrd1wRfQtDlMKufSOsFHV8/tZvvdLyBssoj7euLwDh/5NbgmEpI5E7
	 JUIx8Y5B075S0QAHNOR1Db7EvAE09ErF3DzHQ7BltzA910jHepICOOfMSYOcHfSH4P
	 X6RjdGZGiMy7ZS6LaT/lq7c8ayvP5R2mkuTRRZIfggTIcQim6I6CzmprqerG5B8PVI
	 uHvlXrY3YQ78dYbp1++8oo2wvVV8Y+L0CXDc4GIUjvlhNPzqUqTHMUhWWWyDQrglLe
	 HOY3bkKGWJ6aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: fix 8250 hash_mutex race and
 uart_get_baud_rate() divide-by-zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260919222627.3797854-1-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:45:35 +0000
Message-Id: <20260919224536.37C271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Fix two bugs in the serial subsystem:
>=20
> 1. In serial8250_Label / serial_link_irq_chain() and
>    serial_unlink_irq_chain() (drivers/tty/serial/8250/8250_core.c), hold
>    hash_mutex across the entire IRQ list manipulation and
>    request_irq()/free_irq() sequence to prevent racing IRQ chain
>    insertions/removals.
> 2. In uart_get_baud_rate() and uart_set_info()
>    (drivers/tty/serial/serial_core.c), avoid unsigned overflow in
>    port->uartclk =3D new_info->baud_base * 16 and ensure the fallback
>    retry in uart_get_baud_rate() terminates cleanly when no baud rate
>    lies in [min, max].
>=20
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919222627.3797=
854-1-benquike@gmail.com?part=3D1

