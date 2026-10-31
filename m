Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466984;
	b=AnKsamNqZu/in0SlhJlyUIJStL3ks8EA6LTy9dGFNF063Ccg1uddLvpJKnEzBfK6Drja
	 vXco+xt07E3KN5mGX3eUl/UMRgNB4nhvMHfjNxOn+t39fI7+Od37K4qfvbNneR9AkK2KA
	 Zr3X5Ak/cph92vfZBaDx0+cLHpRH3Yo1MiT6UncnTqt8cmR625UdH0n6rJxnNTAmSfs2T
	 CAkRUNsrZosWOjhHBrmKR9nW84hIdh4nNCaXTbsOUW6OjX85+GvEhD+W1dfI0lYn012FW
	 NPpTR297qhd5NOf49BRz/zuI9zlf/CBkhQ1BrS0VJGUankqhGmnt/qtloOvVMV7oCaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466984;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cyely+UG+JVJubIQkMJv8Gxwvtxt74dmlL2ZhLevSKY=;
	b=TnK4LCGE2GoE+C19fbBt00OLX74gmtFAZLNWUNvbChyggniwGzUhi5I/oCr4q/cMR0Pw
	 df0RLTWzOcWFsbWYh2k2knspUArIL1EhukcSjsxIPaKyz52z+IfXPdz2SmUlfWx7c9UUn
	 1FLFGV4ne8BqDLsjAprUrSUWAMJvf2q1DYi2SEHwvHp2vvaQFgPQGsb7V9kynGFmm2ce/
	 e1LcyQEITYmxLt/S9JZm1bxgfKC0CyKjMDkJg2laWCit+faxHNRiO4IqXcN3xQWWy4/JM
	 T+Y+hj0L+/tn1rGum13VVUNs56xUMaZY4YrPaA8XYFsIC83zkOmaldCjw72YhhLY75A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKOnUOrZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EA606A324
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKOnUOrZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2672E1F00A16;
	Sat, 31 Oct 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466984;
	bh=cyely+UG+JVJubIQkMJv8Gxwvtxt74dmlL2ZhLevSKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKOnUOrZ78mWUxF1+s0EsNrcbS5bFAEcWjslM6GH4yrPaNUBUygdquUfg66WmMQRn
	 naVqC/bjIjRcSxe1JDbEIPFoPZ3009jHYquOGjgTbIHT7H8rKxw6EI8c0WNiMaQTLG
	 tnNGC42u+yJDnuuzshoGUepA4/q7MTk2Hu6JKD3F3L9lV0JH2D8T/b/uXGL7y84g19
	 95zM6sVX0cPOmyvxO8SG3lMtoM60on+8E+W0kGl+JqFdKi3Bd9DjkLaseD5Gkfy40L
	 1rcdRZIAt+t5Y7iRNMV7eS90VPjkE1vD+OLnd+xFb4pZnMV0DTDe+a6Bw1OdjdYY8T
	 R76eDqavJgr3Q==
Message-ID: <sashiko-outbox-192058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] serial: 8250_omap: remove redunant
 pm_runtime_dont_use_autosuspend() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Crofts" <crofts@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-1-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
 <20261031-tty-dont-use-autosuspend-removal-v1-1-7bdadcadc4dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:16:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: 8250_omap: broken runtime suspend in probe error and omap8=
250_remove()
--

commit 651c75542e46afc26bfbf0ef6592eb505fec5ccc
Author: Joshua Crofts <crofts@kernel.org>

serial: 8250_omap: remove redunant pm_runtime_dont_use_autosuspend() calls

This commit removes the explicit pm_runtime_dont_use_autosuspend() calls
from the error path in omap8250_probe() and from omap8250_remove(),
relying on pm_runtime_reinit() in the driver core to clean up autosuspend
state after driver exit.

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 29a203ed93fd8..5d6911b1a2b00 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1608,7 +1608,6 @@ static int omap8250_probe(struct platform_device *p=
dev)
>  	return 0;
>  err:
>  	dev_pm_clear_wake_irq(&pdev->dev);
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
>  	flush_work(&priv->qos_work);
>  	pm_runtime_disable(&pdev->dev);
> @@ -1631,7 +1630,6 @@ static void omap8250_remove(struct platform_device =
*pdev)
>  	serial8250_unregister_port(up);
>  	priv->uport =3D NULL;
>  	dev_pm_clear_wake_irq(&pdev->dev);
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
>  	flush_work(&priv->qos_work);
>  	pm_runtime_disable(&pdev->dev);

[Severity: High]
Does removing pm_runtime_dont_use_autosuspend() before
pm_runtime_put_sync() and pm_runtime_disable() here prevent the device
from runtime suspending on probe failure and in omap8250_remove()?

In omap8250_probe(), the driver enables autosuspend and sets a negative
autosuspend delay when no serdev child nodes are present:

	pm_runtime_enable(&pdev->dev);
	pm_runtime_use_autosuspend(&pdev->dev);
	...
	if (!of_get_available_child_count(pdev->dev.of_node))
		pm_runtime_set_autosuspend_delay(&pdev->dev, -1);

	pm_runtime_get_sync(&pdev->dev);

When power.use_autosuspend is set and power.autosuspend_delay is negative,
update_autosuspend() increments dev->power.usage_count to prevent runtime
suspend. Together with pm_runtime_get_sync() in omap8250_probe() (or
pm_runtime_resume_and_get() in omap8250_remove()), usage_count is 2 when
reaching the teardown path.

Without calling pm_runtime_dont_use_autosuspend(&pdev->dev) first,
pm_runtime_put_sync(&pdev->dev) only drops usage_count from 2 to 1 (or, if
autosuspend_delay is non-negative, schedules the autosuspend timer via
rpm_idle() -> rpm_suspend(dev, RPM_GET_PUT | RPM_AUTO) instead of
synchronously suspending).

The subsequent pm_runtime_disable(&pdev->dev) then cancels any pending
timer and disables runtime PM while the device is still active, without
running omap8250_runtime_suspend() or the PM domain runtime_suspend
callbacks. When the driver core later runs device_unbind_cleanup() ->
pm_runtime_reinit(), runtime PM is already disabled, so pm_runtime_reinit()
only forces the software state to RPM_SUSPENDED via
pm_runtime_set_suspended() and clears use_autosuspend without suspending
the hardware.

On omap_device platforms, leaving the hardware enabled across a failed
probe (such as -EPROBE_DEFER) or driver unbind also causes the next probe
to fail in omap_device_enable() with -EINVAL because the omap_device is
still in OMAP_DEVICE_STATE_ENABLED, which appears to reintroduce the
regression previously fixed by commit 4e0f5cc65098 ("serial: 8250_omap:
Fixdevicealreadyenabled wait loop on deferred probe").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-tty-dont-u=
se-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org?part=3D1
