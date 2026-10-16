Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66648DB40
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174523; cv=none; b=RXhyGgJDmJvvlHKf7+8Wfu+UQJy9zK6oExDGRPdKabniabs62bin58VXzC8RbCatHxq1XqLIr+LcanP0EeAa2ATkX7w9EZqhl2XG6bV53Ve0JVwoXLLOuYAvsEIWNFWlr0EHInSElgwAQqEYM7G0h0NZmBWB1X+1EfHg6XEIrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174523; c=relaxed/simple;
	bh=hchKh6goO3RpNhXIv+sgHzxDH//PRspMGKGxwrOxHXQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=npe73FYG9HIVmj1IQswn2b32thMXDbyVkOffcPcAiUImdpSrruSAhlIVKYi2qE1lnWLa8332mk7Me/ihLvvqmvXTR4U+nCaOE6Q7QOfESKmq6HcLh43gJeDBfBqhaI2H3MM1DYJBmXflOk4EUg1wEtPpSvr/dTa1GQrlBiDRN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM5N6kQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM5N6kQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382CB1F000C4;
	Fri, 16 Oct 2026 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174521;
	bh=oSDXHW7Cclw6abPZUMV5hE6+VgnN57rsqABzvZ3KfxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dM5N6kQl+bjdmv+G5hrMZ6MOTvYFEQ3uhvc2RiSklDaCum7EGKO7dpO50GBn9xeH/
	 dSxn68TS4U89JNIvPLyDPM2Y4W+hi1tYUQxpBn9qtz5NhvOk9FO2Gp5NUvBAHZ/YNY
	 UCZSTJj2275xQI2bbYBHyoklDRV/BP2YDb+kP6tjRnoSDLMynyx951TMUMpyZy8Plh
	 C5kV2jEPa/G1RZopLRS5beIxuBMh1AUWLsUJkcBF+80QGDCZcTc5L/JtRTzf5bJAsH
	 qLlp3xV6LHV/xOVu7+4oJ10M1895SoKXeQTNSnAgV9O+oO/uXyTXWyL+9v2t/MORO6
	 RTk7xU46rvW2w==
Message-ID: <sashiko-outbox-174757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] tty: serdev: Add mutex lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>
References: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
 <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:15:20 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pm: async pm_runtime_put() in remove path cancelled by pm_runtim=
e_disable()
--

commit c4731a25fb19c22b675757b565d963b9ad0190e8
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Add mutex lock

Besides more predictable behaviour, this allows for several hardened
behaviour changes. If the device is left open by the driver after remove,
close it and warn instead of leaving it in an invalid state.

> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc218..77e8e1d4d2a66 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -142,6 +142,11 @@ void serdev_device_remove(struct serdev_device *serd=
ev)
>  	struct serdev_controller *ctrl =3D serdev->ctrl;
> =20
>  	device_unregister(&serdev->dev);
> +
> +	/* Warn if driver did not close the serial device. */
> +	if (ctrl->ops->close && WARN_ON(ctrl->ops->close(ctrl)))
> +		pm_runtime_put(&ctrl->dev);

[Severity: Medium]
When this path is reached during controller teardown, will the pending
asynchronous suspend work be cancelled?

In serdev_controller_remove(), device_for_each_child() synchronously invokes
the removal, and then immediately calls pm_runtime_disable(&ctrl->dev):

serdev_controller_remove() {
	...
	device_for_each_child(&ctrl->dev, NULL, serdev_remove_device);
	pm_runtime_disable(&ctrl->dev);
	device_del(&ctrl->dev);
}

Since pm_runtime_disable() cancels pending asynchronous idle and suspend wo=
rk,
calling pm_runtime_put() here instead of pm_runtime_put_sync() can prevent =
the
hardware from actually suspending, leaving the controller powered on indefi=
nitely.

Could pm_runtime_put_sync() be used here instead to ensure the device is
properly suspended before pm_runtime_disable() is called?

> +
>  	ctrl->serdev =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_remove);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_serde=
v_probe_refactor-v4-0-46832e034757@posteo.de?part=3D1
