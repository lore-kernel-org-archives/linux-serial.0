Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C01440A3E
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928189; cv=none; b=bkCRvO3mnR+8LI+mK2ryfQYQqHD8bwVw9JBdrcaA7TtSt14666b3wVHol0dqb5PVkT2jgqiFBJHQ/S2AkWA8U5ReFxIXK0M9UczopsBO5otAik666nPxfWlB/KhAbO7G1Q1NTEX5tbykWUfPn3tAA/g1dlFylb2Htx+Sze21orc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928189; c=relaxed/simple;
	bh=/hnCC4ygD9QomR0qAj9SWBtV/AJzMmnZfi9/5eO+Yb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cac0fhDEP+vCGNAC2TGyHcWHEusMaMBzNAXvoqsOFDzzjUW+zv102C2diNfqobCDd3PYTwEoFjVJIQoXK1b7WS5eJJQ8hu4RnVbbwjFF03lSjjRpCsLyC5TVFZEr7o817DIa4WfFOjjnaa6WIoKi6Qe4sPdnRtCP0/r8/BDdo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dofeL24o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dofeL24o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A7D1F000E9;
	Fri, 28 Aug 2026 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787928187;
	bh=E4KGb8noFFZVuLx5uuEwFW4+WTlK4TN3/VwwF+eMnSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dofeL24oubJDD/Tml48asIkSycwCtwQqGvtmRYsmgDm04hvIXel3jISRYJUZ/zdj3
	 3S4NbGQkcofDgQCGjdCE0mOfsEFg5ZnvMYPkDsSuJoyjnjsUI7nKZCqvn+s0nBMA8k
	 Xzet6yjVqqUm2HmCaCZE7U0izLV/Dxt7LUpWFQIMM2N3WRC5zUAXy4Q86t7Mwz/35g
	 zGUKuneDdIagwfGGHJfPGDrBycQgrpuIyiC9MFvzHvry8EB7nhzyRvhGjf/J5recyB
	 Mn1T60GXZu0bF0g2VMdLDnxm7m7Owv1BuUc4n1Xte3cEK7KUORpQHmi1MnxJnkktDb
	 ANxnlpL2pR5iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: qcom-geni: Fix unbalanced runtime PM resume for
 no_console_suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abel Vesa" <abel.vesa@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-v1-1-af3e5aef17a6@oss.qualcomm.com>
References: <20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-v1-1-af3e5aef17a6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:43:07 +0000
Message-Id: <20260828144307.79A7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Reallocating the DMA receive buffer in setup_fifos() frees the=
 active DMA-mapped memory without unmapping it, leading to DMA use-after-fr=
ee and massive out-of-bounds reads/writes.
- [High] Asynchronous pm_runtime_put() is used on the probe error path befo=
re devres pm_runtime_disable(), leaving hardware powered on indefinitely.
- [High] Missing rollback in qcom_geni_serial_suspend() if pm_runtime_force=
_suspend() fails, leaving the UART port permanently disabled.
- [High] IDA line ID is freed before the UART port is unregistered, allowin=
g a race condition with a concurrent probe.
--

commit 7fc2859a848a4f1ec1c0bc7d7815a5c518730a33
Author: Abel Vesa <abel.vesa@oss.qualcomm.com>

serial: qcom-geni: Fix unbalanced runtime PM resume for no_console_suspend

When no_console_suspend is set for the serial console, the system
suspend callback skips pm_runtime_force_suspend() to keep the console
active. The resume callback still unconditionally calls
pm_runtime_force_resume(), which triggers an "Unbalanced
pm_runtime_enable!" warning.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..a180a00c9e23d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1074,10 +1074,10 @@ static int setup_fifos(struct qcom_geni_serial_po=
rt *port)
[ ... ]
> 	if (port->rx_buf && (old_rx_fifo_depth !=3D port->rx_fifo_depth) && port=
->rx_fifo_depth) {
> 		/*
> 		 * Use krealloc rather than krealloc_array because rx_buf is
> 		 * accessed as 1 byte entries as well as 4 byte entries so it's
> 		 * not necessarily an array.
> 		 */
> 		port->rx_buf =3D devm_krealloc(uport->dev, port->rx_buf,
> 					     port->rx_fifo_depth * sizeof(u32),
> 					     GFP_KERNEL);

[Severity: Critical]
This is a pre-existing issue, but it looks like devm_krealloc() frees the
original active DMA-mapped memory buffer here without updating
port->rx_dma_addr or unmapping the original DMA mapping.

Could this allow the hardware DMA to write to the freed memory block, and
cause handle_rx_uart() to later read out-of-bounds from the newly allocated,
shrunk port->rx_buf, leaking kernel heap memory to the TTY layer?

> @@ -1991,7 +1991,7 @@ static int qcom_geni_serial_probe(struct platform_d=
evice *pdev)
[ ... ]
> 	ret =3D pm_runtime_resume_and_get(uport->dev);
> 	if (ret < 0) {
> 		dev_err(uport->dev, "Failed to resume and get %d\n", ret);
> 		goto error;
> 	}
>=20
> 	ret =3D uart_add_one_port(drv, uport);
> 	pm_runtime_put(uport->dev);
> 	if (ret)
> 		goto error;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't using an asynchronous
pm_runtime_put() here on the probe error path leave the hardware powered on
indefinitely?

The devres pm_runtime_disable() that follows will cancel any pending
asynchronous suspend work.

> @@ -2022,6 +2022,6 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)
[ ... ]
> 	WRITE_ONCE(port->tx_kick_enabled, false);
> 	irq_work_sync(&port->tx_kick);
> 	dev_pm_clear_wake_irq(&pdev->dev);
> 	device_init_wakeup(&pdev->dev, false);
> 	ida_free(&port_ida, uport->line);
> 	uart_remove_one_port(drv, &port->uport);

[Severity: High]
This is a pre-existing issue, but is the IDA line ID prematurely freed here
before the UART port is completely unregistered on the next line?

If a concurrent device probe allocates the just-freed IDA line ID while
uart_remove_one_port() is still running for the old device, it seems this
could cause a collision in the serial core due to duplicate line IDs being
registered simultaneously.

> @@ -2086,10 +2086,10 @@ static int qcom_geni_serial_suspend(struct device=
 *dev)
[ ... ]
> 	/*
> 	 * When no_console_suspend is set the console must remain active
> 	 * across system sleep, so skip the force suspend path.
> 	 */
> 	if (!console_suspend_enabled && uart_console(uport))
> 		return 0;
>=20
> 	return pm_runtime_force_suspend(dev);

[Severity: High]
This isn't a bug introduced by this patch, but if pm_runtime_force_suspend()
fails, does this return the error without reverting the effects of
uart_suspend_port() and geni_icc_set_tag() executed earlier in the function?

It seems this could leave the UART port permanently disabled.

>  }
> =20
>  static int qcom_geni_serial_resume(struct device *dev)
>  {
>  	int ret;
>  	struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
>  	struct uart_port *uport =3D &port->uport;
>  	struct qcom_geni_private_data *private_data =3D uport->private_data;
> =20
> -	ret =3D pm_runtime_force_resume(dev);
> -	if (ret)
> -		return ret;
> +	if (console_suspend_enabled || !uart_console(uport)) {
> +		ret =3D pm_runtime_force_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	ret =3D uart_resume_port(private_data->drv, uport);
>  	if (uart_console(uport)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-serial-qco=
m-geni-fix-unbalanced-rpm-resume-v1-1-af3e5aef17a6@oss.qualcomm.com?part=3D1
