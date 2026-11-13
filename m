Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580581;
	b=ZOHU9O2w9eb6hmlKZ3Qw8ZexvK0pNIXPPBpuuf8YsKmcC6qkw2tERtqoX5Zr6AGV79NK
	 q4uyCtAF4QmrmRx7BEDCkOrbdrDe/+Wn3JiP9/NYG9mJVFSnjI6uBn6IXxSmezK6Pn9h0
	 kP74JqPZZXFyGj0oDiol4/wN7NFHkIPZcuTj840gqFBIf/a43PH6rI3DMx1Wn/TksOOVX
	 xw7HOjUGxqMCrLYZMbxvijfeX4pBdw3LsRyKr/e+U1DEIE0v8e4aThrZ6IR3JIupgYBhs
	 xR1xGuN04G1RdJ8kMjssTcJqTTTx/9RRj5BoYzJ2+EAfHWsDJlrnGkYlvFTGLz48i/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ju9A26K+3w1u5rXEiTQIwm0dmrFsSgPg1J1vbHR8bDI=;
	b=3E1hI76hbZZ5iluUJQnjg29dgaO9eEIEag3Bx8j7WG4W2eKPylZMxnr4wN0GbIiT37KA
	 B/r5FL9ZCugF7bQwG+caKYXFQBMyogPgMYnjkJAz0T7PNjOPBK7ncqdJN6O2aaWdsfo31
	 Dwq0o1jO2qPw40FNdbrkWaBdmYZUzfgxiFqisl+USceEsw42FuFpZIxt/afm7qxaZWtbp
	 1nlyw2ikhp3teJaRA/exoY7VvPXFyzcEsr2Uv5sXYGx9mz7J4qTcIni/3eHUuDF0MJLzE
	 8XIIPQ3aym/P/qNcCH/XVQ2y9LkPXXfHSVnlIwTP8xkClp38x4W83wYWvYcBj6i5ANQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4ZlpDVy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3A606A8A3
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4ZlpDVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790B31F000D3;
	Fri, 13 Nov 2026 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580580;
	bh=ju9A26K+3w1u5rXEiTQIwm0dmrFsSgPg1J1vbHR8bDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W4ZlpDVyb2gK3mNFW0xQYwqoQ7uLev7Lf3Qn0wdm+2y3Etvqm7PbpLM6rcpWdmc48
	 N+SDE+UQuUW1iasVYqjN0AiwcPEaYefOZVZGXXR67GfyTVcIEbQbBexuqr0JIj9yM9
	 HYpVpO50UbPH6XImk6oxlXZkFyTlySESxwfWIS8l3Z8oW6sJfayvyDGwKhUqIWwg8Z
	 GS2YVRq2EQs5O1z163gPV6t5TNVquOaQ0keMwpUAinB/CVrHJ7YEeWpGFHF4siIigg
	 aLpk+CXWxFyj8csqDaeGItXYDotTC08mRtZ0I9k1jMaWTStJbFv1oN+Z7iEFFM3ysB
	 KDYdg9s/r7dMA==
Message-ID: <sashiko-outbox-212997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] ACPI: SPCR: Support UART clock frequency
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-acpi_spcr-v4-1-443c88f964d7@posteo.de>
References: <20261113-acpi_spcr-v4-1-443c88f964d7@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:36:20 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-acpi_spcr-=
v4-1-443c88f964d7@posteo.de?part=3D1

