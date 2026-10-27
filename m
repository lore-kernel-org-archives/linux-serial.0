Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100374;
	b=tCXPHITV26oNG8GciSc5C87EikD7JtZXtsyBCR9sr8Rvfq3O6o3pN1KAo0z5yju7rIen
	 H/kwRM6O5Uc1cHaLVNjy067+CMp9V7YyhlBsO67fxC7/XhwbOwRWBsN/N6dZV5Dg+5RAV
	 T8wXCcACFy6dzG0hA0aa6HAzWUm3TzwMXsbR16JqCtQmC4YP8y4nrehBHkJCFNe2OrKtY
	 9Hr2L7mP2w9YbGbRIvNvXBRBAMSOYQ2/I+WDjJCTjlnPU4hVPHKvJt386R1nCJCGFn15z
	 MNgxvEXLRLABV+tHJ6eV9rpLJ3ee+jppYtPvDIPCuzoeCQueJb2mF/KKCkdupY4Y7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/xI7Qp0GVhiHUXlm9A4BPFenNX5Ao8f5oO6RwiDucgM=;
	b=TDB99R/I9NYshcXeGLLl5ksC+c6/C7ZVswFM9RJ1wyqUfb/SMv3N9LeThfWCTzdQ5bck
	 hwcH5TiNAikJAvQN/SMGd+fQNbNpTjln/RcASXq/oIhsAz5W6zdPmDx4oUdAP9hgtNI+u
	 +YPs6vGeT21ILbi3D7bHLd3q+2eNWSnkox4qTR/lK6C52F7h+g65FcozHipaU4YUKWiBq
	 kTXE12X471kXS99nQR+qBxh6BQVbXcEfZWfYE9bRVR9zaN2jEpHBDJxwOBNOrUWtMJ13U
	 M9BBQKOgw0hBeHxnyy/7FLy3Ppw+S33M7cxEuOgrHgKWWkPhgpSHR9nszTmiOB/esVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIcx1Ln5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E0606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIcx1Ln5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ED11F01828;
	Tue, 27 Oct 2026 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100373;
	bh=/xI7Qp0GVhiHUXlm9A4BPFenNX5Ao8f5oO6RwiDucgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aIcx1Ln5KOB+59cQ58PkmylVvldKEjMsTaErGZSjjMsHas/sIRtR+44aNTR8xUgJ2
	 ZzlbQEz83MkO6JgSgtsFAsxlfC6JkfiejIUWylax6/0IVtMN3Y/NKfI7DfR9CNSpbN
	 fcm8eNhRbbRa+sxRhgB00KPqc07tv1gcVaGNIfVSJFObH9HVj6cwEio7K7HzUVsGqn
	 B5H/j3yRLjC/Ia1NGCD8z0lIr9Ufn4jaPnMD7rweqGh2sV12yINgm/GReyNN+Gju9M
	 ycfn1KijZWFUASqTo9Mkdo0/KpzsoU7zyaU3e80MPPQ3ah6l2acLuFTkfs6v/9up0T
	 e0TDEgBZquBKA==
Message-ID: <sashiko-outbox-186439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/24] serial: 8250: dfl: validate MMIO resource size
 and regshift
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:26:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] serial: 8250: dfl: conflicting regshift check in dfl_uart_probe()
--

commit 01d97c927b977fd42973306928651fbf771b53aa
Author: Joshua Rogers <linux@joshua.hu>

serial: 8250: dfl: validate MMIO resource size and regshift

This commit adds validation in dfl_uart_probe() to check that the register
shift does not exceed 3 and that the MMIO resource size covers the full 8250
register window.

> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250=
/8250_dfl.c
> index 72938990ea81e..e9329935bc476 100644
> --- a/drivers/tty/serial/8250/8250_dfl.c
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -110,6 +110,7 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
>  {
>  	struct device *dev =3D &dfl_dev->dev;
>  	struct uart_8250_port uart =3D { };
> +	resource_size_t min_size;
>  	int ret;
> =20
>  	uart.port.flags =3D UPF_IOREMAP;
> @@ -120,6 +121,17 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed uart feature walk\n");
> =20
> +	if (uart.port.regshift > 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "unsupported regshift %u\n",
> +				     uart.port.regshift);

[Severity: Low]
Just before this check, dfl_uart_probe() calls dfl_uart_get_params(), which
extracts uart->port.regshift from DFHv1_PARAM_ID_REG_LAYOUT and already
validates it against a different upper bound:

drivers/tty/serial/8250/8250_dfl.c:dfl_uart_get_params() {
	...
	uart->port.regshift =3D FIELD_GET(DFHv1_PARAM_REG_LAYOUT_SHIFT, reg_layout=
);
	if (uart->port.regshift > 4)
		return dev_err_probe(dev, -EINVAL, "unsupported reg-shift %u\n",
				     uart->port.regshift);
	...
}

When DFHv1_PARAM_ID_REG_LAYOUT specifies a regshift of 4, it is accepted by
dfl_uart_get_params() only to be rejected immediately after in
dfl_uart_probe().

Should the bound in dfl_uart_get_params() be updated to 3 instead of adding=
 a
second conflicting check in dfl_uart_probe()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D13
