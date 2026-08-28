Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4401A262A
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916459; cv=none; b=MYBYaQTW8aFNnnTKFNN7AzjX4VjrE3wE1WKfNxylX/b7+zac9CN2GCHr1XfP8QfoQyD0lECy+XPbX3/9FDDtbMt49KkIaS5NjG2g92I7pX6yKtexiRlKf47Zp6jBPzvH7UKYW07F9YZIDVp4GMlT9Z0EeqEhw/74L+RNlXSNQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916459; c=relaxed/simple;
	bh=3mcifXeospvAYceYkLkpUj8IYQ9ExMMfJOB6b9TVW2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O9tAFuxUClZ6/k1Fcv7kml7+WkdyK8hC2NgBM1aVDo9frplAMjvkSFxtxhSjuLJIt/JVNojyxXGM5V72bZybbX2eEeKkTTMn3u9DF/HREege0xu4auxfGz69Ilg1+83TrVvPVT5bbcojcBAaVT8zN8pz0VvytxXYxeEN6tQOBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4ep6Kzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4ep6Kzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7313C1F000E9;
	Fri, 28 Aug 2026 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787916456;
	bh=xsvx8KYPHJCNcEZBjDzAWzYW7jM/aMYao6Rf7QZcGpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4ep6Kzy8m9QFE0RcyvwFksaF/p69vksy9w4pExGpQ/KcaSn666IwGjU/35c8JGf9
	 SuQTF6JM5yQlkPBP+mi5hTt9Q+tfBJ4YjsazquNUWCdIbaXVhKTyVEKWAsnJsmlzn6
	 aXAVNBfemd9p+rm8cWli8alCXdsTtdkSnxMrBZ20i6fX9wuPZFcbAe287jfbs1kq7h
	 jHq6UQLn3cORfmmWBVLFVQN0tP7lqmlYbN2heprvebsJKGbx8C/o9K/mL5uV8F9SLp
	 lVufrONv/r+C1Em4t/RKgsdG+l90ltbaT43LOOGpBvcOzATJu/cS247NLjEOtC28Z0
	 SHiEVi3EC9yEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Fix port_ida handling for console
 and probe errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260828-master-v1-1-1f8afa5f82c2@oss.qualcomm.com>
References: <20260828-master-v1-1-1f8afa5f82c2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 11:27:35 +0000
Message-Id: <20260828112736.7313C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Manual detachment of PM domains that were managed by devres ca=
uses use-after-free and double-free in the error and remove paths.
- [High] `dma_unmap_single()` is called on an invalid DMA error address in =
the probe error path.
--

commit ed6a531eb788e28e28dda8911b32a155ac5da9fd
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

serial: qcom-geni: Fix port_ida handling for console and probe errors

The console port uses a fixed line number and is not allocated from
port_ida. However, qcom_geni_serial_remove() unconditionally frees the
line number for all ports, including the console port.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..3bfe597d2c835 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c

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
This is a pre-existing issue, but could this dma_unmap_single() call in
qcom_geni_serial_probe() be operating on an invalid DMA error address?

If dma_map_single() fails earlier in qcom_geni_serial_probe() for rx_buf, it
returns a non-zero mapping error address. Since that error address is
non-zero, this check for (port->rx_dma_addr) evaluates to true, and
dma_unmap_single() is called on the invalid address.

[Severity: Critical]
This is a pre-existing issue, but does manually calling
dev_pm_domain_detach_list() right after this block cause a double-free?

Just below this hunk in the qcom_geni_serial_probe() error path, the code
calls dev_pm_domain_detach_list(port->se.pd_list).

Since the PM domains are attached using devres-managed functions (via
port->dev_data->resources_init()), the devres cleanup will automatically
invoke devm_pm_domain_detach_list() when probe fails. Manually detaching it
in the error path would free the list, leading to a second free during the
automatic devres cleanup.

> @@ -2024,7 +2025,8 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)
>  	irq_work_sync(&port->tx_kick);
>  	dev_pm_clear_wake_irq(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, false);
> -	ida_free(&port_ida, uport->line);
> +	if (!port->dev_data->console)
> +		ida_free(&port_ida, uport->line);
>  	uart_remove_one_port(drv, &port->uport);
> =20
>  	if (port->rx_dma_addr) {

[Severity: Critical]
This is a pre-existing issue, but does manually calling
dev_pm_domain_detach_list() in qcom_geni_serial_remove() cause a double-fre=
e?

Similar to the probe error path, just below this hunk in
qcom_geni_serial_remove(), the code calls
dev_pm_domain_detach_list(port->se.pd_list).

Since the PM domains were attached using devres-managed functions, the
devres cleanup will automatically invoke devm_pm_domain_detach_list() when
the device is removed. Manually detaching it here would free the list,
leading to a second free during the automatic devres cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-master-v1-=
1-1f8afa5f82c2@oss.qualcomm.com?part=3D1
