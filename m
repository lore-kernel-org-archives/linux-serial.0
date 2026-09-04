Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132253655EA
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512596; cv=none; b=iU/D7GJdOe+kJSC3jhUa7TTvAqJzQbPaEzOjw3GFx31lC9PDfuGDQWchAFqtqoGRCIOWgjpZLIzqaX+6Y9RKM6W6x8XFQeRrr0DeS2i768axOlBNKEMTv462x5CGIOup7xPFtEWiK3dEKTCUjJLK2xQwEiBuMxWESKYnb4u5yU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512596; c=relaxed/simple;
	bh=9UJ3yeGZVgTnvOeyWFx87JJYTo36jzYtbxkuh96P9w8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s8RE7MVGd5vagXeLDJGswf3XetqnLb7Utdstc7DTG9R62flqoF/9TSVCIIbIY8GR79bjqPtm3y2VHsUcZqpTh0L3hT29ADzQ+F4MLxhGA9n70fFq+ghpdyeAP/5vftfKZKVMc6ygvxoBV39C7pmXBzqhZZ+9dIaj/OVhMMT1NUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caYtYzo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caYtYzo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3151F00A3F;
	Fri,  4 Sep 2026 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512594;
	bh=UmrDBodcqirfhGnxGflpwBa8sX0IrBLTQHADH6ajGjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=caYtYzo8MtlcxgeN4ineZpsoibbYlD/ZuMk39OkRv7eqjVrvVUu5ow3gUn9lE+d4g
	 pcp4tbO0XDDOcxBezYe50rEd7rbqU8iWmLpAfYTuphJ4tuoFmI6K461jboXTwGZ+/9
	 hAHb2rBXnxqp1HEraTMOyfq5vUEa8BX8efPj7xOJsgzQOTkTjR5MFEfGs+s3ru8xPP
	 BQqPZLh6uBR58/9W3uF+wsu9XCH5mfalIFcsYghRjwjFPoohIx3Lwc6gsy5f/CKDGD
	 nGaU15VPz/rFxHPC2cdGYPmGVcYiRw/P8qYV1tv701PnVJjopqHT9SB58WHt8hsCVj
	 FYZdIH0jiSsMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: serial: qcom_geni: don't ida_free() the console
 port line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org>
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:03:14 +0000
Message-Id: <20260904090314.AE3151F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The patch introduces the exact same ida_free warning it attempts=
 to fix.

Pre-existing issues:
- [High] Resource Leak of IDA and wakeup IRQ state on probe error paths.
- [High] State Corruption breaks deferred probe and rebind for the console =
port.
- [High] Invalid Resource Free of DMA_MAPPING_ERROR on the probe error path.
--

commit a57f4a6f0374c3009623d75049fdce5fe91711e0
Author: Neil Armstrong <neil.armstrong@linaro.org>

tty: serial: qcom_geni: don't ida_free() the console port line

The console port (qcom_geni_console_port) is a static instance whose
uport.line is hardcoded to 0 and is never allocated from port_ida.
Only the non-console path in get_port_from_line() calls ida_alloc_range().

Fix the qcom_geni_serial_remove() and the matching probe() error path
so unbinding the console device doesn't hit:

  WARNING: ida_free called for id=3D0 which is not allocated
  <snip>
  qcom_geni_serial_remove+0x58/0x80

Fixes: a53be6945f51 ("serial: qcom-geni: Remove alias dependency from qcom =
serial driver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..b47f8d5bb2950 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1979,7 +1979,8 @@ static int qcom_geni_serial_probe(struct platform_d=
evice *pdev)
>  						port->wakeup_irq);
>  		if (ret) {
>  			device_init_wakeup(&pdev->dev, false);
> -			ida_free(&port_ida, uport->line);
> +			if (!data->console)
> +				ida_free(&port_ida, uport->line);
>  			goto error;

[Severity: High]
This is a pre-existing issue, but does this probe function leak the
allocated IDA and wakeup IRQ state on other error paths?

For example, if platform_get_resource() fails, the code jumps to the error
label which does not free the IDA:

	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		ret =3D -EINVAL;
		goto error;
	}

Similarly, if pm_runtime_resume_and_get() fails, it jumps to error and
bypasses the cleanup for device_init_wakeup() and
dev_pm_set_dedicated_wake_irq().

Additionally, if devm_kzalloc() fails in get_port_from_line(), the
allocated IDA is returned but never freed.

Can repeated deferred probes exhaust the limited IDA namespace?

>  		}
>  	}
> @@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)

[Severity: High]
This is a pre-existing issue, but does the remove function fail to clear
uport->private_data?

During qcom_geni_serial_probe(), the static console port checks for
concurrent bindings:

	if (uport->private_data)
		return -ENODEV;

If qcom_geni_serial_remove() doesn't clear this pointer, wouldn't future
rebinds or deferred probes permanently fail for the console port?

>  	irq_work_sync(&port->tx_kick);
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
> -	ida_free(&port_ida, uport->line);
> +	if (!uart_console(uport))
> +		ida_free(&port_ida, uport->line);

[Severity: Medium]
Will this still trigger the exact same ida_free() warning for the console
port if it is not the active system console?

The qcom,geni-debug-uart console device uses data->console =3D true, so it
does not allocate an IDA in probe().

However, if another device is selected as the active console (e.g., via
console=3DttyS0), uart_console(uport) will evaluate to false because the
indexes won't match. Doesn't this mean qcom_geni_serial_remove() will still
incorrectly attempt to free IDA 0?

Would it be safer to check !port->dev_data->console here, matching the
logic added to probe() in this patch?

>  	uart_remove_one_port(drv, &port->uport);
> =20
>  	if (port->rx_dma_addr) {

[Severity: High]
This is a pre-existing issue, but does this cleanup code execute an invalid
unmap if dma_map_single() failed during probe?

If dma_map_single() fails in qcom_geni_serial_probe(), port->rx_dma_addr
retains the DMA_MAPPING_ERROR value (which is non-zero).

Since this non-zero value evaluates to true in both the probe error path and
qcom_geni_serial_remove():

	if (port->rx_dma_addr) {
		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);

Could passing a mapping error to dma_unmap_single() cause IOMMU faults or
memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-topic-sm8x=
50-upstream-tty-serial-geni-fix-ida-free-v2-1-0e83d8df410c@linaro.org?part=
=3D1
