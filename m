Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441443;
	b=ep5jF0MHO1PjhWAdl3z2BNcJG+juGHSHQtoJm9Ql1xxeJCpdaeJ0SlAn24immAG0cSwM
	 EzPKGw1tFnSWfSOQ8W6+qGojPXQTtyfmbfcPD1LNM1yMz76ZF5IEm1sFPe0i84c3doeag
	 l3mH15r3Mp5jIVqjeX9/kPM1iEZeV8tRtaijMstJJNlxM+p1chTrF3w4cG+h2So/5XvSQ
	 TUgz7wIGKgWMttrARZwfNfzGXmVxWNSQi3F6Z1RiTBYf+Z0iEXRXikLOESxWGplo7lOLh
	 2BCBFGfNK+A3O9zcRYq36Eb1s7ekSe2FW//ZoySEGumrLUNAIdr53bkr76k2FzgptIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441443;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lIneOBDtncMD2L3DdpI2+HWh3+meTv4eoOkzM1LtAec=;
	b=VDG1o3FZ18GMi7jJbNFczgKMBxOL8Gmm30daORd5Bz3vtU5nCRnEhqOpMuXt0jW4mlTb
	 xgMX3IV1X/n7C1aI3yhYu2iwqo+hprIdIS89x6Hrpak2WxbRe5Bwh3pHik0ohj4J+ZHUL
	 EvESkmkSJ8eLMPVsHIHO87WDk42+pwHEHTbRymqESbvs+Nrft3KRco7kyP231Wdr/0LZH
	 HhIB9ErhUgjqA2dw0StwbNnPDP9nrLNWYNuwLaIORla6RQOhxl6t/Fr2/uZ0oNPigMYEK
	 YfPg+oiS27Fw1ncYRCZ3SyE80xLovsYhtDpo9Kh7F0qrqcY+o46XeGgTad6II1uoGwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzL88zIS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDFE606A31A
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzL88zIS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2631A1F000C5;
	Mon, 19 Oct 2026 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441442;
	bh=lIneOBDtncMD2L3DdpI2+HWh3+meTv4eoOkzM1LtAec=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HzL88zISk6b5mEK1fcRzFGqkvoQqWV1slAXNLc+jxzqsdIee9U2sXe4LXzcBSYpqX
	 uNjcN97RK1ubDw+bJXIjIkK0VvtJWV9NpfjefDiJDqp5LRVm1aLoMCG2m/OpFq6j09
	 n6MBhlJAJtupsolGcCs7qwmI9Fuk39PlbEMIF104MKPPzxuR9hj2AHejBLXzj0aueO
	 uZYFk8q26GifToOVMJM/6DDTqsA4x0Fcciuf7bN2tik4nE1GmHkG//RXgs6qEf5/Ox
	 vNb4Cn8TOEIYt9Dg1YrKpm4kwd162h4Y1M7T7+HgeBOKRwmJb24bSFd9c9tSDaMYxk
	 dJYVKIJh8WHZA==
Message-ID: <sashiko-outbox-178166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] serial: 8250_dw: Only accept a contiguous DLF
 readback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>, linux-serial@vger.kernel.org
In-Reply-To: <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <a79114e72d029732db6764935dde12aa5d497706.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:24:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> dw8250_setup_port() writes all ones to offset 0xc0 and treats any
> nonzero readback as the DLF register. DLF is a bit field starting at
> bit 0, so a real one reads back as a contiguous 2^n - 1 mask. On some
> Allwinner SoCs offset 0xc0 is the RS485 control register instead
> (UART_485_CTL in the A733 User Manual), whose implemented bits are not
> contiguous. The probe still takes its readback for a DLF of fls(readback)
> bits, and every later divisor change writes the fractional divisor into
> the RS485 control register.
>=20
> Only accept a readback of the form 2^n - 1.
>=20
> The probe itself is unchanged: it still writes all ones to offset 0xc0
> and then restores the old value, so this only changes how the readback
> is interpreted.
>=20
> The A733 reads back 0x19f, and Andre Przywara observed 0x9f on the
> A523. Without this check the A733 RS485 control register reads 0xb after
> boot; with it, the register stays 0 across 300 termios toggle and
> restore cycles.
>=20
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792439398.gi=
t.vinicius.eduardo.pedrosa@gmail.com?part=3D2

