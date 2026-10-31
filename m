Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480212;
	b=Yke4ivenUyC5UuZMdMXHDzyfywt/c1YjihE/Yjds/nLA14tZhUZ5tbKu13wO+gtXCAV0
	 wavZ1anmaMxwIFkqin8EfAk52LH/r/8ykHqVEDbeFNk/oDJpkfFRJAt7iq5Q2y65Kl9d/
	 5RBlVKRXAiWo3c8voeI+rZKeHI8NQ2nlPSteaBnQvbP3Zr/4Zbn2LKbZpGYa//LEDt6Lc
	 LlN5v9/TNyDSNE5CFKIOeql0fOt33XCLWTAJSxywMrzLezX2ORCyL5vTil1O3ijWp76hP
	 8muPcNjD3o+QuMct6ukEmQoIVVWkjj4BTBQVqTq2/nVQiJ1sJn+2/iMhYBXCMPCbtpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aUDIsxrvHjHV74vxorHhPVRhgJYOBGh5uWCJnQfyRoQ=;
	b=XdCRSQECP0nfwWxOr2zbrL1tsiCprri4LSykjg7DG20xqrl7pBERSEzDDFGK9Z93MwG1
	 E4WdQXSr81B3QKmkrWNWC9vsXkpp4Tz2w/4T5dhJZZ6PT7B02NrkifrznWjhDVNkUOFcP
	 q3Rp8eEpsVLzkWnx57iSh60ZOxAIxASDMr3dnz7tNz6Ar152Pcw64qiMrHsA6u4KTBko0
	 e4Arv10TcKUq8jiOMtFtzN6mEhfFQlZ+7dSe+0tyOouEUOxrVMlytRsCZcAskDDSUMhSd
	 AI7ZTSvYzSGLUfqcj2hW5A+fgOAWkqUmnY+c3HbuSMN++ZllNfZ5KRVaoodZtS8TwWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJ8YdiaN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6ED606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJ8YdiaN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3B11F000C1;
	Sat, 31 Oct 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793480211;
	bh=aUDIsxrvHjHV74vxorHhPVRhgJYOBGh5uWCJnQfyRoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJ8YdiaNjjyalk9fPWMjESNoCcltYrEOR+WYy3A1OD4MKsQtMUqjXDI5SxwblorZU
	 bFdKjSvNiNYGtF7NQzLpSZjbBnPojm1gyZyAxqTM0N4K2if/93TTpJSfU22AdjL/0p
	 DV9u5Ppv65hPi6EJKsa/yDvBcuy4LfVm9qQtu2rGOoG9r8KryDx/fteihDuwjtYxLx
	 VIUoWM6j5ORIQvMjsYyJWqL1ZY+YT9npqnEOf4VEWxz6rT02+H2h715AI99e5M/Pc2
	 AY3IJ6JUsVaLYDsA+CtJDHbePITkGQUaE6Qwoea3Z9Ma+JHGu7r7+3ePxWsUKQVhoq
	 AXA6kWVfoBiLQ==
Message-ID: <sashiko-outbox-192133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261031-acpi_spcr-v4-1-c14f00a4f33f@posteo.de>
References: <20261031-acpi_spcr-v4-1-c14f00a4f33f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:56:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Prior to this patch, we assume the uart clock frequency is 1843200 Hz in
> the early console. This behaviour results in garbage console output if the
> actual uart clock frequency differs.
>=20
> The UART Clock Frequency field was added in the Microsoft Serial Port
> Console Redirection (SPCR) specification revision 1.08. If present, use it
> to configure the serial port with the correct uart clock frequency.
> Fallback to old behaviour if missing.
>=20
> Add function `setup_earlycon_with_uartclk` to set uart clock frequency
> while still allowing to reuse the same console string with
> `add_preferred_console`.
>=20
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports=
/serial-port-console-redirection-table
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-acpi_spcr-=
v4-1-c14f00a4f33f@posteo.de?part=3D1

