Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792867863;
	b=V4ROBpW5WOjMBz3xtN5YbhjDNdxJ7UetdN72HmnNwVq20+vjyqRef53wBx3Tjkn0ttGz
	 m4Not6D6zKNTQAw4h8NO7+lOi8C1wJvrFTvrhIqM7xIIkWe1HF9Kah3VStXydiL9pJPds
	 KyeJQwIyhDFI8pSSLhOBSl+2JEYFfICoqSTJeV+CdszwkruGf/yO5ktq5jYC4G68PAq1b
	 BQIebmd2piiI82GSo3rR1xXCZ7TGln6WHxwSR8ebfanWCMyJxykB35EbUOh/nlErVmme4
	 CgnbnDQzIQyB9le62zEg7HMQ0PZefhw7ncGg3BK91jJlcaG73jREB+S+C3PAg+xZefg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c9BvONVTbgQAlNLcKqFfDZz81U7vs1li8YUwS3SFn+s=;
	b=CZYJZbllRBt9AZtPX4jiVmfbZucia98+VGzq7rhWHve57YS6S6ahQQDz0z8iSOAtIMln
	 pg2Ul2/vuQEkQRm04eIaThqwnhpdFOE6uYxOhbuNeQPQoQmEDFv2zZbIVbNgFGxenzX87
	 ASzXMrK8eOSIghQc2xvbOy7WiqkdM1BMXbmjFju3d53IeqNbqBnBDmxTWeJLZY/ikMFSb
	 lZT4DHsjqsjNXnE45taySO6dI7ZzaX+1/Q+JV59NO0AL44DXSCyxA2Nz5mk7Rn7QOmIro
	 wGs+B6wUsebRetWciU9tVfgzuTRI++rIq4i7kK66yGDaCIC9CtVgpP8I1n/0YWZWQTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTqM2GB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D0606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTqM2GB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769D61F01825;
	Sat, 24 Oct 2026 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792867862;
	bh=c9BvONVTbgQAlNLcKqFfDZz81U7vs1li8YUwS3SFn+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTqM2GB4VUZiQbg0JBeETIp7yJhj72gDDBrd6uc7RX74h8oH7l7W8nDPceUZq2h62
	 EDyvxy1BPQQ7F6xUq5uITRwhQSiIYHORX5PYKF7dChmKXdaOLIzS0c2z217A9Gm52F
	 D8Wu5z8z15AVhnMZZOQCuUq5QbcZtOHVbO/nYIbMsuLLikQTqEqZx7oX2vebO5tB+x
	 /qg99elfpm+JRmiXeUcD1vWiAztxqvsiS6IYZ6tN7ULIGoOPvi55d8cQu1Z/AiW+eE
	 ms5ztgRy+HGt4Q0shEQ/TDKuCuTM6tDLbZ4tN8+KhcCvp6irm8JyldLlQO5zVSbWZi
	 tAv90teZ9bcCQ==
Message-ID: <sashiko-outbox-183841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250_dw: preserve BUSY-safe fractional
 divisor programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com>
References: <20261024-submit-serial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 18:51:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> dw8250_probe() installs a divisor setter that makes the UART idle and
> checks DLAB before writing DLL and DLH. When dw8250_setup_port() detects
> fractional-divisor support, it replaces that setter with the library's
> callback. The replacement writes DLF and uses serial8250_do_set_divisor(),
> bypassing the divisor setter's idle sequence and DLAB readback.
>=20
> If the LCR update fails to set DLAB, the subsequent divisor writes can
> reach TX and IER instead of DLL and DLH.
>=20
> Expose the library's fractional-divisor calculation and DLF write as
> shared helpers. Install the BUSY-safe setter after hardware discovery and
> use the shared DLF helper to program the fractional field only after DLAB
> has been confirmed, alongside DLL and DLH. Select the shared calculator
> when fractional divisors are supported, preserving the core calculation
> for integer-only ports.
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dw-divisor-v1-v2-1-032ca5338359@gmail.com?part=3D1

