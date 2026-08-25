Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454748D882
	for <linux-serial@vger.kernel.org>; Tue, 25 Aug 2026 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696241; cv=none; b=qRC5cJH4p7ddm9DkXo858BZ+IA7KLRndSl0pM7ks+4u2q5m54YJy6vnwxLa9qkc+ftGMm+TQU7Moon5BxKX4vxLyjHIAxofGmVtiu5mQUc92j8QTWqIu55UJpFECPZeFOXaqhMPe6RJJB/Ix8e0BWLbb3PgxQ2M2UnKfp4rYKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696241; c=relaxed/simple;
	bh=fkDuswExWO8mmU84d6EWs9awb3zXqfD7eI8k7Qyes9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LEiDf5rzUHp2gUG7Utr2WwAV+l1mVQmRCcYFfV2ogjhYFSHJAFtpS9qyUSBM3WbYXSc43JLk2w9Zs6CAvgVtDTWLJ5sdCdQv3LJsBl9ZBds5GtYWo/qFmerTPgh1/xvDbmqYQxjl80XHcLwP2hDnoXFtxM9Paq/Jx5yTjJMpYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue7oN43S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue7oN43S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9293A1F000E9;
	Tue, 25 Aug 2026 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787696239;
	bh=4CW6yOcKba6mq0k1UXi72DpGNicVNjDQqcHqQRqZano=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ue7oN43St1OEKq5vYtvLV3zfMZJoznCs5kYIXXY89cB9GiGbCrLtMu1SkL7QgYMJ9
	 KpHlyPr7aU+PaV2O2snP19HJF7fxfHDCHFnQrURF6Irpzk7e8zqJ82Tzt+vsDveJYJ
	 GFQ1xZBmmfnBA9+biRtf46zzTr4IYZqf07VRI1e7YrcqmKcRZrXvNfhLEJLqhPBcCG
	 NsOYRzVG4kuC5dCNl3vaFc90jnGjXy92i75huqMpDmXdDEox+Qy06JdyXnfzKOWAbA
	 m7sDyswTPYkjKHeJWEegdWrLmM49VNs8uUhOeMhFQAgRQ3WMP/UeR2S+Uzby2Xbk0R
	 WSb+nFJJLAC4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250_omap: fix wake irq cleared during
 suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com>
References: <20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 22:17:19 +0000
Message-Id: <20260825221719.9293A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The IRQ handler `omap8250_irq()` calls `pm_runtime_get_noresume()`=
 and subsequently accesses hardware registers without checking if the devic=
e is active.
- [High] `omap8250_remove()` ignores the failure of `pm_runtime_resume_and_=
get()`, leading to hardware access on a suspended device and unbalanced run=
time PM usage counters.
- [High] Unchecked return value of `pm_runtime_get_sync()` leads to potenti=
ally unsafe hardware access in `omap8250_probe()`.
--

commit bc6e22f3c6331f4f33e45d32f550a8d1ce7dad46
Author: Kendall Willis <k-willis@ti.com>

serial: 8250_omap: fix wake irq cleared during suspend

This commit moves the wake irq setup from omap_8250_startup() to
omap8250_probe() and teardown from omap_8250_shutdown() to omap8250_remove(=
).
This ensures the wake irq remains armed during the suspend sequence when the
UART is acting as a wakeup source.

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c

[ ... ]

> @@ -1588,6 +1581,12 @@ static int omap8250_probe(struct platform_device *=
pdev)
> =20
>  	priv->wakeirq =3D irq_of_parse_and_map(np, 1);
> =20
> +	if (priv->wakeirq) {
> +		ret =3D dev_pm_set_dedicated_wake_irq(&pdev->dev, priv->wakeirq);
> +		if (ret)
> +			goto err;
> +	}
> +
>  	ret =3D serial8250_register_8250_port(&up);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "unable to register 8250 port\n");
> @@ -1603,6 +1602,7 @@ static int omap8250_probe(struct platform_device *p=
dev)
> =20
>  	return 0;
>  err:
> +	dev_pm_clear_wake_irq(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but I noticed an unchecked return value earli=
er
in omap8250_probe():

drivers/tty/serial/8250/8250_omap.c:omap8250_probe() {
    ...
    pm_runtime_get_sync(&pdev->dev);
    omap_serial_fill_features_erratas(&up, priv);
    ...
}

Does this risk a bus fault if pm_runtime_get_sync() fails? If the device
fails to resume due to PM domain issues, omap_serial_fill_features_erratas()
will proceed to perform readl operations on the unclocked UART memory space.

>  	flush_work(&priv->qos_work);
> @@ -1625,6 +1625,7 @@ static void omap8250_remove(struct platform_device =
*pdev)
>  	omap_8250_shutdown(&up->port);
>  	serial8250_unregister_port(priv->line);
>  	priv->line =3D -ENODEV;
> +	dev_pm_clear_wake_irq(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
>  	flush_work(&priv->qos_work);

[Severity: High]
This is a pre-existing issue, but is it safe to proceed with hardware teard=
own
if we fail to resume the device in omap8250_remove()?

drivers/tty/serial/8250/8250_omap.c:omap8250_remove() {
    ...
    err =3D pm_runtime_resume_and_get(&pdev->dev);
    if (err)
        dev_err(&pdev->dev, "Failed to resume hardware\n");

    up =3D serial8250_get_port(priv->line);
    omap_8250_shutdown(&up->port);
    ...
}

Executing omap_8250_shutdown() on an unclocked device could cause a bus fau=
lt.

Additionally, unconditionally calling pm_runtime_put_sync() at the end of
omap8250_remove() after a failed pm_runtime_resume_and_get() might cause the
usage counter to underflow.

[Severity: High]
This is another pre-existing issue, but is there a risk of invalid hardware
access in the interrupt handler?

drivers/tty/serial/8250/8250_omap.c:omap8250_irq() {
    ...
    pm_runtime_get_noresume(port->dev);
    ...
    lsr =3D serial_port_in(port, UART_LSR);
    ...
}

If the interrupt fires while the device is in a runtime-suspended state (for
instance, via a shared line or spurious interrupt), pm_runtime_get_noresume=
()
increments the usage counter but does not wake the device. Could the
unconditional read of UART_LSR result in invalid register reads returning
0xffffffff on unclocked hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-uart-wakei=
rq-fix-v2-1-0b9fba03d9b6@ti.com?part=3D1
