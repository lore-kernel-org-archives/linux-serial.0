Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC49204C31
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791611202; cv=none; b=k2X7aCpFu4kI1Tm5Y5zhq04CkrnxRYD5/ib44E5FWaH7GoM5sE+B4XrlxPDZ973OVgb0cZyocvEv//q4EPcIVB8vj1s7jt5dtT9h3rNLdAy8APCjePbbmipK0XGQFShTfOC8fNHGsZPVGLDX/LneDorSH162S2bXdvMjgEuGvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791611202; c=relaxed/simple;
	bh=Om4/SoLaVP8K6tzWILTkjaLXtFS25nFTNtQVmU5RXQI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n7WX+1q1jPheyNjGz/WYvMMN5krx+hbQpJczfZqUlBE97GrH5lGeKYgwLbnesA7e0HlOvmcQUXZG7L/8k5+v2hycA91LoDjBreUqwrt9Ennt5SWIdMG4Av6SCTnKs8PWmBh9GXsUt8hl+Cy0ZtG1+S4eFj1O6XU/gUyvRFWqU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knQzhUQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knQzhUQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D504E1F00898;
	Sat, 10 Oct 2026 05:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791611201;
	bh=InoK6OXZfAbCp2/pjHtRcmH+1Wry6rdfacpLWXYdS5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knQzhUQq1jqQMIBB6V+Wao7yGzVM6bd4PVtYBYwKaRXjR7BDWdc8kX6SZC3+fflum
	 b+zJ5X8V67RM/+bjIQwuGdLgA5C+k0wzG3DyGHBF4dm66UQHcZ8JMoAdlZtUQ5SPXp
	 sWds2bG7th9vsg/a4JgQCh8nDSK9CEVKn56kNAFb456IqJAQhSvhkunGXLQLq6VAZA
	 J+5Uo8LHUOon7/pYCFTs4ZfD/dVswf4mhW6xhNWB0AoIjjLJLoLXDRewvXX3gNmxgW
	 Etpy5wAVDEJR1HFlwbLI3o+FgesPCUVCYjh+R51hK8vxozhB3gFlCQltOkdFubRDzk
	 RAMDRSTgqS5eA==
Message-ID: <sashiko-outbox-166269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] serial: 8250: make port operations work on struct
 uart_8250_port
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <dde18b78e0988a2c45e84c13938f1521e5c8b9f9.1791524724.git.jirislaby@kernel.org>
References: <cover.1791524724.git.jirislaby@kernel.org>
 <dde18b78e0988a2c45e84c13938f1521e5c8b9f9.1791524724.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 05:46:40 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tty: NULL/ERR_PTR dereference in pci_xr17v35x_exit() on probe fail=
ure
- [High] tty: NULL pointer dereference in omap8250_irq() during device remo=
val
- [Medium] tty: cleanup mixing goto with guard(mutex) in serial8250_registe=
r_8250_port
--

commit 945c4e51972de691504f65b6a2de3089490c457d
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

serial: 8250: make port operations work on struct uart_8250_port

serial8250_register_8250_port() returns a line number and the other
port operations (serial8250_unregister_port(), serial8250_suspend_port(),
serial8250_resume_port()) accept it. Many drivers then convert the line
back to the port using serial8250_get_port() anyway.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 11424fef7c08b..6ca6b3bed80f5 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -754,16 +751,16 @@ static void serial_8250_overrun_backoff_work(struct=
 work_struct *work)
>   *	The port is then probed and if necessary the IRQ is autodetected
>   *	If this fails an error is returned.
>   *
> - *	On success the port is ready to use and the line number is returned.
> + *	On success, the port is returned as ready to use.
>   */
> -int serial8250_register_8250_port(const struct uart_8250_port *up)
> +struct uart_8250_port *serial8250_register_8250_port(const struct uart_8=
250_port *up)
>  {
>  	struct uart_8250_port *uart;
>  	bool cons_flow;
>  	int ret;
> =20
>  	if (up->port.uartclk =3D=3D 0)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
> =20
>  	guard(mutex)(&serial_mutex);
> =20
[ ... ]
> @@ -926,25 +919,23 @@ int serial8250_register_8250_port(const struct uart=
_8250_port *up)
>  		uart->overrun_backoff_time_ms =3D 0;
>  	}
> =20
> -	return ret;
> +	return uart;
> =20
>  err:
>  	uart->port.dev =3D NULL;
> -	return ret;
> +	return ERR_PTR(ret);
>  }

[Severity: Medium]
Does this code mix goto-based error handling with scope-based lock cleanup?

According to the cleanup guidelines, mixing goto-based error handling and
guard(mutex) within the same function creates confusing ownership semantics.
Since this function uses guard(mutex)(&serial_mutex), it might be better to
convert the entire function to use scope-based cleanup instead of retaining
the err label.

> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index 836792e861bfc..453e843b78ca1 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -1377,9 +1377,8 @@ static void pci_xr17v35x_exit(struct pci_dev *pcide=
v)
>  {
>  	const struct exar8250_platform *platform =3D exar_get_platform();
>  	struct exar8250 *priv =3D pci_get_drvdata(pcidev);
> -	struct uart_8250_port *port =3D serial8250_get_port(priv->line[0]);
> =20
> -	platform->unregister_gpio(port);
> +	platform->unregister_gpio(priv->uport[0]);
>  }

[Severity: High]
Could this result in a NULL or ERR_PTR dereference during unbind if the dev=
ice
probe failed for the first port?

If board->setup() fails for the first port (i=3D0) in exar_pci_probe(),
priv->uport[0] remains NULL. If serial8250_register_8250_port() fails, it
returns an ERR_PTR. In either case, the loop breaks and probe returns
success. When the device is later unbound, pci_xr17v35x_exit()
unconditionally passes priv->uport[0] to platform->unregister_gpio(),
which will dereference it without checking for validity.

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 137175aa4183a..3eb69a2f26e1f 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -628,7 +628,7 @@ static int omap_8250_dma_handle_irq(struct uart_port =
*port);
>  static irqreturn_t omap8250_irq(int irq, void *dev_id)
>  {
>  	struct omap8250_priv *priv =3D dev_id;
> -	struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +	struct uart_8250_port *up =3D priv->uport;
>  	struct uart_port *port =3D &up->port;
>  	unsigned int iir, lsr;
>  	int ret;

[ ... ]

> @@ -1624,10 +1625,10 @@ static void omap8250_remove(struct platform_devic=
e *pdev)
>  	if (err)
>  		dev_err(&pdev->dev, "Failed to resume hardware\n");
> =20
> -	up =3D serial8250_get_port(priv->line);
> +	up =3D priv->uport;
>  	omap_8250_shutdown(&up->port);
> -	serial8250_unregister_port(priv->line);
> -	priv->line =3D -ENODEV;
> +	serial8250_unregister_port(up);
> +	priv->uport =3D NULL;
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);

[Severity: High]
Does this code introduce a NULL pointer dereference if an interrupt fires
during device removal?

In omap8250_remove(), priv->uport is set to NULL after the port is
unregistered. Because the IRQ handler is managed by devm_request_irq(), it
remains active until devres cleanup runs after the remove function complete=
s.
If an interrupt fires in this window, omap8250_irq() will read priv->uport
(which is now NULL) and dereference it when accessing up->port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ef47d676a44346e058f=
29a00c8701484db722831.1791524724.git.jirislaby@kernel.org?part=3D3
