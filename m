Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE747125F
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256950; cv=none; b=RQU3sJJ/LTXFGKd03yOrXaTRDUGnU4/y3XeiF0rwM7+DjQhjFZugf/QFvFk0kn5aCJ5AnZPYZH0Kn6PXLcf+6zUcACdWv3iQJ05LJ7JuaQpSMMjiXiVo1oV5YFJ4GZx3p+ywp1DPAfsAZDJA7jb7DOuh1r6GwO9Ir5q10cQA2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256950; c=relaxed/simple;
	bh=bfn9sDmckH28xQW7ekt13963h0B6DgGqWsrRIhHquOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzR+lpiX4aA2osoy+d8AxMbTm3JPUhbcC3dM1C0eugP37Rw2E3ZD5EqRdNRZSvJyylwOEOeCkJpB7WzZdUPytNMCFFhb9nmwDbLCKry7Sej+Dc035Psl7Ujn0hwOTq1MlqvAxEb3sFucU8Q+32OK0Yh61LwHXch2k7EWJLCuCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afx6n+0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afx6n+0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371FB1F00A3D;
	Tue,  1 Sep 2026 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256949;
	bh=gOigunzjhj5u/J3wVE7GE9KuHG6wsg1xbEFrPoo+5AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=afx6n+0U+wzyfWLonQE9hsvLcuh4oeWE8wSqfXG+JuY9471d2318AWY8rsN/uN3vJ
	 HuMGAIpE6WaxI+TnsjGnwVqFOdJ5X/banA8NUCskM/YedRSVLdyB7YXYgbKIeSaeFb
	 mQ35KwJZY6NDsePz1lwunmBK+RkxRCUqL1wKy7URI3NODt0y10ze/9Fppsk5Uybvy8
	 KrHa7JLj9CzTESmIAEDHbtMRBRyQacgU63opHLLgpsN7vgzNUecVXumsX/v5Esv/LO
	 9fW5NVUVL6NyLlk4wXlu/iA8kngPnk/X5UoNO6E7P852C8v2UMKyHxdn5nZluQnQO9
	 sWW0fOrRqQNrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Avoid double-free of PM domain
 list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aniket Randive" <aniket.randive@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260901-probe_cleanup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com>
References: <20260901-probe_cleanup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 10:02:28 +0000
Message-Id: <20260901100229.371FB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() immediately followed by devres-manag=
ed pm_runtime_disable() on probe error path.
- [High] Probe error paths leak IDA slots and dedicated wake IRQs, and ida_=
free() crashes on console unbind.
--

commit 70e27637a93cd696a967e44f11424854b0e2411a
Author: Aniket Randive <aniket.randive@oss.qualcomm.com>

serial: qcom-geni: Avoid double-free of PM domain list

The SA8255P UART variants attach PM domains through
devm_pm_domain_attach_list(), which registers a devres cleanup action
to detach and free the PM domain list automatically on probe failure
or device removal.

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..fe961b206645c 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c

[ ... ]

> @@ -2008,7 +2007,6 @@ static int qcom_geni_serial_probe(struct platform_d=
evice *pdev)
>  				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
>  		port->rx_dma_addr =3D 0;
>  	}
> -	dev_pm_domain_detach_list(port->se.pd_list);
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
qcom_geni_serial_probe() fail to release several resources?

If uart_add_one_port() or pm_runtime_resume_and_get() fail in probe, the
code jumps to the error label which completely fails to call ida_free(),
dev_pm_clear_wake_irq(), and device_init_wakeup(..., false).

Additionally, if devm_kzalloc() fails earlier in get_port_from_line() in
the same file, the allocated IDA slot is never freed, resulting in a
permanent leak of global IDA slots.

[Severity: High]
This is a pre-existing issue, but does the asynchronous pm_runtime_put()
on the probe error path leave the hardware permanently powered on?

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_probe() {
    ...
	ret =3D uart_add_one_port(drv, uport);
	pm_runtime_put(uport->dev);
	if (ret)
		goto error;
    ...
}

If uart_add_one_port() fails, pm_runtime_put() queues an asynchronous
suspend right before returning. Because this is an error path, devres
will immediately invoke pm_runtime_disable() which cancels the pending
asynchronous idle/suspend work, leaking power.

> @@ -2032,8 +2030,6 @@ static void qcom_geni_serial_remove(struct platform=
_device *pdev)
>  				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
>  		port->rx_dma_addr =3D 0;
>  	}
> -
> -	dev_pm_domain_detach_list(port->se.pd_list);
>  }

[Severity: High]
This is a pre-existing issue, but does the unconditional ida_free() in
qcom_geni_serial_remove() trigger a warning when unbinding console ports?

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_remove() {
    ...
	ida_free(&port_ida, uport->line);
    ...
}

When unbinding the driver for a console port, ida_free() is called on a
port line that was statically assigned, not allocated from the IDA,
which causes a WARN_ON_ONCE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-probe_clea=
nup_uart-v1-1-0bc2b00c970e@oss.qualcomm.com?part=3D1
