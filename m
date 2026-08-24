Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30C448BA0
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582660; cv=none; b=GAwVeWApisFuuDbSQQRB5GCUXwMFoqqxY182IGFKBk8CqjbsuwFcpUEhOpYLbzbvC4N8Hi5vSC7F3RrEH2nqIU01eofzG2M6PuNV8IYFdEFnoP/YWpIxFZ63o+UP69IvJ7xw2WSt9hVdywKtFV2YHVzBEDrxG9owR12yJSz69F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582660; c=relaxed/simple;
	bh=RQjPU715veyWD4FVbyZ1cIjgn9xVwERcI4+2/2OtACg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WrtpYL/8C397Lmjv2OoV6Uo5Ut8t/kpRsMHkGDSvDJoG73alBF/B9Tb8HDLr07QzG7q7r5gDt+vueHZmxmU0hepfQv1I354ggB//THuGjbdkt57VnBNISIy7V/cx8OIqyo1visHzfXdqLXBmpe1aqI2aq4zHWmRoRzZsbcKBtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8RFOiSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8RFOiSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F681F000E9;
	Mon, 24 Aug 2026 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787582652;
	bh=GkraAgVH8xRh6MIIacI9rA0KMlOHa2ysTw46ZvcPIlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8RFOiSD1UF14iJLWes75u7bsyd5sC9yaTjzbQl88DpHoJcoz7qaaMmcl2fTPY7Kk
	 1vel2/DUixWiF3pI/N6wVHUVgLZfkzYtX2m737QXpM5oJC540jR/lArrK+GBCHD78i
	 4HfAzP8rmuF/udMmuxCJwR0pIi0sjoRWvp0ogIY6s3rzRP28j2cK7n0wqOLK3aas5c
	 iMzZh5Vum7UymtBizpkZvfDr2HmpSKwHYBT1YX3WKTHUGYaY1hp+CVSxKbRPqjy+1L
	 q/1/Bk+zBnzaFGLjw2Fgp1Qy8eXur8QB7RqHvctmWBhdwfzRpWTLqEcZW1DjP+fh6V
	 vql9ZRaAP1y8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: qcom-geni: Drop unsafe rx_buf realloc from
 setup_fifos()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v2-1-9a1c8f711e98@oss.qualcomm.com>
References: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v2-1-9a1c8f711e98@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:44:12 +0000
Message-Id: <20260824144412.75F681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting invalid DMA unmap in probe error path.
- [High] Missing bounds check on hardware-reported RX length leads to out-o=
f-bounds read and kernel memory leak.
--

--- Patch [1]: [PATCH v2] serial: qcom-geni: Drop unsafe rx_buf realloc fro=
m setup_fifos() ---
commit 03f147201f8b1d9aa9d2d010a8177ebcd9b90c6e
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

serial: qcom-geni: Drop unsafe rx_buf realloc from setup_fifos()

The RX buffer is allocated once during probe using a fixed DMA_RX_BUF_SIZE
and is DMA-mapped for the lifetime of the port. However, setup_fifos()
attempts to reallocate rx_buf whenever the reported RX FIFO depth changes.
This commit drops this unsafe reallocation.

Link: https://patch.msgid.link/20260824-drop-unsafe-rx-buf-realloc-from-set=
up-fifos-v1-1-52d231c840e1@oss.qualcomm.com

> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 3633723acef8d..75b2e0b77d059 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
[ ... ]

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_probe() {
    ...
		port->rx_dma_addr =3D dma_map_single(pdev->dev.parent, port->rx_buf,
						   DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
		if (dma_mapping_error(pdev->dev.parent, port->rx_dma_addr)) {
			ret =3D -EIO;
			dev_err(&pdev->dev, "Failed to map RX DMA buffer: %d\n", ret);
			goto error;
		}
    ...
error:
	if (port->rx_dma_addr) {
		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
		port->rx_dma_addr =3D 0;
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but does this error path incorrectly unmap an
invalid DMA address?

If dma_map_single() fails, it returns a mapping error (typically ~0ULL).
The code leaves this error value in port->rx_dma_addr and jumps to the error
label. Because port->rx_dma_addr evaluates to true, the cleanup block calls
dma_unmap_single() on this invalid address.

On systems with IOMMU or DMA debugging enabled, could this cause kernel war=
nings
or memory corruption when the IOMMU translation tables are accessed with an
invalid IOVA?

drivers/tty/serial/qcom_geni_serial.c:qcom_geni_serial_handle_rx_dma() {
    ...
	rx_in =3D readl(uport->membase + SE_DMA_RX_LEN_IN);
	if (!rx_in)
		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n"=
);
	else if (!drop) {
		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
		handle_rx_uart(uport, rx_in);
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but is rx_in used without being bounded by
DMA_RX_BUF_SIZE?

The length is read directly from the SE_DMA_RX_LEN_IN register and passed to
handle_rx_uart() without verifying that it does not exceed the size of the =
DMA
buffer.

If the hardware device reports an incorrect length, could this lead to an
out-of-bounds read when copying from port->rx_buf and leak adjacent kernel
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-drop-unsaf=
e-rx-buf-realloc-from-setup-fifos-v2-1-9a1c8f711e98@oss.qualcomm.com?part=
=3D1
