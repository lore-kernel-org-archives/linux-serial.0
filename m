Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467716;
	b=wLJPKDPwqHwKdN9HlQu3WaZQ1pR0UQY9Ox9fkmSPhxJ0wdoCyOuA1WzvF85Kpz74gOn9
	 wqtelV+dd6JUF3p1u+omcr98m0p2CkwGQO6yvzusfpSL1/vyBNbsgjyRPA/+Q6gDaMKOx
	 c1dAE6pirlJbyp26HPB4lgSEwjeBGpQZsMNCx8cnfS/IEW+gKHc0q8gswHYMH2YYxJuyL
	 vWcnNJcKVxaTeYe8Y0nH1qpE2KNBt9+WQkbF5UHDfStDeDXZO/co77NULkE0jAeuLrKp8
	 tiivXIX9UXWNjv17VHMb31o6LTG6GVI+DGPpHbTAuG9JmzFNxNIWodap+7C7kx7m5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tDJ4Tn4yWet0Xg28r+d5fKnmwTF28Ble8rJOhBR+E9o=;
	b=pncAbeyJmafoST4u7gLp71owatkstFA/jekdjPGNVOw8QN6ByJwvvCue5KnkyJWA9wLg
	 I3uVT6hFENZL5gbVbTtctiHcGEtBkKEsdUCuSCvEQM1vrkYG162LOcbl0XhXF1oFUCiRQ
	 GuQ5cEwR77o9QRf7uNcL3kYQYXNIIcAnZ/EuTlyh/5cD65ICeQFM3al/LLm/HA+Q8d+Mg
	 y7h6tTGPEO+MxpAhDgsFC5S48OWGBvkvI6W/EDOH7xR15TyWw9XWNchTAXAj3FJJIhy6/
	 r9qJMCwybHjqXvXeqP4mRlh11/cl15tz/T5EbtHZ+e4qFCcZsBgVIkXFZKhnWGf+Izw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOZV0Ids;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3984606A333
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOZV0Ids
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1355D1F00A07;
	Thu, 12 Nov 2026 07:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467716;
	bh=tDJ4Tn4yWet0Xg28r+d5fKnmwTF28Ble8rJOhBR+E9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOZV0IdsbUJdOQq7Sb1L88UJciI4uV8nysGogSgZcDcmoMokeZ8KjQ/My9X8C5sa+
	 zpnMWynwvrOV1RPUsa+2bB79iwUQ1c1py3Ad+dsfipbIBjtPb7KyZ+vCFb6vYmwY1n
	 hmnsvF7LgtuxJF79Ih8lebm2JW+zMmNvMwd2Z3Td9fynz8/qURYtiyvY6fOKCnBI+S
	 E26SWoqoOs0wk6hvizd044drVTkb6/iHLmksqFcgCGBC+hbFs+CO7VpHlN1HVeWIrA
	 QSBP4kG9VGX3Xx7ZAes4LlAQmh4XmMydXnzmikEePULV0GGBermgCRYRbGQ5a9dv2G
	 cZ3XT+mw5pWeA==
Message-ID: <sashiko-outbox-210574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: shut down the unthrottle
 timer on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112070357.38870-1-mhun512@gmail.com>
References: <20261112070357.38870-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:15:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] serial: 8250: use-after-free and port leaks on probe error
  paths [1]
--

commit afd3348a7cc94ca4f33ad325f21afb53b427217e
Author: Myeonghun Pak <mhun512@gmail.com>

serial: 8250_aspeed_vuart: shut down the unthrottle timer on removal

This commit replaces timer_delete_sync() with timer_shutdown_sync() in
aspeed_vuart_remove() to prevent unthrottle_timer from being re-armed by
an interrupt before the port is unregistered.

> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/se=
rial/8250/8250_aspeed_vuart.c
> index 452bef82bec2a..0776675b83823 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -552,7 +552,7 @@ static void aspeed_vuart_remove(struct platform_devic=
e *pdev)
>  {
>  	struct aspeed_vuart *vuart =3D platform_get_drvdata(pdev);
> =20
> -	timer_delete_sync(&vuart->unthrottle_timer);
> +	timer_shutdown_sync(&vuart->unthrottle_timer);
>  	aspeed_vuart_set_enabled(vuart, false);
>  	serial8250_unregister_port(vuart->port);
>  	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);

[Severity: Critical]
This problem wasn't introduced by this patch, but does the error path in
aspeed_vuart_probe() leave the port registered [1] and cause a
use-after-free of vuart?

drivers/tty/serial/8250/8250_aspeed_vuart.c:aspeed_vuart_probe() {
	...
	struct uart_8250_port *uport =3D serial8250_register_8250_port(&port);
	if (IS_ERR(uport)) {
		rc =3D PTR_ERR(uport);
		goto err_sysfs_remove;
	}
	...
	rc =3D aspeed_vuart_set_lpc_address(vuart, prop);
	if (rc < 0) {
		dev_err_probe(dev, rc, "invalid value in aspeed,lpc-io-reg property\n");
		goto err_sysfs_remove;
	}
	...
err_sysfs_remove:
	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
	return rc;
}

When aspeed_vuart_set_lpc_address() or a later step fails after
serial8250_register_8250_port(), err_sysfs_remove returns without calling
serial8250_unregister_port().  The driver core then frees the
devm-allocated vuart while the 8250 core still holds port.private_data
pointing to it, so a later interrupt or TTY access dereferences freed
memory.

[1] https://sashiko.dev/#/bug/linux-99bf5468-4b0d-497a-8419-674f926b3cdb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112070357.3887=
0-1-mhun512@gmail.com?part=3D1
