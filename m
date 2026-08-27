Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075B4A33E3
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854454; cv=none; b=gjYt3BAc4oANr3UgCUPyMd6+jAQJu/Y1FXsPSFkaM4ZW5cRswMgCds7cuLfyfaUfjbUQ3natjmLM4zBPhdjZrVCse+dn+gWw8xScFEr9i3aesoqJlO7nPFQ6preUD+S81QNoJfn1kE9z9dkKUmTQ/eSoe9xAJazq2JvVVp/rYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854454; c=relaxed/simple;
	bh=Aq3AIe8aQviBQ+dLnqgJOa/wZMDhz2buBMiYZcVf9Qk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FSlDueC2Kjd/U+J6suYJ7ZtmpMXZ6zScCXN8x9ctthFDUblll3CVybyUtOQYjRzpVx3s4OncSqd2mDSbP0L3R6o+tpnO4nBpXXPAhU7EOk5ak3bK3I7jj5Tx8e/olwHYdzvlLvm/mv+ChLG4oPdpHgni2pvTys6CfmIqeyjNgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLdOMuDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLdOMuDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ADC1F000E9;
	Thu, 27 Aug 2026 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854452;
	bh=LsB6PeLp76mzHV4WgClHaVp0ujQfC4j0fT4w6FnsOxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLdOMuDAIGsVV8sffr3u7U6T6FQcVMB6/imVlMbKzvcJc0N5QgVzU4210ua+GVzAs
	 32NI+dcytq597mkX9j/lVhmrqSCl5BcMET+OkBnc55BBsMH668W8LKIax2odkc6C6L
	 zjCcIh3ok+AF7fPaSXTtTvUWCrplBr9XuXUGFjnaOVSKzrlWVye6in+W+pA2YF+4za
	 cnNRgOPr+LMBpObEjqrl3L4KJTlHkw9uq5/tfVnsKEFChAG0wcZbho76Qq4OLKuEST
	 W6rEu8tmat7ehp5K4qIeZkwrjYNEte8OFx1l25wEGaYhRnoEd8mnsZfmoy45LQbWvB
	 lR5SGGi2IQjkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] soc: qcom: geni-se: Add helper to set SE clock
 rate via OPP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:14:11 +0000
Message-Id: <20260827181412.53ADC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free and use-after-free of `port->se.pd_list` via devre=
s cleanup in `qcom_geni_serial_probe` error path and `qcom_geni_serial_remo=
ve`.
--

commit 6ff6aaccb1d04a9b68e796b58d89553fda0f613b
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

soc: qcom: geni-se: Add helper to set SE clock rate via OPP

GENI protocol drivers need a common way to scale the SE source clock
through the OPP framework. The new helper automatically selects the
performance-domain device when power domains are attached and falls back
to the SE device otherwise.

> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 447b9cc6babf6..04f58a6f26fff 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1149,6 +1149,28 @@ int geni_se_set_perf_opp(struct geni_se *se, unsig=
ned long clk_freq)
>  }
>  EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
> =20
[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but could the manual detach calls
in drivers/tty/serial/qcom_geni_serial.c result in a double free and
use-after-free?

In qcom_geni_serial_probe(), the code calls port->dev_data->resources_init(=
).
For configurations that map this to geni_se_domain_attach(), it allocates a=
nd
attaches power domains using the managed API devm_pm_domain_attach_list().
This registers a cleanup action that will automatically detach and free the
list on probe failure or driver unbind.

However, the error path manually frees the list:

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_probe()
	...
error:
	if (port->rx_dma_addr) {
		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
		port->rx_dma_addr =3D 0;
	}
	dev_pm_domain_detach_list(port->se.pd_list);
	return ret;
}

The manual call to dev_pm_domain_detach_list() immediately frees the list,
but since the manual detach bypasses devres, the devres subsystem will
automatically invoke its cleanup action on the exact same, already-freed
pointer when the probe returns an error.

The same manual detach is also present in qcom_geni_serial_remove():

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_remove()
	...
	if (port->rx_dma_addr) {
		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
		port->rx_dma_addr =3D 0;
	}

	dev_pm_domain_detach_list(port->se.pd_list);
}

Could this cause memory corruption or a kernel panic when devres double-fre=
es
the list as soon as the remove function finishes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D3
