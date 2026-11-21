Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295450;
	b=JCi87Q4EkvMwfYZWKdTs4ExK/C57l4o3dnk8A8GdnwC+dTpjJSVHKLfhjHcuTc1o3lgp
	 ETgLGR9RWLyRV8uRweN3wdzCehAW0M7bTPv6MwY1lNqUfoD20ZHUYrJ4KcYlEF+jRpPZg
	 E5dbXY5MIOpJLmoWthVRubOCfrso1lKLDon9DnFKvuLOONG0285vmzEwkIVC76pQVTOM+
	 XI0/Z68/LJ9iyzxM51oBU2YIPizhRSMGZpcGoGvZVYDP6NoEQFRmKC8x28a+reu1EhVKr
	 UGngSuZoMeofW9Rma+6dS/Nvb+UM5peWG0hREbR5+tS9/twr8CcUXPxk9vpB7z32/TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mX91vnJBAj51b8TrYzcl2pOoknrSWxJKSn+DxSW1xkI=;
	b=Ql5eLsy7Oqnq22ya38yzmINufG0uziuZ2kxJEFcgFGJe+bnGQs+uJtBqCO0sjRJjfkkI
	 MUxXiJD6kZEC+EJg0ssXl6X8ykaEtaEKWSguqzqeM3k7WXkZJt9S4+YNMXrTqd+WXawmq
	 chgk4ZD1MApf3GQoy3xUH/PXYxY04/38vHANLxuQDFfuYvTqvgiaT4hqJVmvCY8fDzyjh
	 varqhxsdVf0WOYJJy8fuFpqG9RjYSwNmM+KKI4KX/HKDSuXjLu72CRbDVrnHNU/M5HFRJ
	 A5GNQgb/G5l0bA6pPzUtRPrjgHWj6eB8L5ungZCd+XdgoW76PfyLC9ROwUoLwfMf05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyktJPKm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E92606A33A;
	Sat, 21 Nov 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyktJPKm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3531F000CA;
	Sat, 21 Nov 2026 21:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295450;
	bh=mX91vnJBAj51b8TrYzcl2pOoknrSWxJKSn+DxSW1xkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyktJPKmNFRJXlrpXNeeOvn8njhL/XCasAwhPYCIK4QAN9pdUly4g2TX8xDgb+g84
	 jliOP+t7klkok27CFYwyuXJrJjpc15dZ0JkitJXk0wR6rzVgxPir+MMhgdn5dDIfrC
	 jsFN4VBillMaN5b3zPfTFqQHOu5sh98j37UNewUuwXGgIwssS1pBvLJVKLNsx4bMD1
	 nFW/t/E5qZFzPjCoEIG2bEtCmRfB+lEf+3rPni2PexirKKgtmh8bKdWbmqq5b7XBO7
	 TBs6cGcwkC4SGEOjGefoMbuxVFiVIXEZNc0G+Vuze76nMW9O9TPb8trpp41SpKBO2I
	 IIDRHtdTxdHvw==
Message-ID: <sashiko-outbox-227384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/10] tty: serial: Add Cortina UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122-b4-cs75xx-v8-7-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
 <20261122-b4-cs75xx-v8-7-5f971b0dc69c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:10:49 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tty: serial: cortina-uart: unsigned port->irq check in
  cortina_uart_probe()
--

commit a305c8b2604a8b9812e1e52e3a3c6ade80f87136
Author: Fil Dunsky <filipp.dunsky@gmail.com>

tty: serial: Add Cortina UART driver

This commit adds a serial driver for the UART found in Cortina Systems
CS75xx (Goldengate G2) SoCs, including system console and earlycon
support.

> diff --git a/drivers/tty/serial/cortina-uart.c b/drivers/tty/serial/corti=
na-uart.c
> new file mode 100644
> index 0000000000000..eb63848f09257
> --- /dev/null
> +++ b/drivers/tty/serial/cortina-uart.c
> @@ -0,0 +1,612 @@

[ ... ]

> +static int cortina_uart_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cortina_uart_port *up;
> +	struct uart_port *port;
> +	struct resource *res;
> +	int id, ret;
> +
> +	up =3D devm_kzalloc(dev, sizeof(*up), GFP_KERNEL);
> +	if (!up)
> +		return -ENOMEM;
> +
> +	port =3D &up->port;
> +
> +	port->membase =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(port->membase))
> +		return PTR_ERR(port->membase);
> +
> +	port->irq =3D platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;

[Severity: Medium]
Does assigning the return value of platform_get_irq() directly to
port->irq prevent error detection here?  struct uart_port defines irq as
unsigned int, so port->irq < 0 is always false and negative error codes
such as -EPROBE_DEFER allow probe to succeed with a bogus IRQ number.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-cs75xx-=
v8-0-5f971b0dc69c@gmail.com?part=3D7
