Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A63E025C
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175701; cv=none; b=IjYP8cWOCTRucuRUpnAJIdK5vOCqWFd6IuVpFtpMalVIrX4K4K5whAlgzTMI2680HQTGoqr9x+s21wHrL49W4qDCZbqrVTSr8kgcGt7clOJaxwcA8DVOkA/mihEnEJQEt18j5OJy5IQrAgym5q9NA9/EfrlMHXj2Ci7wyHaN0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175701; c=relaxed/simple;
	bh=ooTztsh7q913zdLF3rnG10Qlgt0SSIjdgyo6dwqCySU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbafuk34E2gJxqjrzsln9wE4ehDfQALxitPEAwEUAFcmScuYSqJvOWVTldfHTnkFyeyTOvWafe0OKKlfhyYkOt4yrB+yIgZnXoS5pHLPa9MH9+42A0NBKRq/lqK122/d7tAJFfAiZ3x0jgkabNS8QGnZ2zU6YLim+mQ6kkCY4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUdGOGeg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUdGOGeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41811F000E9;
	Mon, 31 Aug 2026 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175698;
	bh=VyfiXTIOGO7nraGC8AGRdP89Pd8FMeO1bbrQPO6ULzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUdGOGegu9O+Anq7yny0SHr/IgGtPHBsgTDQCzL1D8XBUwnjkGDFBUGaybECaRF7O
	 hNMKpZCK3p4cV5z0uBM9qmHYA9Qwnmp/I/u5EBuaHulUaC0PnBVO2RLFeRrPvkMHi3
	 1J6KfBVedAZqtWyYfCi/TyVAOfLXaNXfrbB0+Sq9kTBfsz5ERGaM/bkuBP2z7+d/8V
	 YY0LJ+gctqSEd+0Kr1M31zu55hw45OrKekjlBc2Loh+QfTbaiGfiY47PZ9y+StS4RF
	 rL5C9i6XeTPL75nOaZM65aI10g/U4U4ZURv+6pAtoCo0lqg3enuoAx6N5RE7ameBtw
	 WMyhy15u0bD0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
References: <20260831-master-v2-1-0032ec7fd1ca@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:28:17 +0000
Message-Id: <20260831112817.E41811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Manual detachment of the devres-managed PM domain list during =
probe error handling and device removal causes a double-free.
- [High] The driver incorrectly calls `dma_unmap_single()` with a DMA mappi=
ng error address in the probe error path.
- [High] The driver frees the port IDA before unregistering the UART port, =
exposing a race condition.
- [High] Unconditional probe failure if no serial aliases exist in the Devi=
ce Tree.
--

commit db25e732789f738d8e62f2cfae1a09afe0942d97
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

serial: qcom-geni: Fix port_ida handling for console and probe errors

This commit ensures the console port line number is not allocated from or
freed back to port_ida. It also fixes leaks by moving the ida_free() call
to the common probe error path and allocating the port structure before
allocating an ID.

Link: https://patch.msgid.link/20260828-master-v1-1-1f8afa5f82c2@oss.qualco=
mm.com

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..ceaf560fd8dda 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -289,6 +289,10 @@ static struct qcom_geni_serial_port *get_port_from_l=
ine(int line, bool console,
>  	} else {
>  		int max_alias_num =3D of_alias_get_highest_id("serial");
> =20
> +		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +		if (!port)
> +			return ERR_PTR(-ENOMEM);
> +
>  		if (line < 0 || line >=3D nr_ports)
>  			line =3D ida_alloc_range(&port_ida, max_alias_num + 1,
>  					       nr_ports - 1, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does this unconditionally fail the probe
if there are no serial aliases in the Device Tree?

If of_alias_get_highest_id(serial) finds no aliases and returns -ENODEV
(-19), the minimum value passed to ida_alloc_range() becomes -18. Since
ida_alloc_range() performs a signedness bounds check ((int)min < 0), it
immediately returns -ENOSPC, causing the probe to fail on systems without
DT aliases.

[ ... ]

> @@ -2003,6 +2002,8 @@ static int qcom_geni_serial_probe(struct platform_d=
evice *pdev)
>  	return 0;
> =20
>  error:
> +	if (!data->console)
> +		ida_free(&port_ida, uport->line);
>  	if (port->rx_dma_addr) {
>  		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
>  				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);

[Severity: High]
This is a pre-existing issue, but does this erroneously unmap an invalid
DMA address if dma_map_single() fails?

If dma_map_single() fails during probe, it returns DMA_MAPPING_ERROR
(usually ~0ULL) which is non-zero. The failure path directly jumps to the
error label without clearing port->rx_dma_addr, so this check considers it
valid and calls dma_unmap_single() on the error address, potentially causing
IOMMU faults or memory corruption.

[Severity: Critical]
This is a pre-existing issue, but does the manual detachment of the
devres-managed PM domain list here in the probe error path cause a double-f=
ree?

Just below in the error path, dev_pm_domain_detach_list(port->se.pd_list)
is called. Since pd_list was allocated and attached via
devm_pm_domain_attach_list(), the devres subsystem will automatically free =
and
detach it on probe failure. Manually calling dev_pm_domain_detach_list()
results in kfree being called twice on the same pointer, leading to heap
corruption and a kernel panic.

> @@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)
>  	irq_work_sync(&port->tx_kick);
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
> -	ida_free(&port_ida, uport->line);
> +	if (!port->dev_data->console)
> +		ida_free(&port_ida, uport->line);
>  	uart_remove_one_port(drv, &port->uport);

[Severity: High]
This is a pre-existing issue, but does freeing the port IDA before
unregistering the UART port expose a TOCTOU race for the line ID?

If qcom_geni_serial_remove() frees the line IDA while the UART port is still
registered in the TTY layer, a concurrent probe of another UART device could
allocate the exact same line ID and call uart_add_one_port(), resulting in
two active driver instances sharing the same TTY port line in the serial co=
re.

[Severity: Critical]
This is a pre-existing issue, but does the manual detachment of the
devres-managed PM domain list in this remove function cause a double-free?

Further down in qcom_geni_serial_remove(), the driver calls
dev_pm_domain_detach_list(port->se.pd_list). Since pd_list is devm-managed,
the devres subsystem will automatically handle its cleanup when the device =
is
removed. Manually detaching it here causes a double-free of the pd_list mem=
ory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-master-v2-=
1-0032ec7fd1ca@oss.qualcomm.com?part=3D1
