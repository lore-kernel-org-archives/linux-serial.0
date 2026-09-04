Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E653976A4;
	Fri,  4 Sep 2026 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504663; cv=none; b=ESjEvS4M72T5GcdylV/6bvMK9z8DBkWugk6zBiT1vHzv8kGdZ6yIhY7bB2zdcTeuCKkvbswbYesEN99zoBiHcawoPdetsHdUfxY5Lbml/r6xX84c9wiPqqXp4oXCV+wCTZ3JbZ0VzvY4dkoy7JB69LFmvrkhyVyE3ZB2uG7UsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504663; c=relaxed/simple;
	bh=oRgvg5sVdctkhOmWOAGSADODUxFHbks5gQ/0pI3YhA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8fpogpyZmmIVtIz9iEBEJ3lGC6x9Rnh9altPFRfAhTA/W1J/eDL6xaTW6+jvALI6PMWBYehyatYDMevfyTvAUrLl1V9AQWhNctyEj752fO3o9Eq90ZbnlZtEOqp4M4BDhYboEhoC58UYsFuUtECZx3wcwwxEiQ15rCA9iwfJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn9A/nV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn9A/nV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED31F00A3E;
	Fri,  4 Sep 2026 06:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504661;
	bh=Ynqa83emspUIA3TFBV0XlqF6orPsjJj7+nwlFTdtE4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pn9A/nV6DKldYSMR1emGLcpn2KETR+6DFN58SlA78vtZRPnIzc+kYZ+7sLlLEb2Wg
	 XA7BDWKM87FXxuy3dgD8o2Z16m6a08rky5jZtNjP6+VsIECpwTLCSZiQjwWzYAEOWw
	 27HzZ8106MIx9JbIZUa8Xa9CWYIEJYWqNHqnZjfTHkasRxTcN/Zi0VDoZuWV9ML4qw
	 sMidTjOyfI6XSe/VUJ9JwHpptOs7xWlRW6Mlr+TVtf+nZ416LAuRYplW/3KdID4eij
	 EwO0q2xMrEcN5TqiusfQKCuYJkkW9mDZkYuM9gx49U/ODF+bmoE+ogQ1knRHosZPwS
	 Sde7sqalm7sQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:51:00 +0000
Message-Id: <20260904065101.17ED31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Eagerly writing to UART_IER in the startup callback prematurely en=
ables RX interrupts and races with the console lock.

Pre-existing issues:
- [High] Calling pm_runtime_enable() after port registration creates a circ=
ular wait during device probe.
--

commit 75b385eb3bd4a7c612101e72e64ed9ec2244f1eb
Author: Long Zhao <longzhao@ambarella.com>

serial: 8250_dw: add Ambarella CV75 quirks

This patch adds quirk support for the Ambarella CV75 UART to the 8250_dw
driver, reusing existing APB UART functionality while skipping the baud rate
setup and keeping specific IER bits enabled.

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c

[ ... ]

> @@ -572,6 +576,27 @@ static void dw8250_prepare_rx_dma(struct uart_8250_p=
ort *p)
>  	dw8250_writel_ext(up, RZN1_UART_RDMACR, val);
>  }
> =20
> +static int dw8250_ier_mask_startup(struct uart_port *p)
> +{
> +	struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up =3D up_to_u8250p(p);
> +	int ret;
> +
> +	ret =3D serial8250_do_startup(p);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Ambarella keeps variant IER bits (e.g. ETOI) set for correct RX
> +	 * timeout behaviour. Force them into the 8250 IER shadow so later
> +	 * generic IER updates do not clear them.
> +	 */
> +	up->ier |=3D d->pdata->ier_mask;
> +	serial_port_out(p, UART_IER, up->ier);

[Severity: High]
Does this eager write to UART_IER race with the console lock or risk causing
an interrupt storm?

When serial8250_do_startup() executes, it explicitly defers hardware interr=
upt
enablement by only updating the up->ier shadow. By immediately calling
serial_port_out() here without holding the port lock, this could prematurely
enable RX interrupts before FIFOs are fully configured, potentially swamping
the interrupt handler. It also risks data races with concurrent console wri=
tes
that read, clear, and restore UART_IER under the port lock.

Would it be safer to only update the shadow up->ier here, and allow
set_termios() to commit the final value to hardware later under the proper
lock?

> +
> +	return 0;
> +}

[ ... ]

> @@ -889,6 +922,7 @@ static const struct dw8250_platform_data dw8250_ultra=
risc_dp1000_data =3D {
>  };
> =20
>  static const struct of_device_id dw8250_of_match[] =3D {
> +	{ .compatible =3D "ambarella,cv75-uart", .data =3D &dw8250_ambarella_cv=
75_data },

[Severity: High]
This is a pre-existing issue, but does adding this new device expose it to a
deadlock during device probe?

Looking at dw8250_probe(), pm_runtime_enable() is called after the port
is registered:

dw8250_probe() {
    ...
    data->data.line =3D serial8250_register_8250_port(up);
    ...
    pm_runtime_enable(dev);
}

During port registration, uart_add_one_port() can synchronously invoke the =
pm
callback (dw8250_do_pm). Since dw8250_do_pm() uses pm_runtime_get_sync(),
calling it before runtime PM is enabled will hang the worker threads waiting
for operations on an uninitialized device.

Could pm_runtime_enable() be moved before serial8250_register_8250_port() in
dw8250_probe() to prevent this circular wait?

>  	{ .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
>  	{ .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_octeon_3=
860_data },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D11
