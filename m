Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51C30649C
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236871; cv=none; b=ZQYgcesje2hdwYt9Er9fM258Bn/CEldBz63hFfC1Vo7u/Lrga+mtDWWKNoC+itNoW8oCj77OrhCwh2W3pSnUhi8/eNWPoFkwq0ireMUmEZ9B4ubmHZN1Tf0+ANZ/INihlvHgL1vq9fc/0QnvN5h2Q1FqYaMQjOvwuDZRcaqUmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236871; c=relaxed/simple;
	bh=FDddBCSeYq3LlYDT7Rtj/xVK+zOoXVdnTYl+Owa40cA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVg+I/KwoCEur//W/Zt5Zg5YjmjGdFcXj2DsapxM2+JRS+wf7umcnYDTfZdMyd/T/irJefhf1/Bhanm8uX1YrtqxwW8hbjuQSQH6WaEaIPTiW1CSXvuUacRVw0VzWxT/dJDC38r7anGtLppUh6DJbtF6lIH+BPP5cJj5+6Y4jRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA23cvaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA23cvaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF29A1F000E9;
	Tue,  1 Sep 2026 04:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788236869;
	bh=HZz+JS8lbaiQe5/l1ytSRF4KtjWJ0BIeI0AtxQZ4g6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dA23cvaQK9X8fkKZPoKd0YZ56KN3v1F7XY4WaslixxJ3X/dMrNjk4Dx3tRzvKYyhq
	 55V9vebSV9+850pm6hKEVot3Xvm5mPmwjj7/o/vRX6d3QX947G1lwgyXEPrru8vJAg
	 te9mi759U5PVxHLIWK+mTT19KfkU3Xvff2EbMt6/NxeocWkCkO7+ZpXNibplNvXnBo
	 boIYl+pbjNGvjJHhGbHF/w69S7j2NL/TvlGIjXkIBCWSXdgxCiXkcd69/h4uanuJN4
	 B3SksK41wpuC8APqGfyDDyUHZ69Cs9mCfxgB2aIjfoGiyyS3WlAURwyFyZTov7ls0h
	 1Ojn8daBsX+FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250_mxpcie: only unregister the ports
 that were registered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260901041519.114737-3-lilinmao@kylinos.cn>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
 <20260901041519.114737-3-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:27:49 +0000
Message-Id: <20260901042749.AF29A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver fails to initialize `up.port.port_id` for individual se=
rial ports during probe, causing all successfully registered ports to incor=
rectly share `port_id =3D 0`. This leads to configuration meant for other p=
orts silently overwriting port 0's hardware registers and software state.
--

commit 73e9e979a09f1fbc7bf6f2134b67c8afbd507c55
Author: Linmao Li <lilinmao@kylinos.cn>

    serial: 8250_mxpcie: only unregister the ports that were registered
   =20
    When serial8250_register_8250_port() fails the loop stops and the probe
    keeps the ports registered so far, like pciserial_init_ports() in
    8250_pci.c this driver was split from.  What the split lost is that
    function's priv->nr: mxpcie8250_remove() walks all num_ports entries,
    but the ones the loop never reached keep the zero devm_kzalloc() left
    there, and the one that failed keeps a negative error code.

> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8=
250/8250_mxpcie.c
> index c0e3517d4e4ec..ef2516ec16da0 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
[ ... ]
> @@ -564,7 +566,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id
>  	up.port.handle_irq =3D mxpcie8250_handle_irq;
>  	up.port.break_ctl =3D mxpcie8250_break_ctl;
> =20
> -	for (unsigned int i =3D 0; i < num_ports; i++) {
> +	for (i =3D 0; i < num_ports; i++) {
>  		mxpcie8250_setup_port(pdev, priv, &up, i);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does mxpcie8250_setup_port() fail to set
up.port.port_id?

Because up.port.port_id is not initialized for individual serial ports duri=
ng
probe, all successfully registered ports seem to incorrectly share port_id =
=3D 0.

Could this lead to configuration meant for other ports silently overwriting
port 0's hardware registers and software state?

For example, when setting RX trigger levels or handling ioctls for RS485
(TIOCSRS485) on any non-zero port, it looks like port->port_id will evaluate
to 0 in mxpcie8250_rs485_config():

drivers/tty/serial/8250/8250_mxpcie.c:mxpcie8250_rs485_config() {
	...
	mxpcie8250_set_interface(priv, port->port_id, mode);
	...
}

causing the driver to incorrectly read, modify, and write the configuration=
 of
port 0 instead of the target port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901041519.1147=
37-1-lilinmao@kylinos.cn?part=3D2
