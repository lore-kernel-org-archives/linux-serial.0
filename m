Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C249362A
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536651; cv=none; b=gOgfFpz9RSDVBlVuCPlFRyhAbWsWvTBYU9yKOjy0pxApH3kgLfheSgUVC2XUYLcvsmM7B80kW7HpHi+R4sGJvN7rmXQDDP4EwWpa+KRSqKahxMU08BwetVl6zIXVu+LppSMRHKG0LWQBvUFaHidjdcYBiDTbXQ7eZxpY9K5lq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536651; c=relaxed/simple;
	bh=nGXybRzYRgksmfT+3mr2ItfRmOcEGPhF2MEVn90o5HQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKPTm6A8nD9d0gJBnaSKZbiPKtPzOAtqXe3qXerPz1ChO20U+1e4T5xYEz/UYZ/I+Wm9dCfvhnhTv7m9KKHOEIFA8fPc4FlCW/0WFrNBOpzfWDVEeGbyKvlwmzGHEck/yXnFUby3l80khz6F4weW2ZdEyUnNgflNICtHXbnEm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko0JsZCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko0JsZCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC181F00A3D;
	Fri,  4 Sep 2026 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536649;
	bh=U/59q7j6nuUaqOG/8XtyICIXIs/HKFqJ70rQHgXPBQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ko0JsZCYzFyDooZ+iFhx1f+uC6VQnP7licXUtOJHHLS0apSfQbedO0Sc6N6pt0sr8
	 PfDC7xCEn1Fqbotzx9He1AKY8vda1wFw6BCVQAHFS/ll/E70bcyIC6uWs6XpiZTy27
	 WxuXYj4E7MrNRL7n7CSiYmk/ptLZI0yUSq37DHcdIcdHfLbOI8Ttn/b2zr3LPj+w3b
	 9hS1n2BONLfYp/4IECpHcMnOfpnAZXqG0cIKn9IZa7eaXWxuKp162fSNFZ97ZkD5yP
	 9ZVYCc/AdHwYGh04/jBfxmvr3K1DrVXttyfp7hU/wksCmiZEP5AmkHBkDfxbHUdYwS
	 MRjWHZP/zl3oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tty: serial: qcom_geni: don't ida_free() the console
 port line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v3-1-541757ec8a95@linaro.org>
References: <20260904-topic-sm8x50-upstream-tty-serial-geni-fix-ida-free-v3-1-541757ec8a95@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:44:09 +0000
Message-Id: <20260904154409.7AC181F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] UART line IDA is permanently leaked on error paths in get_port_fro=
m_line() and early qcom_geni_serial_probe().
- [High] Dedicated wake IRQ and device wakeup capabilities are leaked if pr=
obe fails late.
- [High] Manual call to `dev_pm_domain_detach_list()` causes a double-free =
because the list is managed by devres.
- [High] The static console port permanently fails probing if a transient e=
rror occurs during `probe()`.
- [High] The probe error path blindly unmaps the RX DMA buffer, even if the=
 mapping failed.
- [Medium] Premature `ida_free()` in `qcom_geni_serial_remove()` creates a =
race condition for the line ID.
--

commit 8e6b3b4c6a06ece45749a076a423f5ca442974fa
Author: Neil Armstrong <neil.armstrong@linaro.org>

tty: serial: qcom_geni: don't ida_free() the console port line

The console port is a static instance whose line is hardcoded to 0 and is
never allocated from port_ida. This patch fixes qcom_geni_serial_remove()
and the matching probe() error path so unbinding the console device doesn't
hit a warning.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..1a36e9fad9768 100644
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
This isn't a bug introduced by this patch, but does qcom_geni_serial_probe()
leak the UART line IDA on other error paths?

If deferred probing causes qcom_geni_serial_probe() to repeatedly fail, the
IDA leaks multiple times and can exhaust the IDA range, permanently breaking
device initialization.

In get_port_from_line(), an IDA is dynamically allocated via
ida_alloc_range(). If the subsequent devm_kzalloc() fails:

	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
	if (!port)
		return ERR_PTR(-ENOMEM);

the function returns directly without freeing the IDA.

Similarly, in qcom_geni_serial_probe(), early failures like resources_init()
or late failures jumping to the shared error: label fail to call ida_free()
for non-console ports. The patch fixes one specific path but leaves the rest
leaking.

[Severity: High]
This is a pre-existing issue, but is the shared error cleanup path missing a
rollback of the wake IRQ or wakeup capabilities?

If dev_pm_set_dedicated_wake_irq() succeeds, the wake IRQ is registered on
the device. If a subsequent initialization step fails (e.g.,
pm_runtime_resume_and_get()), the code jumps to the error: label:

error:
	if (port->rx_dma_addr) {
...

The error: block entirely fails to call dev_pm_clear_wake_irq() and
device_init_wakeup(&pdev->dev, false), leaving a dangling interrupt handler
registered to a failing device. This can cause spurious interrupts, crashes,
or panics when triggered after the device memory is freed.

[Severity: High]
This isn't a bug introduced by this patch, but will the error path blindly
unmap the RX DMA buffer, even if the mapping failed?

In qcom_geni_serial_probe(), dma_map_single() returns an error token when
mapping fails, which is non-zero (typically ~0ULL):

		if (dma_mapping_error(pdev->dev.parent, port->rx_dma_addr)) {
			ret =3D -EIO;
			dev_err(&pdev->dev, "Failed to map RX DMA buffer: %d\n", ret);
			goto error;
		}

The error: block checks if (port->rx_dma_addr), which evaluates to true for
the non-zero error token, and erroneously calls dma_unmap_single() on the
error token:

error:
	if (port->rx_dma_addr) {
		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);

Calling dma_unmap_single() on an error token violates the DMA API and can
cause kernel panics or IOMMU faults.

[Severity: High]
This is a pre-existing issue, but can a transient error during probe()
permanently break the static console port?

qcom_geni_serial_probe() checks if (uport->private_data) to prevent two
drivers from claiming the same port, and subsequently assigns:

	port->private_data.drv =3D drv;
	uport->private_data =3D &port->private_data;

If a later step in probe() fails, the function returns an error but does not
clear uport->private_data. For the console, port points to the statically
allocated qcom_geni_console_port. Thus, the non-NULL state persists.

When deferred probe retries, it hits the uport->private_data check and
returns -ENODEV permanently, rendering the system without a working console.

>  		}
>  	}
> @@ -2015,6 +2016,7 @@ static int qcom_geni_serial_probe(struct platform_d=
evice *pdev)
>  static void qcom_geni_serial_remove(struct platform_device *pdev)
>  {
>  	struct qcom_geni_serial_port *port =3D platform_get_drvdata(pdev);
> +	const struct qcom_geni_device_data *data =3D port->dev_data;
>  	struct uart_port *uport =3D &port->uport;
>  	struct uart_driver *drv =3D port->private_data.drv;
> =20
> @@ -2024,7 +2026,8 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)
>  	irq_work_sync(&port->tx_kick);
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
> -	ida_free(&port_ida, uport->line);
> +	if (!data->console)
> +		ida_free(&port_ida, uport->line);
>  	uart_remove_one_port(drv, &port->uport);

[Severity: Medium]
This isn't a bug introduced by this patch, but does calling ida_free() befo=
re
uart_remove_one_port() create a race condition for the line ID?

ida_free(&port_ida, uport->line) marks the port's line ID as available
immediately. A concurrent probe (e.g., via hotplug or deferred probe
resolution) could allocate the freed line ID.

The concurrent probe would attempt to register a new port using the same ID
while uart_remove_one_port() is still running for the old port, leading to a
collision in the serial subsystem.

[Severity: High]
This is a pre-existing issue, but does the manual call to
dev_pm_domain_detach_list() here and in the probe error path cause a
double-free?

For the sa8255p compatible device, resources_init() points to
geni_se_domain_attach(), which calls devm_pm_domain_attach_list() to attach
power domains. This registers a devres action to automatically free the lis=
t.

Both the error: path in qcom_geni_serial_probe() and
qcom_geni_serial_remove() manually call:

	dev_pm_domain_detach_list(port->se.pd_list);

dev_pm_domain_detach_list() calls kfree(list). When devres subsequently
cleans up, it invokes devm_pm_domain_detach_list() on the exact same dangli=
ng
pointer. This double-free on a list pointer leads to a Use-After-Free kernel
panic, which can be triggered by probe failure or by unbinding the driver.

> =20
>  	if (port->rx_dma_addr) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-topic-sm8x=
50-upstream-tty-serial-geni-fix-ida-free-v3-1-541757ec8a95@linaro.org?part=
=3D1
