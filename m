Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914455;
	b=K2uoRe2wz6+B1wo0j1p7QBIo/e8zPn7ywVW8kSsSZxMFZQH4xybWOFmm7jzc3GjQ8TcY
	 hKLOIuO7BVyrXCELFQ523o8zVYgZ2vPb6KmOZhoK5v8edsuMGK05TN1Etkrx+pUn4oJrK
	 rMr1DlsT8VqGvH6c7BQJ9ScFMfq/DEfDHQbyvkYdoHamkn6Hfo4NmnvYkWlc8EzQHc0oS
	 sNDguZdXJf2PUYCpVKXl7CWMS6X91/IlyH2Umub2MsFkn/D+BQx5eqm1PI5f8LudIJpcP
	 0guQGpdDQ7szOvSMqCThymKKS4RYfpMEJW7QHggbJ67GJ/DUKNaGqaTQhYMbJx6xosg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914455;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dGSfGVviOf34qOFi7HoQdMZ6Pkj0BNsktYSO7lTz/gk=;
	b=resMc+7y2FR7iUDNZPOoHgnn+C+Q1/HSSRVWxc69R1jKTGs2+I+o49FfXsKYawEqpRB/
	 GH8H2h6KO6Jx/x3WnMIL7m2nP4f9uuAiCexRbCM+CKIwiYzy0xKqz3eigG1l7h/zYMXcA
	 HyQ1sMk0bGKlgdJO0tozfeMlGPnFF88q1ZRQYXQhwKfmFffVw8In//d3k8o91sXqQoZC1
	 49PRSEjh1DGMYltErP7FdPa4KVI+Ga8K6EdPpccS3MRUmnlZbf7NSSM1BHM2um9OwgBhF
	 4SPgPk37gxXNtC314rt31MV8gXGh9MPX28w1okns4bqCaFaovybJqisVrDZcOBwtjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEeeLj5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EED606D81E
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEeeLj5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4FC1F008AB;
	Thu,  5 Nov 2026 21:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914454;
	bh=dGSfGVviOf34qOFi7HoQdMZ6Pkj0BNsktYSO7lTz/gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEeeLj5s89JDC8g7Khs+dgOPCT/RGL0zetzWEwdSNfb7F4yKyEZdKmoS1zGCkChI9
	 k1e5USu6xEfwIFj8t8b0mWRIBDJ+ICBYQFpJC6FplzaXSTlL87LIv/m6180SVYjnvV
	 hI5ujeCL2503s+faarDuMzpjlpAnlIYpUA5Cdi+sUIE3XPy3cta2FvqXL5gLEOQwCl
	 8PHgxE3L6HEW0B/rJ4QQZdmb0w47z4mTkQE4/5NAVjZoYlv2tRvu6/Muf/AUsPT5y9
	 asoxy4AcjKUoKjEKpXOC6D+No1g2fgOD1N3Xq1WZZgBSj58dnLVmDc8WDQjrkZlpaR
	 wKN9xb+bONCyg==
Message-ID: <sashiko-outbox-200239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/11] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-10-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-10-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:34:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The A523 UART integration, also used by A527 and T527, has 64-byte FIFOs
> on UART0 and 128-byte FIFOs on UART1 through UART7. Each controller repor=
ts
> its TX/RX FIFO depth in bits 31:8 of the FIFO Clock Control register at
> offset 0xf0. The field holds a byte count, not a logarithmic encoding.
>=20
> Read this field in the sunxi setup callback when platform data does not
> provide a fixed FIFO size. A fixed size takes precedence, so H616 retains
> its 256-byte configuration without accessing FCC. The probe has already
> enabled the clocks and deasserted reset before invoking the callback.
> Leave the FIFO clock-control bits untouched.
>=20
> Use the shared DesignWare trigger setup to validate the depth and build
> the FIFO-relative threshold table. Invalid depths fail probe before
> registration instead of producing zero or truncated thresholds. The 8250
> core derives the transmit load from the discovered depth.
>=20
> Select this setup for the A523 compatible. Like H616, this integration
> has Allwinner-specific debug-divisor and RS485 registers overlapping the
> generic DesignWare feature probes. Use the common sunxi PIO setup,
> BUSY-safe integer divisor programming and software RS485 handling. Keep
> the APB clock gate enabled during termios updates with SKIP_SET_RATE.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D10

