Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBD21883E
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 03:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271541; cv=none; b=rjV1EfkRqc1lPhdlbzoKHEq7ih0bqZlioome9ZT9OFFf0dFc0LW3LInyMY9jnEAbiVaa2uSHoa6z8genbQLNs90nu3dorIOqchUIJmVN3pl31Lsa4dpbo4MJgfXX5teJEWpGfxz+vPbDb4Dd7bzMN77vvZWlDBmzThEu0rRBvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271541; c=relaxed/simple;
	bh=oD5CCjbIO/Of5Hjq4SlRKtAuzYiCPf506I9t2ORqhrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ffFdikjbUq8f09a+13bDpMf6uDGnjyITYJEryGwVihd3H9hztNjR6Vh1E+6+CvxuVbRgRH7IURD0e6/SATWnDmORGjhiHqQU+ujg63wFN8zyfXCtry5tB171vcCj7QJhhCkE/VOrTBJFOhcc7A4MUjRkEvl+oVjipELOEEirFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMReP78N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMReP78N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3592B1F000FF;
	Sun, 13 Sep 2026 03:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789271540;
	bh=1cOrmSi2NyE9JElwHhzAoGiv+iu3+GnIhqFNrKO4cuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QMReP78NAoNenof2BnVtMMqNCIUO8s/kZFZyQlmLhcp0UrgMT7gRDvBP0ZMOsu8pi
	 xGXhzfThe7qcAsuFE2r+MJNoPrr3+TzRcBPSuNs0yE5oBLZumtSn5v/vsD0vnZk/GH
	 4E0b8NGm+E+aZZkCGjdBcnRwEJyfNx3bnpe382VjsM9Q2n5pyq4av5YoVJ4yeHatzV
	 xMhCNXC1EoBW7dXbYJ8ilXrYlWKAO7z+eww0Z9z2LEfi2zSuFs2EoW2Af0l3pzIhKj
	 31BkzRBfD6IxOw7pGMpD91kyqHhgu9ejjVHXKGa2YVc0rfjGQcEHuD1AFfovGHBoiy
	 Tla5UL1NcsXtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: meson: fix UART driver lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-serial@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260913034148.15068-1-mhun512@gmail.com>
References: <20260913034148.15068-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:52:19 +0000
Message-Id: <20260913035220.3592B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to map device memory during port configuration causes a nu=
ll pointer dereference during UART startup.
--

commit f142190e115d4a0b9969d2dd8bd4d9461c01f15a
Author: Myeonghun Pak <mhun512@gmail.com>

    tty: serial: meson: fix UART driver lifetime

    Moving Amlogic UART registration into probe left the first driver
    registration behind if uart_add_one_port() failed. Track whether probe
    registered the driver and undo it when port addition fails. Serialize
    the shared lifecycle decisions against parallel probe and remove
    operations.

> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_u=
art.c
> index a6cb2a535f9dc..4bd9d98268b43 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
[ ... ]
> @@ -781,9 +800,14 @@ static int meson_uart_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	ret =3D uart_add_one_port(uart_driver, port);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
where failure to map device memory during port configuration causes a null
pointer dereference during UART startup.

If devm_request_mem_region() or devm_ioremap() fails during
meson_uart_request_port() (which is called via the .config_port callback
during uart_add_one_port), the failure is silently ignored:

drivers/tty/serial/meson_uart.c:meson_uart_config_port() {
	if (flags & UART_CONFIG_TYPE) {
		port->type =3D PORT_MESON;
		meson_uart_request_port(port);
	}
}

Because port->type is unconditionally set to PORT_MESON, the serial core
believes the port is successfully configured. When user space subsequently
opens the corresponding tty device, meson_uart_startup() is invoked and
executes:

drivers/tty/serial/meson_uart.c:meson_uart_startup() {
	uart_port_lock_irqsave(port, &flags);

	val =3D readl(port->membase + AML_UART_CONTROL);
	...
}

Since port->membase is NULL, this readl() causes an immediate kernel panic =
on
device open.

Could meson_uart_config_port() be updated to only set port->type if
meson_uart_request_port() succeeds, preventing the serial core from using an
unconfigured port?

> -	if (ret)
> +	if (ret) {
>  		meson_ports[pdev->id] =3D NULL;
> +		if (registered)
> +			uart_unregister_driver(uart_driver);
> +	}
> =20
> +out_unlock:
> +	mutex_unlock(&meson_uart_mutex);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913034148.1506=
8-1-mhun512@gmail.com?part=3D1
