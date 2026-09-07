Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A24F6466
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795453; cv=none; b=mefwi8BaTdjST1aBuhlHy2KvPpX6FEq3faZm7+2LYgEXItdvHopg+ZhJaWGbN+jZTa1/u6GykVeXc0L+uBpT/EKb2Vz2k154LLTvXKakMljcbqOOcoYkVJWP1mxugAZGkzhlkKDBV1zxq82Y1fuujEt5gh7LyCUZakmuVqYuwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795453; c=relaxed/simple;
	bh=qyDz1RpVFZXRV0CfRgtTw2VNv2aiVrfBlNH1puSk07Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rULcOHClRdEjXjDqWMUnj0LeNBl7uOU1zv/wFYZ3rKplXSl6WbaHvZ9ouMniVsSOKro72niwx0UKCTYJKu+vPPKNY/11fP93yb4H50+abt+U6rB6tjkHTigTSAKEnBlFUSjjHRz6M3dW6IoVHgOXpSxcBDlYZQsCbeLSnVnvh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+7HiP8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+7HiP8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089061F00A3A;
	Mon,  7 Sep 2026 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788795452;
	bh=IgmNkjWTq5IxofkeuUZL0on2s+3pJNuFZcWGosJ0hZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+7HiP8cxWFW8zTS6/NYJ3rdCYHhoId6OyrvaDVcyN5hV6JAr+bdtaOMN+WoFAg0B
	 aFImgUSX450g/8tFYpTVtrttEvDSEFx93fscT11N6NvCoYmCyV/S5pHb5izhB8lpsV
	 y18FzyzFQUapKue4Sik3hN/w1QEexBO1FWrqseeZp9nhGjgLGuNPGMtOphUsYJVjiN
	 maXRZCXh6jQpeANoKcxFDxzvL4ROP6ro5JWtzLjCif5INI4waVhmgnuLXY+lw6qt6f
	 tnd/6a69m06KrS5vp/7l+OnT2Otr7RJsa0kMfjAM42q/sqRSSaXgx2lZdSjicoT07U
	 Aru1qWUyiqNAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_of: set UART_CAP_NOTEMT for rts-gpios
 RS485 direction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolas Thibert" <nithibert@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907152744.1084359-1-nithibert@gmail.com>
References: <20260907152744.1084359-1-nithibert@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 15:37:31 +0000
Message-Id: <20260907153732.089061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added UART_CAP_NOTEMT flag is either silently overwritte=
n or causes the port to lose all of its default hardware capabilities.
--

commit 1d8dc615b4080d6f9bde37f54eafa34f59649ede
Author: Nicolas Thibert <nithibert@gmail.com>

serial: 8250_of: set UART_CAP_NOTEMT for rts-gpios RS485 direction

This patch sets UART_CAP_NOTEMT for RS485 ports using rts-gpios to prevent
the direction GPIO from getting stuck due to missing TEMT interrupts.

> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/=
8250_of.c
> index b1561c499acda..600a77e1e6143 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -212,6 +212,22 @@ static int of_platform_serial_setup(struct platform_=
device *ofdev,
>  	up->rs485_start_tx =3D serial8250_em485_start_tx;
>  	up->rs485_stop_tx =3D serial8250_em485_stop_tx;
> =20
> +	/*
> +	 * This generic driver never enables a dedicated line-status
> +	 * interrupt on TEMT, so for ports whose RS485 direction is
> +	 * controlled via a GPIO (rts-gpios) rather than the native RTS
> +	 * pin, __stop_tx() (8250_port.c) can see THRE without TEMT on the
> +	 * last byte and bail out without ever retrying -- leaving the
> +	 * direction GPIO stuck asserted after the last byte sent, on
> +	 * hardware whose shift register doesn't reliably surface TEMT.
> +	 * UART_CAP_NOTEMT makes it fall back to a frame-time-based timer
> +	 * instead of waiting on that interrupt. Scoped to rts-gpios users
> +	 * only, to avoid changing timing for ports relying on the native
> +	 * RTS pin, which this has not been observed to affect.
> +	 */
> +	if (of_property_present(np, "rts-gpios"))
> +		up->capabilities |=3D UART_CAP_NOTEMT;
> +
>  	switch (type) {

[Severity: High]
If the device explicitly configures a FIFO size, does the caller overwrite
this newly added capability?

When of_platform_serial_probe() calls of_platform_serial_setup(), it does
this right after:

drivers/tty/serial/8250/8250_of.c:of_platform_serial_probe() {
	...
	ret =3D of_platform_serial_setup(ofdev, port_type, &port8250, info);
	if (ret)
		goto err_free;

	if (port8250.port.fifosize)
		port8250.capabilities =3D UART_CAP_FIFO;
	...
}

Will this direct assignment completely erase the UART_CAP_NOTEMT flag?

Conversely, if the device does not specify a fifosize, port8250.capabilities
will be non-zero because it holds the UART_CAP_NOTEMT flag. Does this
cause the port to miss all its default hardware capabilities?

Later during registration, serial8250_set_defaults() checks if capabilities
is zero before assigning defaults:

drivers/tty/serial/8250/8250_port.c:serial8250_set_defaults() {
	...
	if (!up->capabilities)
		up->capabilities =3D uart_config[port->type].flags;
	...
}

Since up->capabilities is non-zero, this assignment is skipped entirely,
stripping the port of default features like UART_CAP_FIFO and UART_CAP_SLEE=
P.

Could we change the assignment in of_platform_serial_probe() to use |=3D,
and find a different way to merge UART_CAP_NOTEMT with the default flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907152744.1084=
359-1-nithibert@gmail.com?part=3D1
