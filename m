Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D843AE1A2
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076398; cv=none; b=Njre6rJUCFhhOpOAhgSWv+WzOefX92V0FpF7kF4PzzzM38I81OemPSxYoN/kRK+b/MYtNc1Us+76N0kQ53G70whwK1JRWadkzHgSJmvV11xyuuEExzCpKm7gJUlA49HZVihyxQD8JlqWHDsbLMo2mmnj1nDGmrwob4gV48Pm6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076398; c=relaxed/simple;
	bh=gWo67WJsXRirOK1dH+TOpaP9BoqhmqxtAYNP8cFiHN0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p7vQJhCsrEHmzkqSGRUJ75Oenppync0ZZUxSQzliQSdr8VnPAqhKWB0GvZxIM25d3TCWBDOm8MyDlxIiI9N8eJTDhg6CKWqzVRm4Eq/cGyiA/WG3QQVSrN6KS8O4PrG/av7IgHtRFC64lXSwZL75FS3Wk2MpfilLAEVGJPzZe38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LboJtddH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LboJtddH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52671F000C5;
	Thu, 15 Oct 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076396;
	bh=gWo67WJsXRirOK1dH+TOpaP9BoqhmqxtAYNP8cFiHN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LboJtddHmfOSSg3ivb/M/bg3GT/Gc2KrKWyc1EzMaTInjVIcsSJzUnPIBF3GcTt4P
	 12Eev1nG2y3ETn9x1q0bPrzza0g35xj2vJZweM18NEAUFpUMYTC7ouMJlwgjjHleQM
	 VNySNf/+6W59Jh0xOgxE95E0v2YDqInUlPsXq5qPzvEELmfWl85tIWbxAFm+TwehyS
	 w/gsXGaDsO7FE3TH2FKnvvOb992QolZNcUXDXgC5Tiu2pA54DdKf8lFMhYlBb8inpP
	 LlvZQ0+Ac1SD1FdUFTEEKdHFkOvd5WRS8WIU/qiA+0nvQEKNj1CYB8ymOLidn1RUan
	 DdpWM/4BRQvKA==
Message-ID: <sashiko-outbox-173018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: imx: keep the CPU out of deep idle while an
 RS485 port is open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Otavio Salvador" <otavio@ossystems.com.br>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015144627.2461915-1-otavio@ossystems.com.br>
References: <20261015144627.2461915-1-otavio@ossystems.com.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:59:56 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In RS485 mode the driver releases the transmitter (RTS/DE) from the TX
> complete interrupt. On i.MX6UL/ULL the imx6sx cpuidle driver offers an
> "ARM power off" state with a declared exit latency of 300us, measured at
> up to 2ms. When the CPU enters it while the last character is shifted
> out, DE is released that much later. Modbus RTU slaves may answer after
> 3.5 character times (1.75ms at >=3D19200 baud), so the head of their reply
> collides with our still-driven transmitter and is lost.
>=20
> Add a CPU latency QoS request of 100us while an RS485 port is open. It
> excludes the power-off state but keeps WFI and WAIT (50us) available, so
> cpuidle can stay enabled and the constraint only applies while the port
> is in use.
>=20
> The request is added on startup and removed on shutdown, and its value
> follows the RS485 state in imx_uart_rs485_config(), so RS485 enabled
> through TIOCSRS485 after the port is opened, as libmodbus does, is
> covered as well.
>=20
> Tested-by: Rodrigo M. Duarte <rodrigo.duarte@ossystems.com.br>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015144627.2461=
915-1-otavio@ossystems.com.br?part=3D1

