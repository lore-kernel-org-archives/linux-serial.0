Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93712E1DC
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237174; cv=none; b=IZVOzFVqFBJrwciLPUBMWp4knW6AOynjixVFDp2TPMZLUiEqgz6kSgbQ9mJAGuaLJG8qY/l2HEOzJX/IWloHEQOpn/t3TBfAXX3BErjuO7HxOWn1BSzWtcf2mB7dKBDg1JoKfAzVXQwlQthML5Trhnqib2zi2+qPowsneWAlDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237174; c=relaxed/simple;
	bh=Q9RSVCa9290VL3IWNGpCitdHqmHVdndYBjFjVuVe1gs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jfWcjhRO4L4thP+YDcsIXZp1GWtkNo6O3K+KL9sfjGWyPEThD7M38xPTQOWXP2elTni6+WyzilfzaxQjsQiBPAZxQDxbprWi5R3FxvYnCE2qejefoifaDPqDoGt3d+sHckIApK41S3jHYsPTkF8PLzkpm4UneYxfrTkOHk6tvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoENbCFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoENbCFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D391F000E9;
	Tue,  1 Sep 2026 04:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237172;
	bh=qAEkyFzQWNxgghLpVrPVRNVCjWJumtfVPxhpvFfM34U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PoENbCFoLbDwYGxkLCIuUFpUrnPyAnnnJUTqFoLZ7b4GTEBlfvbPVBjbvV6ms71XB
	 4CZNFp1C/mC6oqmdlWNob6aLuOdWEmh94HMmCfuPoSq4lB9iuKEmLEWc7tStgrIdeV
	 UEmzkTPfuBCHiDt7YYnsz7xVwjk9LEZ0ekWjNtIdgVD7Ue9iGBOKU1tmgK6xhrudp7
	 nXA8r2v+DmR75sjky2zNh3/4SADtPHDmDOSw5dn9xrjVHkR9Jmqh9mczit2SM1iBUC
	 AeNrowyup6oneqKXCLerqJcMMVriqsHpF+Hdz4m3WlchELqWQbOFaWoRVnXajGEDSL
	 9kFDBfrd2Ps1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] serial: 8250_mxpcie: set the driver data before
 registering ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260901041519.114737-2-lilinmao@kylinos.cn>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
 <20260901041519.114737-2-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:32:52 +0000
Message-Id: <20260901043252.85D391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing initialization of `up.port.port_id` causes all registered =
serial ports on a multi-port device to share ID 0 and corrupt each other's =
hardware state.
- [High] Unprotected read-modify-write on shared hardware register in `mxpc=
ie8250_set_interface` causes a race condition between concurrent operations=
 on adjacent ports.
--

commit 0dfacc505133057b054c4b8c8d42d557343c298b
Author: Linmao Li <lilinmao@kylinos.cn>

serial: 8250_mxpcie: set the driver data before registering ports

This commit fixes a NULL pointer dereference in the mxpcie8250_rs485_config
callback. It moves pci_set_drvdata() before port registration so the board
data is available when the callback is invoked during initialization.

> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8=
250/8250_mxpcie.c
> index ce873fbd62e93..c0e3517d4e4ec 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -542,6 +542,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id
> =20
>  	mxpcie8250_init_board(pdev, priv);
> =20
> +	pci_set_drvdata(pdev, priv);
> +
>  	up.port.dev =3D dev;
>  	up.port.irq =3D pdev->irq;
>  	up.port.uartclk =3D MOXA_PUART_BASE_BAUD * 16;
> @@ -578,7 +580,6 @@ static int mxpcie8250_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id
>  		}
>  		priv->port[i].rx_trig_level =3D MOXA_PUART_RX_TRIG_DEFAULT;
>  	}
> -	pci_set_drvdata(pdev, priv);
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the port
registration loop, I noticed that mxpcie8250_setup_port() seems to leave
up.port.port_id initialized to 0 for all ports. Because the up structure
is zero-initialized, and up.port.port_id is never assigned the idx value,
it remains 0.

When this zeroed structure is passed into serial8250_register_8250_port(),
does this cause all registered ports on a multi-port device to share ID 0?
If so, hardware callbacks like mxpcie8250_rs485_config() and=20
mxpcie8250_startup() that use port->port_id as an index might inadvertently
apply configuration changes to port 0 instead of the intended port.

[Severity: High]
This is also a pre-existing issue, but looking at mxpcie8250_set_interface(=
),
the shared hardware register controlling adjacent ports is updated using an
unprotected read-modify-write:

mxpcie8250_set_interface()
    ...
    cval =3D ioread8(uir_addr);

    if (port_idx % 2)
        FIELD_MODIFY(MOXA_ODD_RS_MASK, &cval, mode);
    else
        FIELD_MODIFY(MOXA_EVEN_RS_MASK, &cval, mode);

    iowrite8(cval, uir_addr);

Since this is called by mxpcie8250_rs485_config(), which is only protected
by the per-port uart_port_lock, could concurrent ioctls on adjacent ports
(like port 0 and port 1) race and corrupt this shared register byte?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901041519.1147=
37-1-lilinmao@kylinos.cn?part=3D1
