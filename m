Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FED3B2D38
	for <linux-serial@vger.kernel.org>; Wed,  9 Sep 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944249; cv=none; b=PK6wLKI8HZpEZ2mx4D1P4EpxyOqZF64Z9XL6b+sidtSKEi9aQK/5o76ENa1DFspsKu5c2a2sHRnKk63xmyTHEAxK4NeZAfxHTos47PeOhP1CV0/khwWurBWzU8ktlmaiK4Qh7+ujDByEMa9NInpKhhrSPXHcsdoV5gOBc5d76n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944249; c=relaxed/simple;
	bh=8y1srqggC7lKLfrIcrOUq23obo9JpqGo8RocPpY8Slc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKQ1CYlQ6au1FhwO8CtOOJPwcYVBPx+oxpMnETlG5CK8cdDsHKpwyqvKg2lWCEpiWk7E7C0N6UPcPF20wq5pD2qpucIm4/vxbsk5ayQTEMSiYjDZeitwFL2Xr4AP3uyexF00M2V4sS2FjF+umdT4v2jrC0BXzF+0eD/hRWlmLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJm0ojXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJm0ojXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F0F1F00A3A;
	Wed,  9 Sep 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944248;
	bh=F5W6MYLbTIZ+2HC8B89umiteYa4k70m3/W82ewwGzUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJm0ojXKW9qwZgCGusUfQxggn9ngCyfFqYoa/hgowSs/S0enlxoMxlm7HPh8+05bP
	 UMtL7/a3uYXsW147qSA/Dt02krheZA1HYVARnp4dxUggxBQdJUGqhdRgkdVoVSeCaj
	 0Fx05MPE/DeA5/o7yfVRJRm1T6hGHAA0oTD3MGGgLsAFEgQbBwcVlrWprgXxo4mbGq
	 qPDGFxMjZ/Twk2Y1zMB1zim9D1/JM47v47yJzRidfuXaE666D2OPW1ZtXQ80IW9xil
	 JPhPhPkOasiVXUU4zpezLcKAf5GSonEtGKGzjjtBrecj2MmKF9BJAz4HKLD2mlQ64/
	 TmTUToROCXUIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_bcm7271: fix use-after-free in
 brcmuart_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260909084002.686911-1-fanwu01@zju.edu.cn>
References: <20260909084002.686911-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:57:27 +0000
Message-Id: <20260909085728.24F0F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Race condition and lock corruption introduced by reordering hrtime=
r_cancel.

Pre-existing issues:
- [High] Missing hrtimer_cancel on the brcmuart_probe error path leads to a=
 use-after-free.
- [High] brcmuart_free_bufs() frees DMA buffers before the devm-managed DMA=
 IRQ is deactivated, leading to a use-after-free.
- [High] Data race on hardware registers and state flags between set_termio=
s and DMA ISR due to missing locks.
- [High] Race condition between port registration and priv->up initializati=
on causes NULL pointer dereference in the timer callback.
--

commit bdfef65a3f8fdbe1033b7dfafac9c8386120580f
Author: Fan Wu <fanwu01@zju.edu.cn>

serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()
   =20
This commit moves hrtimer_cancel() after serial8250_unregister_port() in
brcmuart_remove() to prevent a use-after-free. The goal is to shut down the
port and free its IRQ so the hrtimer cannot be re-armed before cancelling i=
t.

> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/=
8250/8250_bcm7271.c
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1121,8 +1121,8 @@ static void brcmuart_remove(struct platform_device =
*pdev)
>  	struct brcmuart_priv *priv =3D platform_get_drvdata(pdev);
> =20
>  	debugfs_remove_recursive(priv->debugfs_dir);
> -	hrtimer_cancel(&priv->hrt);
>  	serial8250_unregister_port(priv->line);
> +	hrtimer_cancel(&priv->hrt);

[Severity: High]
Does moving hrtimer_cancel() after serial8250_unregister_port() introduce a
race condition?

A pending hrtimer can start executing on another CPU, read priv->shutdown
locklessly as false, and block waiting for the port lock. Concurrently,
serial8250_unregister_port() calls serial8250_init_port(), which reinitiali=
zes
the port's spinlock using spin_lock_init().=20

If the timer callback attempts to acquire the spinlock while it is being
reinitialized, could this lead to lock corruption or deadlocks?

>  	brcmuart_free_bufs(&pdev->dev, priv);

[Severity: High]
This is a pre-existing issue, but could freeing the DMA buffers here cause a
use-after-free if the devm-managed DMA IRQ handler is still executing?

The driver requests the DMA interrupt via devm_request_irq() with IRQF_SHAR=
ED.
Devres defers freeing the IRQ until after brcmuart_remove() returns. If a
shared interrupt fires concurrently, brcmuart_isr() could process pending
status and dereference priv->rx_bufs via brcmuart_rx_buf_done_isr() after
brcmuart_free_bufs() has freed it.

>  	if (priv->dma_enabled)
>  		brcmuart_arbitration(priv, 0);
>  }


While reviewing this patch, I noticed a few pre-existing issues in related
code.

[Severity: High]
This is a pre-existing issue, but on the error path in brcmuart_probe():

drivers/tty/serial/8250/8250_bcm7271.c:brcmuart_probe() {
    ...
err1:
    serial8250_unregister_port(priv->line);
err:
    return ret;
}

If an RX timeout interrupt triggers brcmuart_handle_irq() and arms priv->hrt
after the port is registered, would failing a subsequent probe step (like a=
 DMA
IRQ request) leave the hrtimer armed?=20

The error path unregisters the port but misses hrtimer_cancel(), which could
result in the timer callback executing on freed memory once devres frees pr=
iv.


[Severity: High]
This is a pre-existing issue, but could brcmstb_set_termios() race with the
DMA ISR?

drivers/tty/serial/8250/8250_bcm7271.c:brcmstb_set_termios() {
    ...
    if (priv->dma_enabled)
        stop_rx_dma(p8250);
    ...
    if (priv->dma_enabled)
        start_rx_dma(p8250);
    ...
}

These functions modify hardware registers and update priv->rx_running witho=
ut
holding the UART port spinlock. Can a concurrent DMA interrupt execute
brcmuart_isr() on another CPU and modify these same states, corrupting the
DMA engine state?


[Severity: High]
This is a pre-existing issue, but is there a window where priv->up is used
before it is initialized?

drivers/tty/serial/8250/8250_bcm7271.c:brcmuart_probe() {
    ...
    ret =3D serial8250_register_8250_port(&up);
    ...
    priv->line =3D ret;
    new_port =3D serial8250_get_port(ret);
    priv->up =3D &new_port->port;
    ...
}

If a UART IRQ fires immediately after serial8250_register_8250_port() but
before priv->up is set, brcmuart_handle_irq() can arm the hrtimer.=20

If brcmuart_hrtimer_func() runs, it dereferences priv->up which is still NU=
LL:

drivers/tty/serial/8250/8250_bcm7271.c:brcmuart_hrtimer_func() {
    ...
    struct uart_port *p =3D priv->up;
    ...
    uart_port_lock_irqsave(p, &flags);
    ...
}

Could this cause a NULL pointer dereference crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909084002.6869=
11-1-fanwu01@zju.edu.cn?part=3D1
