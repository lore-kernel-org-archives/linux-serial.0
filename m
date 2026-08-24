Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A813FDBE8
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589695; cv=none; b=M9vWY8LX+S4DPMaj+A1akwWz9SEpmDhXVERSelmKTcZAIqZ3bYdx9I+m1gR7HOgDtfUHJcbv9tffNPPyPF6URDq/p2zQS1TJBwjU/YlUZ/0f+IjounIH9OfpZOmCeUMDQ/qL4n/Jn7hD84ZifAaFrZGmvnBM/i+Bz1BevE83g9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589695; c=relaxed/simple;
	bh=blXji3OfJSvmpU/cuWlA2ugkq8zFGDp2blqRXj9hTwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YwOsEUbk7CUCkT964aLAfmszw5m0f65GNTeEOJ9DQMmCPWjrdEN0QNO/WGRa3M7bIAkAfL8SITixXh7K22FyCjBH7RDTVoNPTn/PjvFZa659dWdX5KCidilgJGdKAUPO6TdmdbQF5XqVrbMRki+mWxN1xbG/FsBJA7lfGsdTNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A76cGG/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A76cGG/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68561F000E9;
	Mon, 24 Aug 2026 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589693;
	bh=Iz9b6HtC1enPSyGXMKX9gTZF6eMSDDc551C3IbgB6k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A76cGG/ZSBwMLmpI69Ex6UVOX1MiJEgBy/kBIUqOOs6H/WzWXOiPATHbxIQ2nOvg6
	 otuh56cZPGsrb1AnWtElP5YLwG+8jPZAy/AOuozDkGboq7of/uJdcVvxvO3fbhGVKd
	 c5AXiwFymdWc+BGAqoFvI5x7jg7uyuuTWaeCTExC91uo3EANYE8Xs0UKIR+EbCLGVa
	 oL3yS6oZuQDMVXsuXVzRShjmUIPI4vSGOr/3kGwlVb+rOYXjdn1M8chreCkqMRZ5ye
	 PO5O6d+7V11uGygzeMx0LPEy2VUv5S2R4ji+Z7oEiVG2SlsgY774ekgUYUXYHlDPFa
	 /Jo8cJOQeftGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix wake irq cleared during suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kendall Willis" <k-willis@ti.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com>
References: <20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 16:41:33 +0000
Message-Id: <20260824164133.A68561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Calling `dev_pm_clear_wake_irq()` after `pm_runtime_put_sync()` =
in the teardown paths creates a race window that can leave the device perma=
nently active.

Pre-existing issues:
- [High] Invalid hardware access via `pm_runtime_get_noresume()` in the IRQ=
 handler allows access to powered-off hardware.
--

--- Patch [1]: [PATCH] serial: 8250_omap: fix wake irq cleared during suspe=
nd ---
commit 69c0ce16c163036cdb1ba2600546648c535da1c2
Author: Kendall Willis <k-willis@ti.com>

serial: 8250_omap: fix wake irq cleared during suspend
   =20
The wake irq was cleared in shutdown(), which runs during the suspend
sequence, making it impossible to wake the system via UART. Move wake
irq setup to probe() and teardown to remove() so the irq remains armed
during suspend when the UART is a wakeup source.

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/825=
0/8250_omap.c
> index 3c7775df27eff..9cc88d2c510ce 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c

[ ... ]

> @@ -1608,6 +1607,7 @@ static int omap8250_probe(struct platform_device *p=
dev)
>  	flush_work(&priv->qos_work);
>  	pm_runtime_disable(&pdev->dev);
>  	cpu_latency_qos_remove_request(&priv->pm_qos_request);
> +	dev_pm_clear_wake_irq(&pdev->dev);

[Severity: Medium]
Does calling dev_pm_clear_wake_irq() after pm_runtime_put_sync() create a
race condition?

When pm_runtime_put_sync() synchronously suspends the device earlier in the
cleanup path, the PM core enables the wake IRQ. If the wake IRQ fires before
dev_pm_clear_wake_irq() can disable it, the threaded handler may call
pm_runtime_resume().

The subsequent pm_runtime_disable() will then wait for the resume to finish,
leaving the device permanently locked in the RPM_ACTIVE state.

>  	return ret;
>  }
> =20
> @@ -1630,6 +1630,7 @@ static void omap8250_remove(struct platform_device =
*pdev)
>  	flush_work(&priv->qos_work);
>  	pm_runtime_disable(&pdev->dev);
>  	cpu_latency_qos_remove_request(&priv->pm_qos_request);
> +	dev_pm_clear_wake_irq(&pdev->dev);

[Severity: Medium]
Could this teardown order leave the device permanently active here as well?

Similarly to the probe error path above, calling dev_pm_clear_wake_irq()
after pm_runtime_put_sync() opens a window where a wake IRQ could cause the
device to resume.

The pm_runtime_disable() would then wait for the resume to finish, locking
the device in RPM_ACTIVE.

>  	device_set_wakeup_capable(&pdev->dev, false);
>  }

[Severity: High]
This is a pre-existing issue, but does using pm_runtime_get_noresume() in
the interrupt handler allow access to powered-off hardware?

Looking at omap8250_irq() in drivers/tty/serial/8250/8250_omap.c:

omap8250_irq() {
	pm_runtime_get_noresume(port->dev);

	/* Shallow idle state wake-up to an IO interrupt? */
	...
	lsr =3D serial_port_in(port, UART_LSR);
	iir =3D serial_port_in(port, UART_IIR);
	...
}

pm_runtime_get_noresume() only increments the usage counter but does not
initiate a resume or check the runtime status.

If the IO interrupt fires while the device is in a shallow idle state, the
code may proceed to read registers while the hardware is suspended or has
lost context.

Should this use pm_runtime_get_if_active() to verify the device is actually
active before accessing hardware registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-uart-wakei=
rq-fix-v1-1-6d81a230a1c4@ti.com?part=3D1
