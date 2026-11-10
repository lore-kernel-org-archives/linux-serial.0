Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280678;
	b=K7MhIMlf0xaiYpcFb7pMSjEZAg3raAx0akmgNaVqK7vEBJvbLPJhnTKmgAH80qQxiGpN
	 v+mFgNsRn/gwDkbFV4u4V8/XiOxvP3uhFMmigbNDncig6efKv8QwIfosC5jNlfKpFeKFS
	 YgiAHn45pCv9P5kxFARj9fVyWc1yXJ5Lee992RiF2+zs/lSScQwfL7FT5Cr2su3E3okkn
	 8+AmUOj/X1ZBFz+FU6jzUMlp/VOZFHc+vzqu+5zTb0Otr+aj966rC/f2MFqZhBWgiks9D
	 Lzq8GyzklEYHSYHByOPei6RpNoVpuBhx9iWpKGe0NrSNlMtGGFXt01pMVT4/ZHj7q8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0tj0ppEJQvcwkXQALDFUgrU8nYaOU/+pPfeQBaG042Q=;
	b=Mg+yv3fqz05VZefB6PdvX5UGZbOk4Gdaav+VoutnPHvFEsHXUanO6M4bPhGtGzYE+Ab9
	 4LAiA2KJufSSMGGzqYTcrKZR/6XAohppfIHvcSOhG5CB5ukgzhiq5Z5YfeaddL+KQVhQP
	 EFQyRzSWQXPIudadiY6qwzfMxl40wQOcegJUMzNOdp69inI7cy1npBWlWco8OXTLjAomf
	 biTeRPghwWxaKq/2j6i5ihKz9apG3jnvjt5Ny/FVR0hlaOfF6zhLEG5vK4qahnD0MalKD
	 EfCo2IgtRXgYxiflCfKv79dRI2GC/vki1hMmqBm7G/grsoUpftMmd8jpxXI6IFOHSTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3WXK6OR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2153606A31C
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3WXK6OR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1835D1F0089F;
	Tue, 10 Nov 2026 03:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280677;
	bh=0tj0ppEJQvcwkXQALDFUgrU8nYaOU/+pPfeQBaG042Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3WXK6ORwHbjptU3WXY1v4R4ZAZR7zHswZqfSg3CmC7HGdhbT5TXsle1nZp4ZWB04
	 r+h1xo3jfRXusoltV/D1iyNSAYUvIluR4cLu0ddq0aujwkYYQOlsdXz4FKX0vWpYwp
	 AajWw4xIY3R3WBR7Iuq+pbxKEV3fvOLIxfNABtiLkr+Xi07GwcLcy6NRlWdDOV8nIe
	 uD8S34el+VaWCLup8NccH0GWeAo7j9c6wp6Wg8mDI5NuxVDLGMSz8lvXf6JXIKmYam
	 Jmrt5mcxcXvsyxz6kzxzfciklCvyopht3sNaOhZFJJw3VQG6jPZTMpLgPJVxmdlyXI
	 WrDOFDii8f6hg==
Message-ID: <sashiko-outbox-206102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/11] serial: 8250_dw: allow port setup to report
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-1-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-1-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:17:56 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Return a status from dw8250_setup_port() and propagate failures through
> the DW and LPSS probe paths before registering the UART. Use the existing
> LPSS cleanup path to release board resources and IRQ vectors on failure.
>=20
> Keep the current setup behavior by returning zero on both successful
> paths. This separates error propagation from the configuration validation
> that will use it.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D1

