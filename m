Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E1481658
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395825; cv=none; b=QT0MpAgqWO5lpW74RQd5JYEqg5eDaPTSYAZ3geFuip8YSX/WVtPCz+1WVQziXd9VfWSCyqrPt+H1HSF5lKR/A0Q2mWjjrC6TAWTXahjoyksvE/qSwAsKRc02VMRFbo1AwrfXm9P7/auU7K0Id++0ZQNvZq1EFlnsDhTHL3VdAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395825; c=relaxed/simple;
	bh=EoMARskPCopbvZHJnhVyIMzwoQAKZ1A5NQcJ8VOn5jY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGlLpWfxO2XA5lAncd2ch08aBFf2dwP/3V0awbpKFZ/qGmx6rivVzQ2yf172EopUtuXvvXoSiB/sk9I1bsW3Z8kHCQk6mUo168qlDxnhNJ4xM0aaUGWIekYt5GtnAp5n3F0sXdIVXGKcsb6CffY2zAWKhKsBuisy9DD4Jkkkbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3wDrPPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3wDrPPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3B41F00898;
	Mon, 14 Sep 2026 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395823;
	bh=wahCMM9aIvQcE4A4x5AFljsywqZbVmpFW+NbFTEhMG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3wDrPPJP3J1TTajR/qKbRnprkCJ1788hymKMKaqm3D36/960h4ob6n7dqRHW+i3R
	 9N8YETZO0l0HH7SD2z8ee49rHlOZ4m0DDS8eTGiJmU+F1RuFd4O0T+GVVkxVnAV1X7
	 9g5hOMEahJrd1S2GtQLCd3X4h/2GopL7z2QQLE223KiJMxgnF8phej17R98+cVDHkl
	 VwgYCjwiKpV/gyoCXuSIMHF6JZ7qNeD0+0fXK+fwpROmRC/Sv4hI1vo/rgQEn8Zr/W
	 ZmeZQOCAlaIz31iq4CGvKRYRwmtkmEqPgvSesjwpglRpKT4936ieO0ap4+bmXhnES0
	 XiEHDpmVUi+pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next] serial: core: fix NULL/dangling port_dev on
 failed re-register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaosheng Cui" <cuigaosheng1@huawei.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260914135154.3260303-1-cuigaosheng1@huawei.com>
References: <20260914135154.3260303-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:23:42 +0000
Message-Id: <20260914142343.1A3B41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsafe state clearing in error path causes data race and resource =
leak on double-registration
--

commit 18ff022090858881e0c42eddefd1a71c7ed91334
Author: Cui GaoSheng <cuigaosheng1@huawei.com>

serial: core: fix NULL/dangling port_dev on failed re-register

Fixes a general protection fault in the serial unregister path by explicitly
clearing port->port_dev and bailing out if it is NULL. It also clears the
UART port slot in the driver state upon registration failure.

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 95774b0f1484b..62d93c5964e25 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3358,6 +3358,17 @@ int serial_core_register_port(struct uart_driver *=
drv, struct uart_port *port)
> =20
>  err_unregister_port_dev:
>  	serial_base_port_device_remove(port->port_dev);
> +	/*
> +	 * serial_base_port_device_remove() dropped the last reference to the
> +	 * port device, so leave no dangling ->port_dev behind. Restore the
> +	 * state slot to the same "not registered" state that
> +	 * serial_core_remove_one_port() produces on the normal path; the
> +	 * line range guard also covers the -EINVAL exit of
> +	 * serial_core_add_one_port() where line >=3D drv->nr.
> +	 */
> +	port->port_dev =3D NULL;
> +	if (port->line < drv->nr && drv->state[port->line].uart_port =3D=3D por=
t)
> +		drv->state[port->line].uart_port =3D NULL;

[Severity: High]
Can this error path clobber an active registration if a driver incorrectly
attempts to register an already-registered port?

If a driver double-registers the same port, serial_core_add_one_port() will
fail and return -EINVAL because state->uart_port is already set. The error
path here then evaluates drv->state[port->line].uart_port =3D=3D port as tr=
ue
due to the original successful registration.=20

Does this forcibly clear drv->state[port->line].uart_port without acquiring
the required port->mutex, creating a data race and destroying the state of
the active registration?=20

When the driver later calls uart_remove_one_port(), will it return early
because uart_port is NULL, potentially leaking tty devices, sysfs nodes,
and memory allocations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914135154.3260=
303-1-cuigaosheng1@huawei.com?part=3D1
