Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46854FDA60
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895769; cv=none; b=YOOhznokVb0iF/RhAAoXiCSx1hzk7dO66WO9xNlEVmFcm8ON5H4i884saz5JsB5+R3DE9TA8QnWkUvKIoyaCaSwEbv3kMtdJrtnSi82shA1ub53DpZXNPjuBtccoTAS/eefdwavRaV38M8LvTLMExBjUw2DVoeNAN8Wm6qPAJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895769; c=relaxed/simple;
	bh=NcZMnF1qy7v8xyitl9lG3n8WuXTyz6Wodwum6AnZLAs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=e28/RVLR6iXu8Q8G59cS2zSqxJvx0oUzgHuwVwOK6DwevFbDdnJZ4V5/mjCtw7oTztNC48e21y9sYbcdFaDYoxNQFHAh9V4J9QAFNji9a8sPymuBqbrb3wcEOQuqCoJ9OV4QqpRjITmZkbHWrw6ORGjL1bMS6DZiYe5BVN4Tqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWCA8QFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWCA8QFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0BE1F00898;
	Tue, 13 Oct 2026 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895767;
	bh=nat3FEhyrdrbYj9jWiOLETSix61us0ezEme79Bux9hU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TWCA8QFWNX8aTDaT922lW8YeMr45+oCHwyGLkdiAZHAiUFF2sI9vZbsJedogN1RMd
	 gO46XDw5exE3iM2gT7nLWT7B8CqBkbeIL6RQezhdjoC98uDpltMNnuOw5MjGxlmurt
	 GXTEgHNMdqG0tYeCtV96cLM6vUrHA/Gkp5BCGuK63cr3Vwq40yvKYM3jaWW9Fo0FAq
	 JfJ/UNiZV+ErYQxb/ffNiuHgR6taAh68bVhRDl9aWmTe98Y8guNp6ZuoND9IDNlOgj
	 4/mk3PtXjDQ/HfTD6c5byJeiW9XgdjyhWg5TWBwNBVL1f6SUS9GOQGCxHLN07ni4+Y
	 XHmr0JKoDmVMw==
Message-ID: <sashiko-outbox-169741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] serial: mcf: add devicetree support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261013120831.1046590-6-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-6-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:49:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] tty: serial: mcf: ID collision due to persistent pdev->id mutation=
 on probe deferral
- [High] tty: serial: mcf: dangling pointer in global mcf_ports array on pr=
obe error
- [High] tty: serial: mcf: mcf_remove unregisters all ports system-wide ins=
tead of unbound device
- [High] serial: mcf: broken port numbering and API violations in mcf_probe
- [Medium] tty: serial: mcf: missing MODULE_DEVICE_TABLE prevents module au=
toloading
- [Medium] tty: serial: mcf: missing error check for uart_add_one_port
--

commit 61f92ee3964b5b13fd6350da88b718b7350512cd
Author: Greg Ungerer <gerg@linux-m68k.org>

serial: mcf: add devicetree support
   =20
Add basic support for probing the ColdFire UARTs via a devicetree.

> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index 7cbe43cbe3a0e..01b3ab6e7dba9 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
> @@ -582,6 +584,8 @@ static int mcf_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct mcf_uart *mp;
> =20
> +	if (pdev->id =3D=3D -1)
> +		pdev->id =3D mcf_numports;

[Severity: High]
Does modifying pdev->id persistently break deferred probe or unbind/rebind
cycles?

If the device is unbound and rebound, or if probe defers, it will retain
the old ID on the next probe attempt. Since mcf_numports is incremented on
success, this can lead to ID exhaustion over multiple unbind/rebind cycles.

Additionally, should of_alias_get_id(pdev->dev.of_node, "serial") be used
here to respect standard device tree aliases instead of an auto-incrementing
counter?

[Severity: High]
Does this code leave a dangling pointer in the global mcf_ports array if
probe fails later?

If a subsequent call (like devm_platform_get_and_ioremap_resource() or
platform_get_irq()) fails, the devres subsystem will automatically free 'mp'
allocated via devm_kzalloc(), but mcf_ports[pdev->id] is never cleared.

>  	if (pdev->id >=3D MCF_MAXPORTS)
>  		return -ENODEV;
> =20

[ ... ]

> @@ -612,6 +616,8 @@ static int mcf_probe(struct platform_device *pdev)
>  	port->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
> =20
>  	uart_add_one_port(&mcf_driver, port);

[Severity: Medium]
Is it safe to ignore the return value of uart_add_one_port() here?

If registration fails (e.g., out of memory or line conflicts), mcf_numports
is still incremented and probe falsely reports success, leaving a partially
initialized state.

> +
> +	mcf_numports++;
>  	return 0;
>  }
> =20

[ ... ]

> @@ -629,11 +635,17 @@ static void mcf_remove(struct platform_device *pdev)
> =20
>  /***********************************************************************=
*****/
> =20

[Severity: High]
Will mcf_remove() still unregister all ports system-wide when a single
device is unbound?

It appears that mcf_remove() unconditionally iterates over all MCF_MAXPORTS
and removes every active port, rather than only removing the specific port
associated with the unbound device.

> +static const struct of_device_id mcf_uart_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,mcf-uart", },
> +	{ }
> +};
> +

[Severity: Medium]
Does the absence of MODULE_DEVICE_TABLE(of, mcf_uart_dt_ids) prevent module
autoloading when the hardware is present in the device tree?

>  static struct platform_driver mcf_platform_driver =3D {
>  	.probe		=3D mcf_probe,
>  	.remove		=3D mcf_remove,
>  	.driver		=3D {
>  		.name	=3D "mcfuart",
> +		.of_match_table =3D mcf_uart_dt_ids,
>  	},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120831.1046=
590-1-gerg@linux-m68k.org?part=3D5
