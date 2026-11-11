Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401523;
	b=PfAIQq9LUjcfTPu/uEIC7jIohgDlWLod74pPd+mpXGz+Aq9JRPxQziLpbKyULH8uIw8t
	 tzneXNLpuIaQ3hyypydVJdYH/kYWmON63cxK7Y8qZd6gaS3oDr2inxEr/QQDDwBy82nJI
	 DbzC1ZdD3FEFVjnFS3eA0PCZbtHTp8mfVXRPs1+760Xt6vdSlqdLGc9FaejzZ3XlrwoP9
	 1Hze5sxOt0dB8P4Ha9W0o4pBxHOeNQVi12F48iUrJCM8Z6uR8pgofyCWowsqsSgLcqKnd
	 6DVCu5CoquAh9/IsE55TJUL4zMI7dJ6UzOr91cXvTqPh1OiM9xQX5hPo/F4HopcZkHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401523;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nmgIIyXSKCqoL5vDpUmPRAotLBqbwg3zUdjAJ0vNH2A=;
	b=24/RE7db5pn0E68rVRKsVmT8cmwqC5AslafmIEhPKifNAOWsCRtRaLAIvTd3n+EV3FNa
	 MaO8hHYzC7T2hQJWoD5MhlpfO1DQB1lQKp3RYiuNS+UlYgFpAAAYD0KGhYIgIT+Uv/2SJ
	 YqmQMJaoQSzcADxk1ft2P5VR1utkTigFPsBSE7hNTMd6h0Uml/7M4XpnLMLsKQoNySqdk
	 cERRvsGACsotBweutyVTUK4unTncIaUGjpEQgoQp/xUbHNIcbhYSeZIt/AOAMB7wPqUp+
	 t6D5riQ5OfdyWSkjRfoEhdzVo6qwIYtnssCXWZU1QQJpbp/sAJinIabJxKnEaxiRz4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBqMcbWL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A0606A324;
	Wed, 11 Nov 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBqMcbWL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB5A1F00A06;
	Wed, 11 Nov 2026 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401522;
	bh=nmgIIyXSKCqoL5vDpUmPRAotLBqbwg3zUdjAJ0vNH2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBqMcbWLtKe1moIKqFmt5+gNZBNmhAaQ+nNj3LuIpf34HgtyRDxIBgrnUg7eFlIre
	 d3vvDqjvhnZ+am/WnyhDYW7//+LZmpGa2Ld4YnxDz7s5udUSoAZcBo+J8Byj/JXHLS
	 fzgw7obGSAx6DAgVci5eWQ2IosRwVabOITLdK1x3Dm6ore0GejpvDuReFcBabBiTbS
	 egxpVTb6Ng87epBCAG3n4NYF3q75MyMtafZbE9g3YYPIB9m7ouJ5W9vSmDCv/Nl1ck
	 QggHk16CIlysRHuGXFcwfF13f6o5T/6vbned8m7lsECj77QhZzzQWTEsPSkFoHFIHQ
	 MsrklcAnyyxFw==
Message-ID: <sashiko-outbox-209020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] serial: max310x: Look up all channels before adding
 any port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261111-serial-transceiver-supply-v1-1-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
 <20261111-serial-transceiver-supply-v1-1-40bad0f912f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:52:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] serial: max310x: null pointer dereference in max310x_rs_proc()
  [1]
--

commit c564df97d56ed8d392fe2d422cb99ad90eb2aa67
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: Look up all channels before adding any port

This commit splits the per-channel loop in max310x_probe() so that RS485
device tree properties and GPIOs are looked up for all channels before
registering any UART ports with uart_add_one_port().

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index a0ed70185555e..bdfdf4a9000bb 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -2050,12 +2043,23 @@ static int max310x_probe(struct device *dev, cons=
t struct max310x_devtype *devty
>  			device_set_node(dev, saved_fwnode);
>  			of_node_put(port_np);
>  			if (ret)
> -				goto out_uart;
> +				goto out_clk;
>  		} else if (devtype->nr =3D=3D 1) {
>  			ret =3D uart_get_rs485_mode(&s->p[i].port);
>  			if (ret)
> -				goto out_uart;
> +				goto out_clk;
>  		}
> +	}
> +
> +	for (i =3D 0; i < devtype->nr; i++) {
> +		unsigned int line;
> +
> +		line =3D find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
> +		if (line =3D=3D MAX310X_UART_NRMAX) {
> +			ret =3D -ERANGE;
> +			goto out_uart;
> +		}
> +		s->p[i].port.line =3D line;
> =20
>  		/* Register port */
>  		ret =3D uart_add_one_port(&max310x_uart, &s->p[i].port);

[Severity: High]
This problem wasn't introduced by this patch, but can jumping to out_uart
after uart_add_one_port() cause a NULL pointer dereference in
max310x_rs_proc() [1]?

When RS485 is enabled in the device tree, uart_add_one_port() calls
max310x_rs485_config(), which schedules s->p[i].rs_work.  If a later step in
max310x_probe() fails (such as registering a subsequent port or requesting =
the
IRQ), the out_uart cleanup loop calls uart_remove_one_port() without
cancelling rs_work first:

drivers/tty/serial/max310x.c:max310x_probe() {
    ...
out_uart:
	for (i =3D 0; i < devtype->nr; i++) {
		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
			uart_remove_one_port(&max310x_uart, &s->p[i].port);
	}
    ...
}

uart_remove_one_port() clears port.state to NULL, so when max310x_rs_proc()
runs, it dereferences NULL at &one->port.state->port.mutex (and before devr=
es
frees s, or into freed memory afterward).  Should out_uart cancel rs_work
before calling uart_remove_one_port(), as max310x_remove() does?

[1] https://sashiko.dev/#/bug/linux-0992a296-a8ff-4396-990f-c73ea073185b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-serial-tra=
nsceiver-supply-v1-0-40bad0f912f2@vaisala.com?part=3D1
