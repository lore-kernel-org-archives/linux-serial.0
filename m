Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1394D9F7C
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361189; cv=none; b=KHuak2qt5LeELr/jy2/wi1t8VfN4AnLZWtjUSdtWT1qGV5lV1H/G2BBKNuOoPXgJcTx5D6hryywz6g/vS8XL8hS8fbM0TZub77mGNLHvoDSQXUcEOvYtuuhS69M64Kag6Gq3G0S+c2QWQCO58fcKQXbaEPchYIvmtJJMa3qsaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361189; c=relaxed/simple;
	bh=v9zsPHCFStog0RwwWTolBAQAx0G/ToKYIAmQJthP+jI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FrV3toUDxB8tVCrG9BVgtG8vJClSAZP3me16hEm51T6RXk67/IptEQFMT2nJ75dKwFH/UqBgmUPclC1jqt9fjGB2qb/8hJSdJ8cVNOt3wAkL6JeCmJqNSfm5WkM+bUvc2JNnpAVVb57UkAT7j23s+zh5NbjtS2tTYq0a48xSvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkkXvAWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkkXvAWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8961F00893;
	Fri, 25 Sep 2026 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361187;
	bh=ioTN862p/8n3uMuig0ZWIv+F2z7J3FrgNEa/DiD2z7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkkXvAWjwUNV4KTez9QVrShJanWC+YQw3r34+XvqKrOdvLdZ0hf8oFXZEJznDjmQ/
	 g5U2F3B5lkkGpVeTwcmOWX6dLo/NA/a+Cq2/CoIHmpP6Tc+7hF3GyCqTGdoZ3S2KLI
	 FWp8BAVQs1SMsxI67ukDgmflcWI85VsdDBeiRoxE/p1tLia+n9xIqykmrGApuph6b9
	 ubdoZmAOQC9TdF0dDtqEwJ9M6EAlukxnxeMA8hU4Q2FHoSt6HTQMaoR9MP5h9Xy2cY
	 HA6qc4hefED3pqxGYr7hePVX7z13UrNrWY5gQVjkKoaqh1LUYPNilrijx9ASUe/JIs
	 BMvbsTTVlrCzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: ucc_uart: Use platform IRQ helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260925182504.54976-1-rosenp@gmail.com>
References: <20260925182504.54976-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:33:07 +0000
Message-Id: <20260925183307.8F8961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] probe deferral: leak of async firmware load due to platform_get_ir=
q() ordering
--

commit 887c64b890c9273da1e7e1715e89bca754adbfb0
Author: Rosen Penev <rosenp@gmail.com>

serial: ucc_uart: Use platform IRQ helper

This commit updates the driver to use platform_get_irq() instead of
irq_of_parse_and_map() to obtain the IRQ. The IRQ lookup is moved earlier
in the probe function to simplify error handling and explicitly handle
probe deferral.

> diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
> index 6b7dcbbacd13d..c3c83a59dcce7 100644
> --- a/drivers/tty/serial/ucc_uart.c
> +++ b/drivers/tty/serial/ucc_uart.c
> @@ -1238,6 +1238,7 @@ static int ucc_uart_probe(struct platform_device *o=
fdev)
>  	struct uart_qe_port *qe_port =3D NULL;
>  	struct resource res;
>  	u32 val;
> +	int irq;
>  	int ret;
> =20
>  	/*
> @@ -1247,6 +1248,10 @@ static int ucc_uart_probe(struct platform_device *=
ofdev)
>  	if (ret)
>  		return ret;
> =20
> +	irq =3D platform_get_irq(ofdev, 0);
> +	if (irq < 0)
> +		return irq;
> +

[Severity: High]
If platform_get_irq() returns -EPROBE_DEFER here, does this leak the
asynchronous firmware load initiated by the preceding call to
soft_uart_init()?

Looking at soft_uart_init(), an async load is triggered like this:

    ret =3D request_firmware_nowait(THIS_MODULE,
                                  FW_ACTION_UEVENT, filename, &ofdev->dev,
                                  GFP_KERNEL, &ofdev->dev, uart_firmware_co=
nt);

Since the async firmware load is not cancelled on probe deferral, the probe=
=20
will eventually be retried and will call soft_uart_init() a second time.=20

Could this lead to duplicated asynchronous firmware loads and concurrent
execution of qe_upload_firmware() upon probe retry, potentially causing
data races or hardware state corruption?

Would it make sense to move platform_get_irq() even earlier in the
probe function, before soft_uart_init(), to prevent this probe deferral
side effect?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925182504.5497=
6-1-rosenp@gmail.com?part=3D1
